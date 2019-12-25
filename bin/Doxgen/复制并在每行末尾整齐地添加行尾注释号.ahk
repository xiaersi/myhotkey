#NoTrayIcon
#include ../../
#include .\inc\string.aik
#include .\inc\inifile.aik

AutoTrim, Off


;; 设置图标
change_icon( )

g_text =
g_param = %1%
StringSplit paramArray, g_param, |
if paramArray0 > 1
{
	g_comment 	:= paramArray1
	g_test		:= paramArra2
}
else
{
	if paramArray0 = 1
		g_comment 	:= paramArray1
}

if g_comment =
	g_comment := read_ini( "temp.ini", "复制并在每行末尾整齐地添加行尾注释符", "lastComment", "/**<  */" )

;; 如果参数不带选中的文本内容，则复制之
if g_text =
{
	g_oldclip := clipboardall
	clipboard =
	sleep 20
	send ^c
	sleep 100
	g_text = %clipboard%
	clipboard := g_oldclip
	if clipboard =
	{
		tooltip 没有选中要注释的内容
		clipboard := g_oldclip
		sleep 800
		tooltip
		exitapp
	}

}

g_defaultOff := 40
g_tablen := 4
g_minlen := 4	 ; 行尾注释至少要有一个Tab
g_lineArr =
g_lineCount := 0
g_space = ``
g_tab = ````````
g_help =
(
功能说明：`r
	在剪贴板中的文本内容的每一行后面，整齐地添加指定字符，如注释符号。`r
	`r
使用说明：`r
	1、选中要处理的文本内容。`r
	2、通过快捷键（例如：//e、 `;`;e、 AppsKey+/ --> 1 ) 打开本窗口`r
	3、本窗口会自动复制选中的内容，显示到预览窗口。`r
	4、调整缩进，选择在要末尾添加的符号（也可以直接输入）。`r
	5、按【刷新】按钮预览效果（其实不用按，在你输入或选择末尾符号时会自动刷新）。`r
	6、对预览效果满意时，按【确定】按钮，将预览内容发送到原来复制的窗口，替换掉原来的内容。`r
`r
快捷键说明：`r
    F1	-> 【减少缩进】`r
    F2	-> 【增加缩进】`r
    F3	-> 【设置默认缩进值】`r
    F4	->  切换注释符号`r
    F5	-> 【刷新按钮】`r
    F6	->  展开释符号下拉框`r
    F7	->  收起释符号下拉框`r
    ESC	->  退出程序
)


g_commentList = //|///<|/**<  */|`;`;|--

var_clip := g_text

; 将剪贴板中的Tab用空格替换，将换行符统一成`n
stringreplace var_clip, var_clip, ``, \~, All
StringReplaceAll(var_clip, "`t", g_tab )
;stringreplace var_clip, var_oldclip, `t, %var_tab%, All
stringreplace var_clip, var_clip, `r`n, `n, All
stringreplace var_clip, var_clip, `r, `n, All

; 按行分解剪贴板内容，每行保存到g_lineArr数组中
loop parse, var_clip, `n
{
	var_loopfield := a_loopfield
	StrTrimRight( var_loopfield )
	if var_loopfield <>
	{
		g_lineCount ++
		var_len := strlen( var_loopfield )
		if ( var_len > g_minlen )
			g_minlen := var_len
		g_lineArr%g_lineCount% := var_loopfield
	}
}

if g_lineCount <= 0
{
	tooltip 选中要注释的内容为空
	sleep 800
	tooltip
	exitapp
}

; 弹出窗口，调整行尾注释后退位置
g_curoff := read_ini("temp.ini", "复制并在每行末尾整齐地添加行尾注释符", "LastOffset", g_minlen )

if (g_curoff < g_defaultOff )
	g_curoff := g_defaultOff
else
	∑将数字调整到不小于另一个数字的整数倍( g_curoff, g_tablen )

g_title = 复制并在每行末尾整齐地添加行尾注释
g_wintitle = 复制并在每行末尾整齐地添加行尾注释 ahk_class AutoHotkeyGUI

g_output =

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 显示窗口

Gui, Add, Text, x16 y21 h20 , 缩进：至少
Gui, Add, ComboBox, x296 y16 w70 h20 +Center vg_curoff R8 g【当前缩进值框】, 16|28|40|60|80

Gui, Add, Edit, x80 y16 w30 h20  +Center +ReadOnly , %g_minlen%

Gui, Add, Button, x210 y16 w40 h20 g【设置默认缩进值】, 默认
Gui, Add, Button, x256 y16 w40 h20 g【减少缩进】, <&<
Gui, Add, Button, x366 y16 w40 h20 g【增加缩进】, >&>
Gui, Add, Button, x410 y16 w40 h20 g【刷新按钮】, 刷新

Gui, Add, Edit, x6 y51 w790 h320 +ReadOnly vg_output, 预览
Gui, Add, ComboBox, x465 y16 w70 h20 R5 vg_comment g【注释符号框】, %g_commentList%

Gui, Add, Text, x120 y21 h20 , 默认值
Gui, Add, Edit, x160 y16 w30 h20  +Center +ReadOnly , %g_defaultOff%

Gui, Add, Button, x550 y11 w80 h30 default g【确定按钮】, 确定(&Y)
Gui, Add, Button, x635 y11 w80 h30 g【取消按钮】, 取消(&N)
Gui, Add, Button, x720 y11 w70 h30 g【帮助按钮】, 帮助(&H)

; Generated using SmartGUI Creator 4.0
Gui, Show, center h377 w800 , %g_title%

ControlSetText Edit4, %g_comment%, %g_wintitle%	; 设置注释符号框默认值
ControlSetText Edit1, %g_curoff%, %g_wintitle%	; 设置缩进框的默认值

goto 【根据g_lineArr生成显示信息】
Return

【当前缩进值框】:
	goto 【根据g_lineArr生成显示信息】
	return
【注释符号框】:
	goto 【根据g_lineArr生成显示信息】
	return

【设置默认缩进值】:
	if ( g_defaultOff >= g_minlen )
	{
		g_curoff := g_defaultOff
	}
	else
	{
		g_curoff := g_minlen
		∑将数字调整到不小于另一个数字的整数倍( g_curoff, g_tablen )
	}
	controlsettext Edit1, %g_curoff%, %g_wintitle%
	goto 【根据g_lineArr生成显示信息】
	return

【减少缩进】:
	if ( g_curoff > ( g_minlen + g_tablen ) )
	{
		g_curoff -= g_tablen
		controlsettext Edit1, %g_curoff%, %g_wintitle%
		goto 【根据g_lineArr生成显示信息】
	}
	return

【增加缩进】:
	g_curoff += g_tablen
	controlsettext Edit1, %g_curoff%, %g_wintitle%
	goto 【根据g_lineArr生成显示信息】
	return

【刷新按钮】:
	goto 【根据g_lineArr生成显示信息】
	return


【确定按钮】:
	ControlGetText var_comment, Edit4, %g_wintitle%
	ControlGetText var_lastoff, Edit1, %g_wintitle%
	Gui, Submit, hide
	stringreplace clipboard, g_output, %g_space%, %a_space%, All
	stringreplace clipboard, clipboard, `r`n, `n, All
	stringreplace clipboard, clipboard, `r, `n, All
	stringreplace clipboard, clipboard, `n, `r`n, All
	stringreplace clipboard, clipboard, \~,``, All
	tooltip 复制到剪贴板`n%clipboard%
	sleep 300
	send ^v
	clipboard := g_oldclip

	write_ini( "temp.ini", "复制并在每行末尾整齐地添加行尾注释符", "lastComment",  var_comment )
	write_ini( "temp.ini", "复制并在每行末尾整齐地添加行尾注释符", "LastOffset",   var_lastoff )

【取消按钮】:
GuiClose:
ExitApp


【帮助按钮】:
	controlsettext Edit3, %g_help%, %g_wintitle%
	return

【根据g_lineArr生成显示信息】:
	Gui, Submit, nohide
	g_output =

	loop %g_lineCount%
	{
		var_line := g_lineArr%a_index%
		var_len := strlen( var_line  )
		if ( var_len > 0 )
		{
			if ( var_len > g_curoff )
			{
				g_curoff := var_len
				∑将数字调整到不小于另一个数字的整数倍( g_curoff, g_tablen )
				controlsettext edit1, %g_curoff%, %g_wintitle%
			}
			if ( var_len < g_curoff )
			{
				var_loopnum := g_curoff - var_len


				loop %var_loopnum%
				{
				;	AddString( var_line, " ", false )
					var_line = %var_line%%g_space%
				}
			}
			var_line = %var_line%%g_comment%%g_space%
			g_output = %g_output%`r`n%var_line%
		}
	}
	stringleft var_temp, g_output, 2
	if ( var_temp == "`r`n" )
	{
		stringmid g_output, g_output, 3
	}
	controlsettext Edit3, %g_output%, %g_wintitle%
	return


∑将数字调整到不小于另一个数字的整数倍( byref num, len )
{
	var_temp := num // len
	var_temp *= len
	if ( var_temp < num )
		num := var_temp + 4
	else
		num := var_temp
}


#IfWinActive 复制并在每行末尾整齐地添加行尾注释 ahk_class AutoHotkeyGUI
F1::
	goto 【减少缩进】
	return

F2::
	goto 【增加缩进】
	return

F3::
	goto 【设置默认缩进值】
	return


F4::
	;; 得到【注释符号框】 ComboBox 的下拉列表的行数
	CB_GETCOUNT:=326 ;0x0146
	SendMessage, CB_GETCOUNT, 0, 0, ComboBox2
	nRowCount:=ErrorLevel

	nNextRow++
	if (nNextRow > nRowCount )
		nNextRow = 1

	;; 选择下拉列表的第 nNextRow 行
;	GuiControl, Choose, g_comment, %nNextRow%
	Control, Choose, %nNextRow%, ComboBox2
	goto 【刷新按钮】
	return

F5::
	goto 【刷新按钮】
	return

F6::
	if g_ShowDropDown
	{
		Control HideDropDown, , ComboBox2
		g_ShowDropDown := false
	}
	else
	{
		Control ShowDropDown, , ComboBox2
		g_ShowDropDown := true
	}
	return

esc::
	exitapp
#ifWinActive


