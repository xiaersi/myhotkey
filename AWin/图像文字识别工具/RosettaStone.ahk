#ifwinactive RosettaStone - 
^+v::
	clipboard =
	sleep 50
	send ^c
	sleep 50
	var_temp := clipboard
;	var_temp := RegexReplace(var_temp, "", "" )
	var_temp := regexreplace(var_temp, "(南业|苘业|茼业)", "商业" )
	var_temp := RegexReplace(var_temp, "娄似", "类似" )
	var_temp := RegexReplace(var_temp, "恒得", "值得" )
	var_temp := RegexReplace(var_temp, "技资", "投资" )
	var_temp := RegexReplace(var_temp, "原困", "原因" )
	var_temp := RegexReplace(var_temp, "高营", "高管" )
	var_temp := RegexReplace(var_temp, "诀策", "决策" )
	var_temp := RegexReplace(var_temp, "戍", "成" )
	var_temp := RegexReplace(var_temp, "效盍", "效益" )
	var_temp := RegexReplace(var_temp, "(分桁|分柝)", "分析" )
	var_temp := RegexReplace(var_temp, "根瞩", "根据" )
	var_temp := RegexReplace(var_temp, "曲", "的" )
	var_temp := RegexReplace(var_temp, "基亍", "基于" )
	var_temp := RegexReplace(var_temp, "(丈件|艾件)", "文件" )
	var_temp := RegexReplace(var_temp, "＇", "，" )
	var_temp := RegexReplace(var_temp, "应垓", "应该" )
	var_temp := RegexReplace(var_temp, "范国", "范围" )
	var_temp := RegexReplace(var_temp, "法舰", "法规" )
	var_temp := RegexReplace(var_temp, "结杓", "结构" )
	var_temp := RegexReplace(var_temp, "过裎", "过程" )
	var_temp := RegexReplace(var_temp, "信患", "信息" )
	var_temp := RegexReplace(var_temp, "凤险", "风险" )
	var_temp := RegexReplace(var_temp, "(批堆|批榷)", "批准" )
	var_temp := RegexReplace(var_temp, "(章裎|覃裎)", "章程" )
	var_temp := RegexReplace(var_temp, "檑权", "授权" )
	var_temp := RegexReplace(var_temp, "赍源", "资源" )
	var_temp := RegexReplace(var_temp, "軎户", "客户" )
	var_temp := RegexReplace(var_temp, "自的", "目的" )
	var_temp := RegexReplace(var_temp, "祭件", "条件" )
	var_temp := RegexReplace(var_temp, "请单", "清单" )
	var_temp := RegexReplace(var_temp, "因表", "因素" )
	var_temp := RegexReplace(var_temp, "(边舁|边＃)", "边界" )
	var_temp := RegexReplace(var_temp, "忠体", "总体" )
	var_temp := RegexReplace(var_temp, "杈", "权" )
	var_temp := RegexReplace(var_temp, "妣", "批" )
	var_temp := RegexReplace(var_temp, "审牝", "审批" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
;	var_temp := RegexReplace(var_temp, "", "" )
	clipboard := var_temp
	send ^v
	return


^+F5::
	reload
	return
#ifwinactive
