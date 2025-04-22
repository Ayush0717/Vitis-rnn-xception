#include "model_weights.h"
#include <cmath>

#define SEQ_LEN 4
#define INPUT_SIZE 1
#define HIDDEN_SIZE 8
#define OUTPUT_SIZE 1

void rnn_forward(
    const float input_sequence[SEQ_LEN][INPUT_SIZE],
    float output_sequence[SEQ_LEN][OUTPUT_SIZE])
{

#pragma HLS INTERFACE s_axilite port = return bundle = CONTROL_BUS
#pragma HLS INTERFACE s_axilite port = input_sequence bundle = CONTROL_BUS
#pragma HLS INTERFACE s_axilite port = output_sequence bundle = CONTROL_BUS

    float hidden_state[HIDDEN_SIZE] = {0};
#pragma HLS ARRAY_PARTITION variable = hidden_state complete dim = 1

    float temp_hidden[HIDDEN_SIZE];
#pragma HLS ARRAY_PARTITION variable = temp_hidden complete dim = 1

    for (int t = 0; t < SEQ_LEN; t++)
    {
        float input_t = input_sequence[t][0];

        // RNN Cell
        for (int h = 0; h < HIDDEN_SIZE; h++)
        {
#pragma HLS UNROLL
            float sum = rnn_b[h];

            sum += input_t * rnn_Wx[0][h];

            for (int i = 0; i < HIDDEN_SIZE; i++)
            {
                sum += hidden_state[i] * rnn_Wh[i][h];
            }

            temp_hidden[h] = tanh(sum);
        }

        // Update hidden state
        for (int h = 0; h < HIDDEN_SIZE; h++)
        {
            hidden_state[h] = temp_hidden[h];
        }

        // Dense layer output
        for (int o = 0; o < OUTPUT_SIZE; o++)
        {
#pragma HLS UNROLL
            float sum = dens_b[o];
            for (int h = 0; h < HIDDEN_SIZE; h++)
            {
                sum += hidden_state[h] * dens_W[h][o];
            }
            output_sequence[t][o] = sum;
        }
    }
}