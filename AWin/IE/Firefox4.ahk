;; firefox 4.0 ���ȼ�
#ifwinactive ahk_class MozillaWindowClass
GetURL()
{
	send {f6}
	sleep 100
	send ^c
	return %clipboard%
}

!f6::
#f6:: ;{ 用IE打开本网页
	clipboard =
	send ^l
	sleep 200
	send ^c
	clipwait 2
	run C:\Program Files\Internet Explorer\IEXPLORE.EXE %clipboard%
	return ;}

f9::

	send ^c
	sleep 100
	ifwinexist ahk_class IEFrame
	{
		winactivate
		sleep 300
		send {f6}
		sleep 100
		clipboard=http://dict.iciba.com/%clipboard%/
		send ^v{enter}
	}
	else
	run C:\Program Files\Internet Explorer\IEXPLORE.EXE http://dict.iciba.com/%clipboard%/
	return
^+f6::
	send {f6}
	sleep 100
;	click 300,70
	send ^c
	ifwinexist ahk_class TThooeMain,״̬8
	winactivate
	return

 
esc::
	send ^w
	return
	
!esc::
	send ^w
	send !{tab}
	return

f12::	; 保存图片
	click right
	send s
	winwait 保存图片 ahk_class #32770,,5
	if not errorlevel 
	{
	winactivate
	send {home}
	send %a_year%
	send %a_dd%
	send %A_Min%
	}
	return

^f8::
	send ^x
	sleep 100
;	if(clipboard="")  return
	clipboard=<div><blockquote><table style="width: 561px`;" bgcolor="#f6f6f6" border="0" cellpadding="0" cellspacing="10"><tbody><tr align="center"><td bgcolor="#ffffff" valign="bottom">  </td></tr><tr><td bgcolor="#ffffff">`r%clipboard%`r<table style="table-layout: fixed`;" border="0" cellpadding="2" cellspacing="2" width="100`%"><tbody><tr><td></td></tr></tbody></table></td></tr></tbody></table></blockquote></div>
	send ^v
	return
#ifwinactive
