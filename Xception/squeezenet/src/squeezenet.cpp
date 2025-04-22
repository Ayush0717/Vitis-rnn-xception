#include "squeezenet.h"
#include <cfloat> // For FLT_MIN in max_pooling

//--------------------------------------------------------------------------
// Standard Convolution
//--------------------------------------------------------------------------
void convolution(
    const float input[], const float weights[], const float biases[], float output[],
    int InH, int InW, int InC, int OutH, int OutW, int OutC,
    int KH, int KW, int StrideH, int StrideW, int PadH, int PadW, bool apply_relu)
{
    // Output Feature Map (OFM) Loops
    OUT_C_LOOP: for (int oc = 0; oc < OutC; ++oc) {
        OUT_H_LOOP: for (int oh = 0; oh < OutH; ++oh) {
            OUT_W_LOOP: for (int ow = 0; ow < OutW; ++ow) {
#pragma HLS PIPELINE II=1

                float sum = biases ? biases[oc] : 0.0f;

                // Kernel Loops
                IN_C_LOOP: for (int ic = 0; ic < InC; ++ic) {
                    KERNEL_H_LOOP: for (int kh = 0; kh < KH; ++kh) {
                        KERNEL_W_LOOP: for (int kw = 0; kw < KW; ++kw) {
                            int ih = oh * StrideH + kh - PadH;
                            int iw = ow * StrideW + kw - PadW;

                            if (ih >= 0 && ih < InH && iw >= 0 && iw < InW) {
                                int input_idx = ic * InH * InW + ih * InW + iw;
                                int weight_idx = oc * (InC * KH * KW) + ic * (KH * KW) + kh * KW + kw;
                                sum += input[input_idx] * weights[weight_idx];
                            }
                        }
                    }
                }
                float result = apply_relu ? relu_activation(sum) : sum;
                int output_idx = oc * OutH * OutW + oh * OutW + ow;
                output[output_idx] = result;
            }
        }
    }
}

//--------------------------------------------------------------------------
// Max Pooling
//--------------------------------------------------------------------------
void max_pooling(
    const float input[], float output[],
    int InH, int InW, int InC, int OutH, int OutW,
    int KH, int KW, int StrideH, int StrideW)
{
    POOL_C_LOOP: for (int c = 0; c < InC; ++c) {
        POOL_OH_LOOP: for (int oh = 0; oh < OutH; ++oh) {
            POOL_OW_LOOP: for (int ow = 0; ow < OutW; ++ow) {
#pragma HLS PIPELINE II=1
                float max_val = -FLT_MAX;
                POOL_KH_LOOP: for (int kh = 0; kh < KH; ++kh) {
                    POOL_KW_LOOP: for (int kw = 0; kw < KW; ++kw) {
                        int ih = oh * StrideH + kh;
                        int iw = ow * StrideW + kw;
                        if (ih < InH && iw < InW) {
                            int input_idx = c * InH * InW + ih * InW + iw;
                            if (input[input_idx] > max_val) {
                                max_val = input[input_idx];
                            }
                        }
                    }
                }
                int output_idx = c * OutH * OutW + oh * OutW + ow;
                output[output_idx] = max_val;
            }
        }
    }
}

//--------------------------------------------------------------------------
// Global Average Pooling
//--------------------------------------------------------------------------
void global_average_pooling(
    const float input[], float output[], int InH, int InW, int InC)
{
    GAP_C_LOOP: for (int c = 0; c < InC; ++c) {
#pragma HLS PIPELINE II=1
        float sum = 0.0f;
        GAP_H_LOOP: for (int h = 0; h < InH; ++h) {
            GAP_W_LOOP: for (int w = 0; w < InW; ++w) {
                int input_idx = c * InH * InW + h * InW + w;
                sum += input[input_idx];
            }
        }
        output[c] = sum / (float)(InH * InW);
    }
}

