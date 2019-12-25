#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������
#NoTrayIcon

#include ..\..\
#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\run.aik
#include .\inc\tip.aik
#include .\inc\path.aik
#include .\inc\expression.aik

g_bAutoList := true   ;; ��ʱֹͣ�Զ�ˢ�������б�����ʹ�ãգУ��ģ������ѡ�������б���
g_title = �ҵ����д���
g_wintitle = �ҵ����д��� ahk_class AutoHotkeyGUI
g_inifile = launchy.ini

;; ����ȫ�ֱ�����ini�ļ��ж�ȡ
g_file_keys =
g_send_keys =
g_var_keys =

ifnotexist %g_inifile%
{
	msgbox [�ҵ����д���] �������ļ������ڣ�
	exitapp
}

g_file_count := read_seckeys( g_file_keys, g_inifile, "file", false )
g_send_count := read_seckeys( g_send_keys, g_inifile, "send", false )
g_var_count := read_seckeys( g_var_keys, g_inifile, "variable", false )

g_bGoogleType := readTempIni("run", "googleType", "0")
g_recent := read_ini( "temp.ini", "run", "recent", "" )
g_recent_calc := read_ini( "temp.ini", "run", "calc", "" )
g_recent_web := read_ini( "temp.ini", "run", "web", "" )
g_recent_script := read_ini( "temp.ini", "run", "script", "" )
g_recent_var := read_ini( "temp.ini", "run", "variable", "" )
g_recent_rundirect := read_ini( "temp.ini", "run", "rundirect", "" )
g_last := read_ini( "temp.ini", "run", "last", "" )
g_background := read_ini(g_inifile, "file", "���б���", "" ) 
g_extExlist := read_ini(g_inifile, "����", "��չ�������б�", "" )	;; ��չ�������б�, ���磺txt|exe|bat

