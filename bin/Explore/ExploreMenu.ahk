;; �ҵ��Ҽ��˵�--��Դ������
#NoTrayIcon
#SingleInstance force

#include ..\..\

g_oldclip := clipboard

clipboard =
send ^c

RegRead,var_vimpath,  REG_SZ, HKEY_LOCAL_MACHINE, SOFTWARE\Vim\Gvim\, path

iniread var_emedit, launchy.ini, file, emedit
if var_emedit =
{
	iniread var_emedit, launchy.ini, file, em
}
if var_emedit <>
{
	var_emedit := StrLeft2sub( var_emedit, "|" )
}

RegRead var_hideExt, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt
RegRead,var_hidden,  REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden

g_renameIterm = ���Ʋ�������(&N)
g_readIterm = ȥ��ֻ������(&R)
g_extIterm = ��ʾ������չ��(&X)
g_nohideIterm = ��ʾ�����ļ�(&S)
g_tempHideIterm = ��ʱ��ʾ�����ļ�(&Z)
g_launcheyIni = %a_workingdir%\launchy.ini
g_scipath := read_ini( g_launcheyIni, "file", "SciTE", "" )
if g_scipath <>
{
	g_scipath := StrLeft2sub( g_scipath, "|" )
}

; EXAMPLE #2: This is a working script that creates a popup menu that is displayed when the user presses the Win-Z hotkey.

; Create the popup menu by adding some items to it.
if var_vimpath <>
{
	Menu, MyMenu, Add, �� VIM �༭(&V), ����VIM���ļ���
}

ifexist %var_emedit%
{
	Menu, MyMenu, Add, �� Emedit �༭(&E), ����EmEdit���ļ���
}

ifexist %g_scipath%
{
	Menu, MyMenu, Add, ��SciTE�༭AHK�ű��ļ�(&T), ����SciTE�༭AHK�ű��ļ���
}

Menu, MyMenu, Add  ; Add a separator line.

Menu, MyMenu, Add, %g_readIterm%, ��ȥ��ֻ�����ԡ�
Menu, MyMenu, Add, ����ͬ���ļ�(&G), ������ͬ���ļ���
Menu, MyMenu, Add, ����ѡ�е��ļ�(&F), ������ѡ�е��ļ���
Menu, MyMenu, Add, һ������ĳЩ�ļ�(&H), ��һ������ĳЩ�ļ���
Menu, MyMenu, Add  ; Add a separator line.

Menu, MyMenu, Add, �����ļ�·��(&C), ����ȡ�ļ�·����
Menu, MyMenu, Add, �Զ�������/ȡ��������(&Q), ���Զ���������
Menu, MyMenu, Add  ; Add a separator line.

Menu, MyMenu, Add, %g_extIterm%, ����֪��չ����
Menu, MyMenu, Add, %g_nohideIterm%, ����ʾ�����ļ���

If var_hideExt = 1
	Menu, MyMenu, UnCheck, %g_extIterm%
else
	Menu, MyMenu, Check, %g_extIterm%



if var_hidden = 2
{
	Menu, MyMenu, UnCheck, 	%g_nohideIterm%
	Menu, MyMenu, Add, %g_tempHideIterm%, ����ʱ��ʾ�����ļ���
}
else
	Menu, MyMenu, Check, %g_nohideIterm%

Menu, MyMenu, Show

Sleep 100
clipboard := g_oldclip
ExitApp
return

����ʱ��ʾ�����ļ���:
	;; ע�����Hidden �Ƿ���ʾ�����ļ��� ��ShowSuperHidden ָ���Ƿ���ʾϵͳ�ļ�
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, Hidden, 00000001
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, ShowSuperHidden, 00000001
	send +{F10}e
	TrayTip , ��ʱ��ʾ�����ļ�, ��ʱ��ʾ�����ļ���ϵͳ�ļ�`n5����������״̬ ��Ҫ�ֶ�ˢ��, 5
	Sleep 5000
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, Hidden, 00000002
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, ShowSuperHidden, 00000000
	exitapp
	return

����SciTE�༭AHK�ű��ļ���:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %a_loopfield%
		 	{
				if g_scipath =
				{
					return
				}
				if  var_file <>
				{
					run %g_scipath% `"%var_file%`"
				}
			}
		}
		Exitapp
	}
	else
	{
		tooltip û��ѡ���ļ���
		sleep 500
	}
	return


����VIM���ļ���:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %a_loopfield%
		 	{
				����VIM���ļ�(var_file)
			}
		}
		Exitapp
	}
	else
	{
		tooltip û��ѡ���ļ���
		sleep 500
	}
	return

����EmEdit���ļ���:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %var_file%
		 	{
				����EmEdit���ļ�(var_file)
			}
			else
			{
			msgbox %a_loopfield%
			}
		}
		Exitapp
	}
	else
	{
		tooltip û��ѡ���ļ���
		sleep 500
	}
	return

