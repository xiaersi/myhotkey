;; �����
#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������

#ifwinactive ahk_class VMUIFrame
~Rbutton & lbutton::
	send {ctrl}{alt}
	return


#1::
	ControlGetPos , cX, cY, cWidth, cHeight, MKSEmbedded1, ahk_class VMUIFrame
	WinSet, Region, %cX%-%cY% W%cWidth% H%cHeight% R20-20, ahk_class VMUIFrame
	return

#3::
	ControlGetPos , cX, cY, cWidth, cHeight, MKSEmbedded1, ahk_class VMUIFrame
	cY := cY + 30
	cHeight := cHeight - 30
	WinSet, Region, %cX%-%cY% W%cWidth% H%cHeight% R20-20, ahk_class VMUIFrame
	return	


#~::
	WinSet, Region , , A
	return



#ifwinactive


#ifwinExist ahk_class VMUIFrame


F4::                                    ;; ����VMWare����
	if is_same_key()
	{
		winhide ahk_class VMUIFrame
	}
	return

#ifwinNotExist ahk_class VMUIFrame


F4::                                    ;; ��ʾVMWare����
	if is_same_key()
	{
		winshow ahk_class VMUIFrame
	}
	return


#ifwinExist
