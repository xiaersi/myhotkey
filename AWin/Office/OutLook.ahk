
;; OutLook2003
#ifwinactive  ahk_class rctrl_renwnd32, MSO Generic Control Container

;; esc 最小化窗口
esc::
	WinGetActiveTitle, OutputVar 
	WinMinimize  ahk_class rctrl_renwnd32
	return

#ifwinactive
