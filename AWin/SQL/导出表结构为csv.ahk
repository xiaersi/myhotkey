#ifwinactive ahk_class TPLSQLDevForm
g_dicttitle =�ҵ�С�ֵ� ahk_class AutoHotkeyGUI

F2:: ;; �鿴�ṹ
	send {appskey}
	send v
	return
	
F3:: ;; �������Ϣ���Ƶ��ֵ�
	controlgettext var_name, TEdit3, ahk_class TPLSQLDevForm
	controlgettext var_comment, TEdit4, ahk_class TPLSQLDevForm
	if ( var_name != "" && var_comment != "" )
	{
		winactivate %g_dicttitle%
		sleep 100
		controlsettext edit1, %var_name%, %g_dicttitle%
		controlsettext edit3, ��%var_comment%��, %g_dicttitle%
		controlclick button4, %g_dicttitle%
		sleep 200
		winactivate ahk_class TPLSQLDevForm
	}
	return

F4:: ;; ����Ľṹ���Ƶ��ֵ�
	MouseClick, left,  340,  145
	Sleep, 100
	MouseClick, right,  401,  407
	Sleep, 100
    send ec   							;; ����Ҽ�,ѡ��Export->����Ϊcsv�ļ� 
    winwait ���Ϊ ahk_class #32770,  ,1
	sleep 100
	ifwinactive  ���Ϊ ahk_class #32770
	{
        controlsettext Edit1, temp.csv  ;; ���õ����ļ���Ϊtemp.csv
        controlclick button2            ;; ���[����]��ť
		sleep 200

		ifwinactive  ���Ϊ ahk_class #32770, Ҫ�滻����?
		{
			click 165, 95
			;controlclick button1
			sleep 200
		}
		winactivate %g_dicttitle%
		sleep 200
        send !e                         ;; ʹ�ÿ�ݼ�Alt+C ������������ֵ�Ĵ���
        send {up}{enter}
	}
	
	return


#ifwinactive ������ӵ����� ahk_class AutoHotkeyGUI
F4::
	ControlClick ��
	WinWait, ��ѡ���ֵ��ļ� ahk_class #32770, , 2
	sleep 100
	ifwinexist  ��ѡ���ֵ��ļ� ahk_class #32770
	{
		winactivate
		sleep 100
		ifwinactive ��ѡ���ֵ��ļ� ahk_class #32770
		{
	        controlsettext Edit1, temp.csv  ;; ���õ����ļ���Ϊtemp.csv
			sleep 100
			click 515, 370
	       ; controlclick button2            
        }
	}
	return

F5::
	ControlClick ����
	winwait ׷�ӻ��滻����, , 1
	sleep 100
	ifwinexist ׷�ӻ��滻����
	{
		winactivate ׷�ӻ��滻����
	;	WinWaitActive , ׷�ӻ��滻����, , 1
		sleep 100
		click 157, 120
	;	controlclick button1, ׷�ӻ��滻����
		sleep 100
	}
	winactivate ahk_class TPLSQLDevForm
	WinWaitActive , ahk_class TPLSQLDevForm, , 1
	ifwinactive ahk_class TPLSQLDevForm
	{
        send !fc                        ;; �ر�
	}
	return