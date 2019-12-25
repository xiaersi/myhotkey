; 对PDF转TXT项目中产生的结果日志进行分析，将转换成功、转换失败按原因进行归类。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StrLeft2Sub(SearchString, Needle ) 在SearchString字符串中寻找子串Needle
;; 找到Needle则截取它的左边，作为子字符串返回，举个例子：
;; SearchString = squeezer@imageset
;; Needle  = @
;; OutString = StrLeft2Sub( SearchString, Needle  )
;; 那么得到的OutString的值为squeezer

#include ..\..\..\

#include inc\string.aik
/*
StrLeft2Sub(SearchString, Needle )
{
	StringGetPos, varPos, SearchString, %Needle%
	if  errorlevel
	{ 
		return ""
	}
	stringleft varReturn, SearchString, %varPos%
	return %varReturn%
}


StrMid2Sub(varString,subString1,subString2)
{
	StringGetPos, varPos, varString, %subString1%
	if errorlevel
	{
		return ""
	}
	varLen := strlen(subString1)
	varTemp := substr(varString,varPos+varLen+1)

	ifinstring varTemp,%subString2%
	  varTemp := StrLeft2Sub(varTemp,subString2)
;	msgbox varTemp=%varTemp%
	return varTemp
}

StrRight2Sub(varString,subString)
{
	StringGetPos varPos, varString, %subString% , R1
	stringleft varTemp,varString,%varPos%
	varLen := strlen(varTemp)
	varLen := strlen(varString) - varLen - strlen(subString)
	stringright varReturn,varString,%varLen%
	return %varReturn%
;举例..............................
;MyStringVar = squeezer::imageset
;fileExtVar = StrRight2Sub(MyStringVar,"::")
;fileExtVar的值为"imageset"
}
*/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
var_SelectedFile = %1%
if var_SelectedFile = 
{
	FileSelectFile, var_SelectedFile, 3, %A_WorkingDir%, 选择需要分析的日志文件, Log Documents (*.txt; *.log )
}
if var_SelectedFile =
{
    MsgBox, The user didn't select anything.
}
else
{
	g_pages := 0
	g_p2 := 0
	g_t1 := 0
	g_t2 := 0
	g_time := 0
	SplitPath, var_SelectedFile, , dir, ext, name_no_ext
	if name_no_ext =
	{
		MsgBox 文件路径出错`n%var_SelectedFile%
		return
	}
	var_outfile = %dir%\%name_no_ext%_rpt.%ext%
	FileDelete, %var_outfile%

	Loop, read, %var_SelectedFile%, %var_outfile%
	{
		if A_LoopReadLine =
			continue

		var_sub := StrRight2Sub( A_LoopReadLine, "[发布最终页" )
		
		if var_sub =
			continue
		;; 计算最终发布页
		var_page := StrLeft2Sub( var_sub, "个,耗费1:")
		
		if var_page is not integer
		{
			msgbox 最终发布页有误[%var_page%]：`nvar_sub=%var_sub%`n%A_LoopReadLine%
			return
		}
		g_pages := g_pages + var_page
		
		;; 耗费时间 
		var_sub := StrRight2Sub( var_sub, "个,耗费1: " )
		var_t1 := StrLeft2Sub( var_sub, "秒][刷新列表页")
		strtrim( var_t1 )
		g_t1 := var_t1 + g_t1


		var_sub := StrRight2Sub( var_sub, "秒][刷新列表页" )
		var_p2 := StrLeft2Sub( var_sub, "个,耗费2:")
		strtrim( var_p2 )
		g_p2 := var_p2 + g_p2

		var_sub := StrRight2Sub( var_sub, "个,耗费2:" )
		var_t2 := StrLeft2Sub( var_sub, "秒][总共耗费:")
		strtrim( var_t2 )
		g_t2 := var_t2 + g_t2	

		var_sub := StrRight2Sub( var_sub, "秒][总共耗费:" )
		var_time := StrLeft2Sub( var_sub, "秒]")
		strtrim( var_time )
	}
	g_time := var_time + g_time	
	var_tip = 
	(
文件：%var_SelectedFile%
最发布页1有 【%g_pages%】页, 耗时1 【%g_t1%】
最发布页2有 【%g_p2%】页, 耗时2 【%g_t2%】
最耗时 【%g_time%】
	)

	msgbox %var_tip%
}



