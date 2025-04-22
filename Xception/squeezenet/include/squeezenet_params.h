#ifndef SQUEEZENET_PARAMS_H
#define SQUEEZENET_PARAMS_H

// Input Parameters
#define INPUT_H 224
#define INPUT_W 224
#define INPUT_C 3
#define NUM_CLASSES 1000

// Layer Dimensions
// Conv1
#define CONV1_H_OUT 111
#define CONV1_W_OUT 111
#define CONV1_C_OUT 96

// MaxPool1
#define POOL1_H_OUT 55
#define POOL1_W_OUT 55

// Fire2
#define FIRE2_H_OUT 55
#define FIRE2_W_OUT 55
#define FIRE2_C_OUT 128

// Fire3
#define FIRE3_H_OUT 55
#define FIRE3_W_OUT 55
#define FIRE3_C_OUT 128

// Fire4
#define FIRE4_H_OUT 27
#define FIRE4_W_OUT 27
#define FIRE4_C_OUT 256

// Fire5
#define FIRE5_H_OUT 27
#define FIRE5_W_OUT 27
#define FIRE5_C_OUT 256

// Fire6
#define FIRE6_H_OUT 13
#define FIRE6_W_OUT 13
#define FIRE6_C_OUT 384

// Fire7
#define FIRE7_H_OUT 13
#define FIRE7_W_OUT 13
#define FIRE7_C_OUT 384

// Fire8
#define FIRE8_H_OUT 13
#define FIRE8_W_OUT 13
#define FIRE8_C_OUT 512

// Fire9
#define FIRE9_H_OUT 13
#define FIRE9_W_OUT 13
#define FIRE9_C_OUT 512

// Conv10
#define CONV10_H_OUT 13
#define CONV10_W_OUT 13
#define CONV10_C_OUT 1000

// Buffer Sizes
#define BUF_CONV1_SIZE (CONV1_H_OUT * CONV1_W_OUT * CONV1_C_OUT)
#define BUF_POOL1_SIZE (POOL1_H_OUT * POOL1_W_OUT * CONV1_C_OUT)
#define BUF_FIRE2_SIZE (FIRE2_H_OUT * FIRE2_W_OUT * FIRE2_C_OUT)
#define BUF_FIRE3_SIZE (FIRE3_H_OUT * FIRE3_W_OUT * FIRE3_C_OUT)
#define BUF_FIRE4_SIZE (FIRE4_H_OUT * FIRE4_W_OUT * FIRE4_C_OUT)
#define BUF_FIRE5_SIZE (FIRE5_H_OUT * FIRE5_W_OUT * FIRE5_C_OUT)
#define BUF_FIRE6_SIZE (FIRE6_H_OUT * FIRE6_W_OUT * FIRE6_C_OUT)
#define BUF_FIRE7_SIZE (FIRE7_H_OUT * FIRE7_W_OUT * FIRE7_C_OUT)
#define BUF_FIRE8_SIZE (FIRE8_H_OUT * FIRE8_W_OUT * FIRE8_C_OUT)
#define BUF_FIRE9_SIZE (FIRE9_H_OUT * FIRE9_W_OUT * FIRE9_C_OUT)
#define BUF_CONV10_SIZE (CONV10_H_OUT * CONV10_W_OUT * CONV10_C_OUT)

// Fire Module Buffer Sizes
#define MAX_SQUEEZE_SIZE (FIRE9_H_OUT * FIRE9_W_OUT * 512) // Maximum squeeze layer size
#define MAX_EXPAND_SIZE (FIRE9_H_OUT * FIRE9_W_OUT * 512)  // Maximum expand layer size

#endif // SQUEEZENET_PARAMS_H 