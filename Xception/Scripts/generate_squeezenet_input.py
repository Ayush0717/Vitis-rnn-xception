#!/usr/bin/env python3
import numpy as np
from PIL import Image
import torch
import torchvision.transforms as transforms
import os

def preprocess_image(image_path, output_path):
    print(f"Processing image: {image_path}")
    
    # Load and preprocess the image
    image = Image.open(image_path)
    
    # Define preprocessing pipeline (same as SqueezeNet training)
    preprocess = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406],
                           std=[0.229, 0.224, 0.225])
    ])
    
    # Apply preprocessing
    input_tensor = preprocess(image)
    
    # Convert to numpy array and flatten (CHW -> flat array)
    input_array = input_tensor.numpy().flatten()
    
    # Create output directory if it doesn't exist
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    # Save as binary file
    input_array.astype(np.float32).tofile(output_path + '.bin')
    
    # Save as C header file
    with open(output_path + '.h', 'w') as f:
        f.write("#ifndef INPUT_IMAGE_SQUEEZENET_H\n")
        f.write("#define INPUT_IMAGE_SQUEEZENET_H\n\n")
        
        f.write("// Input image data for SqueezeNet\n")
        f.write("// Preprocessed with:\n")
        f.write("//   1. Resize to 256x256\n")
        f.write("//   2. Center crop to 224x224\n")
        f.write("//   3. Convert to tensor (scale to [0, 1])\n")
        f.write("//   4. Normalize with mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]\n")
        f.write("//   5. Flatten to 1D array (CHW order)\n\n")
        
        f.write("static const float input_image_data[] = {\n")
        
        # Write data in rows of 8
        for i in range(0, len(input_array), 8):
            row = input_array[i:i+8]
            f.write('    ' + ', '.join(f'{x:.6f}f' for x in row))
            if i + 8 < len(input_array):
                f.write(',')
            f.write('\n')
        
        f.write("};\n\n")
        f.write("#endif // INPUT_IMAGE_SQUEEZENET_H\n")
    
    print(f"Preprocessed data saved to {output_path}.bin and {output_path}.h")

if __name__ == "__main__":
    # Process the dog image
    image_path = "../Test/dog.jpg"
    output_path = "../Test/input_image_squeezenet"
    preprocess_image(image_path, output_path) 