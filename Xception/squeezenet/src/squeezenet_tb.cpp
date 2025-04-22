#include "squeezenet.h"
#include <iostream>
#include <fstream>
#include <iomanip>
#include <cfloat>  // Added for FLT_MAX

// Function to read image data from file
void read_image(const char* filename, float* image_data) {
    std::ifstream file(filename, std::ios::binary);
    if (!file) {
        std::cerr << "Error opening file: " << filename << std::endl;
        return;
    }
    file.read(reinterpret_cast<char*>(image_data), INPUT_H * INPUT_W * INPUT_C * sizeof(float));
    file.close();
}

// Function to write results to file
void write_results(const char* filename, float* results, int size) {
    std::ofstream file(filename);
    if (!file) {
        std::cerr << "Error opening file: " << filename << std::endl;
        return;
    }
    for (int i = 0; i < size; ++i) {
        file << std::fixed << std::setprecision(6) << results[i] << std::endl;
    }
    file.close();
}

int main() {
    // Allocate memory for input and output
    float* input_image = new float[INPUT_H * INPUT_W * INPUT_C];
    float* output_logits = new float[NUM_CLASSES];

    // Read input image
    read_image("../Test/input_image_squeezenet.bin", input_image);

    // Run SqueezeNet
    SqueezeNet(input_image, output_logits);

    // Write results
    write_results("output_logits.txt", output_logits, NUM_CLASSES);

    // Print top 5 predictions
    std::cout << "Top 5 predictions:" << std::endl;
    for (int i = 0; i < 5; ++i) {
        float max_val = -FLT_MAX;
        int max_idx = 0;
        for (int j = 0; j < NUM_CLASSES; ++j) {
            if (output_logits[j] > max_val) {
                max_val = output_logits[j];
                max_idx = j;
            }
        }
        std::cout << "Class " << max_idx << ": " << max_val << std::endl;
        output_logits[max_idx] = -FLT_MAX; // Remove this prediction for next iteration
    }

    // Clean up
    delete[] input_image;
    delete[] output_logits;

    return 0;
} 