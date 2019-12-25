#ifwinactive ahk_class TPLSQLDevForm
g_dicttitle =我的小字典 ahk_class AutoHotkeyGUI

F2:: ;; 查看结构
	send {appskey}
	send v
	return
	
F3:: ;; 将表的信息复制到字典
	controlgettext var_name, TEdit3, ahk_class TPLSQLDevForm
	controlgettext var_comment, TEdit4, ahk_class TPLSQLDevForm
	if ( var_name != "" && var_comment != "" )
	{
		winactivate %g_dicttitle%
		sleep 100
		controlsettext edit1, %var_name%, %g_dicttitle%
		controlsettext edit3, 【%var_comment%】, %g_dicttitle%
		controlclick button4, %g_dicttitle%
		sleep 200
		winactivate ahk_class TPLSQLDevForm
	}
	return

F4:: ;; 将表的结构复制到字典
	MouseClick, left,  340,  145
	Sleep, 100
	MouseClick, right,  401,  407
	Sleep, 100
    send ec   							;; 点击右键,选择Export->导出为csv文件 
    winwait 另存为 ahk_class #32770,  ,1
	sleep 100
	ifwinactive  另存为 ahk_class #32770
	{
        controlsettext Edit1, temp.csv  ;; 设置导出文件名为temp.csv
        controlclick button2            ;; 点击[保存]按钮
		sleep 200

		ifwinactive  另存为 ahk_class #32770, 要替换它吗?
		{
			click 165, 95
			;controlclick button1
			sleep 200
		}
		winactivate %g_dicttitle%
		sleep 200
        send !e                         ;; 使用快捷键Alt+C 呼出批量添加字典的窗口
        send {up}{enter}
	}
	
	return


#ifwinactive 批量添加单词项 ahk_class AutoHotkeyGUI
F4::
	ControlClick 打开
	WinWait, 请选择字典文件 ahk_class #32770, , 2
	sleep 100
	ifwinexist  请选择字典文件 ahk_class #32770
	{
		winactivate
		sleep 100
		ifwinactive 请选择字典文件 ahk_class #32770
		{
	        controlsettext Edit1, temp.csv  ;; 设置导出文件名为temp.csv
			sleep 100
			click 515, 370
	       ; controlclick button2            
        }
	}
	return

F5::
	ControlClick 保存
	winwait 追加或替换单词, , 1
	sleep 100
	ifwinexist 追加或替换单词
	{
		winactivate 追加或替换单词
	;	WinWaitActive , 追加或替换单词, , 1
		sleep 100
		click 157, 120
	;	controlclick button1, 追加或替换单词
		sleep 100
	}
	winactivate ahk_class TPLSQLDevForm
	WinWaitActive , ahk_class TPLSQLDevForm, , 1
	ifwinactive ahk_class TPLSQLDevForm
	{
        send !fc                        ;; 关闭
	}
	return