set SynModuleInfo {
  {SRCNAME exp_generic<double> MODELNAME exp_generic_double_s RTLNAME rnn_forward_exp_generic_double_s
    SUBMODULES {
      {MODELNAME rnn_forward_mul_13s_71s_71_1_1 RTLNAME rnn_forward_mul_13s_71s_71_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_mul_43ns_36ns_79_1_1 RTLNAME rnn_forward_mul_43ns_36ns_79_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_mul_49ns_44ns_93_1_1 RTLNAME rnn_forward_mul_49ns_44ns_93_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_mul_50ns_50ns_100_1_1 RTLNAME rnn_forward_mul_50ns_50ns_100_1_1 BINDTYPE op TYPE mul IMPL auto LATENCY 0 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_mac_muladd_16s_15ns_19s_31_4_1 RTLNAME rnn_forward_mac_muladd_16s_15ns_19s_31_4_1 BINDTYPE op TYPE all IMPL dsp_slice LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_exp_generic_double_s_table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_arbkb RTLNAME rnn_forward_exp_generic_double_s_table_exp_Z1_ap_ufixed_58_1_ap_q_mode_5_ap_o_mode_3_0_arbkb BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_exp_generic_double_s_table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arracud RTLNAME rnn_forward_exp_generic_double_s_table_f_Z3_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arracud BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_exp_generic_double_s_table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arradEe RTLNAME rnn_forward_exp_generic_double_s_table_f_Z2_ap_ufixed_59_0_ap_q_mode_5_ap_o_mode_3_0_arradEe BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME generic_tanh<double> MODELNAME generic_tanh_double_s RTLNAME rnn_forward_generic_tanh_double_s
    SUBMODULES {
      {MODELNAME rnn_forward_dadd_64ns_64ns_64_5_full_dsp_1 RTLNAME rnn_forward_dadd_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_dsub_64ns_64ns_64_5_full_dsp_1 RTLNAME rnn_forward_dsub_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dsub IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_dmul_64ns_64ns_64_5_max_dsp_1 RTLNAME rnn_forward_dmul_64ns_64ns_64_5_max_dsp_1 BINDTYPE op TYPE dmul IMPL maxdsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_ddiv_64ns_64ns_64_17_no_dsp_1 RTLNAME rnn_forward_ddiv_64ns_64ns_64_17_no_dsp_1 BINDTYPE op TYPE ddiv IMPL fabric LATENCY 16 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_dcmp_64ns_64ns_1_2_no_dsp_1 RTLNAME rnn_forward_dcmp_64ns_64ns_1_2_no_dsp_1 BINDTYPE op TYPE dcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME rnn_forward MODELNAME rnn_forward RTLNAME rnn_forward IS_TOP 1
    SUBMODULES {
      {MODELNAME rnn_forward_fadd_32ns_32ns_32_4_full_dsp_1 RTLNAME rnn_forward_fadd_32ns_32ns_32_4_full_dsp_1 BINDTYPE op TYPE fadd IMPL fulldsp LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_fmul_32ns_32ns_32_3_max_dsp_1 RTLNAME rnn_forward_fmul_32ns_32ns_32_3_max_dsp_1 BINDTYPE op TYPE fmul IMPL maxdsp LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_fptrunc_64ns_32_2_no_dsp_1 RTLNAME rnn_forward_fptrunc_64ns_32_2_no_dsp_1 BINDTYPE op TYPE fptrunc IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_fpext_32ns_64_2_no_dsp_1 RTLNAME rnn_forward_fpext_32ns_64_2_no_dsp_1 BINDTYPE op TYPE fpext IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME rnn_forward_CONTROL_BUS_s_axi RTLNAME rnn_forward_CONTROL_BUS_s_axi BINDTYPE interface TYPE interface_s_axilite}
      {MODELNAME rnn_forward_flow_control_loop_pipe RTLNAME rnn_forward_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME rnn_forward_flow_control_loop_pipe_U}
    }
  }
}
