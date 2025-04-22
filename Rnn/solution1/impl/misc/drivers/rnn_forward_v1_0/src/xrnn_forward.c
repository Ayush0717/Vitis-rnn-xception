// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xrnn_forward.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XRnn_forward_CfgInitialize(XRnn_forward *InstancePtr, XRnn_forward_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_bus_BaseAddress = ConfigPtr->Control_bus_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XRnn_forward_Start(XRnn_forward *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL) & 0x80;
    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL, Data | 0x01);
}

u32 XRnn_forward_IsDone(XRnn_forward *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XRnn_forward_IsIdle(XRnn_forward *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XRnn_forward_IsReady(XRnn_forward *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XRnn_forward_EnableAutoRestart(XRnn_forward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL, 0x80);
}

void XRnn_forward_DisableAutoRestart(XRnn_forward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_AP_CTRL, 0);
}

u32 XRnn_forward_Get_input_sequence_BaseAddress(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE);
}

u32 XRnn_forward_Get_input_sequence_HighAddress(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_HIGH);
}

u32 XRnn_forward_Get_input_sequence_TotalBytes(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + 1);
}

u32 XRnn_forward_Get_input_sequence_BitWidth(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRNN_FORWARD_CONTROL_BUS_WIDTH_INPUT_SEQUENCE;
}

u32 XRnn_forward_Get_input_sequence_Depth(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRNN_FORWARD_CONTROL_BUS_DEPTH_INPUT_SEQUENCE;
}

u32 XRnn_forward_Write_input_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XRnn_forward_Read_input_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + (offset + i)*4);
    }
    return length;
}

u32 XRnn_forward_Write_input_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XRnn_forward_Read_input_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_INPUT_SEQUENCE_BASE + offset + i);
    }
    return length;
}

u32 XRnn_forward_Get_output_sequence_BaseAddress(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE);
}

u32 XRnn_forward_Get_output_sequence_HighAddress(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_HIGH);
}

u32 XRnn_forward_Get_output_sequence_TotalBytes(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return (XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + 1);
}

u32 XRnn_forward_Get_output_sequence_BitWidth(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRNN_FORWARD_CONTROL_BUS_WIDTH_OUTPUT_SEQUENCE;
}

u32 XRnn_forward_Get_output_sequence_Depth(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRNN_FORWARD_CONTROL_BUS_DEPTH_OUTPUT_SEQUENCE;
}

u32 XRnn_forward_Write_output_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(int *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + (offset + i)*4) = *(data + i);
    }
    return length;
}

u32 XRnn_forward_Read_output_sequence_Words(XRnn_forward *InstancePtr, int offset, word_type *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length)*4 > (XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(int *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + (offset + i)*4);
    }
    return length;
}

u32 XRnn_forward_Write_output_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(char *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + offset + i) = *(data + i);
    }
    return length;
}

u32 XRnn_forward_Read_output_sequence_Bytes(XRnn_forward *InstancePtr, int offset, char *data, int length) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr -> IsReady == XIL_COMPONENT_IS_READY);

    int i;

    if ((offset + length) > (XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_HIGH - XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + 1))
        return 0;

    for (i = 0; i < length; i++) {
        *(data + i) = *(char *)(InstancePtr->Control_bus_BaseAddress + XRNN_FORWARD_CONTROL_BUS_ADDR_OUTPUT_SEQUENCE_BASE + offset + i);
    }
    return length;
}

void XRnn_forward_InterruptGlobalEnable(XRnn_forward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_GIE, 1);
}

void XRnn_forward_InterruptGlobalDisable(XRnn_forward *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_GIE, 0);
}

void XRnn_forward_InterruptEnable(XRnn_forward *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_IER);
    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_IER, Register | Mask);
}

void XRnn_forward_InterruptDisable(XRnn_forward *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_IER);
    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_IER, Register & (~Mask));
}

void XRnn_forward_InterruptClear(XRnn_forward *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XRnn_forward_WriteReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_ISR, Mask);
}

u32 XRnn_forward_InterruptGetEnabled(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_IER);
}

u32 XRnn_forward_InterruptGetStatus(XRnn_forward *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XRnn_forward_ReadReg(InstancePtr->Control_bus_BaseAddress, XRNN_FORWARD_CONTROL_BUS_ADDR_ISR);
}

