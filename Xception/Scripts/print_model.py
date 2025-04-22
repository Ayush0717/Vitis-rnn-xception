import torch
import torchvision.models as models

def print_model_structure():
    print("Loading SqueezeNet model...")
    model = models.squeezenet1_1(weights=models.SqueezeNet1_1_Weights.IMAGENET1K_V1)
    
    print("\nModel Structure:")
    print(model)
    
    print("\nFeatures Structure:")
    for i, layer in enumerate(model.features):
        print(f"{i}: {layer}")

if __name__ == "__main__":
    print_model_structure() 