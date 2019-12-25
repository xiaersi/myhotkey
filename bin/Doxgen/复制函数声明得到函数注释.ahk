#NoTrayIcon
#include ../../
#include .\inc\string.aik


;; 设置图标
change_icon()


bShowMsgbox := true
g_paramArr =
g_outArr =
g_commentArr =
g_paramCount = 0
g_funName =
g_funExplain =
g_return =
g_returnExplain =
g_lineHeadSpace =                                   ;; 保存函数声明的缩进量，以便生成的注释也缩进

;; g_oldclip保存旧的剪贴板内容，以便操作后复制剪贴板的内容
g_oldclip := clipboard

WinGet, g_active_id, ID, A

;; 复制选择的内容到剪贴板
send ^c
clipwait 1, 1
sleep 100

ifnotinstring clipboard, (
{
	MyShow( "复制的内容不是函数，无法分析得到函数注释", bShowMsgbox )
	clipboard := g_oldclip
	exitapp
}

;; 去掉换行符
var_oldclip := clipboard
stringreplace var_clip, var_oldclip, `n, , All
stringreplace var_clip, var_clip, `r, , All

;; 使用正则表达式获取函数声明的缩进量 g_lineHeadSpace
RegExMatch( var_clip, "^\s+", g_lineHeadSpace )

;; 分解出函数名var_fun和参数列表var_paramlist
StringGetPos, varPos, var_clip, (
if  errorlevel
{
	MyShow( "分解函数名时，没有找到 ( 符号，函数注释获取失败！", bShowMsgbox )
	exitapp
}
stringleft var_fun, var_clip, %varPos%

ifinstring var_fun, *
{
	var_fun := StrRight2Sub( var_fun, "*" )
}

ifinstring var_fun, `:`:
{
	g_funName := StrRight2Sub( var_fun, "`:`:" )
}
else
{
	g_funName := GetLastWord2( var_fun )
}

if g_funName =
{
	MyShow( "分解得到的函数名为空，函数注释生成失败！", bShowMsgbox )
	exitapp
}



varLen := strlen(var_fun)
varLen := strlen(var_clip) - varLen - 1
stringright var_paramlist, var_clip, %varLen%

StringGetPos, varPos, var_paramlist, )
if  errorlevel
{
	MyShow( "分解函数参数列表时，没有找到 ) 符号，函数注释获取失败！", bShowMsgbox )
	exitapp
}

stringleft var_paramlist, var_paramlist, %varPos%

Loop parse, var_paramlist, `,
{
	g_paramCount ++
	var_temp := a_loopfield
	ifinstring var_temp, =
	{
		var_temp := StrLeft2sub( var_temp, "=" )
	}
	ifinstring var_temp, &
	{
		g_outArr%g_paramCount% := true
		var_temp := StrRight2Sub( var_temp, "&" )
		StrTrim( var_temp )
	}
	else
	{
		var_temp := GetLastWord2( var_temp )
	}
	g_paramArr%g_paramCount% = %var_temp%

}


【弹出窗口修改函数注释信息】:
;; 弹出对话框
gui, add, Text
gui, add, Text, ,函数
Loop %g_paramCount%
{
	gui, add, Text, , 参数%a_index%
}

gui, add, Text, y+68,返回值
;------------------------------------------------------------------
gui, add, Text, ym, Out
gui, add, Text,
Loop %g_paramCount%
{
	Gui, Add, Checkbox, y+14 vg_outArr%a_index%
}
;------------------------------------------------------------------
gui, add, Text, ym, 函数
gui, add, Edit, w150 R1 vg_funName,  %g_funName%
Loop %g_paramCount%
{
	var_temp := g_paramArr%a_index%
	gui, add, Edit,w150 R1 vg_paramArr%a_index%, %var_temp%
}
gui, add, button, y+20 h28 g【增加参数】, [ + ] 增加参数


gui, add, Edit, y+20 w150 vg_return
gui, add, Button,  y+25 w100 h28 default, 生成注释
gui, add, Button,   w100 h28, 取消退出
;------------------------------------------------------------------
gui, add, Text, ym , 说明
gui, add, Edit, w320 vg_funExplain, %g_funExplain%
Loop %g_paramCount%
{
	var_temp := g_commentArr%a_index%
	gui, add, Edit,w320 vg_commentArr%a_index%, %var_temp%
}
gui, add, button,y+21 h28 g【减少参数】, [ - ] 减少参数
gui, add, Edit, y+20 w320 h100 vg_returnExplain, %g_returnExplain%
gui, add, Text
;------------------------------------------------------------------
gui, show, center , 生成函数注释

GuiControl, Focus, g_funExplain   ;; 将焦点定位到函数说明的编辑框上。

clipboard := g_oldclip                  ;; 在显示窗口之后，恢复剪贴板的内容
return


【增加参数】:
	Gui, Submit, nohide
	g_paramCount++
	Gui, Destroy
	goto 【弹出窗口修改函数注释信息】
	return

【减少参数】:
	Gui, Submit, nohide
	if g_paramCount > 0
	{
		g_paramCount--
		Gui, Destroy
		goto 【弹出窗口修改函数注释信息】
	}
	return


button生成注释:
	Gui, Submit, hide
	var_brief = `/** `r`n * @brief	%g_funExplain%
	var_params =
	bBrief := true		; 仅生成单行注释/** @brief	%g_funExplain% */, 当其他说明都为空时
	loop %g_paramCount%
	{
		var_temp := g_commentArr%a_index%
		if ( bBrief == true && var_temp != "")
		{
			bBrief := false
		}
		var_paramname := g_paramArr%a_index%
		var_out := g_outArr%a_index%
		if var_out
			var_params = %var_params%`r`n * @param[out]	%var_paramname%  %var_temp%
		else
			var_params = %var_params%`r`n * @param[in]	%var_paramname%  %var_temp%
	}
	var_return =

	if g_return <>
	{
		var_return = `r`n * @return	%g_return%
		if bBrief
			bBrief := false
	}
	else if g_returnExplain <>
	{
		var_return = `r`n * @return	%g_return%
		if bBrief
			bBrief := false
	}

	if g_returnExplain <>
	{
		stringreplace var_temp, g_returnExplain, `r, , All
		loop parse, var_temp, `n
		{
			var_return = %var_return%`r`n *      %a_loopfield%
		}
		if bBrief
			bBrief := false
	}
	var_output = %var_brief%%var_params%%var_return%`r`n */
	if bBrief ; 当其他说明都为空时, 仅生成单行注释
		clipboard = `/** @brief	%g_funExplain% *`/
	else
		clipboard = %var_output%

	AutoTrim, off
	;; 如果复制的函数有缩进，则对注释的每一行也缩进
	if g_lineHeadSpace <>
	{
		StringReplace clipboard, clipboard, `r`n, `r`n%g_lineHeadSpace%, All
		Clipboard := g_lineHeadSpace . Clipboard
	}
	;; 将复制的原函数声明，连接到注释下一行
	clipboard = %clipboard%`r`n%var_oldclip%
	AutoTrim, on

;	∑删除字符串末尾的回车符号(clipboard)
	tooltip 已将生成的函数注释复制到剪贴板
	WinGet, var_ThisID, ID, ahk_pid %g_active_id%
	winactivate ahk_id %var_ThisID%
	sleep 300
	send ^v

button取消退出:
GuiClose:
ExitApp



;;----相关函数-------------------------------------------------
GetLastWord2( InputString )
{
	var_ret =
	varLen := strlen(InputString)
	Loop %varLen%
	{
		var_index := varLen - a_index + 1
		StringMid var_char, InputString, %var_index%, 1
		if var_ret =
		{
			if var_char is not space
				var_ret := var_char
		}
		else
		{
			if var_char is space
				break
			else if var_char in `,
				break
			else
				var_ret = %var_char%%var_ret%
		}

	}
	return var_ret
}

MyShow( var_tip,  bMsgBox = 1 )
{
	if bMsgBox = 1
	{
		msgbox %var_tip%
	}
	else
	{
		tooltip %var_tip%
		sleep 1000
		tooltip
	}
}


