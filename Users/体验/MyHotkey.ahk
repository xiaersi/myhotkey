#include ..\..\


;; 连接按两次LWin键，显示开始菜单，屏蔽按一下LWIN就弹出开始菜单
LWin::
	If is_same_key()
	{
		send ^{esc}
	}
	return
	
	
;; 连接按两次Ctrl启动“我的运行窗口”
Ctrl::
	If is_same_key()
	{
		ifwinexist 我的运行窗口 ahk_class AutoHotkeyGUI
		{
			winclose
		}
		else
		{
			WriteTempIni("run", "googleType", "1")
			var_run := ∑获取根目录()
			var_run = %var_run%\bin\run\run3.ahk
			run_ahk( var_run )			
			var_run =
		}
	}
	return

;;------ 右Alt+空格 弹出"运行"窗口 ----------------------------------
	

:://file:: 
	var_root := ∑获取根目录()
	var_file = %var_root%\bin\Doxgen\新增文件注释.ahk
	run_ahk(var_file )
	return

:://brief::
	sendinput /** @brief  */{left 2}
	return

:://w::             ;; 添加一行注释
	SelectLine()
:://line::
	WriteTempIni( "添加行注释", "type", "cpp" )
	var_root := ∑获取根目录()
	var_file = %var_root%\bin\Doxgen\添加行注释.ahk
	run_ahk(var_file )
	return

::;;w::
	SelectLine() 
::;;line::
	WriteTempIni( "添加行注释", "type", "ahk" )
	var_root := ∑获取根目录()
	var_file = %var_root%\bin\Doxgen\添加行注释.ahk
	run_ahk(var_file )
	return

:://e::         	;; 弹出窗口调整行末的注释符号位置
	sleep 100
	write_ini( "temp.ini", "复制并在每行末尾整齐地添加行尾注释符", "lastComment", "//" )
	var_root := ∑获取根目录()
	send {shift down}{home}{shift up}
	var_file = %var_root%\bin\Doxgen\复制并在每行末尾整齐地添加行尾注释号.ahk
	run_ahk( var_file )
	return

::;;e::         	;; 弹出窗口调整行末的注释符号位置
	sleep 100
	write_ini( "temp.ini", "复制并在每行末尾整齐地添加行尾注释符", "lastComment", ";;" )
	var_root := ∑获取根目录()
	send {shift down}{home}{shift up}
	var_file = %var_root%\bin\Doxgen\复制并在每行末尾整齐地添加行尾注释号.ahk
	run_ahk( var_file )
	return

