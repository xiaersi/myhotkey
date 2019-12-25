

;; google 金山词霸
#ifwinexist 谷歌金山词霸合作版 ahk_class #32770

;; 用谷歌金山词霸查找选中的单词
AppsKey::
#F9::	
	clipboard=
	sleep 100
	send ^c
	sleep 200
	if clipboard<>
	{
		ControlSetText, Edit1, %clipboard%, 谷歌金山词霸合作版 ahk_class #32770
		winactivate 谷歌金山词霸合作版 ahk_class #32770
		sleep 100
		send {enter}
	}
	return
	
#ifwinexist