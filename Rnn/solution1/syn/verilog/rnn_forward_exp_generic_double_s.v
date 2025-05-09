// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module rnn_forward_exp_generic_double_s (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        ap_ce,
        x,
        ap_return
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   ap_ce;
input  [63:0] x;
output  [63:0] ap_return;

reg ap_done;
reg ap_idle;
reg ap_ready;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_enable_reg_pp0_iter5;
reg    ap_enable_reg_pp0_iter6;
reg    ap_enable_reg_pp0_iter7;
reg    ap_idle_pp0;
reg    ap_block_pp0_stage0_subdone;
wire   [7:0] table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_address0;
reg    table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_ce0;
wire   [57:0] table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_q0;
wire   [7:0] table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address0;
reg    table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0;
wire   [25:0] table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q0;
wire   [7:0] table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address1;
reg    table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce1;
wire   [25:0] table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q1;
wire   [7:0] table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address0;
reg    table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0;
wire   [41:0] table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q0;
wire   [0:0] es_sign_fu_274_p3;
reg   [0:0] es_sign_reg_1104;
wire    ap_block_pp0_stage0_11001;
reg   [0:0] es_sign_reg_1104_pp0_iter1_reg;
reg   [0:0] es_sign_reg_1104_pp0_iter2_reg;
reg   [0:0] es_sign_reg_1104_pp0_iter3_reg;
reg   [0:0] es_sign_reg_1104_pp0_iter4_reg;
reg   [0:0] es_sign_reg_1104_pp0_iter5_reg;
reg   [0:0] es_sign_reg_1104_pp0_iter6_reg;
wire   [0:0] icmp_ln18_fu_296_p2;
reg   [0:0] icmp_ln18_reg_1109;
reg   [0:0] icmp_ln18_reg_1109_pp0_iter1_reg;
reg   [0:0] icmp_ln18_reg_1109_pp0_iter2_reg;
reg   [0:0] icmp_ln18_reg_1109_pp0_iter3_reg;
reg   [0:0] icmp_ln18_reg_1109_pp0_iter4_reg;
reg   [0:0] icmp_ln18_reg_1109_pp0_iter5_reg;
reg   [0:0] icmp_ln18_reg_1109_pp0_iter6_reg;
wire   [0:0] icmp_ln18_1_fu_302_p2;
reg   [0:0] icmp_ln18_1_reg_1117;
reg   [0:0] icmp_ln18_1_reg_1117_pp0_iter1_reg;
reg   [0:0] icmp_ln18_1_reg_1117_pp0_iter2_reg;
reg   [0:0] icmp_ln18_1_reg_1117_pp0_iter3_reg;
reg   [0:0] icmp_ln18_1_reg_1117_pp0_iter4_reg;
reg   [0:0] icmp_ln18_1_reg_1117_pp0_iter5_reg;
reg   [0:0] icmp_ln18_1_reg_1117_pp0_iter6_reg;
wire   [53:0] select_ln224_fu_336_p3;
reg   [53:0] select_ln224_reg_1123;
reg   [53:0] select_ln224_reg_1123_pp0_iter1_reg;
reg   [53:0] select_ln224_reg_1123_pp0_iter2_reg;
reg   [53:0] select_ln224_reg_1123_pp0_iter3_reg;
reg   [53:0] select_ln224_reg_1123_pp0_iter4_reg;
reg   [53:0] select_ln224_reg_1123_pp0_iter5_reg;
reg   [53:0] select_ln224_reg_1123_pp0_iter6_reg;
reg   [0:0] tmp_1_reg_1128;
reg   [0:0] tmp_1_reg_1128_pp0_iter1_reg;
wire   [58:0] trunc_ln255_fu_458_p1;
reg   [58:0] trunc_ln255_reg_1138;
reg   [58:0] trunc_ln255_reg_1138_pp0_iter1_reg;
reg   [58:0] trunc_ln255_reg_1138_pp0_iter2_reg;
reg   [58:0] trunc_ln255_reg_1138_pp0_iter3_reg;
wire   [0:0] icmp_ln309_fu_462_p2;
reg   [0:0] icmp_ln309_reg_1143;
reg   [0:0] icmp_ln309_reg_1143_pp0_iter1_reg;
reg   [0:0] icmp_ln309_reg_1143_pp0_iter2_reg;
reg   [0:0] icmp_ln309_reg_1143_pp0_iter3_reg;
reg   [0:0] icmp_ln309_reg_1143_pp0_iter4_reg;
reg   [0:0] icmp_ln309_reg_1143_pp0_iter5_reg;
reg   [0:0] icmp_ln309_reg_1143_pp0_iter6_reg;
wire   [0:0] icmp_ln309_2_fu_484_p2;
reg   [0:0] icmp_ln309_2_reg_1151;
reg   [0:0] icmp_ln309_2_reg_1151_pp0_iter1_reg;
reg   [0:0] icmp_ln309_2_reg_1151_pp0_iter2_reg;
reg   [0:0] icmp_ln309_2_reg_1151_pp0_iter3_reg;
reg   [0:0] icmp_ln309_2_reg_1151_pp0_iter4_reg;
reg   [0:0] icmp_ln309_2_reg_1151_pp0_iter5_reg;
reg   [0:0] icmp_ln309_2_reg_1151_pp0_iter6_reg;
wire  signed [12:0] r_exp_fu_540_p3;
reg  signed [12:0] r_exp_reg_1161;
reg  signed [12:0] r_exp_reg_1161_pp0_iter4_reg;
reg  signed [12:0] r_exp_reg_1161_pp0_iter5_reg;
reg  signed [12:0] r_exp_reg_1161_pp0_iter6_reg;
reg   [7:0] m_diff_hi_reg_1168;
reg   [7:0] Z2_reg_1173;
reg   [7:0] Z2_reg_1173_pp0_iter5_reg;
wire   [7:0] Z3_fu_595_p4;
reg   [7:0] Z3_reg_1180;
wire   [34:0] Z4_fu_605_p1;
reg   [34:0] Z4_reg_1185;
wire   [42:0] exp_Z3_m_1_fu_656_p4;
reg   [42:0] exp_Z3_m_1_reg_1205;
wire   [35:0] add_ln130_fu_689_p2;
reg   [35:0] add_ln130_reg_1210;
reg   [57:0] exp_Z1_reg_1220;
reg   [49:0] exp_Z1P_m_1_reg_1225;
reg   [49:0] exp_Z1_hi_reg_1230;
wire   [63:0] zext_ln114_fu_619_p1;
wire    ap_block_pp0_stage0;
wire   [63:0] zext_ln119_fu_624_p1;
wire   [63:0] zext_ln292_fu_629_p1;
wire   [63:0] zext_ln138_fu_695_p1;
wire   [42:0] mul_ln123_fu_258_p0;
wire   [35:0] mul_ln123_fu_258_p1;
wire   [48:0] mul_ln142_fu_262_p0;
wire   [43:0] mul_ln142_fu_262_p1;
wire   [49:0] mul_ln297_fu_266_p0;
wire   [49:0] mul_ln297_fu_266_p1;
wire   [63:0] data_fu_270_p1;
wire   [10:0] es_exp_fu_282_p4;
wire   [51:0] es_sig_fu_292_p1;
wire   [11:0] zext_ln486_fu_308_p1;
wire   [52:0] e_frac_fu_318_p3;
wire   [53:0] zext_ln221_fu_326_p1;
wire   [53:0] e_frac_1_fu_330_p2;
wire   [60:0] m_frac_l_fu_344_p3;
wire   [11:0] m_exp_fu_312_p2;
wire   [10:0] sub_ln229_fu_364_p2;
wire   [0:0] tmp_fu_356_p3;
wire  signed [11:0] sext_ln229_fu_370_p1;
wire   [11:0] select_ln229_fu_374_p3;
wire  signed [31:0] sext_ln229_1_fu_382_p1;
wire  signed [70:0] sext_ln227_fu_352_p1;
wire   [70:0] zext_ln229_fu_386_p1;
wire   [70:0] ashr_ln229_fu_390_p2;
wire   [70:0] shl_ln229_fu_396_p2;
wire   [70:0] m_fix_fu_402_p3;
wire   [63:0] m_fix_l_fu_410_p4;
wire   [63:0] zext_ln230_fu_420_p1;
wire  signed [15:0] m_fix_hi_fu_436_p4;
wire   [63:0] shl_ln230_fu_424_p2;
wire   [63:0] ashr_ln230_fu_430_p2;
wire   [63:0] select_ln230_fu_468_p3;
wire   [70:0] shl_ln2_fu_476_p3;
wire  signed [18:0] shl_ln_fu_490_p3;
wire  signed [30:0] grp_fu_1093_p3;
wire   [17:0] trunc_ln243_fu_517_p1;
wire   [12:0] tmp_cast_fu_501_p4;
wire   [0:0] icmp_ln243_fu_520_p2;
wire   [12:0] add_ln243_1_fu_526_p2;
wire   [0:0] tmp_7_fu_510_p3;
wire   [12:0] select_ln243_fu_532_p3;
wire   [70:0] mul_ln249_fu_253_p2;
wire   [57:0] tmp_2_fu_552_p4;
wire   [58:0] and_ln_fu_562_p3;
wire   [58:0] m_diff_fu_570_p2;
wire   [7:0] Z4_ind_fu_609_p4;
wire   [9:0] f_Z4_fu_633_p4;
wire   [35:0] zext_ln115_fu_643_p1;
wire   [35:0] zext_ln115_1_fu_646_p1;
wire   [35:0] exp_Z4_m_1_fu_650_p2;
wire   [78:0] mul_ln123_fu_258_p2;
wire   [19:0] tmp_4_fu_675_p4;
wire   [35:0] zext_ln130_1_fu_685_p1;
wire   [43:0] zext_ln130_fu_702_p1;
wire   [43:0] zext_ln120_fu_699_p1;
wire   [39:0] tmp_6_fu_711_p4;
wire   [48:0] exp_Z2_m_1_fu_721_p4;
wire   [43:0] exp_Z2P_m_1_fu_705_p2;
wire   [50:0] and_ln1_fu_740_p5;
wire   [92:0] mul_ln142_fu_262_p2;
wire   [35:0] tmp_8_fu_755_p4;
wire   [43:0] zext_ln145_2_fu_765_p1;
wire   [43:0] add_ln145_fu_769_p2;
wire   [51:0] zext_ln145_1_fu_775_p1;
wire   [51:0] zext_ln145_fu_751_p1;
wire   [51:0] exp_Z1P_m_1_l_fu_779_p2;
wire   [0:0] xor_ln182_fu_805_p2;
wire   [0:0] and_ln182_1_fu_810_p2;
wire   [0:0] xor_ln18_fu_820_p2;
wire   [0:0] and_ln18_fu_825_p2;
wire   [0:0] and_ln182_fu_815_p2;
wire   [0:0] or_ln185_fu_838_p2;
wire   [63:0] select_ln18_fu_830_p3;
wire   [57:0] add_ln297_fu_852_p2;
wire   [99:0] mul_ln297_fu_266_p2;
wire   [106:0] shl_ln1_fu_865_p3;
wire   [106:0] zext_ln297_2_fu_873_p1;
wire   [106:0] add_ln297_1_fu_877_p2;
wire   [0:0] tmp_9_fu_883_p3;
wire   [12:0] r_exp_1_fu_891_p2;
wire   [12:0] r_exp_2_fu_896_p3;
wire   [2:0] tmp_10_fu_903_p4;
wire   [0:0] icmp_ln309_1_fu_913_p2;
wire   [0:0] tmp_11_fu_924_p3;
wire   [10:0] trunc_ln336_fu_945_p1;
wire   [51:0] tmp_3_fu_955_p4;
wire   [51:0] tmp_5_fu_965_p4;
wire   [10:0] out_exp_fu_949_p2;
wire   [51:0] select_ln303_fu_975_p3;
wire   [63:0] t_fu_983_p4;
wire   [63:0] select_ln185_fu_844_p3;
wire   [63:0] bitcast_ln497_fu_993_p1;
wire   [0:0] or_ln309_fu_919_p2;
wire   [0:0] xor_ln309_fu_1009_p2;
wire   [0:0] and_ln309_fu_1004_p2;
wire   [0:0] and_ln309_1_fu_1014_p2;
wire   [0:0] or_ln309_1_fu_1020_p2;
wire   [0:0] xor_ln18_1_fu_1026_p2;
wire   [0:0] and_ln309_2_fu_1031_p2;
wire   [63:0] select_ln310_fu_931_p3;
wire   [63:0] select_ln18_1_fu_997_p3;
wire   [0:0] xor_ln309_1_fu_1045_p2;
wire   [0:0] or_ln309_2_fu_1056_p2;
wire   [0:0] and_ln309_3_fu_1051_p2;
wire   [0:0] xor_ln309_2_fu_1061_p2;
wire   [0:0] or_ln309_3_fu_1067_p2;
wire   [0:0] and_ln309_4_fu_1073_p2;
wire   [0:0] icmp_ln326_fu_939_p2;
wire   [0:0] and_ln309_5_fu_1079_p2;
wire   [63:0] select_ln309_fu_1037_p3;
wire   [14:0] grp_fu_1093_p1;
reg    grp_fu_1093_ce;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to6;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire   [78:0] mul_ln123_fu_258_p00;
wire   [78:0] mul_ln123_fu_258_p10;
wire   [92:0] mul_ln142_fu_262_p00;
wire   [92:0] mul_ln142_fu_262_p10;
wire   [99:0] mul_ln297_fu_266_p00;
wire   [99:0] mul_ln297_fu_266_p10;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_enable_reg_pp0_iter5 = 1'b0;
#0 ap_enable_reg_pp0_iter6 = 1'b0;
#0 ap_enable_reg_pp0_iter7 = 1'b0;
end

