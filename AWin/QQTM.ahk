#ifwinactive �鿴�û���Ϣ ahk_class #32770, ����ǩ�� ��
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

;;..������ʾ....................................
^!/::
	var_help =
	var_help = %var_help%`n!Q  !S`t`t��ʾQ-Zone
	var_help = %var_help%`n!H`t`t��ʾ������ҳ��http://�Զ����
	talkshow(var_help,"AHK - QQTM")
	return
#ifwinactive