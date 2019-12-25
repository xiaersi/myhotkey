; Winword 窗口中，pageup,pagedown分别上下滚动
#include .\inc\functions.inc
#include .\inc\onenote.aik
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 实现鼠标移动到指定窗口，该窗口会自动变换透明度
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
text_AutoTransparent  = 整页视图

OneNote窗口变小时自动置顶和透明:
	sleep 500
	ifwinexist %title_AutoTransparent%, %text_AutoTransparent%
	{
		WinGetPos var_x,var_y,var_width,var_height ,%title_AutoTransparent%,%text_AutoTransparent%
		if (var_width <= g_ontnote_width and var_height <= g_ontnote_height) 	{
			bool_AutoTransparent_smallwindow :=true		;; 窗口不大于指定小窗口的宽高, 则允许自动透明
		} else {
			bool_AutoTransparent_smallwindow :=false
		}
			
		if bool_AutoTransparent_smallwindow		{
			SetWin_Top_autoTransparent_onenote(title_AutoTransparent,text_AutoTransparent)
		} else {
			SetTimer, OneNote窗口变小时自动置顶和透明, Off
			tooltip 
		}
	}
	else
	{
		msgbox OneNote窗口不存在, 取消自动透明`ntitle=%title_AutoTransparent%`ntext=%text_AutoTransparent%
		SetTimer, OneNote窗口变小时自动置顶和透明, Off
		tooltip 
	}
	return


;; 搜索OneNote, 参数var_area是搜索范围
SeachOneNote(var_area, var_search)
{
  ;; 确保是OneNote
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
;; OneNote 窗口 Exist
;;////////////////////////////////////////////////////////
#IfWinExist #ifwinactive ahk_class Framework::CFrame, MsoDockTop

#IfWinExist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OneNote 窗口
#ifwinactive ahk_class Framework::CFrame, MsoDockTop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
::;reload::
	reload
	return

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; 临时使用
  F9::
  	send {tab}{end}{tab 2}
  	sleep 100
  	send {left}{home}
  	return


f12::   ;用来切换大窗口与小窗口
	ifwinnotactive ahk_class Framework::CFrame,MsoDockTop
		return

	WinGetActiveTitle var_title

	;; 确保是OneNote
	IfNotInString , var_title, - Microsoft Office OneNote
		Return
	
 	;; 设置小窗口的宽高
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
 	

	winGetPos,var_x,var_y,var_width,var_height,ahk_class Framework::CFrame,整页视图
	if (var_height<=g_ontnote_height)	; 窗口最小已经是小透明窗口时，按F12最大化，取消动态透明
	{
		bool_AutoTransparent_smallwindow :=false
		SetTimer, OneNote窗口变小时自动置顶和透明, off
		WinSet, Transparent, Off, ahk_class Framework::CFrame,整页视图
	 	if (varMinMax = 1) 
		    WinRestore A
		WinMaximize A
	}
	else		;否则，将OneNote窗口缩小到右下角（g_ontnote_width，g_ontnote_height），并动态透明
	{
	 	if (varMinMax = 1) 
	 	{
		    WinRestore A
		    sleep 100
		}
		bool_AutoTransparent_smallwindow :=true
		winmove, ahk_class Framework::CFrame,整页视图,A_ScreenWidth-g_ontnote_width-20,A_ScreenHeight-g_ontnote_height - 20,g_ontnote_width,g_ontnote_height
		sleep 300
		winGetPos,var_x,var_y,var_width,var_height,ahk_class Framework::CFrame,整页视图
		WinGetTitle title_AutoTransparent,A
		bool_AutoTransparent_alwaystop := false
		if var_width < 400	; 窗口太小时, 置顶按钮位置不正常
		{
			click 30,40		;点击置顶按钮
		}
		else 
		{
;			msgbox var_width=%var_width%
			click 55,45		;点击置顶按钮
		}
		SetTimer, OneNote窗口变小时自动置顶和透明, 500
		sleep 1000
	}
	return 

^+c::	; 仅复制文本
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
;; 确保是OneNote
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	varClip := clipboard
	clipboard := varClip
	send ^v
  }
  return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 搜索功能
/*
;; 搜索剪贴板中的内容
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
    ;; 确保是OneNote
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	send ^f
	controlfocus OneNote::CJotSurfaceWnd1, A
  }
  return

*/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 按F3将弹出搜索范围的选项菜单, 5秒之内选择范围之后即在相应的范围内搜索剪贴板中的内容
F3::
  WinGetActiveTitle var_title
  ifinstring , var_title, - Microsoft Office OneNote
  {
	var_ok := 0
	ControlFocus, RichEdit20W2, A
	sleep 100
	send {tab}{down}
	loop 40	; 循环50次, 每次sleep 0.1秒, 即相当于等待5秒 用户选择搜索范围
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
			tooltip 在当前分区内搜索
			var_ok := 1
			break
		    }

		GetKeyState, state, g
		if state = D
		    {
			tooltip 在当前 分区组 内搜索
			var_ok := 1
			break
		    }

		GetKeyState, state, t
		if state = D
		    {
			tooltip 在当前笔记本内搜索
			var_ok := 1
			break
		    }

		GetKeyState, state, n
		if state = D
		    {
			tooltip 在所有笔记本搜索
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
  


^`::	; 将整行加粗并且加大一级字号
	send {home}{shift down}{end}{shift up}
^+B::
	sendevent {ctrl down}b{ctrl up}
	sendevent ^+.
	return
	

#ifwinactive 
