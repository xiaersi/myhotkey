;; google 浏览器

#ifwinactive ahk_class Chrome_WidgetWin_1
esc::send ^w


f1::
f2::send ^+!p  ;; 使用iReader

f7::^t

F10::^b
F12::^b
F9::^b


f8::
	send ^b
	SetTimer, 等四秒后关闭谷歌书签栏,4000
	return 

等四秒后关闭谷歌书签栏:
	send ^b
	SetTimer, 等四秒后关闭谷歌书签栏, Off
	return

