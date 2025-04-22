set ModuleHierarchy {[{
"Name" : "rnn_forward","ID" : "0","Type" : "sequential",
"SubLoops" : [
	{"Name" : "VITIS_LOOP_24_1","ID" : "1","Type" : "pipeline",
	"SubInsts" : [
	{"Name" : "grp_generic_tanh_double_s_fu_306","ID" : "2","Type" : "pipeline",
			"SubInsts" : [
			{"Name" : "grp_exp_generic_double_s_fu_89","ID" : "3","Type" : "pipeline"},]},
	{"Name" : "grp_generic_tanh_double_s_fu_317","ID" : "4","Type" : "pipeline",
			"SubInsts" : [
			{"Name" : "grp_exp_generic_double_s_fu_89","ID" : "5","Type" : "pipeline"},]},]},]
}]}