��ȥ��ֻ�����ԡ�:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %a_loopfield%
		 	{
				��ȥ��ֻ������(var_file)
			}
		}
		Exitapp
	}
	else
	{
		tooltip û��ѡ���ļ���
		sleep 500
	}
	exitapp


����ȡ�ļ�·����:
	if clipboard <>
	{
		var_file = %clipboard%
		IfInString clipboard, |
		{
			var_file := StrLeft2sub( var_file, "|" )
		}

		;; ���ͬʱѡ���˶���ļ����򷵻���Щ�ļ����ڵ�Ŀ¼·��
		IfInString , clipboard, `n
		{
			var_file := get_parent_dir( var_file )
		}

		Clipboard := var_file
		ToolTip %var_file%
		Sleep 300
		ToolTip %var_file%
		Sleep 300
		ToolTip %var_file%
		Sleep 500
		ToolTip
		Exitapp
	}
	Return

������ѡ�е��ļ���:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		Loop, parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %var_file%
		 	{
				������ѡ�еĵ����ļ�(var_file)
			}
			else
			{
				StringReplace, var_temp, a_loopfield, `r , @, all
				StringReplace, var_temp, var_temp, `n , #, all
				msgbox ifnotexist [%var_temp%]
			}
		}
		Exitapp
	}
	else
	{
		tooltip û��ѡ���ļ���
		sleep 500
	}
	return


����֪��չ����:
	����ʾ������չ��()
	exitapp
	return

����ʾ�����ļ���:
	����ʾ���������ļ�()
	exitapp
	return

������ͬ���ļ���:
	var_file := clipboard
	ifexist %var_file%
	{
		SplitPath, var_file , OutFileName, var_dir, var_ext, var_name
		if var_ext =
			return

		if var_dir =
		 	return

		msgbox 4, ����ͬ���ļ�, �Ƿ�������չ��Ϊ %var_ext% �������ļ�: `n  %var_dir%\*.%var_ext%
		IfMsgBox No
			return

		var_pattern = %var_dir%\*.%var_ext%
		������ͬ���ļ�( var_pattern )
	}
	exitapp
	return

��һ������ĳЩ�ļ���:
	if clipboard <>
	{
		var_root := �ƻ�ȡ��Ŀ¼()
		var_file = %var_root%\bin\Explore\һ������ĳЩ�ļ�.ahk
		run_ahk( var_file )
	}
	return

���Զ���������:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		NewExt := myinput( "������չ��", "��ָ����չ����������ļ���ǰ��չ����ͬ��ȥ��֮���������Ϊ����չ����", "������", 300, 135 )
		if NewExt =
		{
			return
		}
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %var_file%
		 	{
		 		SplitPath, var_file, , , var_ext
		 		if var_ext = %NewExt%
		 		{
		 			StringGetPos, var_pos, var_file, .%NewExt% , R
					StringLeft var_new, var_file, var_pos
				}
				else
				{
					var_new = %var_file%.%NewExt%
				}
				FileMove, %var_file%, %var_new% , 1
				if ErrorLevel  ; Report each problem folder by name.
            		MsgBox FileMove����������ʧ�ܣ�
            	else
            	{
            		tooltip �������ɹ���
            		sleep 100
            		send !vr
            	}
				sleep 800
			}
			else
			{
			msgbox %a_loopfield%
			}
		}
		Exitapp
	}
	else
	{
		tooltip û��ѡ���ļ���
		sleep 500
	}
	return

����ʾ������չ��()
{
	RegRead value, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt
	If value = 0
		value = 1
	Else
		value = 0

	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt, %Value%
	send +{F10}e
	; ��������ϵ� AppsKey �������Ҽ���ѡ��ˢ��(e)�� ��
	return
}

����ʾ���������ļ�()
{
	RegRead, value, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden
	If(value=1)
		value = 2
	Else
		value = 1

	RegWrite, REG_DWORD, HKEY_CURRENT_USER,Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden, %Value%
	send +{F10}e
	return
}


��ȥ��ֻ������( var_file )
{
	ifexist %var_file%
	{
		FileSetAttrib -R+A, %var_file%
	}
}



����EmEdit���ļ�( var_file )
{
	global var_emedit
	if  var_file <>
	{
		ifexist %var_emedit%
			run %var_emedit% %var_file%
	}
}

����VIM���ļ�( var_file )
{
	global var_vimpath
	if var_vimpath =
	{
		return
	}
	if  var_file <>
	{
		ifexist %var_vimpath%
			run %var_vimpath% `"%var_file%`"
	}
}

������ѡ�еĵ����ļ�( var_file )
{
	ifexist %var_file%
	{
		FileSetAttrib +H, %var_file%
	}
}

������ͬ���ļ�( var_pattern )
{
	Loop, %var_pattern%
	{
		FileSetAttrib +H, %A_LoopFileFullPath%
	}
}


;#include .\inc\tip.aik
#include .\inc\inifile.aik
#include .\inc\path.aik
#include .\inc\tip.aik

