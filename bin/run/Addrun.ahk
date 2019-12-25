;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 添加可运行的程序到配置文件, 使得可以使用运行窗口运行它
change_icon()                           ;; 设置图标

#SingleInstance ignore	;只运行一次，禁止多次运行

g_Param = %1%

; msgbox param1 = %g_Param%

;; 如果没有传参数，则尝试从剪贴板中获取
if g_Param =
{
	Sleep 100
	g_Param := clipboard
}



g_inifile = launchy.ini
g_title = 添加运行命令到配置文件
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_ForbinChar = `;,`#,=,`%,`&
g_ForbinCharTip = `n `; `# = `% `& `@

EDITWIDTH = 320

_Hotkey =
_HotString =
_WorkPath =
_RadioFile =
_RadioSend =
_radioVar =

;; 设计界面

Gui, +AlwaysOnTop
Gui, Add, Text
Gui, Add, Text, , 命令:
Gui, Add, Text, , 执行内容:
Gui, Add, Text, , 工作目录:

Gui, Add, Text, ym
Gui, Add, Edit, w%EDITWIDTH% v_Hotkey  g【命令编辑框】
Gui, Add, Edit, w%EDITWIDTH% v_Hotstring, %g_Param%
Gui, Add, Edit, w%EDITWIDTH% Disabled v_WorkPath

Gui, Add, Text, ym
Gui, Add, Radio, y+10 v_RadioFile checked g【ClickRadioFile】, Run file     ;; button1
Gui, Add, Radio, y+15 v_RadioSend g【ClickRadioSend】, 飞扬命令串           ;; button2
Gui, Add, Radio, y+12 v_radioVar g【包含变量的命令】, 命令::变量            ;; button3

Gui, Add, Button, x135 y120 w100 h30 default g【确定运行用户输入的命令】, 确定
Gui, Add, Button, x285 y120 w100 h30 g【取消运行用户输入的命令】, 取消

Gui, Add, Checkbox, x15 y120 w100 h30  v_bSaveWorkPath g【工作路径复选框】, 保存工作路径
Gui, Show, h170, %g_title%

;;---判断剪贴板里是否包含变量, 有变量$var$则点击"命令::变量"的单选框---------
if g_Param <>
{
	if IsCmdString( g_Param )
		ControlClick Button2, %g_wintitle%
	else IfInString g_Param, $var$
		ControlClick Button3, %g_wintitle%
	else
	{
		ControlClick Button1, %g_wintitle%
	}
}
ControlFocus , Edit1, %g_wintitle%
RETURN

GuiDropFiles:
	Loop, parse, A_GuiEvent, `n
	{
		if A_LoopField=
			continue

		guicontrol, , _Hotstring, %A_LoopField%
		break
	}
	Return


【命令编辑框】:
	Gui, Submit, nohide
	if ( CheckKeyName( _Hotkey ) == "ERROR_CHAR" )
	{
		Send {backspace}
	}
	RETURN


【工作路径复选框】:
	Gui, Submit, nohide
	if _bSaveWorkPath
		GuiControl, Enable, Edit3
	else
		GuiControl, Disable, Edit3
	RETURN

【ClickRadioSend】:
【包含变量的命令】:
	ControlSetText  Edit3, ,  %g_wintitle%
	Control UnCheck, , button6, %g_wintitle% 	;; 取消选择保存工作路径复选框
	GuiControl, Disable, Edit3
	RETURN

【ClickRadioFile】:

	ControlGetText var_temp, Edit2,  %g_wintitle%
	SplitPath, var_temp , , OutDir
	StringReplace, OutDir, OutDir, `", , All

	var_ext := get_file_ext( var_temp)

	;; 如果是文件夹，则取消“保存路径”的复选框
	if var_ext = $Web$
	{
		OutDir =	;; 网址不保存路径
	}

	;; 如果运行的文件是目录且有父路径时，勾选“保存路径”复选框
	if OutDir <>
	{
		if var_ext <> $dir$
		{
			Control Check, , button6, %g_wintitle% 		;; 选择保存工作路径复选框
			GuiControl, Enable, Edit3
		}
		ControlSetText  Edit3, %OutDir%,  %g_wintitle% ahk_class AutoHotkeyGUI
	}
	else  ;; 路径为空时， 不勾选“保存路径”复选框
	{
		Control UnCheck, , button6, %g_wintitle% 	;; 选择保存工作路径复选框
		GuiControl, Disable, Edit3
	}
	RETURN

