#include  .\inc\functions.aik


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 	VC++2005.net
#ifwinactive ahk_class TFoxmail_Main,Foxmail工具条
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
esc::	;; 删除邮件
	send !md
	return
f3:: ;; 加入黑名单
	send !mb
	winwait 确认 ahk_class TMessageForm,,2
	controlclick Tbutton2
	winwait 确认 ahk_class TMessageForm,,2
	controlclick Tbutton2
	winwait 消息 ahk_class TMessageForm,,4
	controlclick Tbutton1
	return
sc07b & /::
^!/::
	traytip ,,F4 删除邮件`nF3 加入黑名单
	sleep 4000
	traytip
	return

#ifwinactive