rnn_forward_exp_generic_double_s_table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_arbkb #(
    .DataWidth( 58 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_address0),
    .ce0(table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_ce0),
    .q0(table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_q0)
);

rnn_forward_exp_generic_double_s_table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arracud #(
    .DataWidth( 26 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address0),
    .ce0(table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0),
    .q0(table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q0),
    .address1(table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address1),
    .ce1(table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce1),
    .q1(table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q1)
);

rnn_forward_exp_generic_double_s_table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arradEe #(
    .DataWidth( 42 ),
    .AddressRange( 256 ),
    .AddressWidth( 8 ))
table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_U(
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address0),
    .ce0(table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0),
    .q0(table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q0)
);

rnn_forward_mul_13s_71s_71_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 13 ),
    .din1_WIDTH( 71 ),
    .dout_WIDTH( 71 ))
mul_13s_71s_71_1_1_U1(
    .din0(r_exp_reg_1161),
    .din1(71'd1636647506585939924452),
    .dout(mul_ln249_fu_253_p2)
);

rnn_forward_mul_43ns_36ns_79_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 43 ),
    .din1_WIDTH( 36 ),
    .dout_WIDTH( 79 ))
mul_43ns_36ns_79_1_1_U2(
    .din0(mul_ln123_fu_258_p0),
    .din1(mul_ln123_fu_258_p1),
    .dout(mul_ln123_fu_258_p2)
);

