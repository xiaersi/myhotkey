
#IfWinExist ����ħ������ ahk_class AutoHotkeyGUI
!Rshift::		;; Alt+RShift �������ħ�������ǵ����ð�ť
	Gosub ���������ħ�������ǵ����ð�ť��
	return


#IfWinExist 


���������ħ�������ǵ����ð�ť��:
	ControlClick , Button57, ����ħ������ ahk_class AutoHotkeyGUI
	;; ���shift���ڰ���״̬������֮
	GetKeyState, state, Shift
	if state = D
		send {shift up}
	return
