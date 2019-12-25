/**
 *@file    ʹ��ָ�����߱༭ѡ���ı�.ahk
 *@author  teshorse
 *@date    2011.09.26
 *@brief   ʹ��ָ�����ı��༭���༭��ǰѡ�е�����
 *
 * ͨ������1��ָ���ı��༭���ߣ�
 *- ���Ƶ�ǰѡ�е����ݲ�����Ϊtemp.txt�����øù��ߴ򿪱༭֮��
 *- �ı��༭���ı������������أ�ͬʱ��һ��������
 *- �༭���֮��ͨ�������ɰ�ť���༭�õ����ݸ��Ƶ�ԭ���Ĵ��ڡ�
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
g_title = �༭ѡ���ı�
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_winx := A_CaretX
g_winx := A_CaretY
g_bMultTab := false                     ;; �ı��༭���Ƕ��ǩ��
g_bClosed := false

if ( g_winx == "" or g_winy == "" )
	MouseGetPos, g_winx, g_winy 

;; ��ȡ����
g_param1 = %1%
ifinstring g_param1, `n
{
	;; ����������лس��������ж������
	g_TextEditor := GetValueFromParams(g_param1, "editor")
	g_bClip := GetValueFromParams(g_param1, "bclip")
	g_winsize := GetValueFromParams(g_param1, "winsize")
	g_winx := GetValueFromParams(g_param1, "winx")
	g_winy := GetValueFromParams(g_param1, "winy")
	g_bActivateEditor := GetValueFromParams(g_param1, "activate")
}
else
{
	;; �������û�лس������������Ǳ༭��
	g_TextEditor := g_param1

	;; ���༭�����ƶ�Ҫ��Ļ����
	g_winx := ( a_ScreenWidth - 800 ) / 2
	g_winy := ( a_ScreenHeight - 600 ) / 2
	
}

;; ���ָ�����ı��༭���Ƿ����
ifNotExist %g_TextEditor%
{
	msgbox û����ȷָ���ı��༭����
	ExitApp
}

;; ��������
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
		msgbox û��ѡ�����ݣ�
		ExitApp
	}
}

;; �����BCB��VS2008��ʹ��cpp��չ��
if g_AWinClass in TEditWindow,wndclass_desked_gsk
{
	g_tempfile = bak/temp.cpp
	g_tempfileName = temp.cpp
}
/* ;; ������֤ȯ��Ϣ���޹�˾���������ܲɱ�ϵͳ�У���Ҫ�༭JavaScript�ű���
else if g_AWinTitle = �ۺ�ҵ��֧��ϵͳ------���ܲɱ�ϵͳ------�ɱ��������
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

;; �����Ƶ����ݱ��浽temp.txt�ļ���
ifExist %g_tempfile%
	filedelete %g_tempfile%


filebuf = %clipboard%
fileappend %filebuf%, %g_tempfile%


;; ��ָ���ı༭���򿪸���ʱ�ļ����б༭
run %g_TextEditor% %g_tempfile%, , min, g_EditorPID

WinWait, ahk_pid %g_EditorPID%, , 1
WinGet, g_EditorID, ID, ahk_pid %g_EditorPID%
if g_EditorID <>
{
	WinSet, Style, -0xC00000, ahk_id %g_EditorID%
}
else
{
    g_bMultTab := true                 ;; �ı��༭�����ж����ǩ
	WinGetActiveTitle, OutputVar 
	ifInString OutputVar, %g_tempfileName%
	{	
		WinGet, g_EditorID, id, A
	}
}

;; �˵�

;;---�����˵���--------------------------------------------------------------
Menu, FileMenu, Add, ��ɱ༭(&Y),���༭��ɡ�
Menu, FileMenu, Add, ȡ���༭(&N),��ȡ���༭��
Menu, FileMenu, Add
Menu, FileMenu, Add, E&xit     �˳�����       ESC, GuiClose

Menu, WindowMenu, Add, ����༭(&C) , ������༭���ڡ�
Menu, WindowMenu, Add, ����(&F), ������������
Menu, WindowMenu, Add, ��͸��(&A), �����ڰ�͸����
Menu, WindowMenu, Add, ������ǰ(&T), �������ö���



Menu, HelpMenu, Add,
;Menu, HelpMenu, Add, ���� (&0),  �����ڡ�

Menu, MyMenuBar, Add, ���(&Y),���༭��ɡ�
;menu, MyMenuBar, add,  |��, ��donothing��

Menu, MyMenuBar, Add, &File, :FileMenu
Menu, MyMenuBar, Add, С����(&1), ��С���ڡ�
Menu, MyMenuBar, Add, �д���(&2), ���д��ڡ�
Menu, MyMenuBar, Add, �󴰿�(&3), ���󴰿ڡ�
Menu, MyMenuBar, Add, &Window, :WindowMenu
Menu, MyMenuBar, Add, &Help, :HelpMenu
;menu, MyMenuBar, add, ��������, ��donothing�� 
;menu, MyMenuBar, add, ��|, ��donothing��
Menu, MyMenuBar, Add, ȡ��(&N),��ȡ���༭��

_bFullScr 	:= false                   ;; ��ǰ�Ƿ�����״̬
_bA         := false                   ;; ��ǰ�Ƿ��͸��״̬ 
_bTop      	:= false                   ;; ��ǰ�Ƿ��ö�״̬


;; ��ʾUI
var_y := g_winy - 55
Gui +ToolWindow  +AlwaysOnTop
Gui +LastFound
;; ���ô���͸������ʾ
;Gui, Color, EEAA99
;WinSet, TransColor, EEAA99
Gui, Menu, MyMenuBar
;Gui, Add, Text, , XXX

/*
Gui add, button,    g���༭��ɡ�, ��ɱ༭(&Y)
Gui add, button, ym g������༭���ڡ�, ����༭(&A)
Gui add, button, ym g��С���ڡ�, С����
Gui add, button, ym g���д��ڡ�, �д���
Gui add, button, ym g���󴰿ڡ�, �󴰿�
Gui add, checkbox, ym y12 v_bFullScr g������������, ����
Gui add, checkbox, ym y12 v_bA g�����ڰ�͸����, ��͸��
Gui add, button, ym g��ȡ���༭��, ȡ���༭(&N)
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
	;; ȥ���༭��������
	WinRestore , ahk_id %g_EditorID%
	if g_winsize = big
	{
		gosub ���󴰿ڡ�
	}
	else if g_winsize = small
	{
		gosub ��С���ڡ�
	}
	else
	{
		gosub ���д��ڡ�
	}
	winshow ahk_id %g_EditorID%
}
else
{
	;; ��Gui�ƶ������ǩ�༭���ı������Ϸ�
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

;; Ϊ�༭�����ÿ�ݼ�
Hotkey, IfWinActive, ahk_id %g_EditorID%
Hotkey, !enter, ���༭��ɡ�
Hotkey, ^enter, ���༭��ɡ�
Hotkey, !esc, ��ȡ���༭��
Hotkey, !F4, ��ȡ���༭��

return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
��DoNothing��:
	return

���༭��ɡ�:
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
	gosub ���رձ༭���ڡ�
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
��ȡ���༭��:
	gui hide
	winactivate ahk_id %g_EditorID%
	sleep 100
	gosub ���رձ༭���ڡ�

	ExitApp
	return


������༭���ڡ�:
	winactivate ahk_id %g_EditorID%
	return


��С���ڡ�:
	WinGetPos , guiX, guiY, guiW, guiH, %g_wintitle%
	winmove ahk_id %g_EditorID%, ,  guiX, guiY+guiH, 480, 320
	return

���д��ڡ�:
	WinGetPos , guiX, guiY, guiW, guiH, %g_wintitle%
	winmove ahk_id %g_EditorID%, ,  guiX, guiY+guiH, 800, 600
	return

���󴰿ڡ�:
	WinGetPos , guiX, guiY, guiW, guiH, %g_wintitle%
	winmove ahk_id %g_EditorID%, ,  guiX, guiY+guiH, 1024, 768
	return
	return

�������ö���:
	_bTop := !_bTop
	if _bTop
	{
		Menu, WindowMenu,Check, ������ǰ(&T)
	  	WinSet, AlwaysOnTop,  on,  ahk_id %g_EditorID%
	}
	else
	{
		Menu, WindowMenu, Uncheck, ������ǰ(&T)
		WinSet, AlwaysOnTop,  off,  ahk_id %g_EditorID%	
	}
	return


�����ڰ�͸����:
	gui submit, nohide
	_bA := !_bA
	if _bA
	{
		Menu, WindowMenu,Check, ��͸��(&A)
	  	WinSet, Transparent,  160,  ahk_id %g_EditorID%
	}
	else
	{
		Menu, WindowMenu, Uncheck, ��͸��(&A)
		WinSet, Transparent,  off,  ahk_id %g_EditorID%
	}
	return

������������:
	gui submit, nohide
	_bFullScr := !_bFullScr
	if _bFullScr
	{
		Menu, WindowMenu,Check, ����(&F)
		WinGetPos , , , EditorWidth, EditorHeight,  ahk_id %g_EditorID%
		var_h := GetDeskHeight()
		WinGetPos , g_guiX, g_guiY, g_guiW, g_guiH, %g_wintitle% 		;; ��ô��ڵĵ�ǰλ��
		winmove ahk_id %g_EditorID%, ,  0, 0, a_screenwidth, var_h
		winmove %g_wintitle%, ,  a_screenwidth - g_guiW, 0				;; �������������ƶ��������Ͻ�
	}
	else
	{	
		Menu, WindowMenu, Uncheck, ����(&F)
		if EditorWidth =
			EditorWidth := 800
		if EditorHeight =
			EditorHeight := 600

		winmove %g_wintitle%, ,  g_guiX, g_guiY							;; ��ԭ����������λ��
		winmove ahk_id %g_EditorID%, ,  g_guiX, g_guiY + g_guiH, EditorWidth, EditorHeight  ;; ��ԭ�༭��λ��
	}
	return


���رձ༭���ڡ�:
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
			send ^{F4}                      ;; �Ƕ��ǩ���ڣ�����ctrl+F4�رյ�ǰ��ǩ
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
	;; ������ʱ���༭������GUI���ƶ����ƶ�
	if not _bFullScr
	{
		WinGetActiveStats, Title, Width, Height, X, Y 
		y := y + Height
		winmove ahk_id %g_EditorID%, ,  x, y
	}
}


;;---���ڼ�����ʧȥ����------------------------------------------------------
WM_ACTIVATE()
{
	GLOBAL
	if g_bClosed
		return

	;; ����༭���ڴ����ö�״̬���������ټ���֮
	if _bTop
		return

	sleep 100
	IfWinActive %g_WINTITLE%
	{
		;; �����������л���������
		if g_EnterExit = -1
		{
			WinSet, Transparent, 200,  %g_WINTITLE%
			Winset, Transparent, 100,  ahk_id %g_EditorID%
			g_EnterExit = 1
		}
		;; �ڱ�����ˢ��
		else
		{
			g_EnterExit = 0
		}
				
		;; �����������л����ҵ�С�ֵ䴰�� or �ڱ�����ˢ��
		ifWinNotActive ahk_id %g_EditorID%
		{
			winactivate ahk_id %g_EditorID%
			sleep 100
			winactivate %g_WINTITLE%
		}
	}
	else  ;; ��С�ֵ䴰���л�����������
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

