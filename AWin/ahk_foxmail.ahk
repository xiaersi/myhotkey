#include  .\inc\functions.aik


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 	VC++2005.net
#ifwinactive ahk_class TFoxmail_Main,Foxmail������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
esc::	;; ɾ���ʼ�
	send !md
	return
f3:: ;; ���������
	send !mb
	winwait ȷ�� ahk_class TMessageForm,,2
	controlclick Tbutton2
	winwait ȷ�� ahk_class TMessageForm,,2
	controlclick Tbutton2
	winwait ��Ϣ ahk_class TMessageForm,,4
	controlclick Tbutton1
	return
sc07b & /::
^!/::
	traytip ,,F4 ɾ���ʼ�`nF3 ���������
	sleep 4000
	traytip
	return

#ifwinactive