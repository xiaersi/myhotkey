::dirflash::
run D:\My Documents\My Music\小朋友的flash\verygood
return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#ifwinactive  verygood ahk_class CabinetWClass
f4::
f3::
f5::
f6::
f7::
return

#ifwinactive Adobe Flash Player 9 ahk_class ShockwaveFlash

f4::	;; 关闭当前
	winclose A
	return
f5::
g::
	send ^{enter}
	return
f6::
f::		;;滚轮向上滚动
	send ^f
f7::
t::
	winset,AlwaysOnTop,, A
	return
f3::
	winclose A
	ifwinexist verygood ahk_class CabinetWClass
	winactivate
	sleep 500
	send {down}{enter}
	return
	
	f2::
	winclose A
	ifwinexist verygood ahk_class CabinetWClass
	winactivate
	sleep 500
	send {down}{enter}
	sleep 2000	
	send ^f
	return

Rbutton::
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
#ifwinactive Macromedia Flash Player 8 ahk_class ShockwaveFlash

f4::	;; 关闭当前
	winclose A
	return
f5::
g::
	send ^{enter}
	return
f6::
f::		;;滚轮向上滚动
	send ^f
f7::
t::
	winset,AlwaysOnTop,, A
	return
f3::
	winclose A
	ifwinexist verygood ahk_class CabinetWClass
	winactivate
	sleep 500
	send {down}{enter}
	return
	
	f2::
	winclose A
	ifwinexist verygood ahk_class CabinetWClass
	winactivate
	sleep 500
	send {down}{enter}
	sleep 2000	
	send ^f
	return

Rbutton::
return

#ifwinactive