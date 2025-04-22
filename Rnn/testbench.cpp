//#include <iostream>
//#include "model_weights.h"
//
//#define SEQ_LEN 4
//#define INPUT_SIZE 1
//#define OUTPUT_SIZE 1
//
//void rnn_forward(const float input_sequence[SEQ_LEN][INPUT_SIZE],
//                 float output_sequence[SEQ_LEN][OUTPUT_SIZE]);
//
//int main()
//{
//    float input_sequence[SEQ_LEN][INPUT_SIZE] = {
//        {0.5f}, {0.3f}, {-0.1f}, {0.7f}};
//    float output_sequence[SEQ_LEN][OUTPUT_SIZE];
//
//    rnn_forward(input_sequence, output_sequence);
//
//    std::cout << "RNN Output:\n";
//    for (int t = 0; t < SEQ_LEN; t++)
//    {
//        std::cout << "Time " << t << ": " << output_sequence[t][0] << std::endl;
//    }
//
//    return 0;
//}
