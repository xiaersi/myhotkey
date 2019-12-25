;; Wink 是录屏软件，shift+Pause 普通录屏， Alt+Pause 用户动一下，录一下， Pause 抓图。
g_wintitle = ahk_class wxMDIFrameClassNR
#ifwinexist ahk_class wxMDIFrameClassNR
g_page = 

F5::
	send +{Pause}
	return
	
F8::
	send !{Pause}
	return
	
F4::
	send {Pause}
	return
	
esc::
	ExitApp

#ifwinactive ahk_class wxMDIFrameClassNR
numpadAdd::     ;; 设置当前帧停留时间 +0.5秒                                                                                    
	controlgettext var_time, Edit3, %g_wintitle%
	var_time += 0.5
	ControlSetText Edit3, %var_time%, %g_wintitle%
	return

numpadsub::     ;; 设置当前帧停留时间 -0.1秒
	controlgettext var_time, Edit3, %g_wintitle%
	var_time -= 0.1
	ControlSetText Edit3, %var_time%, %g_wintitle%
	return

^G::			;; 跳转到页面
	if g_page <>  	;; 返回到之前的页面
	{
		ControlFocus Edit1, %g_wintitle%
		sleep 100
		send %g_page%
		send {enter}
		g_page =
		tooltip 已经跳转到 %g_page% 页！
		sleep 1000
		tooltip
	}
	else 
	{
		inputbox var_input, 跳转, 您想跳转到第几页？, , 260, 120
		if var_input > 0
		{
			sleep 50
			ControlFocus Edit1, %g_wintitle%
			sleep 50
			controlgettext, g_page, edit1, %g_wintitle%
			sleep 50
			send %var_input%
			send {enter}
		}
	}
	return

~Rbutton::
	run 	WinK右键快捷菜单.ahk
	return
#ifwinactive 

