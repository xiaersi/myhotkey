#include ..\
#include .\inc\common.aik

; ���MKZ��û����, ������֮
ifwinnotexist MetalKnightZeroClient v0.07.0693.1101 ahk_class DriftingLivingClass
{
	ifwinnotexist mkz_shell ahk_class #32770
	{
		run D:\Program Files\һ����ƽ̨\MKZ����\shell\Shell_2008.exe, D:\Program Files\һ����ƽ̨\MKZ����
	}
}
#ifwinnotexist  MetalKnightZeroClient v0.07.0693.1101 ahk_class DriftingLivingClass

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��¼����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive mkz_shell ahk_class #32770


F5::
	reload
	return
F8::
	ControlSetText, Edit2, object
	InputBox, OutputVar, ��֤��, ��������֤��!, , 360, 120
	ControlSetText, Edit3, %OutputVar%
	controlclick ��ʼ��Ϸ
	Sleep 800
	send {enter}
;	winwait 
	ExitApp
	return
	
g_diubao := false

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��Ϸ����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#IfWinActive MetalKnightZeroClient v0.07.0717.1102 ahk_class DriftingLivingClass
;#ifwinactive ahk_class DriftingLivingClass
; ����������
<#:: return
H::return
y::Return
U::Return
^space::return

	
; �л�����MKZ����
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
	tooltip ��ʼ��������
	g_diubao := true
	SetTimer, ��������,25000
	sleep 1000
	tooltip
	return

��������:
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
	SetTimer, ��������, off
	return
	
F11:
	tooltip ֹͣ����
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