【确定运行用户输入的命令】:
	Gui, Submit, nohide
	if  ( CheckKeyName( _Hotkey ) != "OK" )
	{
		MsgBox 命令中包含非法字符！
		RETURN
	}
	;; 如果命令类型不是飞扬命令串，则[执行内容]编辑框不能有分隔符
	if not _radiosend
	{
		IfInString _Hotstring, |
		{
			MsgBox [执行内容]编辑框不能有分隔符`" | `"
			RETURN
		}
	}
	if _bSaveWorkPath
	{
		IfInString _WorkPath, |
		{
			MsgBox [工作目录]编辑框不能有分隔符`" | `"
			RETURN
		}
	}
	;; 准备好Section
	if _radiosend = 1
		var_sec = cmd
	else if _radioVar = 1
		var_sec = variable
	else
		var_sec = file

	if ( _Hotkey != "" && _Hotstring != ""  )
	{
		iniread,var_read,%g_inifile%,%var_sec%,%_HotKey%
		if not (var_read="" or var_read="ERROR")
		{
			MsgBox, 4,, %g_inifile%文件的%var_sec%节中，`n%_HotKey%已经存在，要替换吗 ？`n%_HotKey%＝%var_read%`n将替换为`n%_HotKey%＝%_Hotstring%
			IfMsgBox No
			{
				EXITAPP
				RETURN
			}
		}
		var_value := _Hotstring

		;; 如果是保存文件，则填入扩展名和工作路径, 并保存图标
		if  var_sec = file
		{
			var_ext := get_file_ext( _Hotstring )
			var_value = %var_value%|%var_ext%
			if var_ext <>
			{
				if var_ext not in $Dir$,$NoExt$,$Web$
				{
					if ( _bSaveWorkPath && get_first_char( _HotKey, var_char) > 0 && var_char != "\" && var_char != "/" )
					{
						var_value = %var_value%|%_WorkPath%
					}
					;; 保存图标
					if var_ext not in exe,com,dll,ico,cur,cpl,scr,bmp,jpg,gif,png,tif,bak,tmp
					{

					}
				}
			}

		}
		write_ini( g_inifile, var_sec, _HotKey, var_value )
		EXITAPP
	}
	else
	{
		if _Hotstring =
			ToolTip 请输入要执行的内容
		else if _HotKey =
			ToolTip 请设置命令
		Sleep 800
		ToolTip
	}
	RETURN

【取消运行用户输入的命令】:
GuiClose:
	EXITAPP
	RETURN



#include ..\..\
#include .\inc\common.aik
#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\tip.aik
#include .\inc\cmdstring.aik

CheckKeyName( keyName )
{
	if keyName contains ``,~,!,`#,=,-,*,$,?,`%,`&,|, ,@,[,],`:,`',`",`,,`;
	{
		tooltip7("命令中不能包含下列任何字符之一：`n `` ~ `! @ `# $ `% `&  *  - = | . [ □ ] ? `' “ `, `: `;  ")
		RETURN "ERROR_CHAR"
	}
	if keyName in vim,calc,run
	{
		tooltip7("以下命令有特殊含义，不能作为自定义命令：`n vim,calc,run")
		RETURN "ERROR_CMD"
	}
	RETURN "OK"
}


#IfWinActive 添加运行命令到配置文件 ahk_class AutoHotkeyGUI

RAlt::
	Gui, Submit, nohide
	if _bSaveWorkPath
		Control UnCheck, , button6, %g_wintitle% 	;; 取消选择保存工作路径复选框
	else
		Control Check, , button6, %g_wintitle%
	RETURN
#IfWinActive


