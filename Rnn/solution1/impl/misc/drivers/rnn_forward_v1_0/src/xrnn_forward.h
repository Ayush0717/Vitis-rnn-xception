// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XRNN_FORWARD_H
#define XRNN_FORWARD_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xrnn_forward_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_bus_BaseAddress;
} XRnn_forward_Config;
#endif

typedef struct {
    u64 Control_bus_BaseAddress;
    u32 IsReady;
} XRnn_forward;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XRnn_forward_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XRnn_forward_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XRnn_forward_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XRnn_forward_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XRnn_forward_Initialize(XRnn_forward *InstancePtr, UINTPTR BaseAddress);
XRnn_forward_Config* XRnn_forward_LookupConfig(UINTPTR BaseAddress);
#else
int XRnn_forward_Initialize(XRnn_forward *InstancePtr, u16 DeviceId);
XRnn_forward_Config* XRnn_forward_LookupConfig(u16 DeviceId);
#endif
int XRnn_forward_CfgInitialize(XRnn_forward *InstancePtr, XRnn_forward_Config *ConfigPtr);
#else
int XRnn_forward_Initialize(XRnn_forward *InstancePtr, const char* InstanceName);
int XRnn_forward_Release(XRnn_forward *InstancePtr);
#endif

void XRnn_forward_Start(XRnn_forward *InstancePtr);
u32 XRnn_forward_IsDone(XRnn_forward *InstancePtr);
u32 XRnn_forward_IsIdle(XRnn_forward *InstancePtr);
u32 XRnn_forward_IsReady(XRnn_forward *InstancePtr);
void XRnn_forward_EnableAutoRestart(XRnn_forward *InstancePtr);
void XRnn_forward_DisableAutoRestart(XRnn_forward *InstancePtr);

u32 XRnn_forward_Get_input_sequence_BaseAddress(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_input_sequence_HighAddress(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_input_sequence_TotalBytes(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_input_sequence_BitWidth(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_input_sequence_Depth(XRnn_forward *InstancePtr);
u32 XRnn_forward_Write_input_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length);
u32 XRnn_forward_Read_input_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length);
u32 XRnn_forward_Write_input_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length);
u32 XRnn_forward_Read_input_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length);
u32 XRnn_forward_Get_output_sequence_BaseAddress(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_output_sequence_HighAddress(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_output_sequence_TotalBytes(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_output_sequence_BitWidth(XRnn_forward *InstancePtr);
u32 XRnn_forward_Get_output_sequence_Depth(XRnn_forward *InstancePtr);
u32 XRnn_forward_Write_output_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length);
u32 XRnn_forward_Read_output_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length);
u32 XRnn_forward_Write_output_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length);
u32 XRnn_forward_Read_output_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length);

void XRnn_forward_InterruptGlobalEnable(XRnn_forward *InstancePtr);
void XRnn_forward_InterruptGlobalDisable(XRnn_forward *InstancePtr);
void XRnn_forward_InterruptEnable(XRnn_forward *InstancePtr, u32 Mask);
void XRnn_forward_InterruptDisable(XRnn_forward *InstancePtr, u32 Mask);
void XRnn_forward_InterruptClear(XRnn_forward *InstancePtr, u32 Mask);
u32 XRnn_forward_InterruptGetEnabled(XRnn_forward *InstancePtr);
u32 XRnn_forward_InterruptGetStatus(XRnn_forward *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