g_helplist = ?���߰���|?-----------------------------------
g_helplist = %g_helplist%|?��?����ͷ��ʾ��Ҫ����
g_helplist = %g_helplist%|?��`;����ͷ�������С����ڣ�ֱ��Runϵͳ����
g_helplist = %g_helplist%|?��=����ͷ������������
g_helplist = %g_helplist%|?��<����ͷֱ����Ϊ�ű�����
g_helplist = %g_helplist%|? ����::���� ��ʾ��������������
g_helplist = %g_helplist%|? �ȺŽ��������ݸ��Ƶ������塾=��
g_helplist = %g_helplist%|? F4 ��Ĭ���ı��༭���������ļ�
g_helplist = %g_helplist%|?-----------------------------------
g_helplist = %g_helplist%|?���ߣ�teshorse@hotmail.com|

;;---��ʾ����----------------------------------------------------------------
Gui +ToolWindow  +AlwaysOnTop
if g_bGoogleType = 1
{
	ifnotexist %g_background%
	{
		loop 100
		{
			Random, nRandom , 1, 60
			g_background = %a_scriptdir%\BackGround\Snap%nRandom%.JPG
			ifexist %g_background%
				break
		}
	}
	gui -Caption
	Gui, Add, Picture, x22 y15, %g_background%
	Gui, Add, ComboBox, x35 y35 w310 h25 R15 v_ComboBox g���ҵ����д���_�����, %g_recent%
	Gui, Add, Button, x66 y65 w80 h30 hide default  g���ҵ����д���_ȷ����ť��, ȷ��(&Y)
	Gui, Add, Button, x206 y65 w80 h30 hide  g���ҵ����д���_ȡ����ť��, ȡ��(&N)
	Gui, Add, GroupBox, x11 y0 w360 h85 v_GroupBox , ����������

	Gui, Color, EEAA99
	Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
	hGui := WInExist()
	WinSet, TransColor, EEAA99
	Gui, Show,xCenter yCenter  h90 w375, %g_title%
}
else
{
	Gui, Add, ComboBox, x21 y28 w310 h25 R15 v_ComboBox g���ҵ����д���_�����, %g_recent%
	Gui, Add, GroupBox, x11 y10 w330 h50 v_GroupBox, ����������
	Gui, Add, Button, x66 y65 w80 h30 default  g���ҵ����д���_ȷ����ť��, ȷ��(&Y)
	Gui, Add, Button, x206 y65 w80 h30  g���ҵ����д���_ȡ����ť��, ȡ��(&N)
	Gui, Show,xCenter yCenter  h108 w353, %g_title%
}

OnMessage( 0x06, "WM_ACTIVATE" )

Return 

;;---��Ӧ�û�����------------------------------------------------------------
���ҵ����д���_�����:
	ControlGetText var_curInput, Edit1, %g_wintitle%
	if var_curInput =
	{
		GuiControl, Text, _GroupBox, ����������
		Control HideDropDown, , ComboBox1, 
	}
	if (var_preInput == var_curInput)
	{
		return
	}
	var_preInput := var_curInput
	
	;;___��ʾ������������Ӧ�ľ�������________________________________________
	
	
	if not g_bAutoList 
	{
		g_bAutoList := true
		�Ʋ��ұ���( var_curInput )
		return
	}
	findList := �����������б�( var_curInput )
	if ( g_preList == findList )
	{
		return
	}
	g_preList := findList
	;;___��ʾ�����б�________________________________________________________
	Control HideDropDown, , ComboBox1, 
	GuiControl,,_ComboBox, |
	if findList <>
	{	
		GuiControl,,_ComboBox, %findList%
		Control ShowDropDown, , ComboBox1, %g_wintitle%
	;	ControlFocus,  Edit1, %g_wintitle%
	}
	else
	{
		GuiControl,,_ComboBox, %var_strList%
	}
	GuiControl, Text, _ComboBox, %var_curInput%
	send {end}
	return	
	
;;---��ť��Ӧ----------------------------------------------------------------
���ҵ����д���_ȷ����ť��:
	gui, submit, hide
	sleep 100
	var_user := _ComboBox
	if var_user =
	{
		ControlGetText var_user, Edit1, %g_wintitle%
	}
;	msgbox [%var_user%]

	;;___����ĸΪ";"ʱֱ��run�ֺź��������__________________________________
	StringLeft  vartemp, var_user, 1
	if vartemp = ?
	{
		if (var_user == "?���߰���")
		{
			run http://blog.csdn.net/teshorse/archive/2010/08/04/5788574.aspx
		}
		return
	}
	else if (vartemp = ";")
	{
		StringMid vartemp, var_user, 2
		run %vartemp%
		iniwrite, %var_user%, temp.ini, run, last
		������������е�����( var_user, "rundirect" )
		exitapp
	}
	;;___����ĸ��=�ţ������=�ź���ı��ʽ__________________________________
	else if (vartemp = "=") 
	{
		vartemp := SubStr(var_user, 2)
		var_re := CalcLine(vartemp)
		if var_re = EXP_ERROR 
		{
			msgbox �������
		}
		else if var_re <>
		{
			clipboard := var_re
			tooltip �Ѹ��Ƽ�������%clipboard% 
			sleep 1000
			tooltip
		}
		������������е�����( var_user, "calc" )
		exitapp
	}
	;;___�û����������ֱ����Ϊ�����������__________________________________
	else if (vartemp = "<") 
	{
		vartemp := SubStr(var_user, 2)
		run_with_temp_file(vartemp)
		������������е�����( var_user, "script" )
		exitapp
	}
	;;___�û����������ַ���ļ�·��, ��ֱ������______________________________
	StringMid, vartemp, var_user, 2, 2
	StringLeft varhttp, var_user, 7
	if (vartemp = ":\" or varhttp = "http://") 
	{
		run %var_user%
		������������е�����( var_user, "web" )
		exitapp
	}
	stringLeft varwww, var_user, 4
	if (varwww = "www.")
	{
		run http://%var_user%
		������������е�����( var_user, "web" )
		exitapp
	}
	;;___�û�����"vim myhotkey.ahk", ����vim �༭����myhotkey.ahk�ļ�______
	else if ( varwww = "vim " )  
	{
		StringMid, var_user, var_user, 5
		iniread,var_vim,launchy.ini,file, vim
		if var_vim <>
		{
			iniread,var_keyValue,launchy.ini,file,%var_user%
			StringLeft firstChar, var_keyValue, 1
			var_list = +-`;
			IfInstring var_list, %firstChar% 
			{
				StringMid var_keyValue, var_keyValue, 2	;; ȥ�����׵�+-�Լ��ֺ�
			}
			IfNotExist %var_keyValue%
			{
				tooltip ����VIM�򿪵��ļ������� `n %var_keyValue%
				sleep 2000
				tooltip
				exitapp
			}
			StringLeft firstChar, var_vim, 1
			IfInstring var_list, %firstChar%	
			{
				StringMid var_vim, var_vim, 2	;; ȥ�����׵�+-�Լ��ֺ�
			}
			IfNotExist %var_vim%
			{
				tooltip û����ȷָ�� VIM �༭����·��`n�뽫��·����Ϊvim�ؼ���
				sleep 2000
				tooltip
				exitapp
			}
			run %var_vim% `"%var_keyValue%`"
		}
		else
		{
			tooltip7("�㻹û��ָ��vim�ı��༭����λ��, �ҵ�vim�������ļ�, `n��Ctrl+Alt+Insert���������Ϊ�ؼ���Vim")
		}
		exitapp
	}

	
	;;___�������ַ�Ϊ=��, ��ֱ������ؼ��ֵ�ֵ_____________________________
	if ( StrLastWord(var_user, 1) = "=" )
	{
		varleft := StrLeft2Sub(var_user, "=")
		var_temp := read_ini(g_inifile,"file",varleft,"")
		if ( var_temp != "" ) {
			clipboard := var_temp
			tooltip �Ѿ����ƣ�%var_temp%
			sleep 800
			tooltip
		}
		exitapp
	}

	;;_______________________________________________________________________
	; ��������а���"::"�ַ�, 
	; �÷���ǰ�������ļ���[::]�ڵĹؼ���, 
	; �÷��ź����滻�ؼ�ֵ�е�$var$�ı���
	varpos := instr(var_user, "::")
	if (varpos)
	{
		varPos -= 1

		stringleft varleft, var_user, %varPos%
		varPos += 3
		stringmid  varright, var_user, %varPos%

		var_temp := read_ini(g_inifile,"variable",varleft,"")

		if var_temp <>
		{
			; ��������б任
			if (instr(var_temp, "google"))
			{	; �������������, ���滻һЩ�ַ�,�罫"+"���滻��"%2B"
				StringReplace, varright, varright, +, `%2B
			}
			else if (instr(var_temp, "baidu"))
			{	; �������������, ���滻һЩ�ַ�,�罫"+"���滻��"%2B"
				StringReplace, varright, varright, +, `%2B
			}

			; ���任�������ֵ, �滻��$var$, Ȼ������
			StringReplace, var_temp, var_temp, $var$, %varright%
			run %var_temp%
			������������е�����( var_user, "variable" )
			exitapp
		}
	}

	;;___�������ַ����ֱ������______________________________________________
	if ( instr(var_user, ".com") or instr(var_user, ".net") or instr(var_user, ".cn") or instr(var_user, ".org") )
	{	
		var_temp = http://%var_user% 
		run %var_temp%
		������������е�����( var_temp, "web" )
		exitapp
	}
	
;;_______________________________________________________________________
;; ����û��������Ŀ¼����� \ ���ſ�ͷ����� 
;; �������б�����ʾ���Ǹ�Ŀ¼�µ������ļ���, 
;; ȷ��֮��run ��Ŀ¼�µ�����ļ�
	guicontrolget _GroupText, , _GroupBox
	strleft := substr(_GroupText, 1, 5)
	if ( strleft == "[Dir]" )
	{
		var_file := substr(_GroupText, 6)
		var_file = %var_file%\%var_user%
		ifexist %var_file%
		{
			run %var_file%
			exitapp
		}
	}
	;;___���������������____________________________________________________
	var_temp := read_ini( g_inifile, "file", var_user,"")
	if var_temp =
	{
		
		; ���[send]����, ���û�ж�Ӧ�ؼ���, ���û�������������
		iniread,var_send,launchy.ini,send,%var_user%
		if (var_send="" or var_send="ERROR") 
		{
			if var_user = \ahk
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%
			}
			else if var_user = \ahkbin
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%\bin
			}
			else if var_user = \ahklib
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%\lib
			}
			else if var_user = \ahkAwin
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%\Awin
			}
			else if var_user = \ahkinc
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%\inc
			}
			else if var_user = \ahkusers
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%\Users
			}
			else if var_user = \ahklearn
			{
				var_root := �ƻ�ȡ��Ŀ¼()
				run %var_root%\learn
			}						
			else if var_user = \workdir
			{
				run %a_workingdir%
			}
			else if var_user = \windir
			{
				run %A_WinDir%
			}
			else if var_user = \programs
			{
				run %A_Programs%
			}
			else if var_user = \desktop
			{
				run %A_Desktop%
			}
			else if var_user = \mydoc
			{
				run %A_MyDocuments%
			}
			else if var_user = spy
			{
				dir := get_ahk_dir()
				if dir <>
				{
					run %dir%\AU3_Spy.exe
				}
			}
			else if var_user = ahkhelp
			{
				dir := get_ahk_dir()
				if dir <>
				{
					run %dir%\AutoHotkey.chm
				}
			}
			else
			{
				tooltip �ղ�������������
				sleep 1000
				tooltip
			}
		}
		else ; [send]�������û�����Ĺؼ���, ��ֱ������ؼ�ֵ, ������ "#+n"(��OneNote) ,
		{
			send %var_send%
		}
	}
	else		; �������ļ����ҵ��ؼ���, ����ִ��
	{
		runini(var_user)		; ����ini�ļ���ָ���ĳ���
		iniwrite, %var_user%, temp.ini, run, last
		������������е�����( var_user, "recent" )
	}	
	exitapp
	return 
		
