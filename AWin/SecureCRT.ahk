;; 增加 SecureCRT 远程控制器 的快捷键


;#ifWinActive ahk_class VanDyke Software - SecureCRT

#ifWinActive ahk_class  ahk_class RAIL_WINDOW

;#ifWinActive - SecureCRT
/*
;; 将Ctrl+C 映射为 Ctrl+insert 完成复制功能
^c::
	send ^{ins}
	return

;; 将 Alt+c 映射为 Ctrl+C 实现退出功能
!c::
	send ^c
	return
*/

insert & c::
^insert::
	send ^{ins}
	return

insert & v::
+insert::
	send +{ins}
	return

#ifWinActive