rnn_forward_mul_49ns_44ns_93_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 49 ),
    .din1_WIDTH( 44 ),
    .dout_WIDTH( 93 ))
mul_49ns_44ns_93_1_1_U3(
    .din0(mul_ln142_fu_262_p0),
    .din1(mul_ln142_fu_262_p1),
    .dout(mul_ln142_fu_262_p2)
);

rnn_forward_mul_50ns_50ns_100_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 50 ),
    .din1_WIDTH( 50 ),
    .dout_WIDTH( 100 ))
mul_50ns_50ns_100_1_1_U4(
    .din0(mul_ln297_fu_266_p0),
    .din1(mul_ln297_fu_266_p1),
    .dout(mul_ln297_fu_266_p2)
);

rnn_forward_mac_muladd_16s_15ns_19s_31_4_1 #(
    .ID( 1 ),
    .NUM_STAGE( 4 ),
    .din0_WIDTH( 16 ),
    .din1_WIDTH( 15 ),
    .din2_WIDTH( 19 ),
    .dout_WIDTH( 31 ))
mac_muladd_16s_15ns_19s_31_4_1_U5(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(m_fix_hi_fu_436_p4),
    .din1(grp_fu_1093_p1),
    .din2(shl_ln_fu_490_p3),
    .ce(grp_fu_1093_ce),
    .dout(grp_fu_1093_p3)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter5 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter5 <= ap_enable_reg_pp0_iter4;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter6 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter6 <= ap_enable_reg_pp0_iter5;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter7 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter7 <= ap_enable_reg_pp0_iter6;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce))) begin
        Z2_reg_1173 <= {{m_diff_fu_570_p2[50:43]}};
        Z2_reg_1173_pp0_iter5_reg <= Z2_reg_1173;
        Z3_reg_1180 <= {{m_diff_fu_570_p2[42:35]}};
        Z4_reg_1185 <= Z4_fu_605_p1;
        add_ln130_reg_1210 <= add_ln130_fu_689_p2;
        es_sign_reg_1104_pp0_iter2_reg <= es_sign_reg_1104_pp0_iter1_reg;
        es_sign_reg_1104_pp0_iter3_reg <= es_sign_reg_1104_pp0_iter2_reg;
        es_sign_reg_1104_pp0_iter4_reg <= es_sign_reg_1104_pp0_iter3_reg;
        es_sign_reg_1104_pp0_iter5_reg <= es_sign_reg_1104_pp0_iter4_reg;
        es_sign_reg_1104_pp0_iter6_reg <= es_sign_reg_1104_pp0_iter5_reg;
        exp_Z1P_m_1_reg_1225 <= {{exp_Z1P_m_1_l_fu_779_p2[51:2]}};
        exp_Z1_hi_reg_1230 <= {{table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_q0[57:8]}};
        exp_Z1_reg_1220 <= table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_q0;
        exp_Z3_m_1_reg_1205[25 : 0] <= exp_Z3_m_1_fu_656_p4[25 : 0];
