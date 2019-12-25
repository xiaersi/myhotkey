#include ..\
#include .\inc\common.aik

; 如果MKZ还没启动, 则启动之
ifwinnotexist MetalKnightZeroClient v0.07.0693.1101 ahk_class DriftingLivingClass
{
	ifwinnotexist mkz_shell ahk_class #32770
	{
		run D:\Program Files\一起玩平台\MKZ军魂\shell\Shell_2008.exe, D:\Program Files\一起玩平台\MKZ军魂
	}
}
#ifwinnotexist  MetalKnightZeroClient v0.07.0693.1101 ahk_class DriftingLivingClass

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 登录窗口
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive mkz_shell ahk_class #32770


F5::
	reload
	return
F8::
	ControlSetText, Edit2, object
	InputBox, OutputVar, 验证码, 请输入验证码!, , 360, 120
	ControlSetText, Edit3, %OutputVar%
	controlclick 开始游戏
	Sleep 800
	send {enter}
;	winwait 
	ExitApp
	return
	
g_diubao := false

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 游戏窗口
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive MetalKnightZeroClient v0.07.0717.1102 ahk_class DriftingLivingClass
;#ifwinactive ahk_class DriftingLivingClass
; 屏蔽两个键
<#:: return
H::return
y::Return
U::Return
^space::return

	
; 切换到非MKZ窗口
!Tab::
F4::
	if not g_TrayWndGroup
	{
	GroupAdd, g_TrayWndGroup, ahk_class Shell_TrayWnd
	}
	GroupActivate, g_TrayWndGroup
	return 
	
	
	
F8::
::psw;::
	send 175pt{enter}
	return

!f4::	
	exitapp
	return
	
	
F12::
	tooltip 开始丢包救人
	g_diubao := true
	SetTimer, 丢包救人,25000
	sleep 1000
	tooltip
	return

丢包救人:
	ifwinexist MetalKnightZeroClient v0.07.0693.1101 ahk_class DriftingLivingClass
	{
		if (g_diubao)
		{
		WinGetActiveTitle this_title
		MouseGetPos, xpos, ypos  
		winactivate MetalKnightZeroClient v0.07.0693.1101 ahk_class DriftingLivingClass
		send {lbutton }
		sleep 200
		WinActivate %this_title%
		MouseMove , xpos, ypos 
		return
		}
	}
	SetTimer, 丢包救人, off
	return
	
F11:
	tooltip 停止丢包
	g_diubao := false
	sleep 1000
	tooltip
	return
	
#!numpad1::
	WinGetActiveStats,title_ActiveWindow,var_width,var_height,var_x,var_y
	winmove,%title_ActiveWindow%,,0,880
	return
	
#!numpad0::
	WinGetActiveStats,title_ActiveWindow,var_width,var_height,var_x,var_y
	winmove,%title_ActiveWindow%,,0,0
	return
	
i::
	loop_send_while_keydown("i", "+w")
	Return
	
k::
	loop_send_while_keydown("k", "+s")
	Return	
j::
	loop_send_while_keydown("j", "+a")
	Return	
l::
	loop_send_while_keydown("l", "+d")
	Return	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive