

createquicklaunchy(quickname,quickpath)
{
	send !Fws
	winwait ������ݷ�ʽ ahk_class #32770,,5
	if not errorlevel
	{
	winactivate
	ControlSetText,Edit1,%quickpath%
	send !n
	
	sleep 300
	ControlSetText,Edit1,%quickname%
	ControlClick,Button5
	sleep 500
	tooltip �ȴ���ѡ�������⡱����
	winwait ѡ�������� ahk_class #32770,���ļ������Ѿ�����һ����Ϊ %quickname% �Ŀ�ݷ�ʽ���Ƿ��滻?,4
	if not errorlevel
		{
		controlclick Button2,ѡ�������� ahk_class #32770,���ļ������Ѿ�����һ����Ϊ %quickname% �Ŀ�ݷ�ʽ���Ƿ��滻?
		controlclick Button6,ѡ�������� ahk_class #32770,��������ɡ�������ݷ�ʽ��
		} 
	}
	tooltip
;;	winwait ѡ�������� ahk_class #32770,,3
;;	if not errorlevel
;;	{
;;	}
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
createquicklaunchy2(dirpath,quickname,quickpath)
{
	run %dirpath%
	winwait ahk_class CabinetWClass,,3
	{
	createquicklaunchy(quickname,quickpath)
	}
}

isexit()
{
	msgbox 4,�˳��ű�,��ݷ�ʽ�Ѿ�������ϣ��Ƿ��˳���,5
	ifmsgbox yes
	exitapp
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
f1::
	createquicklaunchy2("c:\windows","cjpibm","D:\My documents\MyHotKey\IBM\CJPIBM.ahk")
	isexit()
	return
f2::
	createquicklaunchy2(A_Desktop,"cjpibm","D:\My documents\MyHotKey\IBM\CJPIBM.ahk")
	isexit()
	return 
f3::
	createquicklaunchy2(A_Startup,"WinStart","D:\My documents\MyHotKey\IBM\WinStart.ahk")
	sleep 2000
	createquicklaunchy2(A_Startup,"cjpibm","D:\My documents\MyHotKey\IBM\CJPIBM.ahk")
	isexit()
	return
esc::
	exitapp
	return
