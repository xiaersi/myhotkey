;; Wink ��¼�������shift+Pause ��ͨ¼���� Alt+Pause �û���һ�£�¼һ�£� Pause ץͼ��
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
numpadAdd::     ;; ���õ�ǰ֡ͣ��ʱ�� +0.5��                                                                                    
	controlgettext var_time, Edit3, %g_wintitle%
	var_time += 0.5
	ControlSetText Edit3, %var_time%, %g_wintitle%
	return

numpadsub::     ;; ���õ�ǰ֡ͣ��ʱ�� -0.1��
	controlgettext var_time, Edit3, %g_wintitle%
	var_time -= 0.1
	ControlSetText Edit3, %var_time%, %g_wintitle%
	return

^G::			;; ��ת��ҳ��
	if g_page <>  	;; ���ص�֮ǰ��ҳ��
	{
		ControlFocus Edit1, %g_wintitle%
		sleep 100
		send %g_page%
		send {enter}
		g_page =
		tooltip �Ѿ���ת�� %g_page% ҳ��
		sleep 1000
		tooltip
	}
	else 
	{
		inputbox var_input, ��ת, ������ת���ڼ�ҳ��, , 260, 120
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
	run 	WinK�Ҽ���ݲ˵�.ahk
	return
#ifwinactive 

