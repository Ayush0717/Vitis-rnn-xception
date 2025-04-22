#!/usr/bin/env python3
import numpy as np
import torch
import torchvision.models as models
import os

def generate_squeezenet_weights():
    print("--- SqueezeNet Weight Extraction ---")
    
    # Create weights directory if it doesn't exist
    weights_dir = "weights"
    if not os.path.exists(weights_dir):
        os.makedirs(weights_dir)
    
    # Load pre-trained SqueezeNet model
    print("Loading pre-trained SqueezeNet 1.1 model...")
    model = models.squeezenet1_1(pretrained=True)
    print("Loaded model trained for 1000 classes.")
    
    # Modify the final classifier for 10 classes
    if model.classifier[1].out_channels != 10:
        print("WARNING: C++ code expects 10 classes, but loaded model has 1000.")
        print("         Replacing the final classifier layer with a randomly initialized one of size 10.")
        print("         For accurate results, use weights trained for your specific number of classes.")
        num_features = model.classifier[1].in_channels
        model.classifier[1] = torch.nn.Conv2d(num_features, 10, kernel_size=1)
    
    # Extract weights and biases
    print("Extracting weights and writing to squeezenet_weights.h...")
    
    # Create header file
    with open('../squeezenet/include/squeezenet_weights.h', 'w') as f:
        f.write('#ifndef SQUEEZENET_WEIGHTS_H\n')
        f.write('#define SQUEEZENET_WEIGHTS_H\n\n')
        
        # Conv1 layer
        conv1_weights = model.features[0].weight.detach().numpy()
        conv1_biases = model.features[0].bias.detach().numpy()
        
        f.write('// Conv1 layer\n')
        f.write('static const float conv1_weights[] = {\n')
        np.savetxt(f, conv1_weights.flatten(), fmt='%.6f', delimiter=',\n')
        f.write('};\n\n')
        f.write('static const float conv1_biases[] = {\n')
        np.savetxt(f, conv1_biases.flatten(), fmt='%.6f', delimiter=',\n')
        f.write('};\n\n')
        
        # Fire modules 2-9
        fire_modules = {
            2: model.features[3],  # Fire2
            3: model.features[4],  # Fire3
            4: model.features[6],  # Fire4 (after MaxPool)
            5: model.features[7],  # Fire5
            6: model.features[9],  # Fire6 (after MaxPool)
            7: model.features[10], # Fire7
            8: model.features[11], # Fire8
            9: model.features[12]  # Fire9
        }
        
        for i in range(2, 10):
            fire_module = fire_modules[i]
            
            # Squeeze weights and biases
            squeeze_weights = fire_module.squeeze.weight.detach().numpy()
            squeeze_biases = fire_module.squeeze.bias.detach().numpy()
            
            # Expand 1x1 weights and biases
            expand1x1_weights = fire_module.expand1x1.weight.detach().numpy()
            expand1x1_biases = fire_module.expand1x1.bias.detach().numpy()
            
            # Expand 3x3 weights and biases
            expand3x3_weights = fire_module.expand3x3.weight.detach().numpy()
            expand3x3_biases = fire_module.expand3x3.bias.detach().numpy()
            
            # Write to file
            f.write(f'// Fire{i} module\n')
            
            f.write(f'static const float fire{i}_squeeze_weights[] = {{\n')
            np.savetxt(f, squeeze_weights.flatten(), fmt='%.6f', delimiter=',\n')
            f.write('};\n\n')
            
            f.write(f'static const float fire{i}_squeeze_biases[] = {{\n')
            np.savetxt(f, squeeze_biases.flatten(), fmt='%.6f', delimiter=',\n')
            f.write('};\n\n')
            
            f.write(f'static const float fire{i}_expand_1x1_weights[] = {{\n')
            np.savetxt(f, expand1x1_weights.flatten(), fmt='%.6f', delimiter=',\n')
            f.write('};\n\n')
            
            f.write(f'static const float fire{i}_expand_1x1_biases[] = {{\n')
            np.savetxt(f, expand1x1_biases.flatten(), fmt='%.6f', delimiter=',\n')
            f.write('};\n\n')
            
            f.write(f'static const float fire{i}_expand_3x3_weights[] = {{\n')
            np.savetxt(f, expand3x3_weights.flatten(), fmt='%.6f', delimiter=',\n')
            f.write('};\n\n')
            
            f.write(f'static const float fire{i}_expand_3x3_biases[] = {{\n')
            np.savetxt(f, expand3x3_biases.flatten(), fmt='%.6f', delimiter=',\n')
            f.write('};\n\n')
        
        # Final convolution layer (conv10)
        conv10 = model.classifier[1]
        conv10_weights = conv10.weight.detach().numpy()
        conv10_biases = conv10.bias.detach().numpy()
        
        f.write('// Conv10 layer\n')
        f.write('static const float conv10_weights[] = {{\n')
        np.savetxt(f, conv10_weights.flatten(), fmt='%.6f', delimiter=',\n')
        f.write('};\n\n')
        f.write('static const float conv10_biases[] = {{\n')
        np.savetxt(f, conv10_biases.flatten(), fmt='%.6f', delimiter=',\n')
        f.write('};\n\n')
        
        f.write('#endif // SQUEEZENET_WEIGHTS_H\n')
    
    print("Weights successfully written to squeezenet_weights.h")

if __name__ == "__main__":
    generate_squeezenet_weights() 