; Winword �����У�pageup,pagedown�ֱ����¹���
#include .\inc\functions.inc
#include .\inc\onenote.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ʵ������ƶ���ָ�����ڣ��ô��ڻ��Զ��任͸����
SetWin_Top_autoTransparent_onenote(var_title,var_text,var_Transparent1=240,var_Transparent2=200,var_Transparent3=180,var_Transparent4=80)
{

	ifwinexist %var_title%,%var_text%
	{
	WinGetPos var_x,var_y,var_width,var_height ,%var_title%,%var_text%
CoordMode, mouse, Screen  
		MouseGetPos, mouseVarX, mouseVarY
		if(mouseVarX>var_x and mouseVarX<var_x+var_width and mousevary > var_y+25 and mousevary<var_y+var_height)
			SetWin_Top_Transparent(var_title,var_text,false,var_Transparent1,var_Transparent2)
		else
			SetWin_Top_Transparent(var_title,var_text,false,var_Transparent3,var_Transparent4)
CoordMode, mouse, Relative  
	}
}

var_wheelnum =3
bool_AutoTransparent_smallwindow :=false
title_AutoTransparent = ahk_class Framework::CFrame
text_AutoTransparent  = ��ҳ��ͼ

OneNote���ڱ�Сʱ�Զ��ö���͸��:
	sleep 500
	ifwinexist %title_AutoTransparent%, %text_AutoTransparent%
	{
		WinGetPos var_x,var_y,var_width,var_height ,%title_AutoTransparent%,%text_AutoTransparent%
		if (var_width <= g_ontnote_width and var_height <= g_ontnote_height) 	{
			bool_AutoTransparent_smallwindow :=true		;; ���ڲ�����ָ��С���ڵĿ��, �������Զ�͸��
		} else {
			bool_AutoTransparent_smallwindow :=false
		}
			
		if bool_AutoTransparent_smallwindow		{
			SetWin_Top_autoTransparent_onenote(title_AutoTransparent,text_AutoTransparent)
		} else {
			SetTimer, OneNote���ڱ�Сʱ�Զ��ö���͸��, Off
			tooltip 
		}
	}
	else
	{
		msgbox OneNote���ڲ�����, ȡ���Զ�͸��`ntitle=%title_AutoTransparent%`ntext=%text_AutoTransparent%
		SetTimer, OneNote���ڱ�Сʱ�Զ��ö���͸��, Off
		tooltip 
	}
	return


;; ����OneNote, ����var_area��������Χ
SeachOneNote(var_area, var_search)
{
  ;; ȷ����OneNote
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	ControlFocus, NetUIHWND1, A
	send {down}

	if (var_area="g" or var_area=2)
	{
		send g
	}
	else if (var_area="t" or var_area=3)
	{
		send t
	}
	else if (var_area="n" or var_area=n)
	{
		send n
	}
	else ;if(var_area="s" or var_area=1)
	{	
		send s
	}
	send ^f
	clipboard = %var_search%
	sleep 100
	send ^v{enter}
  }
}

;;////////////////////////////////////////////////////////
;; OneNote ���� Exist
;;////////////////////////////////////////////////////////
#IfWinExist #ifwinactive ahk_class Framework::CFrame, MsoDockTop

#IfWinExist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OneNote ����
#ifwinactive ahk_class Framework::CFrame, MsoDockTop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
::;reload::
	reload
	return

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; ��ʱʹ��
  F9::
  	send {tab}{end}{tab 2}
  	sleep 100
  	send {left}{home}
  	return