���ҵ����д���_ȡ����ť��:
GuiClose:
���˳�����:
	exitapp
	return 


;;---��ݼ���Ӧ--------------------------------------------------------------
#ifwinactive �ҵ����д��� ahk_class AutoHotkeyGUI
~up::	
~down::
	g_bAutoList := false
	return
	
[::             ;; �������б��У�����ѡ��
	g_bAutoList := false
	send {up}
	return
	
]::				;; �������б��У�����ѡ��
	g_bAutoList := false
	send {down}
	return
		
		
^del::			;; ������б���ɾ������
	;; Google ���������ķ��,������ɾ������
	if g_bGoogleType = 1
	{
		return
	}
	
 	;; ��ͳ���Ĵ���
	controlGetText groupBoxText, Button3
	controlGetText curInput, Edit1
	if curInput =
		return
		
	if groupBoxText = ����򿪵���ַ
	{
		g_recent_web := readTempIni("run", "web", "" )
		if g_recent_web <>
		{
			if StrListDelete( g_recent_web, curInput, "|")
			{
				writeTempIni("run", "web", g_recent_web)
				tooltip7( "�ɹ���[����򿪵���ַ]�б���ɾ���� ". curInput )
			}
		}	
	}
	else if groupBoxText = ���ֱ�����е�����
	{
		g_recent_rundirect := readTempIni("run", "rundirect", "" )
		if g_recent_rundirect <>
		{
			if StrListDelete( g_recent_rundirect, curInput, "|")
			{
				writeTempIni("run", "rundirect", g_recent_rundirect)
				tooltip7( "�ɹ���[���ֱ�����е�����]�б���ɾ���� ". curInput )
			}
		}			
	}
	else if groupBoxText = ���������ʽ
	{
		g_recent_calc := readTempIni("run", "calc", "" )
		if g_recent_calc <>
		{
			if StrListDelete( g_recent_calc, curInput, "|")
			{
				writeTempIni("run", "calc", g_recent_calc)
				tooltip7( "�ɹ���[���������ʽ]�б���ɾ���� ". curInput )
			}
		}			
	}
	else if groupBoxText = ������еĽű�
	{
		g_recent_script := readTempIni("run", "script", "" )
		if g_recent_script <>
		{
			if StrListDelete( g_recent_script, curInput, "|")
			{
				writeTempIni("run", "script", g_recent_script)
				tooltip7( "�ɹ���[������еĽű�]�б���ɾ���� ". curInput )
			}
		}			
	}
	else if groupBoxText = �����������������
	{
		g_recent_var := readTempIni("run", "variable", "" )
		if g_recent_var <>
		{
			if StrListDelete( g_recent_var, curInput, "|")
			{
				writeTempIni("run", "script", g_recent_var)
				tooltip7( "�ɹ���[������еĽű�]�б���ɾ���� ". curInput )
			}
		}	
	}
	else if groupBoxText = ����
	{
		;; �������ݲ�����ɾ��
	}
	else 
	{
		g_recent := readTempIni("run", "recent", "" )
		if g_recent <>
		{
			if StrListDelete( g_recent, curInput, "|") 
			{
				writeTempIni("run", "recent", g_recent)
				tooltip7( "�ɹ���[���ʹ�õ�����]�б���ɾ���� ". curInput )
			}
		}	
	}
		
	return
	
