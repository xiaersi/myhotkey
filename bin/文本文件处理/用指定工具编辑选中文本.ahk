/**
 *@file    使用指定工具编辑选中文本.ahk
 *@author  teshorse
 *@date    2011.09.26
 *@brief   使用指定的文本编辑器编辑当前选中的内容
 *
 * 通过参数1，指定文本编辑工具，
 *- 复制当前选中的内容并保存为temp.txt，再用该工具打开编辑之。
 *- 文本编辑器的标题栏将被隐藏，同时打开一个主窗口
 *- 编辑完毕之后，通过点击完成按钮将编辑好的内容复制到原来的窗口。
 */


AutoTrim, Off


#include ../../ 
change_icon()

CoordMode, Caret, Screen
CoordMode, Mouse, Screen

g_TextEditor =
g_oldclip =
g_tempfile = bak/temp.txt
g_tempfileName = temp.txt
g_EditorPID =
g_EditorID =
g_AWinID =
g_AWinClass = 
g_title = 编辑选中文本
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_winx := A_CaretX
g_winx := A_CaretY
g_bMultTab := false                     ;; 文本编辑器是多标签吗？
g_bClosed := false

if ( g_winx == "" or g_winy == "" )
	MouseGetPos, g_winx, g_winy 

;; 获取参数
g_param1 = %1%
ifinstring g_param1, `n
{
	;; 如果参数带有回车符，则有多个参数
	g_TextEditor := GetValueFromParams(g_param1, "editor")
	g_bClip := GetValueFromParams(g_param1, "bclip")
	g_winsize := GetValueFromParams(g_param1, "winsize")
	g_winx := GetValueFromParams(g_param1, "winx")
	g_winy := GetValueFromParams(g_param1, "winy")
	g_bActivateEditor := GetValueFromParams(g_param1, "activate")
}
else
{
	;; 如果参数没有回车符，参数就是编辑器
	g_TextEditor := g_param1

	;; 将编辑窗口移动要屏幕中央
	g_winx := ( a_ScreenWidth - 800 ) / 2
	g_winy := ( a_ScreenHeight - 600 ) / 2
	
}

;; 检查指定的文本编辑器是否存在
ifNotExist %g_TextEditor%
{
	msgbox 没有正确指定文本编辑器！
	ExitApp
}

;; 复制内容
g_AWinID := WinExist("A") 
WinGetClass, g_AWinClass , A
WinGetActiveTitle, g_AWinTitle 

g_oldclip := clipboardall
if g_bClip <> false
{
	clipboard =
	send ^c
	ClipWait 1
	if clipboard =
	{
		msgbox 没有选中内容！
		ExitApp
	}
}

;; 如果是BCB或VS2008则使用cpp扩展名
if g_AWinClass in TEditWindow,wndclass_desked_gsk
{
	g_tempfile = bak/temp.cpp
	g_tempfileName = temp.cpp
}
/* ;; 在深圳证券信息有限公司开发的智能采编系统中，需要编辑JavaScript脚本。
else if g_AWinTitle = 综合业务支持系统------智能采编系统------采编界面配置
{
	g_tempfile = bak/temp.js
	g_tempfileName = temp.js
}
*/
else if g_AWinClass = TPLSQLDevForm ;; plsql sql
{
	g_tempfile = bak/temp.sql
	g_tempfileName = temp.sql
}
else if g_AWinClass = SWT_Window0	;; eclipse java
{
	ifinstring g_AWinTitle, .jsp
	{
		g_tempfile = bak/temp.jsp
		g_tempfileName = temp.jsp
	}	
	else ifinstring g_AWinTitle, .js
	{
		g_tempfile = bak/temp.js
		g_tempfileName = temp.js
	}
	else ifinstring g_AWinTitle, .xml
	{
		g_tempfile = bak/temp.xml
		g_tempfileName = temp.xml
	}	
	else
	{
		g_tempfile = bak/temp.java
		g_tempfileName = temp.java
	}
}

;; 将复制的内容保存到temp.txt文件中
ifExist %g_tempfile%
	filedelete %g_tempfile%


filebuf = %clipboard%
fileappend %filebuf%, %g_tempfile%


;; 用指定的编辑器打开该临时文件进行编辑
run %g_TextEditor% %g_tempfile%, , min, g_EditorPID

WinWait, ahk_pid %g_EditorPID%, , 1
WinGet, g_EditorID, ID, ahk_pid %g_EditorPID%
if g_EditorID <>
{
	WinSet, Style, -0xC00000, ahk_id %g_EditorID%
}
else
{
    g_bMultTab := true                 ;; 文本编辑器是有多个标签
	WinGetActiveTitle, OutputVar 
	ifInString OutputVar, %g_tempfileName%
	{	
		WinGet, g_EditorID, id, A
	}
}

;; 菜单

;;---创建菜单栏--------------------------------------------------------------
Menu, FileMenu, Add, 完成编辑(&Y),【编辑完成】
Menu, FileMenu, Add, 取消编辑(&N),【取消编辑】
Menu, FileMenu, Add
Menu, FileMenu, Add, E&xit     退出程序       ESC, GuiClose

Menu, WindowMenu, Add, 激活编辑(&C) , 【激活编辑窗口】
Menu, WindowMenu, Add, 满屏(&F), 【窗口满屏】
Menu, WindowMenu, Add, 半透明(&A), 【窗口半透明】
Menu, WindowMenu, Add, 保持最前(&T), 【窗口置顶】



Menu, HelpMenu, Add,
;Menu, HelpMenu, Add, 关于 (&0),  【关于】

Menu, MyMenuBar, Add, 完成(&Y),【编辑完成】
;menu, MyMenuBar, add,  |　, 【donothing】

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, 小窗口(&1), 【小窗口】
Menu, MyMenuBar, Add, 中窗口(&2), 【中窗口】
Menu, MyMenuBar, Add, 大窗口(&3), 【大窗口】
Menu, MyMenuBar, Add, &Window, :WindowMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
;menu, MyMenuBar, add, 　　　　, 【donothing】 
;menu, MyMenuBar, add, 　|, 【donothing】
Menu, MyMenuBar, Add, 取消(&N),【取消编辑】

_bFullScr 	:= false                   ;; 当前是否满屏状态
_bA         := false                   ;; 当前是否半透明状态 
_bTop      	:= false                   ;; 当前是否置顶状态


;; 显示UI
var_y := g_winy - 55
Gui +ToolWindow  +AlwaysOnTop
Gui +LastFound
;; 设置窗口透明并显示
;Gui, Color, EEAA99
;WinSet, TransColor, EEAA99
Gui, Menu, MyMenuBar
;Gui, Add, Text, , XXX

/*
Gui add, button,    g【编辑完成】, 完成编辑(&Y)
Gui add, button, ym g【激活编辑窗口】, 激活编辑(&A)
Gui add, button, ym g【小窗口】, 小窗口
Gui add, button, ym g【中窗口】, 中窗口
Gui add, button, ym g【大窗口】, 大窗口
Gui add, checkbox, ym y12 v_bFullScr g【窗口满屏】, 满屏
Gui add, checkbox, ym y12 v_bA g【窗口半透明】, 半透明
Gui add, button, ym g【取消编辑】, 取消编辑(&N)
*/


if g_winx < 0
	g_winx := 0

if var_y < 0
	var_y := 0

gui show, x%g_winx% y%var_y% w450 H0, %g_title%

OnMessage( 0x03, "WM_MOVE" )
OnMessage( 0x06, "WM_ACTIVATE" )


if not g_bMultTab
{
	;; 去掉编辑器标题栏
	WinRestore , ahk_id %g_EditorID%
	if g_winsize = big
	{
		gosub 【大窗口】
	}
	else if g_winsize = small
	{
		gosub 【小窗口】
	}
	else
	{
		gosub 【中窗口】
	}
	winshow ahk_id %g_EditorID%
}
else
{
	;; 将Gui移动到多标签编辑器的标题栏上方
	ifWinExist ahk_id %g_EditorID%
	{
		WinGetPos , g_winx, var_y, , , ahk_id %g_EditorID%
		var_y := var_y - 44

		if g_winx < 0
			g_winx := 0

		if var_y < 0
			var_y := 0

		gui show, x%g_winx% y%var_y% w300 H0, %g_title%		
	}

}

if g_bActivateEditor = true
{
	WinActivate   ahk_id %g_EditorID%
}

;; 为编辑器设置快捷键
Hotkey, IfWinActive, ahk_id %g_EditorID%
Hotkey, !enter, 【编辑完成】
Hotkey, ^enter, 【编辑完成】
Hotkey, !esc, 【取消编辑】
Hotkey, !F4, 【取消编辑】

return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
【DoNothing】:
	return

【编辑完成】:
	winactivate ahk_id %g_EditorID%
	WinWaitActive , ahk_id %g_EditorID%, , 1
	clipboard =
	IfWinActive ahk_id %g_EditorID%
	{
		send ^s
		send ^A
		send ^c
		sleep 100
	}
	gosub 【关闭编辑窗口】
	gui, destroy
	winactivate ahk_id %g_AWinID%
	WinWaitActive , ahk_id %g_AWinID%, , 1	
	if clipboard =
	{
		FileRead, clipboard, %g_tempfile%
 	}
	if clipboard <>
	{
		IfWinActive ahk_id %g_AWinID%
			send ^v
	}
	ExitApp
	return

guiclose:
【取消编辑】:
	gui hide
	winactivate ahk_id %g_EditorID%
	sleep 100
	gosub 【关闭编辑窗口】

	ExitApp
	return


【激活编辑窗口】:
	winactivate ahk_id %g_EditorID%
	return


【小窗口】:
	WinGetPos , guiX, guiY, guiW, guiH, %g_wintitle%
	winmove ahk_id %g_EditorID%, ,  guiX, guiY+guiH, 480, 320
	return

【中窗口】:
	WinGetPos , guiX, guiY, guiW, guiH, %g_wintitle%
	winmove ahk_id %g_EditorID%, ,  guiX, guiY+guiH, 800, 600
	return

【大窗口】:
	WinGetPos , guiX, guiY, guiW, guiH, %g_wintitle%
	winmove ahk_id %g_EditorID%, ,  guiX, guiY+guiH, 1024, 768
	return
	return

【窗口置顶】:
	_bTop := !_bTop
	if _bTop
	{
		Menu, WindowMenu,Check, 保持最前(&T)
	  	WinSet, AlwaysOnTop,  on,  ahk_id %g_EditorID%
	}
	else
	{
		Menu, WindowMenu, Uncheck, 保持最前(&T)
		WinSet, AlwaysOnTop,  off,  ahk_id %g_EditorID%	
	}
	return


【窗口半透明】:
	gui submit, nohide
	_bA := !_bA
	if _bA
	{
		Menu, WindowMenu,Check, 半透明(&A)
	  	WinSet, Transparent,  160,  ahk_id %g_EditorID%
	}
	else
	{
		Menu, WindowMenu, Uncheck, 半透明(&A)
		WinSet, Transparent,  off,  ahk_id %g_EditorID%
	}
	return

【窗口满屏】:
	gui submit, nohide
	_bFullScr := !_bFullScr
	if _bFullScr
	{
		Menu, WindowMenu,Check, 满屏(&F)
		WinGetPos , , , EditorWidth, EditorHeight,  ahk_id %g_EditorID%
		var_h := GetDeskHeight()
		WinGetPos , g_guiX, g_guiY, g_guiW, g_guiH, %g_wintitle% 		;; 获得窗口的当前位置
		winmove ahk_id %g_EditorID%, ,  0, 0, a_screenwidth, var_h
		winmove %g_wintitle%, ,  a_screenwidth - g_guiW, 0				;; 将控制栏窗口移动到最右上角
	}
	else
	{	
		Menu, WindowMenu, Uncheck, 满屏(&F)
		if EditorWidth =
			EditorWidth := 800
		if EditorHeight =
			EditorHeight := 600

		winmove %g_wintitle%, ,  g_guiX, g_guiY							;; 还原控制栏窗口位置
		winmove ahk_id %g_EditorID%, ,  g_guiX, g_guiY + g_guiH, EditorWidth, EditorHeight  ;; 还原编辑器位置
	}
	return


【关闭编辑窗口】:
	g_bClosed := true
	if g_bMultTab
	{
		IfWinNotActive, ahk_id %g_EditorID%, , WinActivate, ahk_id %g_EditorID%, 
		WinWaitActive, ahk_id %g_EditorID%, 
		WinGetActiveTitle, OutputVar 
		ifInString OutputVar, %g_tempfileName%
		{	
			IfWinActive ahk_id %g_EditorID%
				send ^s		
			send ^{F4}                      ;; 是多标签窗口，则发送ctrl+F4关闭当前标签
		}		
	}
	else
	{
		IfWinActive ahk_id %g_EditorID%
			send ^s	
		WinClose ahk_id %g_EditorID%
	}
	return

WM_MOVE()
{
	local Width, Height, x,y
	if g_bClosed
		return

	gui submit, nohide
	;; 非满屏时，编辑器跟随GUI的移动而移动
	if not _bFullScr
	{
		WinGetActiveStats, Title, Width, Height, X, Y 
		y := y + Height
		winmove ahk_id %g_EditorID%, ,  x, y
	}
}


;;---窗口激活与失去焦点------------------------------------------------------
WM_ACTIVATE()
{
	GLOBAL
	if g_bClosed
		return

	;; 如果编辑窗口处于置顶状态，则无需再激活之
	if _bTop
		return

	sleep 100
	IfWinActive %g_WINTITLE%
	{
		;; 从其他窗口切换到本窗口
		if g_EnterExit = -1
		{
			WinSet, Transparent, 200,  %g_WINTITLE%
			Winset, Transparent, 100,  ahk_id %g_EditorID%
			g_EnterExit = 1
		}
		;; 在本窗口刷新
		else
		{
			g_EnterExit = 0
		}
				
		;; 从其他窗口切换到我的小字典窗口 or 在本窗口刷新
		ifWinNotActive ahk_id %g_EditorID%
		{
			winactivate ahk_id %g_EditorID%
			sleep 100
			winactivate %g_WINTITLE%
		}
	}
	else  ;; 从小字典窗口切换到其他窗口
	{
		g_EnterExit = -1
		WinSet, Transparent, 100,  %g_WINTITLE%
		IfWinActive  ahk_id %g_EditorID%
		{
			Winset, Transparent, 200,  ahk_id %g_EditorID%
		}
	}
	RETURN
}

#include ./inc/common.aik

