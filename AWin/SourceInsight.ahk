;; Source Insight 是代码阅读工具

#SingleInstance ignore	;只运行一次，禁止多次运行
#ifWinActive ahk_class si_Frame  ;; SourceInsight
F11::	;; F11 同时隐藏、显示侧方和下方工具栏，相当于全屏
	send !vp
	send !vo
	send !vr
	return

+F11::	;; 显示或隐藏右侧的Project工具栏
	send !vp
	return

^F11::	;; 显示或隐藏左下方Context工具栏
	send !vo
	return 

!F11::	;; 显示或隐藏右下方的Relation工具栏
	send !vr
	return

esc::   ;; 关闭当前页面
	send ^w
	return 

#ifWinActive