esc::
	exitapp
	return

+enter::	;; ���������λس���ֱ������
	send {enter}
	sleep 100
	goto ���ҵ����д���_ȷ����ť��
	return

~enter::	;; �س�ʱ���жϵ�ǰ�����������Ƿ��Ѿ����ڣ�������ֱ�����и�������ⰴ���λس���
	Control HideDropDown, , ComboBox1, 
	ControlGetText var_curInput, Edit1, %g_wintitle%
	if ( g_file_count > 0 &&  g_file_keys != "" )
	{
		Loop parse, g_file_keys, `n
		{
			IfInString A_LoopField, %var_curInput%
			{
				goto ���ҵ����д���_ȷ����ť��
			}
		}
	}

	if ( g_send_count > 0 && g_send_keys != "" )
	{
		Loop parse, g_send_keys, `n
		{
			IfInString A_LoopField, %var_curInput%
			{
				goto ���ҵ����д���_ȷ����ť��
			}
		}
	}

	if ( g_var_count > 0 && g_var_keys != "" )
	{
		Loop parse, g_var_keys, `n
		{
			IfInString A_LoopField, %var_curInput%
			{
				goto ���ҵ����д���_ȷ����ť��
			}
		}
	}    
  	return

F2::    ;; ��Ini�ļ����ֹ��༭launchy.ini
	ifexist %g_inifile%
		run %g_inifile%
	return
	
#ifwinactive 

WM_ACTIVATE()	
{
	global
	if g_bGoogleType = 1
	{
		ifwinnotactive %g_wintitle%
		{
			gui, submit, hide
			SetTimer ���˳�����, 500
		}
	}
	else
	{
		ifwinactive %g_wintitle%
			WinSet, Transparent, off,  %g_wintitle%
		else
			WinSet, Transparent, 180,  %g_wintitle%
	}
	return
}

;;///////////////////////////////////////////////////////////////////////////
;; ����ָ���Ĺؼ��ֵ�temp.ini�����ҽ�����Ĺؼ��ֽ�������
������������е�����( var_lastkey, var_recent_keyname )
{
	var_recent := read_ini("temp.ini", "run", var_recent_keyname, "")
	var_first := StrLeft2Sub( var_recent, "|" )
	IfNotEqual var_first , %var_lastkey%
	{
		��Add�ַ�������( var_recent, var_lastkey, "|", true, 15 )
		write_ini( "temp.ini", "run", var_recent_keyname, var_recent ) 
	}
}


�����������б�( var_curInput )
{
	global
	ret =
	if var_curInput =
		return ret
	
	get_first_char( var_curInput, firstChar )
	
	if firstChar = ?
	{
		ret := g_helplist
		GuiControl, Text, _GroupBox, ����
	}
	else if firstChar = <
	{
		ret := g_recent_script
		GuiControl, Text, _GroupBox, ������еĽű�
	}
	else if ( firstChar == "=" )
	{
		ret := g_recent_calc
		GuiControl, Text, _GroupBox, ���������ʽ
	}
	else if ( firstChar == ";" )
	{
		ret := g_recent_rundirect
		GuiControl, Text, _GroupBox, ���ֱ�����е�����
	}
	else ifinstring var_curInput, http:
	{
		ret := g_recent_web
		GuiControl, Text, _GroupBox, ����򿪵���ַ
	}
	else ifinstring var_curInput, www.
	{
		ret := g_recent_web
		GuiControl, Text, _GroupBox, ����򿪵���ַ
	}
	else ifinstring var_curInput, ::
	{
		ret := g_recent_var
		GuiControl, Text, _GroupBox, �����������������
	}
	else if ( var_curInput == g_last || var_curInput == "" )
	{
		ret := g_recent
		GuiControl, Text, _GroupBox, ���ʹ�õ�����
	}
	else
	{
		var_title = 
		var_count = 0
		
		if ( StrLastWord( var_curInput, 1) == "=" )
		{
			var_count := strlen( var_curInput ) - 1
			StringLeft, var_search, var_curInput, %var_count%
		}
		else 
			var_search := var_curInput
			
		if ( g_file_count > 0 &&  g_file_keys != "" )
		{
			Loop parse, g_file_keys, `n
			{
				IfInString A_LoopField, %var_search%
				{
					IfEqual var_search , %A_LoopField%
					{
						var_title := read_ini( g_inifile, "file", var_search, "��������" )
						
						;; ����������� \ ��ͷ�� ��ʾ�������Ӧһ��Ŀ¼�� �����б���ʾ��Ŀ¼�µ������ļ�
						if equal_first_char( var_search, "\" )
						{
							var_Attribute := FileExist(var_title)
;							msgbox %var_Attribute% := FileExist(%var_title%)
							ifinstring var_Attribute, D
							{
								StrTrimRight( var_Attribute, "\" )	;; ȥ�����ұߵ� \ ����
								tempret := ������ָ��Ŀ¼���ļ��б�( var_title )
								if tempret <>
								{
									var_title = [Dir] %var_title%
									GuiControl, Text, _GroupBox, %var_title%
									return tempret
								}							
							}

						}
						var_title := ������·��( var_title, 50)
						var_title = [Run] %var_title%
					}
					var_lastkey := a_loopfield
					StrListAdd( ret, var_lastkey, "|" )
					var_count++
				}
			}
		}

		if ( g_send_count > 0 && g_send_keys != "" )
		{
			Loop parse, g_send_keys, `n
			{
				IfInString A_LoopField, %var_search%
				{
					if ( var_title == "" && var_search == A_LoopField )
					{
						var_title := read_ini( g_inifile, "send", var_search, "��������" )
						var_title = [Send] %var_title% 
					}				
					var_lastkey := a_loopfield
					StrListAdd( ret, var_lastkey, "|" )
					var_count++
				}
			}
		}

		if ( g_var_count > 0 && g_var_keys != "" )
		{
			Loop parse, g_var_keys, `n
			{
				IfInString A_LoopField, %var_search%
				{
					if ( var_title == "" && var_search == A_LoopField )
					{
						var_title := read_ini( g_inifile, "variable", var_search, "��������" )
						var_title = [Run] %var_title% 
					}				
					var_lastkey := a_loopfield
					StrListAdd( ret, var_lastkey, "|" )
					var_count++
				}
			}
		}
		
		if var_title =
			var_title = ��������
		GuiControl, Text, _GroupBox, %var_title%
	}	
	return ret
}

