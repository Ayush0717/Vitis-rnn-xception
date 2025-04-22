# Embedded Neural Network Implementation

This repository contains the implementation of RNN and Xception neural network architectures optimized for embedded systems using High-Level Synthesis (HLS).

## Project Structure

```
.
├── Rnn/
│   ├── code.cpp           # Main RNN implementation
│   ├── testbench.cpp      # Test bench for RNN
│   ├── model_weights.h    # RNN model weights
│   ├── hls.app           # HLS application configuration
│   └── solution1/        # HLS solution directory
│
└── Xception/
    ├── Scripts/          # Helper scripts
    ├── Test/            # Test files and data
    ├── squeezenet/      # SqueezeNet model implementation
    ├── xception/        # Xception model implementation
    └── xception_weights.h # Xception model weights
```

## Features

- Hardware-optimized RNN implementation
- Xception model for efficient image classification
- High-Level Synthesis ready code
- Test benches for verification
- Pre-trained model weights included

## Requirements

- Vitis HLS or compatible High-Level Synthesis tool
- C++ compiler
- Hardware platform supporting neural network acceleration

## Getting Started

1. Clone the repository
2. Set up your HLS environment
3. Open the respective project in Vitis HLS:
   - For RNN: Use the `Rnn/hls.app` configuration
   - For Xception: Navigate to the `Xception` directory

## Implementation Details

### RNN
- Implemented in C++ for hardware synthesis
- Includes test bench for functional verification
- Optimized for embedded deployment

### Xception
- Efficient implementation of the Xception architecture
- Includes SqueezeNet implementation for comparison
- Separate test environment for validation

## License

[Add your license information here]

## Contributing

Feel free to submit issues and enhancement requests.

## Contact

[Add your contact information here]
