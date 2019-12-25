

createquicklaunchy(quickname,quickpath)
{
	send !Fws
	winwait 创建快捷方式 ahk_class #32770,,5
	if not errorlevel
	{
	winactivate
	ControlSetText,Edit1,%quickpath%
	send !n
	
	sleep 300
	ControlSetText,Edit1,%quickname%
	ControlClick,Button5
	sleep 500
	tooltip 等待“选择程序标题”窗口
	winwait 选择程序标题 ahk_class #32770,该文件夹中已经存在一个名为 %quickname% 的快捷方式。是否替换?,4
	if not errorlevel
		{
		controlclick Button2,选择程序标题 ahk_class #32770,该文件夹中已经存在一个名为 %quickname% 的快捷方式。是否替换?
		controlclick Button6,选择程序标题 ahk_class #32770,单击“完成”创建快捷方式。
		} 
	}
	tooltip
;;	winwait 选择程序标题 ahk_class #32770,,3
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
	msgbox 4,退出脚本,快捷方式已经创建完毕，是否退出？,5
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
