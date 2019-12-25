; Winword 窗口中，pageup,pagedown分别上下滚动
#include .\inc\functions.aik


;;//////////////////////////////////////////////////////////////
;; 用来将论文的引用标号改成目标
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Word窗口#ifwinactive 陈建平论文初稿(完全稿).doc - Microsoft Word ahk_class OpusApp
f12::
	winactivate  查找和替换 ahk_class bosa_sdm_Microsoft Office Word 11.0
	send !f
	winactivate  陈建平毕业论文(打印稿).doc - Microsoft Word ahk_class OpusApp
	send  +{right 3}
	send ^+={right}
	return
#ifwinexist 陈建平毕业论文(打印稿).doc - Microsoft Word ahk_class OpusApp
f6::
f9::
	winactivate  陈建平毕业论文(打印稿).doc - Microsoft Word ahk_class OpusApp
	send ^+={right}
	return
f5::
	winactivate  陈建平毕业论文(打印稿).doc - Microsoft Word ahk_class OpusApp
	send +{left}
	return
f8::
	winactivate  陈建平毕业论文(打印稿).doc - Microsoft Word ahk_class OpusApp
	send +{right}
	return
#ifwinexist 查找和替换 ahk_class bosa_sdm_Microsoft Office Word 11.0
f7::
	winactivate  查找和替换 ahk_class bosa_sdm_Microsoft Office Word 11.0
	send !f
	return


#ifwinexist
#ifwinactive 陈建平毕业论文(打印稿).doc - Microsoft Word ahk_class OpusApp
/*
f8::	;;word中选择性粘贴
	ifwinactive ahk_class OpusApp,Microsoft Word 文档
	{
	send !es
	sleep 300
	send {end}
	send {enter}
	}
	return
f7::
	send ^a^c
	return
f5::
	send []{tab}{left 2}
	keywait f6, D T3
	send {end}
	return
f6::
	send ^c
	ifwinexist ahk_class XFrame_Wnd
	winactivate
	sleep 300
	send {home}
	return
*/

::;reload::
	reload
	return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Word窗口#ifwinactive 陈建平论文初稿(完全稿).doc - Microsoft Word ahk_class OpusApp
#ifwinactive ahk_class XFrame_Wnd
tab::home
rbutton::
+lbutton::
	click
	send {home}+{end}^v{enter}
	return
f9::
	send ^c
	send !{tab}
	return
#ifwinactive