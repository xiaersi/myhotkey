;; ���ļ����������������е��ȼ�������IE��TheWorld��Thooe��
#include .\inc\functions.inc

#ifwinactive ahk_class IEFrame 
#2::
;	WinGetActiveStats,title_ActiveWindow,var_width,var_height,var_x,var_y
;	winmove,%title_ActiveWindow%,,%var_x%,%var_y%,800,600
	ResetActiveWindowRect(810,600)
	return

;; ���ʰ����߲���
f9::

	send ^c
	sleep 100
	ifwinexist ahk_class IEFrame
	{
		winactivate
		sleep 300
		send {f6}
		sleep 100
		clipboard=http://dict.iciba.com/%clipboard%/
		send ^v{enter}
	}
	else
	run C:\Program Files\Internet Explorer\IEXPLORE.EXE http://dict.iciba.com/%clipboard%/
	return

esc::                                                   ;; �رմ���
	send ^w
	return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;�ѹ������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive ahk_class SE_AxControl
esc::
	send ^w
	return

f1::
	send ^+p
	return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;���������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive ahk_class Maxthon3Cls_MainFrm
esc::
	send ^w
	return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 360�����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; se3.0
#ifwinactive ahk_class Container
esc::
	send ^w
	return

f1::
f12::	; ����ͼƬ
	click right
	send s
	winwait ����ͼƬ ahk_class #32770,,5
	if not errorlevel 
	{
	winactivate
	send {home}
	send %a_year%
	send %a_dd%
	send %A_Min%
	}
	return
#ifwinactive 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ����֮�������
#ifwinactive ahk_class XFrame_Wnd
sc07b::
f7::		;;�������Ϲ���
	MouseClick, WheelUp, , , 2
	return
sc079::
f8::
	MouseClick, WheelDown, , , 2
	return
sc070 & x::
esc::
	send ^w
	return
f1::
f12::	; ����ͼƬ
	click right
	send s
	winwait ����ͼƬ ahk_class #32770,,5
	if not errorlevel 
	{
	winactivate
	send {home}
	send %a_year%
	send %a_dd%
	send %A_Min%
	}
	return



#ifwinactive ����ͼƬ ahk_class #32770
f2::
	controlclick Button2,����ͼƬ ahk_class #32770
;	ifwinexist  ahk_class TThooeMain
	ifwinexist   ahk_class XFrame_Wnd
	winactivate
	send ^w
return
#ifwinactive
