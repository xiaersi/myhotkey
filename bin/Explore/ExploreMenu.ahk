;; 我的右键菜单--资源管理器
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

g_renameIterm = 复制并重命名(&N)
g_readIterm = 去掉只读属性(&R)
g_extIterm = 显示所有扩展名(&X)
g_nohideIterm = 显示隐藏文件(&S)
g_tempHideIterm = 临时显示隐藏文件(&Z)
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
	Menu, MyMenu, Add, 用 VIM 编辑(&V), 【用VIM打开文件】
}

ifexist %var_emedit%
{
	Menu, MyMenu, Add, 用 Emedit 编辑(&E), 【用EmEdit打开文件】
}

ifexist %g_scipath%
{
	Menu, MyMenu, Add, 用SciTE编辑AHK脚本文件(&T), 【用SciTE编辑AHK脚本文件】
}

Menu, MyMenu, Add  ; Add a separator line.

Menu, MyMenu, Add, %g_readIterm%, 【去掉只读属性】
Menu, MyMenu, Add, 隐藏同类文件(&G), 【隐藏同类文件】
Menu, MyMenu, Add, 隐藏选中的文件(&F), 【隐藏选中的文件】
Menu, MyMenu, Add, 一键隐藏某些文件(&H), 【一键隐藏某些文件】
Menu, MyMenu, Add  ; Add a separator line.

Menu, MyMenu, Add, 复制文件路径(&C), 【获取文件路径】
Menu, MyMenu, Add, 自动重命名/取消重命名(&Q), 【自动重命名】
Menu, MyMenu, Add  ; Add a separator line.

Menu, MyMenu, Add, %g_extIterm%, 【已知扩展名】
Menu, MyMenu, Add, %g_nohideIterm%, 【显示所有文件】

If var_hideExt = 1
	Menu, MyMenu, UnCheck, %g_extIterm%
else
	Menu, MyMenu, Check, %g_extIterm%



if var_hidden = 2
{
	Menu, MyMenu, UnCheck, 	%g_nohideIterm%
	Menu, MyMenu, Add, %g_tempHideIterm%, 【临时显示所有文件】
}
else
	Menu, MyMenu, Check, %g_nohideIterm%

Menu, MyMenu, Show

Sleep 100
clipboard := g_oldclip
ExitApp
return

【临时显示所有文件】:
	;; 注册表中Hidden 是否显示隐藏文件， 而ShowSuperHidden 指定是否显示系统文件
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, Hidden, 00000001
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, ShowSuperHidden, 00000001
	send +{F10}e
	TrayTip , 临时显示所有文件, 临时显示隐藏文件和系统文件`n5秒后将设回隐藏状态 需要手动刷新, 5
	Sleep 5000
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, Hidden, 00000002
	RegWrite REG_DWORD, HKEY_CURRENT_USER, Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Advanced, ShowSuperHidden, 00000000
	exitapp
	return

【用SciTE编辑AHK脚本文件】:
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
		tooltip 没有选中文件！
		sleep 500
	}
	return


【用VIM打开文件】:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %a_loopfield%
		 	{
				∑用VIM打开文件(var_file)
			}
		}
		Exitapp
	}
	else
	{
		tooltip 没有选中文件！
		sleep 500
	}
	return

【用EmEdit打开文件】:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %var_file%
		 	{
				∑用EmEdit打开文件(var_file)
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
		tooltip 没有选中文件！
		sleep 500
	}
	return

【去掉只读属性】:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		loop parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %a_loopfield%
		 	{
				∑去掉只读属性(var_file)
			}
		}
		Exitapp
	}
	else
	{
		tooltip 没有选中文件！
		sleep 500
	}
	exitapp


【获取文件路径】:
	if clipboard <>
	{
		var_file = %clipboard%
		IfInString clipboard, |
		{
			var_file := StrLeft2sub( var_file, "|" )
		}

		;; 如果同时选中了多个文件，则返回这些文件所在的目录路径
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

【隐藏选中的文件】:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		Loop, parse, clipboard, `n
		{
			var_file := a_loopfield
		 	ifexist %var_file%
		 	{
				∑隐藏选中的单个文件(var_file)
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
		tooltip 没有选中文件！
		sleep 500
	}
	return


【已知扩展名】:
	∑显示隐藏扩展名()
	exitapp
	return

【显示所有文件】:
	∑显示隐藏隐藏文件()
	exitapp
	return

【隐藏同类文件】:
	var_file := clipboard
	ifexist %var_file%
	{
		SplitPath, var_file , OutFileName, var_dir, var_ext, var_name
		if var_ext =
			return

		if var_dir =
		 	return

		msgbox 4, 隐藏同类文件, 是否隐藏扩展名为 %var_ext% 的所有文件: `n  %var_dir%\*.%var_ext%
		IfMsgBox No
			return

		var_pattern = %var_dir%\*.%var_ext%
		∑隐藏同类文件( var_pattern )
	}
	exitapp
	return

【一键隐藏某些文件】:
	if clipboard <>
	{
		var_root := ∑获取根目录()
		var_file = %var_root%\bin\Explore\一键隐藏某些文件.ahk
		run_ahk( var_file )
	}
	return

【自动重命名】:
	StringReplace, clipboard, clipboard, `r , , all
	if clipboard <>
	{
		NewExt := myinput( "设置扩展名", "请指定扩展名，如果与文件当前扩展名相同则去掉之，否则添加为新扩展名。", "重命名", 300, 135 )
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
            		MsgBox FileMove出错，重命名失败！
            	else
            	{
            		tooltip 重命名成功！
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
		tooltip 没有选中文件！
		sleep 500
	}
	return

∑显示隐藏扩展名()
{
	RegRead value, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt
	If value = 0
		value = 1
	Else
		value = 0

	RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, HideFileExt, %Value%
	send +{F10}e
	; 点击键盘上的 AppsKey ，弹出右键，选择“刷新(e)” 。
	return
}

∑显示隐藏隐藏文件()
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


∑去掉只读属性( var_file )
{
	ifexist %var_file%
	{
		FileSetAttrib -R+A, %var_file%
	}
}



∑用EmEdit打开文件( var_file )
{
	global var_emedit
	if  var_file <>
	{
		ifexist %var_emedit%
			run %var_emedit% %var_file%
	}
}

∑用VIM打开文件( var_file )
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

∑隐藏选中的单个文件( var_file )
{
	ifexist %var_file%
	{
		FileSetAttrib +H, %var_file%
	}
}

∑隐藏同类文件( var_pattern )
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