//--------------------------------------------------------------------------
// Fire Module Implementation
//--------------------------------------------------------------------------
void fire_module(
    const float input[], float output[],
    int InH, int InW, int InC,
    int OutH, int OutW, int OutC,
    int squeeze_1x1_filters,
    int expand_1x1_filters,
    int expand_3x3_filters,
    const float squeeze_weights[], const float squeeze_biases[],
    const float expand_1x1_weights[], const float expand_1x1_biases[],
    const float expand_3x3_weights[], const float expand_3x3_biases[],
    float squeeze_buffer[], float expand_buffer[])
{
    // 1. Squeeze Layer (1x1 convolution)
    convolution(input, squeeze_weights, squeeze_biases, squeeze_buffer,
                InH, InW, InC, InH, InW, squeeze_1x1_filters,
                1, 1, 1, 1, 0, 0, true);

    // 2. Expand Layer (1x1 and 3x3 convolutions in parallel)
    // 2a. Expand 1x1
    convolution(squeeze_buffer, expand_1x1_weights, expand_1x1_biases, expand_buffer,
                InH, InW, squeeze_1x1_filters, OutH, OutW, expand_1x1_filters,
                1, 1, 1, 1, 0, 0, true);

    // 2b. Expand 3x3
    convolution(squeeze_buffer, expand_3x3_weights, expand_3x3_biases, output + (expand_1x1_filters * OutH * OutW),
                InH, InW, squeeze_1x1_filters, OutH, OutW, expand_3x3_filters,
                3, 3, 1, 1, 1, 1, true);

    // 3. Concatenate the outputs (already in place in output buffer)
}