exp_Z3_m_1_reg_1205[42 : 35] <= exp_Z3_m_1_fu_656_p4[42 : 35];
        icmp_ln18_1_reg_1117_pp0_iter2_reg <= icmp_ln18_1_reg_1117_pp0_iter1_reg;
        icmp_ln18_1_reg_1117_pp0_iter3_reg <= icmp_ln18_1_reg_1117_pp0_iter2_reg;
        icmp_ln18_1_reg_1117_pp0_iter4_reg <= icmp_ln18_1_reg_1117_pp0_iter3_reg;
        icmp_ln18_1_reg_1117_pp0_iter5_reg <= icmp_ln18_1_reg_1117_pp0_iter4_reg;
        icmp_ln18_1_reg_1117_pp0_iter6_reg <= icmp_ln18_1_reg_1117_pp0_iter5_reg;
        icmp_ln18_reg_1109_pp0_iter2_reg <= icmp_ln18_reg_1109_pp0_iter1_reg;
        icmp_ln18_reg_1109_pp0_iter3_reg <= icmp_ln18_reg_1109_pp0_iter2_reg;
        icmp_ln18_reg_1109_pp0_iter4_reg <= icmp_ln18_reg_1109_pp0_iter3_reg;
        icmp_ln18_reg_1109_pp0_iter5_reg <= icmp_ln18_reg_1109_pp0_iter4_reg;
        icmp_ln18_reg_1109_pp0_iter6_reg <= icmp_ln18_reg_1109_pp0_iter5_reg;
        icmp_ln309_2_reg_1151_pp0_iter2_reg <= icmp_ln309_2_reg_1151_pp0_iter1_reg;
        icmp_ln309_2_reg_1151_pp0_iter3_reg <= icmp_ln309_2_reg_1151_pp0_iter2_reg;
        icmp_ln309_2_reg_1151_pp0_iter4_reg <= icmp_ln309_2_reg_1151_pp0_iter3_reg;
        icmp_ln309_2_reg_1151_pp0_iter5_reg <= icmp_ln309_2_reg_1151_pp0_iter4_reg;
        icmp_ln309_2_reg_1151_pp0_iter6_reg <= icmp_ln309_2_reg_1151_pp0_iter5_reg;
        icmp_ln309_reg_1143_pp0_iter2_reg <= icmp_ln309_reg_1143_pp0_iter1_reg;
        icmp_ln309_reg_1143_pp0_iter3_reg <= icmp_ln309_reg_1143_pp0_iter2_reg;
        icmp_ln309_reg_1143_pp0_iter4_reg <= icmp_ln309_reg_1143_pp0_iter3_reg;
        icmp_ln309_reg_1143_pp0_iter5_reg <= icmp_ln309_reg_1143_pp0_iter4_reg;
        icmp_ln309_reg_1143_pp0_iter6_reg <= icmp_ln309_reg_1143_pp0_iter5_reg;
        m_diff_hi_reg_1168 <= {{m_diff_fu_570_p2[58:51]}};
        r_exp_reg_1161 <= r_exp_fu_540_p3;
        r_exp_reg_1161_pp0_iter4_reg <= r_exp_reg_1161;
        r_exp_reg_1161_pp0_iter5_reg <= r_exp_reg_1161_pp0_iter4_reg;
        r_exp_reg_1161_pp0_iter6_reg <= r_exp_reg_1161_pp0_iter5_reg;
        select_ln224_reg_1123_pp0_iter2_reg <= select_ln224_reg_1123_pp0_iter1_reg;
        select_ln224_reg_1123_pp0_iter3_reg <= select_ln224_reg_1123_pp0_iter2_reg;
        select_ln224_reg_1123_pp0_iter4_reg <= select_ln224_reg_1123_pp0_iter3_reg;
        select_ln224_reg_1123_pp0_iter5_reg <= select_ln224_reg_1123_pp0_iter4_reg;
        select_ln224_reg_1123_pp0_iter6_reg <= select_ln224_reg_1123_pp0_iter5_reg;
        trunc_ln255_reg_1138_pp0_iter2_reg <= trunc_ln255_reg_1138_pp0_iter1_reg;
        trunc_ln255_reg_1138_pp0_iter3_reg <= trunc_ln255_reg_1138_pp0_iter2_reg;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        es_sign_reg_1104 <= data_fu_270_p1[32'd63];
        es_sign_reg_1104_pp0_iter1_reg <= es_sign_reg_1104;
        icmp_ln18_1_reg_1117 <= icmp_ln18_1_fu_302_p2;
        icmp_ln18_1_reg_1117_pp0_iter1_reg <= icmp_ln18_1_reg_1117;
        icmp_ln18_reg_1109 <= icmp_ln18_fu_296_p2;
        icmp_ln18_reg_1109_pp0_iter1_reg <= icmp_ln18_reg_1109;
        icmp_ln309_2_reg_1151 <= icmp_ln309_2_fu_484_p2;
        icmp_ln309_2_reg_1151_pp0_iter1_reg <= icmp_ln309_2_reg_1151;
        icmp_ln309_reg_1143 <= icmp_ln309_fu_462_p2;
        icmp_ln309_reg_1143_pp0_iter1_reg <= icmp_ln309_reg_1143;
        select_ln224_reg_1123 <= select_ln224_fu_336_p3;
        select_ln224_reg_1123_pp0_iter1_reg <= select_ln224_reg_1123;
        tmp_1_reg_1128 <= m_fix_fu_402_p3[32'd70];
        tmp_1_reg_1128_pp0_iter1_reg <= tmp_1_reg_1128;
        trunc_ln255_reg_1138 <= trunc_ln255_fu_458_p1;
        trunc_ln255_reg_1138_pp0_iter1_reg <= trunc_ln255_reg_1138;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter7 == 1'b1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter7 == 1'b0) & (ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter6 == 1'b0) & (ap_enable_reg_pp0_iter5 == 1'b0) & (ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to6 = 1'b1;
    end else begin
        ap_idle_pp0_0to6 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_idle_pp0_0to6 == 1'b1) & (ap_start == 1'b0))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_ce) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        grp_fu_1093_ce = 1'b1;
    end else begin
        grp_fu_1093_ce = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter5 == 1'b1) & (1'b1 == ap_ce))) begin
        table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_ce0 = 1'b1;
    end else begin
        table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter5 == 1'b1) & (1'b1 == ap_ce))) begin
        table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0 = 1'b1;
    end else begin
        table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1) & (1'b1 == ap_ce))) begin
        table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0 = 1'b1;
    end else begin
        table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1) & (1'b1 == ap_ce))) begin
        table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce1 = 1'b1;
    end else begin
        table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_ce1 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign Z3_fu_595_p4 = {{m_diff_fu_570_p2[42:35]}};

assign Z4_fu_605_p1 = m_diff_fu_570_p2[34:0];

assign Z4_ind_fu_609_p4 = {{m_diff_fu_570_p2[34:27]}};

assign add_ln130_fu_689_p2 = (exp_Z4_m_1_fu_650_p2 + zext_ln130_1_fu_685_p1);

assign add_ln145_fu_769_p2 = (exp_Z2P_m_1_fu_705_p2 + zext_ln145_2_fu_765_p1);

assign add_ln243_1_fu_526_p2 = (tmp_cast_fu_501_p4 + 13'd1);

assign add_ln297_1_fu_877_p2 = (shl_ln1_fu_865_p3 + zext_ln297_2_fu_873_p1);

assign add_ln297_fu_852_p2 = (exp_Z1_reg_1220 + 58'd16);

assign and_ln182_1_fu_810_p2 = (xor_ln182_fu_805_p2 & icmp_ln18_1_reg_1117_pp0_iter6_reg);

assign and_ln182_fu_815_p2 = (icmp_ln18_reg_1109_pp0_iter6_reg & and_ln182_1_fu_810_p2);

assign and_ln18_fu_825_p2 = (xor_ln18_fu_820_p2 & icmp_ln18_reg_1109_pp0_iter6_reg);

assign and_ln1_fu_740_p5 = {{{{Z2_reg_1173_pp0_iter5_reg}, {1'd0}}, {tmp_6_fu_711_p4}}, {2'd0}};

assign and_ln309_1_fu_1014_p2 = (xor_ln309_fu_1009_p2 & icmp_ln309_1_fu_913_p2);

assign and_ln309_2_fu_1031_p2 = (xor_ln18_1_fu_1026_p2 & or_ln309_1_fu_1020_p2);

assign and_ln309_3_fu_1051_p2 = (xor_ln309_1_fu_1045_p2 & icmp_ln309_reg_1143_pp0_iter6_reg);

assign and_ln309_4_fu_1073_p2 = (xor_ln18_1_fu_1026_p2 & or_ln309_3_fu_1067_p2);

assign and_ln309_5_fu_1079_p2 = (icmp_ln326_fu_939_p2 & and_ln309_4_fu_1073_p2);

assign and_ln309_fu_1004_p2 = (or_ln309_fu_919_p2 & icmp_ln309_reg_1143_pp0_iter6_reg);

assign and_ln_fu_562_p3 = {{tmp_2_fu_552_p4}, {1'd0}};

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_subdone = (1'b0 == ap_ce);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign ap_return = ((and_ln309_5_fu_1079_p2[0:0] == 1'b1) ? 64'd0 : select_ln309_fu_1037_p3);

assign ashr_ln229_fu_390_p2 = $signed(sext_ln227_fu_352_p1) >>> zext_ln229_fu_386_p1;

assign ashr_ln230_fu_430_p2 = $signed(m_fix_l_fu_410_p4) >>> zext_ln230_fu_420_p1;

assign bitcast_ln497_fu_993_p1 = t_fu_983_p4;

assign data_fu_270_p1 = x;

assign e_frac_1_fu_330_p2 = (54'd0 - zext_ln221_fu_326_p1);

assign e_frac_fu_318_p3 = {{1'd1}, {es_sig_fu_292_p1}};

assign es_exp_fu_282_p4 = {{data_fu_270_p1[62:52]}};

assign es_sig_fu_292_p1 = data_fu_270_p1[51:0];

assign es_sign_fu_274_p3 = data_fu_270_p1[32'd63];

assign exp_Z1P_m_1_l_fu_779_p2 = (zext_ln145_1_fu_775_p1 + zext_ln145_fu_751_p1);

assign exp_Z2P_m_1_fu_705_p2 = (zext_ln130_fu_702_p1 + zext_ln120_fu_699_p1);

assign exp_Z2_m_1_fu_721_p4 = {{{Z2_reg_1173_pp0_iter5_reg}, {1'd0}}, {tmp_6_fu_711_p4}};

assign exp_Z3_m_1_fu_656_p4 = {{{Z3_reg_1180}, {9'd0}}, {table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q0}};

assign exp_Z4_m_1_fu_650_p2 = (zext_ln115_fu_643_p1 + zext_ln115_1_fu_646_p1);

assign f_Z4_fu_633_p4 = {{table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q1[25:16]}};

assign grp_fu_1093_p1 = 31'd23637;

assign icmp_ln18_1_fu_302_p2 = ((es_sig_fu_292_p1 == 52'd0) ? 1'b1 : 1'b0);

assign icmp_ln18_fu_296_p2 = ((es_exp_fu_282_p4 == 11'd2047) ? 1'b1 : 1'b0);

assign icmp_ln243_fu_520_p2 = ((trunc_ln243_fu_517_p1 == 18'd0) ? 1'b1 : 1'b0);

assign icmp_ln309_1_fu_913_p2 = (($signed(tmp_10_fu_903_p4) > $signed(3'd0)) ? 1'b1 : 1'b0);

assign icmp_ln309_2_fu_484_p2 = ((shl_ln2_fu_476_p3 != sext_ln227_fu_352_p1) ? 1'b1 : 1'b0);

assign icmp_ln309_fu_462_p2 = (($signed(m_exp_fu_312_p2) > $signed(12'd0)) ? 1'b1 : 1'b0);

assign icmp_ln326_fu_939_p2 = (($signed(r_exp_2_fu_896_p3) < $signed(13'd7170)) ? 1'b1 : 1'b0);

assign m_diff_fu_570_p2 = (trunc_ln255_reg_1138_pp0_iter3_reg - and_ln_fu_562_p3);

assign m_exp_fu_312_p2 = ($signed(zext_ln486_fu_308_p1) + $signed(12'd3073));

assign m_fix_fu_402_p3 = ((tmp_fu_356_p3[0:0] == 1'b1) ? ashr_ln229_fu_390_p2 : shl_ln229_fu_396_p2);

assign m_fix_hi_fu_436_p4 = {{m_fix_fu_402_p3[70:55]}};

assign m_fix_l_fu_410_p4 = {{m_fix_fu_402_p3[70:7]}};

assign m_frac_l_fu_344_p3 = {{select_ln224_fu_336_p3}, {7'd0}};

assign mul_ln123_fu_258_p0 = mul_ln123_fu_258_p00;

assign mul_ln123_fu_258_p00 = exp_Z3_m_1_fu_656_p4;

assign mul_ln123_fu_258_p1 = mul_ln123_fu_258_p10;

assign mul_ln123_fu_258_p10 = exp_Z4_m_1_fu_650_p2;

assign mul_ln142_fu_262_p0 = mul_ln142_fu_262_p00;

assign mul_ln142_fu_262_p00 = exp_Z2_m_1_fu_721_p4;

assign mul_ln142_fu_262_p1 = mul_ln142_fu_262_p10;

assign mul_ln142_fu_262_p10 = exp_Z2P_m_1_fu_705_p2;

assign mul_ln297_fu_266_p0 = mul_ln297_fu_266_p00;

assign mul_ln297_fu_266_p00 = exp_Z1P_m_1_reg_1225;

assign mul_ln297_fu_266_p1 = mul_ln297_fu_266_p10;

assign mul_ln297_fu_266_p10 = exp_Z1_hi_reg_1230;

assign or_ln185_fu_838_p2 = (and_ln18_fu_825_p2 | and_ln182_fu_815_p2);

assign or_ln309_1_fu_1020_p2 = (and_ln309_fu_1004_p2 | and_ln309_1_fu_1014_p2);

assign or_ln309_2_fu_1056_p2 = (icmp_ln309_reg_1143_pp0_iter6_reg | icmp_ln309_1_fu_913_p2);

assign or_ln309_3_fu_1067_p2 = (xor_ln309_2_fu_1061_p2 | and_ln309_3_fu_1051_p2);

assign or_ln309_fu_919_p2 = (icmp_ln309_2_reg_1151_pp0_iter6_reg | icmp_ln309_1_fu_913_p2);

assign out_exp_fu_949_p2 = (trunc_ln336_fu_945_p1 + 11'd1023);

assign r_exp_1_fu_891_p2 = ($signed(r_exp_reg_1161_pp0_iter6_reg) + $signed(13'd8191));

assign r_exp_2_fu_896_p3 = ((tmp_9_fu_883_p3[0:0] == 1'b1) ? r_exp_reg_1161_pp0_iter6_reg : r_exp_1_fu_891_p2);

assign r_exp_fu_540_p3 = ((tmp_7_fu_510_p3[0:0] == 1'b1) ? select_ln243_fu_532_p3 : tmp_cast_fu_501_p4);

assign select_ln185_fu_844_p3 = ((or_ln185_fu_838_p2[0:0] == 1'b1) ? select_ln18_fu_830_p3 : 64'd0);

assign select_ln18_1_fu_997_p3 = ((icmp_ln18_reg_1109_pp0_iter6_reg[0:0] == 1'b1) ? select_ln185_fu_844_p3 : bitcast_ln497_fu_993_p1);

assign select_ln18_fu_830_p3 = ((and_ln18_fu_825_p2[0:0] == 1'b1) ? 64'd9223372036854775807 : 64'd9218868437227405312);

assign select_ln224_fu_336_p3 = ((es_sign_fu_274_p3[0:0] == 1'b1) ? e_frac_1_fu_330_p2 : zext_ln221_fu_326_p1);

assign select_ln229_fu_374_p3 = ((tmp_fu_356_p3[0:0] == 1'b1) ? sext_ln229_fu_370_p1 : m_exp_fu_312_p2);

assign select_ln230_fu_468_p3 = ((tmp_fu_356_p3[0:0] == 1'b1) ? shl_ln230_fu_424_p2 : ashr_ln230_fu_430_p2);

assign select_ln243_fu_532_p3 = ((icmp_ln243_fu_520_p2[0:0] == 1'b1) ? tmp_cast_fu_501_p4 : add_ln243_1_fu_526_p2);

assign select_ln303_fu_975_p3 = ((tmp_9_fu_883_p3[0:0] == 1'b1) ? tmp_3_fu_955_p4 : tmp_5_fu_965_p4);

assign select_ln309_fu_1037_p3 = ((and_ln309_2_fu_1031_p2[0:0] == 1'b1) ? select_ln310_fu_931_p3 : select_ln18_1_fu_997_p3);

assign select_ln310_fu_931_p3 = ((tmp_11_fu_924_p3[0:0] == 1'b1) ? 64'd0 : 64'd9218868437227405312);

assign sext_ln227_fu_352_p1 = $signed(m_frac_l_fu_344_p3);

assign sext_ln229_1_fu_382_p1 = $signed(select_ln229_fu_374_p3);

assign sext_ln229_fu_370_p1 = $signed(sub_ln229_fu_364_p2);

assign shl_ln1_fu_865_p3 = {{add_ln297_fu_852_p2}, {49'd0}};

assign shl_ln229_fu_396_p2 = sext_ln227_fu_352_p1 << zext_ln229_fu_386_p1;

assign shl_ln230_fu_424_p2 = m_fix_l_fu_410_p4 << zext_ln230_fu_420_p1;

assign shl_ln2_fu_476_p3 = {{select_ln230_fu_468_p3}, {7'd0}};

assign shl_ln_fu_490_p3 = {{tmp_1_reg_1128_pp0_iter1_reg}, {18'd131072}};

assign sub_ln229_fu_364_p2 = (11'd1023 - es_exp_fu_282_p4);

assign t_fu_983_p4 = {{{{1'd0}, {out_exp_fu_949_p2}}}, {select_ln303_fu_975_p3}};

assign table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_array_address0 = zext_ln292_fu_629_p1;

assign table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address0 = zext_ln138_fu_695_p1;

assign table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address0 = zext_ln119_fu_624_p1;

assign table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_address1 = zext_ln114_fu_619_p1;

assign tmp_10_fu_903_p4 = {{r_exp_2_fu_896_p3[12:10]}};

assign tmp_11_fu_924_p3 = select_ln224_reg_1123_pp0_iter6_reg[32'd53];

assign tmp_2_fu_552_p4 = {{mul_ln249_fu_253_p2[70:13]}};

assign tmp_3_fu_955_p4 = {{add_ln297_1_fu_877_p2[105:54]}};

assign tmp_4_fu_675_p4 = {{mul_ln123_fu_258_p2[78:59]}};

assign tmp_5_fu_965_p4 = {{add_ln297_1_fu_877_p2[104:53]}};

assign tmp_6_fu_711_p4 = {{table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_array_q0[41:2]}};

assign tmp_7_fu_510_p3 = grp_fu_1093_p3[32'd30];

assign tmp_8_fu_755_p4 = {{mul_ln142_fu_262_p2[92:57]}};

assign tmp_9_fu_883_p3 = add_ln297_1_fu_877_p2[32'd106];

assign tmp_cast_fu_501_p4 = {{grp_fu_1093_p3[30:18]}};

assign tmp_fu_356_p3 = m_exp_fu_312_p2[32'd11];

assign trunc_ln243_fu_517_p1 = grp_fu_1093_p3[17:0];

assign trunc_ln255_fu_458_p1 = m_fix_fu_402_p3[58:0];

assign trunc_ln336_fu_945_p1 = r_exp_2_fu_896_p3[10:0];

assign xor_ln182_fu_805_p2 = (es_sign_reg_1104_pp0_iter6_reg ^ 1'd1);

assign xor_ln18_1_fu_1026_p2 = (icmp_ln18_reg_1109_pp0_iter6_reg ^ 1'd1);

assign xor_ln18_fu_820_p2 = (icmp_ln18_1_reg_1117_pp0_iter6_reg ^ 1'd1);

assign xor_ln309_1_fu_1045_p2 = (or_ln309_fu_919_p2 ^ 1'd1);

assign xor_ln309_2_fu_1061_p2 = (or_ln309_2_fu_1056_p2 ^ 1'd1);

assign xor_ln309_fu_1009_p2 = (icmp_ln309_reg_1143_pp0_iter6_reg ^ 1'd1);

assign zext_ln114_fu_619_p1 = Z4_ind_fu_609_p4;

assign zext_ln115_1_fu_646_p1 = f_Z4_fu_633_p4;

assign zext_ln115_fu_643_p1 = Z4_reg_1185;

assign zext_ln119_fu_624_p1 = Z3_fu_595_p4;

assign zext_ln120_fu_699_p1 = exp_Z3_m_1_reg_1205;

assign zext_ln130_1_fu_685_p1 = tmp_4_fu_675_p4;

assign zext_ln130_fu_702_p1 = add_ln130_reg_1210;

assign zext_ln138_fu_695_p1 = Z2_reg_1173;

assign zext_ln145_1_fu_775_p1 = add_ln145_fu_769_p2;

assign zext_ln145_2_fu_765_p1 = tmp_8_fu_755_p4;

assign zext_ln145_fu_751_p1 = and_ln1_fu_740_p5;

assign zext_ln221_fu_326_p1 = e_frac_fu_318_p3;

assign zext_ln229_fu_386_p1 = $unsigned(sext_ln229_1_fu_382_p1);

assign zext_ln230_fu_420_p1 = $unsigned(sext_ln229_1_fu_382_p1);

assign zext_ln292_fu_629_p1 = m_diff_hi_reg_1168;

assign zext_ln297_2_fu_873_p1 = mul_ln297_fu_266_p2;

assign zext_ln486_fu_308_p1 = es_exp_fu_282_p4;

always @ (posedge ap_clk) begin
    exp_Z3_m_1_reg_1205[34:26] <= 9'b000000000;
end

endmodule //rnn_forward_exp_generic_double_s
