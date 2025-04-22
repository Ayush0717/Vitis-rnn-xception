#ifndef SQUEEZENET_H
#define SQUEEZENET_H

#include <cmath> // For fmaxf
#include "squeezenet_params.h"
#include "squeezenet_weights.h"

// --- Activation ---
inline float relu_activation(float x) {
#pragma HLS INLINE
    return (x < 0.0f) ? 0.0f : x;
}

// --- Basic Layers ---

// Standard Convolution
void convolution(
    const float input[], const float weights[], const float biases[], float output[],
    int InH, int InW, int InC, int OutH, int OutW, int OutC,
    int KH, int KW, int StrideH, int StrideW, int PadH, int PadW, bool apply_relu);

// Max Pooling
void max_pooling(
    const float input[], float output[],
    int InH, int InW, int InC, int OutH, int OutW,
    int KH, int KW, int StrideH, int StrideW);

// Global Average Pooling
void global_average_pooling(
    const float input[], float output[], int InH, int InW, int InC);

// --- SqueezeNet Specific Blocks ---

// Fire Module (Squeeze -> Expand)
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
    float squeeze_buffer[], float expand_buffer[]);

// --- Top-level Function ---
void SqueezeNet(
    const float input_image[INPUT_H * INPUT_W * INPUT_C], // Input image
    float output_logits[NUM_CLASSES]                       // Output logits
);

#endif // SQUEEZENET_H 