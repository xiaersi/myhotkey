; Winword �����У�pageup,pagedown�ֱ����¹���
#include .\inc\functions.aik


;;//////////////////////////////////////////////////////////////
;; ���������ĵ����ñ�Ÿĳ�Ŀ��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Word����#ifwinactive �½�ƽ���ĳ���(��ȫ��).doc - Microsoft Word ahk_class OpusApp
f12::
	winactivate  ���Һ��滻 ahk_class bosa_sdm_Microsoft Office Word 11.0
	send !f
	winactivate  �½�ƽ��ҵ����(��ӡ��).doc - Microsoft Word ahk_class OpusApp
	send  +{right 3}
	send ^+={right}
	return
#ifwinexist �½�ƽ��ҵ����(��ӡ��).doc - Microsoft Word ahk_class OpusApp
f6::
f9::
	winactivate  �½�ƽ��ҵ����(��ӡ��).doc - Microsoft Word ahk_class OpusApp
	send ^+={right}
	return
f5::
	winactivate  �½�ƽ��ҵ����(��ӡ��).doc - Microsoft Word ahk_class OpusApp
	send +{left}
	return
f8::
	winactivate  �½�ƽ��ҵ����(��ӡ��).doc - Microsoft Word ahk_class OpusApp
	send +{right}
	return
#ifwinexist ���Һ��滻 ahk_class bosa_sdm_Microsoft Office Word 11.0
f7::
	winactivate  ���Һ��滻 ahk_class bosa_sdm_Microsoft Office Word 11.0
	send !f
	return


#ifwinexist
#ifwinactive �½�ƽ��ҵ����(��ӡ��).doc - Microsoft Word ahk_class OpusApp
/*
f8::	;;word��ѡ����ճ��
	ifwinactive ahk_class OpusApp,Microsoft Word �ĵ�
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
;; Word����#ifwinactive �½�ƽ���ĳ���(��ȫ��).doc - Microsoft Word ahk_class OpusApp
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