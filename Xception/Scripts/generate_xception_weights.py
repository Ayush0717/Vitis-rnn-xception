import torch
import torchvision.models as models
import numpy as np
import os
import sys

# --- Configuration ---
# !! IMPORTANT !! Set this to match NUM_CLASSES in your squeezenet_params.h
# The standard SqueezeNet 1.1 is trained for 1000 classes (ImageNet).
# If your C++ code expects a different number (e.g., 10), this script
# will attempt to replace the final layer weights with *randomly initialized*
# weights of the correct size. You would ideally need weights from a
# model *trained* for your specific number of classes.
CPP_NUM_CLASSES = 10 # Example: Set to 10 if using CIFAR-10 size output

# Output file path relative to this script's location
OUTPUT_FILENAME = "../xception_weights.h"
VALUES_PER_LINE = 10 # For readability in the output file

# --- Helper function to write a tensor to the C++ file ---
def write_cpp_array(f, cpp_var_name, tensor, values_per_line=10):
    """Writes a PyTorch tensor into a C++ static const float array."""
    f.write(f"// Shape: {list(tensor.shape)}\n")
    f.write(f"static const float {cpp_var_name}[{tensor.numel()}] = {{\n")

    # Flatten the tensor and iterate through its values
    flat_tensor = tensor.detach().cpu().view(-1) # Flatten

    for i, val in enumerate(flat_tensor):
        f.write(f"    {val.item():.8f}f") # Format with 8 decimal places

        if i < tensor.numel() - 1:
            f.write(",")
        else:
            f.write(" ") # No comma after the last element

        if (i + 1) % values_per_line == 0 or i == tensor.numel() - 1:
            f.write("\n")
        else:
            f.write(" ") # Space between values on the same line

    f.write("};\n\n")

# --- Main Script Logic ---
print("--- Xception Weight Extraction ---")

# 1. Calculate output file path
script_dir = os.path.dirname(__file__)
output_path = os.path.abspath(os.path.join(script_dir, OUTPUT_FILENAME))
print(f"Output will be written to: {output_path}")

# 2. Load pre-trained Xception model
print("Loading pre-trained Xception model...")
try:
    model = models.xception(pretrained=True)
    print("Loaded model trained for 1000 classes.")

    # 3. Check and potentially modify the final classifier layer
    if model.fc.out_features != CPP_NUM_CLASSES:
        print(f"WARNING: C++ code expects {CPP_NUM_CLASSES} classes, but loaded model has {model.fc.out_features}.")
        print(f"         Replacing the final classifier layer with a randomly initialized one of size {CPP_NUM_CLASSES}.")
        print("         For accurate results, use weights trained for your specific number of classes.")
        model.fc = torch.nn.Linear(model.fc.in_features, CPP_NUM_CLASSES)

    else:
        print(f"Model's {model.fc.out_features} classes match CPP_NUM_CLASSES ({CPP_NUM_CLASSES}). Using pre-trained classifier weights.")

except ImportError:
     print("ERROR: PyTorch or Torchvision not found. Please install them (`pip install torch torchvision`)")
     sys.exit(1)
except Exception as e:
     print(f"ERROR: Failed to load model: {e}")
     sys.exit(1)

# 4. Extract weights and biases
print("Extracting weights and writing to xception_weights.h...")

# Entry flow weights
entry_conv1_weights = model.conv1.weight.detach().numpy()
entry_conv1_biases = model.conv1.bias.detach().numpy()

entry_conv2_weights = model.conv2.weight.detach().numpy()
entry_conv2_biases = model.conv2.bias.detach().numpy()

# Block 1 weights
entry_b1_res_conv_weights = model.block1.res_conv.weight.detach().numpy()
entry_b1_res_conv_biases = model.block1.res_conv.bias.detach().numpy()

entry_b1_sep1_dw_weights = model.block1.sep_conv1.depthwise.weight.detach().numpy()
entry_b1_sep1_pw_weights = model.block1.sep_conv1.pointwise.weight.detach().numpy()
entry_b1_sep1_pw_biases = model.block1.sep_conv1.pointwise.bias.detach().numpy()

entry_b1_sep2_dw_weights = model.block1.sep_conv2.depthwise.weight.detach().numpy()
entry_b1_sep2_pw_weights = model.block1.sep_conv2.pointwise.weight.detach().numpy()
entry_b1_sep2_pw_biases = model.block1.sep_conv2.pointwise.bias.detach().numpy()

# 5. Open the output file and write weights/biases
try:
    with open(output_path, "w") as f:
        # --- Header ---
        f.write("#ifndef XCEPTION_WEIGHTS_H\n")
        f.write("#define XCEPTION_WEIGHTS_H\n\n")
        f.write('#include "squeezenet_params.h"\n\n')
        f.write("// ==========================================================================\n")
        f.write("// === Xception Weights and Biases ====================================\n")
        f.write("// ==========================================================================\n")
        f.write("// Extracted from torchvision pre-trained model.\n")
        f.write("// WARNING: If NUM_CLASSES was modified, classifier weights are RANDOM.\n")
        f.write("// Weight shape convention: (OutC, InC, KH, KW) flattened\n")
        f.write("// Bias shape convention: (OutC)\n")
        f.write("// ==========================================================================\n\n")

        # --- Entry flow weights ---
        f.write("// Entry Flow Weights\n")
        f.write("static const float entry_conv1_weights[] = {\n")
        np.savetxt(f, entry_conv1_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_conv1_biases[] = {\n")
        np.savetxt(f, entry_conv1_biases, fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_conv2_weights[] = {\n")
        np.savetxt(f, entry_conv2_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_conv2_biases[] = {\n")
        np.savetxt(f, entry_conv2_biases, fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        # --- Block 1 weights ---
        f.write("// Block 1 Weights\n")
        f.write("static const float entry_b1_res_conv_weights[] = {\n")
        np.savetxt(f, entry_b1_res_conv_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_res_conv_biases[] = {\n")
        np.savetxt(f, entry_b1_res_conv_biases, fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_sep1_dw_weights[] = {\n")
        np.savetxt(f, entry_b1_sep1_dw_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_sep1_pw_weights[] = {\n")
        np.savetxt(f, entry_b1_sep1_pw_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_sep1_pw_biases[] = {\n")
        np.savetxt(f, entry_b1_sep1_pw_biases, fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_sep2_dw_weights[] = {\n")
        np.savetxt(f, entry_b1_sep2_dw_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_sep2_pw_weights[] = {\n")
        np.savetxt(f, entry_b1_sep2_pw_weights.flatten(), fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")
        
        f.write("static const float entry_b1_sep2_pw_biases[] = {\n")
        np.savetxt(f, entry_b1_sep2_pw_biases, fmt='%f', delimiter=', ', newline=',\n')
        f.write("};\n\n")

        # --- Footer ---
        f.write("\n#endif // XCEPTION_WEIGHTS_H\n")

except IOError as e:
    print(f"\nERROR: Could not write to file '{output_path}': {e}")
    sys.exit(1)
except Exception as e:
    print(f"\nERROR: An unexpected error occurred during weight writing: {e}")
    sys.exit(1)

print(f"\nSuccessfully extracted weights to {output_path}")
print("--- Weight Extraction Complete ---")