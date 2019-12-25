#ifwinactive 查看用户信息 ahk_class #32770, 个性签名 ：
!s::
!q::
	send ^c
	sleep 200
	run http://%clipboard%.qzone.qq.com/
	return

!h::
	send ^c
	sleep 200
	run http://%clipboard%
	return

;;..帮助提示....................................
^!/::
	var_help =
	var_help = %var_help%`n!Q  !S`t`t显示Q-Zone
	var_help = %var_help%`n!H`t`t显示个人主页，http://自动添加
	talkshow(var_help,"AHK - QQTM")
	return
#ifwinactive