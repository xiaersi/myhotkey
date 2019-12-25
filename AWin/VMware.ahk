;; 虚拟机
#SingleInstance ignore	;只运行一次，禁止多次运行

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


F4::                                    ;; 隐藏VMWare窗口
	if is_same_key()
	{
		winhide ahk_class VMUIFrame
	}
	return

#ifwinNotExist ahk_class VMUIFrame


F4::                                    ;; 显示VMWare窗口
	if is_same_key()
	{
		winshow ahk_class VMUIFrame
	}
	return


#ifwinExist
