
#IfWinExist 飞扬魔术键盘 ahk_class AutoHotkeyGUI
!Rshift::		;; Alt+RShift 点击飞扬魔术键盘是的设置按钮
	Gosub 【点击飞扬魔术键盘是的设置按钮】
	return


#IfWinExist 


【点击飞扬魔术键盘是的设置按钮】:
	ControlClick , Button57, 飞扬魔术键盘 ahk_class AutoHotkeyGUI
	;; 如果shift处于按下状态，则弹起之
	GetKeyState, state, Shift
	if state = D
		send {shift up}
	return
