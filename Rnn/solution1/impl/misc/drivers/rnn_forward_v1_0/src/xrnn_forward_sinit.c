// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xrnn_forward.h"

extern XRnn_forward_Config XRnn_forward_ConfigTable[];

#ifdef SDT
XRnn_forward_Config *XRnn_forward_LookupConfig(UINTPTR BaseAddress) {
	XRnn_forward_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XRnn_forward_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XRnn_forward_ConfigTable[Index].Control_bus_BaseAddress == BaseAddress) {
			ConfigPtr = &XRnn_forward_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XRnn_forward_Initialize(XRnn_forward *InstancePtr, UINTPTR BaseAddress) {
	XRnn_forward_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XRnn_forward_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XRnn_forward_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XRnn_forward_Config *XRnn_forward_LookupConfig(u16 DeviceId) {
	XRnn_forward_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XRNN_FORWARD_NUM_INSTANCES; Index++) {
		if (XRnn_forward_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XRnn_forward_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XRnn_forward_Initialize(XRnn_forward *InstancePtr, u16 DeviceId) {
	XRnn_forward_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XRnn_forward_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XRnn_forward_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