//--------------------------------------------------------------------------
// Top-level SqueezeNet Function Implementation
//--------------------------------------------------------------------------
void SqueezeNet(
    const float input_image[INPUT_H * INPUT_W * INPUT_C],
    float output_logits[NUM_CLASSES])
{
    // --- HLS Interface Pragmas ---
    #pragma HLS INTERFACE m_axi     port=input_image  offset=slave bundle=gmem0
    #pragma HLS INTERFACE m_axi     port=output_logits offset=slave bundle=gmem1
    #pragma HLS INTERFACE s_axilite port=return        bundle=control

    // --- Intermediate Buffers ---
    static float buf_conv1[BUF_CONV1_SIZE];
    static float buf_pool1[BUF_POOL1_SIZE];
    static float buf_fire2[BUF_FIRE2_SIZE];
    static float buf_fire3[BUF_FIRE3_SIZE];
    static float buf_fire4[BUF_FIRE4_SIZE];
    static float buf_fire5[BUF_FIRE5_SIZE];
    static float buf_fire6[BUF_FIRE6_SIZE];
    static float buf_fire7[BUF_FIRE7_SIZE];
    static float buf_fire8[BUF_FIRE8_SIZE];
    static float buf_fire9[BUF_FIRE9_SIZE];
    static float buf_conv10[BUF_CONV10_SIZE];
    
    // Fire module intermediate buffers
    static float buf_squeeze[MAX_SQUEEZE_SIZE];
    static float buf_expand[MAX_EXPAND_SIZE];

    // === SqueezeNet Architecture ===
    
    // Conv1
    convolution(input_image, conv1_weights, conv1_biases, buf_conv1,
                INPUT_H, INPUT_W, INPUT_C, CONV1_H_OUT, CONV1_W_OUT, CONV1_C_OUT,
                7, 7, 2, 2, 3, 3, true);

    // MaxPool1
    max_pooling(buf_conv1, buf_pool1,
                CONV1_H_OUT, CONV1_W_OUT, CONV1_C_OUT,
                POOL1_H_OUT, POOL1_W_OUT,
                3, 3, 2, 2);

    // Fire2
    fire_module(buf_pool1, buf_fire2,
                POOL1_H_OUT, POOL1_W_OUT, CONV1_C_OUT,
                FIRE2_H_OUT, FIRE2_W_OUT, FIRE2_C_OUT,
                16, 64, 64,
                fire2_squeeze_weights, fire2_squeeze_biases,
                fire2_expand_1x1_weights, fire2_expand_1x1_biases,
                fire2_expand_3x3_weights, fire2_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire3
    fire_module(buf_fire2, buf_fire3,
                FIRE2_H_OUT, FIRE2_W_OUT, FIRE2_C_OUT,
                FIRE3_H_OUT, FIRE3_W_OUT, FIRE3_C_OUT,
                16, 64, 64,
                fire3_squeeze_weights, fire3_squeeze_biases,
                fire3_expand_1x1_weights, fire3_expand_1x1_biases,
                fire3_expand_3x3_weights, fire3_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire4
    fire_module(buf_fire3, buf_fire4,
                FIRE3_H_OUT, FIRE3_W_OUT, FIRE3_C_OUT,
                FIRE4_H_OUT, FIRE4_W_OUT, FIRE4_C_OUT,
                32, 128, 128,
                fire4_squeeze_weights, fire4_squeeze_biases,
                fire4_expand_1x1_weights, fire4_expand_1x1_biases,
                fire4_expand_3x3_weights, fire4_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire5
    fire_module(buf_fire4, buf_fire5,
                FIRE4_H_OUT, FIRE4_W_OUT, FIRE4_C_OUT,
                FIRE5_H_OUT, FIRE5_W_OUT, FIRE5_C_OUT,
                32, 128, 128,
                fire5_squeeze_weights, fire5_squeeze_biases,
                fire5_expand_1x1_weights, fire5_expand_1x1_biases,
                fire5_expand_3x3_weights, fire5_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire6
    fire_module(buf_fire5, buf_fire6,
                FIRE5_H_OUT, FIRE5_W_OUT, FIRE5_C_OUT,
                FIRE6_H_OUT, FIRE6_W_OUT, FIRE6_C_OUT,
                48, 192, 192,
                fire6_squeeze_weights, fire6_squeeze_biases,
                fire6_expand_1x1_weights, fire6_expand_1x1_biases,
                fire6_expand_3x3_weights, fire6_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire7
    fire_module(buf_fire6, buf_fire7,
                FIRE6_H_OUT, FIRE6_W_OUT, FIRE6_C_OUT,
                FIRE7_H_OUT, FIRE7_W_OUT, FIRE7_C_OUT,
                48, 192, 192,
                fire7_squeeze_weights, fire7_squeeze_biases,
                fire7_expand_1x1_weights, fire7_expand_1x1_biases,
                fire7_expand_3x3_weights, fire7_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire8
    fire_module(buf_fire7, buf_fire8,
                FIRE7_H_OUT, FIRE7_W_OUT, FIRE7_C_OUT,
                FIRE8_H_OUT, FIRE8_W_OUT, FIRE8_C_OUT,
                64, 256, 256,
                fire8_squeeze_weights, fire8_squeeze_biases,
                fire8_expand_1x1_weights, fire8_expand_1x1_biases,
                fire8_expand_3x3_weights, fire8_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Fire9
    fire_module(buf_fire8, buf_fire9,
                FIRE8_H_OUT, FIRE8_W_OUT, FIRE8_C_OUT,
                FIRE9_H_OUT, FIRE9_W_OUT, FIRE9_C_OUT,
                64, 256, 256,
                fire9_squeeze_weights, fire9_squeeze_biases,
                fire9_expand_1x1_weights, fire9_expand_1x1_biases,
                fire9_expand_3x3_weights, fire9_expand_3x3_biases,
                buf_squeeze, buf_expand);

    // Conv10
    convolution(buf_fire9, conv10_weights, conv10_biases, buf_conv10,
                FIRE9_H_OUT, FIRE9_W_OUT, FIRE9_C_OUT,
                CONV10_H_OUT, CONV10_W_OUT, CONV10_C_OUT,
                1, 1, 1, 1, 0, 0, true);

    // Global Average Pooling
    global_average_pooling(buf_conv10, output_logits,
                          CONV10_H_OUT, CONV10_W_OUT, CONV10_C_OUT);
} 