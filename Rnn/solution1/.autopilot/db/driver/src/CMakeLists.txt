# ==============================================================
# Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
# Tool Version Limit: 2023.10
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
# 
# ==============================================================
cmake_minimum_required(VERSION 3.15)
project(rnn_forward)
find_package(common)
collector_create (PROJECT_LIB_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}")
collect (PROJECT_LIB_SOURCES xrnn_forward.c)
collect (PROJECT_LIB_SOURCES xrnn_forward_sinit.c)
collect (PROJECT_LIB_SOURCES xrnn_forward_linux.c)
collect (PROJECT_LIB_SOURCES xrnn_forward_g.c)
collector_list (_sources PROJECT_LIB_SOURCES)
collector_create (PROJECT_LIB_HEADERS "${CMAKE_CURRENT_SOURCE_DIR}")
collect (PROJECT_LIB_HEADERS xrnn_forward.h)
collect (PROJECT_LIB_HEADERS xrnn_forward_hw.h)
collector_list (_headers PROJECT_LIB_HEADERS)
file(COPY ${_headers} DESTINATION ${CMAKE_BINARY_DIR}/include)
include_directories(${CMAKE_BINARY_DIR}/include)
add_library(rnn_forward STATIC ${_sources})
set_target_properties(rnn_forward PROPERTIES LINKER_LANGUAGE C)