f12::   ;�����л��󴰿���С����
	ifwinnotactive ahk_class Framework::CFrame,MsoDockTop
		return

	WinGetActiveTitle var_title

	;; ȷ����OneNote
	IfNotInString , var_title, - Microsoft Office OneNote
		Return
	
 	;; ����С���ڵĿ��
 	if (g_ontnote_width < 10 or g_ontnote_width ="")
 	{
 		IniRead, g_ontnote_width, var.ini, OneNote, minwidth, 0
 		if (g_ontnote_width = 0  or g_ontnote_width="" or g_ontnote_width="error")
 		{
 			g_ontnote_width := A_ScreenWidth * 0.45
 			write_ini ( "var.ini", "OneNote", "minwidth", g_ontnote_width)
 		}
 	}
 	
 	if (g_ontnote_height < 10 or g_ontnote_height = "")
 	{
 		IniRead , g_ontnote_height, var.ini, OneNote, minheight, error
 		if (g_ontnote_height < 10 or g_ontnote_height="" or g_ontnote_height="error")
 		{
 			g_ontnote_height := A_ScreenHeight / 3
 			write_ini ( "var.ini", "OneNote", "minheight", g_ontnote_height)
 		}
 	}
 	
 	
	send {f11}
 	WinGet, varMinMax, Minmax, A
 	

	winGetPos,var_x,var_y,var_width,var_height,ahk_class Framework::CFrame,��ҳ��ͼ
	if (var_height<=g_ontnote_height)	; ������С�Ѿ���С͸������ʱ����F12��󻯣�ȡ����̬͸��
	{
		bool_AutoTransparent_smallwindow :=false
		SetTimer, OneNote���ڱ�Сʱ�Զ��ö���͸��, off
		WinSet, Transparent, Off, ahk_class Framework::CFrame,��ҳ��ͼ
	 	if (varMinMax = 1) 
		    WinRestore A
		WinMaximize A
	}
	else		;���򣬽�OneNote������С�����½ǣ�g_ontnote_width��g_ontnote_height��������̬͸��
	{
	 	if (varMinMax = 1) 
	 	{
		    WinRestore A
		    sleep 100
		}
		bool_AutoTransparent_smallwindow :=true
		winmove, ahk_class Framework::CFrame,��ҳ��ͼ,A_ScreenWidth-g_ontnote_width-20,A_ScreenHeight-g_ontnote_height - 20,g_ontnote_width,g_ontnote_height
		sleep 300
		winGetPos,var_x,var_y,var_width,var_height,ahk_class Framework::CFrame,��ҳ��ͼ
		WinGetTitle title_AutoTransparent,A
		bool_AutoTransparent_alwaystop := false
		if var_width < 400	; ����̫Сʱ, �ö���ťλ�ò�����
		{
			click 30,40		;����ö���ť
		}
		else 
		{
;			msgbox var_width=%var_width%
			click 55,45		;����ö���ť
		}
		SetTimer, OneNote���ڱ�Сʱ�Զ��ö���͸��, 500
		sleep 1000
	}
	return 

^+c::	; �������ı�
	WinGetActiveTitle var_title
	ifinstring , var_title, - Microsoft Office OneNote
	{
	clipboard =
	sleep 100
	send ^c
	sleep 200
	varClip := clipboard
	clipboard := varClip
	}
	return
^+v::
;; ȷ����OneNote
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	varClip := clipboard
	clipboard := varClip
	send ^v
  }
  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��������
/*
;; �����������е�����
F3 & numpad1::
F3 & s::
  SeachOneNote("s", clipboard)
  return

F3 & numpad2::
F3 & g::
  SeachOneNote("g", clipboard)
  return

F3 & numpad3::
F3 & t::
  SeachOneNote("t", clipboard)
  return

F3 & numpad4::
F3 & n::
  SeachOneNote("n", clipboard)
  return

F3 & space::
F3 & numpad0::
    ;; ȷ����OneNote
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	send ^f
	controlfocus OneNote::CJotSurfaceWnd1, A
  }
  return

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��F3������������Χ��ѡ��˵�, 5��֮��ѡ��Χ֮������Ӧ�ķ�Χ�������������е�����
F3::
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	var_ok := 0
	ControlFocus, RichEdit20W2, A
	sleep 100
	send {tab}{down}
	loop 40	; ѭ��50��, ÿ��sleep 0.1��, ���൱�ڵȴ�5�� �û�ѡ��������Χ
	{
		sleep 100
		GetKeyState, state, LButton
		GetKeyState, state2, space
		if state = D or state2 = D
		    {
			var_ok := 0
			send {ctrl down}f{ctrl up}
			controlfocus OneNote::CJotSurfaceWnd1, A
			break
		    }

		GetKeyState, state, s
		if state = D
		    {
			tooltip �ڵ�ǰ����������
			var_ok := 1
			break
		    }

		GetKeyState, state, g
		if state = D
		    {
			tooltip �ڵ�ǰ ������ ������
			var_ok := 1
			break
		    }

		GetKeyState, state, t
		if state = D
		    {
			tooltip �ڵ�ǰ�ʼǱ�������
			var_ok := 1
			break
		    }

		GetKeyState, state, n
		if state = D
		    {
			tooltip �����бʼǱ�����
			var_ok := 1
			break
		    }

		GetKeyState, state, enter
		if state = D
		    {
			var_ok := 0
			return
		    }
	}

	if (var_ok=1)
	    {
		send ^f^v{enter}
		sleep 800
	    }

	tooltip
  }
  return
  


^`::	; �����мӴֲ��ҼӴ�һ���ֺ�
	send {home}{shift down}{end}{shift up}
^+B::
	sendevent {ctrl down}b{ctrl up}
	sendevent ^+.
	return
	

#ifwinactive 