�Ʋ��ұ���(var_search)
{
	global
	var_title = 
			
	;; ����û������Ŀ¼�����"\"���ſ�ͷ�������ô�����±���
	guicontrolget _GroupText, , _GroupBox
	strleft := substr(_GroupText, 1, 5)
	if ( strleft == "[Dir]" )
		return
	
	if ( g_file_count > 0 &&  g_file_keys != "" )
	{
		Loop parse, g_file_keys, `n
		{
			if ( var_search == A_LoopField )
			{
				var_title := read_ini( g_inifile, "file", var_search, "��������" )
				var_title := ������·��( var_title, 50)
				var_title = [Run] %var_title%
				GuiControl, Text, _GroupBox, %var_title%
				return
			}
		}
	}

	if ( g_send_count > 0 && g_send_keys != "" )
	{
		Loop parse, g_send_keys, `n
		{
			if ( var_search == A_LoopField )
			{
				var_title := read_ini( g_inifile, "send", var_search, "��������" )
				var_title = [Send] %var_title% 
				GuiControl, Text, _GroupBox, %var_title%
				return
			}				
		}
	}

	if ( g_var_count > 0 && g_var_keys != "" )
	{
		Loop parse, g_var_keys, `n
		{
			if ( var_search == A_LoopField )
			{
				var_title := read_ini( g_inifile, "variable", var_search, "��������" )
				var_title = [Run] %var_title% 
				GuiControl, Text, _GroupBox, %var_title%
				return
			}
		}
	}
	
	GuiControl, Text, _GroupBox, ��������
}

get_ahk_dir()
{
	if a_ahkpath =
	{
		dir =
	}
	else
	{
		;;  �� C:\Program Files\AutoHotkey\AutoHotkey.exe �з����Ŀ¼
		ifInString a_ahkpath, AutoHotkey.exe
		{
			�Ʒֽ�·��( a_ahkpath, dir, filename, ext )
		}
		else	;; a_ahkpath �������Ŀ¼ 
		{
			dir := a_ahkpath
		}
	}
	return dir
}


������ָ��Ŀ¼���ļ��б�( var_path )
{
	global g_extExlist
	ret =
	FilePattern = %var_path%\*.*
	FileList =  ; Initialize to be blank.
	
	;; ��Ѱ�ļ���
	Loop, %FilePattern%
	    FileList = %FileList%%A_LoopFileName%`n
	    
	;; ���û��ƥ����ļ������˳�
	if FileList =
		return 
	
	Sort, FileList, R  ; The R option sorts in reverse order. See Sort for other options.
	Loop, parse, FileList, `n
	{
	    if A_LoopField =  ; Ignore the blank item at the end of the list.
	        continue
	        
		fileFullName := A_LoopField
		
		stringleft var_left, fileFullName, 0, 2
		if ( var_left == "~$" )
		{
			continue					;; ���˵�~$��ͷ���ļ���������Word�ĵ��ı����ļ�
		}
		
		�Ʒֽ�·��( fileFullName, dir, filename, ext )
		
		if ext =
			continue					;; ���˵�û����չ�����ļ�
		
		ifInstring ext, ~
            continue                    ;;���˵���ʱ�ļ�����չ���а���~��
		
		ifinstring g_extExlist, %ext%
		{
			bInExlist := false
			loop parse, g_extExlist, |
			{
				if ( A_LoopField == ext )
				{
					bInExlist := true	;; ��չ���ڹ����б��У����ļ��������˵�
					break
				}
			}
			
			if bInExlist
				continue
		}
	    StrListAdd( ret, fileFullName, "|" )
	}	
	return ret
}

