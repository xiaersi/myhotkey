#SingleInstance ignore	;只运行一次，禁止多次运行
#NoTrayIcon

#include ..\..\
#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\run.aik
#include .\inc\tip.aik
#include .\inc\path.aik
#include .\inc\expression.aik

g_bAutoList := true   ;; 暂时停止自动刷新下拉列表，方便使用ＵＰ／Ｄｏｗｎ方向键选择下拉列表项
g_title = 我的运行窗口
g_wintitle = 我的运行窗口 ahk_class AutoHotkeyGUI
g_inifile = launchy.ini

;; 以下全局变量从ini文件中读取
g_file_keys =
g_send_keys =
g_var_keys =

ifnotexist %g_inifile%
{
	msgbox [我的运行窗口] 的配置文件不存在！
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
g_background := read_ini(g_inifile, "file", "运行背景", "" ) 
g_extExlist := read_ini(g_inifile, "设置", "扩展名过滤列表", "" )	;; 扩展名过滤列表, 例如：txt|exe|bat

g_helplist = ?在线帮助|?-----------------------------------
g_helplist = %g_helplist%|?【?】开头显示简要帮助
g_helplist = %g_helplist%|?【`;】开头变身“运行”窗口，直接Run系统命令
g_helplist = %g_helplist%|?【=】开头变身超级计算器
g_helplist = %g_helplist%|?【<】开头直接作为脚本运行
g_helplist = %g_helplist%|? 命令::变量 表示包含变量的命令
g_helplist = %g_helplist%|? 等号结束将内容复制到剪贴板【=】
g_helplist = %g_helplist%|? F4 用默认文本编辑器打开配置文件
g_helplist = %g_helplist%|?-----------------------------------
g_helplist = %g_helplist%|?作者：teshorse@hotmail.com|

;;---显示窗口----------------------------------------------------------------
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
	Gui, Add, ComboBox, x35 y35 w310 h25 R15 v_ComboBox g【我的运行窗口_输入框】, %g_recent%
	Gui, Add, Button, x66 y65 w80 h30 hide default  g【我的运行窗口_确定按钮】, 确定(&Y)
	Gui, Add, Button, x206 y65 w80 h30 hide  g【我的运行窗口_取消按钮】, 取消(&N)
	Gui, Add, GroupBox, x11 y0 w360 h85 v_GroupBox , 请输入命令

	Gui, Color, EEAA99
	Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
	hGui := WInExist()
	WinSet, TransColor, EEAA99
	Gui, Show,xCenter yCenter  h90 w375, %g_title%
}
else
{
	Gui, Add, ComboBox, x21 y28 w310 h25 R15 v_ComboBox g【我的运行窗口_输入框】, %g_recent%
	Gui, Add, GroupBox, x11 y10 w330 h50 v_GroupBox, 请输入命令
	Gui, Add, Button, x66 y65 w80 h30 default  g【我的运行窗口_确定按钮】, 确定(&Y)
	Gui, Add, Button, x206 y65 w80 h30  g【我的运行窗口_取消按钮】, 取消(&N)
	Gui, Show,xCenter yCenter  h108 w353, %g_title%
}

OnMessage( 0x06, "WM_ACTIVATE" )

Return 

;;---响应用户输入------------------------------------------------------------
【我的运行窗口_输入框】:
	ControlGetText var_curInput, Edit1, %g_wintitle%
	if var_curInput =
	{
		GuiControl, Text, _GroupBox, 请输入命令
		Control HideDropDown, , ComboBox1, 
	}
	if (var_preInput == var_curInput)
	{
		return
	}
	var_preInput := var_curInput
	
	;;___显示输入内容所对应的具体内容________________________________________
	
	
	if not g_bAutoList 
	{
		g_bAutoList := true
		∑查找标题( var_curInput )
		return
	}
	findList := ∑生成下拉列表( var_curInput )
	if ( g_preList == findList )
	{
		return
	}
	g_preList := findList
	;;___显示下拉列表________________________________________________________
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
	
;;---按钮响应----------------------------------------------------------------
【我的运行窗口_确定按钮】:
	gui, submit, hide
	sleep 100
	var_user := _ComboBox
	if var_user =
	{
		ControlGetText var_user, Edit1, %g_wintitle%
	}
;	msgbox [%var_user%]

	;;___首字母为";"时直接run分号后面的命令__________________________________
	StringLeft  vartemp, var_user, 1
	if vartemp = ?
	{
		if (var_user == "?在线帮助")
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
		∑排序最近运行的命令( var_user, "rundirect" )
		exitapp
	}
	;;___首字母是=号，则计算=号后面的表达式__________________________________
	else if (vartemp = "=") 
	{
		vartemp := SubStr(var_user, 2)
		var_re := CalcLine(vartemp)
		if var_re = EXP_ERROR 
		{
			msgbox 计算出错！
		}
		else if var_re <>
		{
			clipboard := var_re
			tooltip 已复制计算结果：%clipboard% 
			sleep 1000
			tooltip
		}
		∑排序最近运行的命令( var_user, "calc" )
		exitapp
	}
	;;___用户输入的内容直接作为代码进行运行__________________________________
	else if (vartemp = "<") 
	{
		vartemp := SubStr(var_user, 2)
		run_with_temp_file(vartemp)
		∑排序最近运行的命令( var_user, "script" )
		exitapp
	}
	;;___用户输入的是网址或文件路径, 则直接运行______________________________
	StringMid, vartemp, var_user, 2, 2
	StringLeft varhttp, var_user, 7
	if (vartemp = ":\" or varhttp = "http://") 
	{
		run %var_user%
		∑排序最近运行的命令( var_user, "web" )
		exitapp
	}
	stringLeft varwww, var_user, 4
	if (varwww = "www.")
	{
		run http://%var_user%
		∑排序最近运行的命令( var_user, "web" )
		exitapp
	}
	;;___用户输入"vim myhotkey.ahk", 将用vim 编辑器打开myhotkey.ahk文件______
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
				StringMid var_keyValue, var_keyValue, 2	;; 去掉行首的+-以及分号
			}
			IfNotExist %var_keyValue%
			{
				tooltip 想用VIM打开的文件不存在 `n %var_keyValue%
				sleep 2000
				tooltip
				exitapp
			}
			StringLeft firstChar, var_vim, 1
			IfInstring var_list, %firstChar%	
			{
				StringMid var_vim, var_vim, 2	;; 去掉行首的+-以及分号
			}
			IfNotExist %var_vim%
			{
				tooltip 没有正确指定 VIM 编辑器的路径`n请将其路径绑定为vim关键字
				sleep 2000
				tooltip
				exitapp
			}
			run %var_vim% `"%var_keyValue%`"
		}
		else
		{
			tooltip7("你还没有指定vim文本编辑器的位置, 找到vim的运行文件, `n按Ctrl+Alt+Insert键将其添加为关键字Vim")
		}
		exitapp
	}

	
	;;___如果最后字符为=号, 则直接输出关键字的值_____________________________
	if ( StrLastWord(var_user, 1) = "=" )
	{
		varleft := StrLeft2Sub(var_user, "=")
		var_temp := read_ini(g_inifile,"file",varleft,"")
		if ( var_temp != "" ) {
			clipboard := var_temp
			tooltip 已经复制：%var_temp%
			sleep 800
			tooltip
		}
		exitapp
	}

	;;_______________________________________________________________________
	; 如果输入中包含"::"字符, 
	; 该符号前是配置文件中[::]节的关键字, 
	; 该符号后是替换关键值中的$var$的变量
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
			; 对输入进行变换
			if (instr(var_temp, "google"))
			{	; 如果是搜索引擎, 则替换一些字符,如将"+"号替换成"%2B"
				StringReplace, varright, varright, +, `%2B
			}
			else if (instr(var_temp, "baidu"))
			{	; 如果是搜索引擎, 则替换一些字符,如将"+"号替换成"%2B"
				StringReplace, varright, varright, +, `%2B
			}

			; 将变换后的输入值, 替换掉$var$, 然后运行
			StringReplace, var_temp, var_temp, $var$, %varright%
			run %var_temp%
			∑排序最近运行的命令( var_user, "variable" )
			exitapp
		}
	}

	;;___检查是网址，则直接运行______________________________________________
	if ( instr(var_user, ".com") or instr(var_user, ".net") or instr(var_user, ".cn") or instr(var_user, ".org") )
	{	
		var_temp = http://%var_user% 
		run %var_temp%
		∑排序最近运行的命令( var_temp, "web" )
		exitapp
	}
	
;;_______________________________________________________________________
;; 如果用户输入的是目录命令，以 \ 符号开头的命令， 
;; 则下拉列表中显示的是该目录下的所有文件名, 
;; 确定之后run 该目录下的这个文件
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
	;;___其他正常情况输入____________________________________________________
	var_temp := read_ini( g_inifile, "file", var_user,"")
	if var_temp =
	{
		
		; 检查[send]节中, 如果没有对应关键字, 则用户输入的命令不存在
		iniread,var_send,launchy.ini,send,%var_user%
		if (var_send="" or var_send="ERROR") 
		{
			if var_user = \ahk
			{
				var_root := ∑获取根目录()
				run %var_root%
			}
			else if var_user = \ahkbin
			{
				var_root := ∑获取根目录()
				run %var_root%\bin
			}
			else if var_user = \ahklib
			{
				var_root := ∑获取根目录()
				run %var_root%\lib
			}
			else if var_user = \ahkAwin
			{
				var_root := ∑获取根目录()
				run %var_root%\Awin
			}
			else if var_user = \ahkinc
			{
				var_root := ∑获取根目录()
				run %var_root%\inc
			}
			else if var_user = \ahkusers
			{
				var_root := ∑获取根目录()
				run %var_root%\Users
			}
			else if var_user = \ahklearn
			{
				var_root := ∑获取根目录()
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
				tooltip 刚才输入的命令不存在
				sleep 1000
				tooltip
			}
		}
		else ; [send]节中有用户输入的关键字, 则直接输出关键值, 可以是 "#+n"(打开OneNote) ,
		{
			send %var_send%
		}
	}
	else		; 在配置文件中找到关键字, 正常执行
	{
		runini(var_user)		; 运行ini文件中指定的程序
		iniwrite, %var_user%, temp.ini, run, last
		∑排序最近运行的命令( var_user, "recent" )
	}	
	exitapp
	return 
		
【我的运行窗口_取消按钮】:
GuiClose:
【退出程序】:
	exitapp
	return 


;;---快捷键响应--------------------------------------------------------------
#ifwinactive 我的运行窗口 ahk_class AutoHotkeyGUI
~up::	
~down::
	g_bAutoList := false
	return
	
[::             ;; 在下拉列表中，向上选择
	g_bAutoList := false
	send {up}
	return
	
]::				;; 在下拉列表中，向下选择
	g_bAutoList := false
	send {down}
	return
		
		
^del::			;; 在最近列表中删除内容
	;; Google 桌面搜索的风格,不允许删除内容
	if g_bGoogleType = 1
	{
		return
	}
	
 	;; 传统风格的窗口
	controlGetText groupBoxText, Button3
	controlGetText curInput, Edit1
	if curInput =
		return
		
	if groupBoxText = 最近打开的网址
	{
		g_recent_web := readTempIni("run", "web", "" )
		if g_recent_web <>
		{
			if StrListDelete( g_recent_web, curInput, "|")
			{
				writeTempIni("run", "web", g_recent_web)
				tooltip7( "成功从[最近打开的网址]列表中删除了 ". curInput )
			}
		}	
	}
	else if groupBoxText = 最近直接运行的命令
	{
		g_recent_rundirect := readTempIni("run", "rundirect", "" )
		if g_recent_rundirect <>
		{
			if StrListDelete( g_recent_rundirect, curInput, "|")
			{
				writeTempIni("run", "rundirect", g_recent_rundirect)
				tooltip7( "成功从[最近直接运行的命令]列表中删除了 ". curInput )
			}
		}			
	}
	else if groupBoxText = 最近计算表达式
	{
		g_recent_calc := readTempIni("run", "calc", "" )
		if g_recent_calc <>
		{
			if StrListDelete( g_recent_calc, curInput, "|")
			{
				writeTempIni("run", "calc", g_recent_calc)
				tooltip7( "成功从[最近计算表达式]列表中删除了 ". curInput )
			}
		}			
	}
	else if groupBoxText = 最近运行的脚本
	{
		g_recent_script := readTempIni("run", "script", "" )
		if g_recent_script <>
		{
			if StrListDelete( g_recent_script, curInput, "|")
			{
				writeTempIni("run", "script", g_recent_script)
				tooltip7( "成功从[最近运行的脚本]列表中删除了 ". curInput )
			}
		}			
	}
	else if groupBoxText = 最近包含变量的命令
	{
		g_recent_var := readTempIni("run", "variable", "" )
		if g_recent_var <>
		{
			if StrListDelete( g_recent_var, curInput, "|")
			{
				writeTempIni("run", "script", g_recent_var)
				tooltip7( "成功从[最近运行的脚本]列表中删除了 ". curInput )
			}
		}	
	}
	else if groupBoxText = 帮助
	{
		;; 帮助内容不允许删除
	}
	else 
	{
		g_recent := readTempIni("run", "recent", "" )
		if g_recent <>
		{
			if StrListDelete( g_recent, curInput, "|") 
			{
				writeTempIni("run", "recent", g_recent)
				tooltip7( "成功从[最近使用的命令]列表中删除了 ". curInput )
			}
		}	
	}
		
	return
	
esc::
	exitapp
	return

+enter::	;; 连续按两次回车，直接运行
	send {enter}
	sleep 100
	goto 【我的运行窗口_确定按钮】
	return

~enter::	;; 回车时，判断当前输入框的命令是否已经存在，存在则直接运行该命令（避免按两次回车）
	Control HideDropDown, , ComboBox1, 
	ControlGetText var_curInput, Edit1, %g_wintitle%
	if ( g_file_count > 0 &&  g_file_keys != "" )
	{
		Loop parse, g_file_keys, `n
		{
			IfInString A_LoopField, %var_curInput%
			{
				goto 【我的运行窗口_确定按钮】
			}
		}
	}

	if ( g_send_count > 0 && g_send_keys != "" )
	{
		Loop parse, g_send_keys, `n
		{
			IfInString A_LoopField, %var_curInput%
			{
				goto 【我的运行窗口_确定按钮】
			}
		}
	}

	if ( g_var_count > 0 && g_var_keys != "" )
	{
		Loop parse, g_var_keys, `n
		{
			IfInString A_LoopField, %var_curInput%
			{
				goto 【我的运行窗口_确定按钮】
			}
		}
	}    
  	return

F2::    ;; 打开Ini文件，手工编辑launchy.ini
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
			SetTimer 【退出程序】, 500
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
;; 保存指定的关键字到temp.ini，并且将最近的关键字进行排序
∑排序最近运行的命令( var_lastkey, var_recent_keyname )
{
	var_recent := read_ini("temp.ini", "run", var_recent_keyname, "")
	var_first := StrLeft2Sub( var_recent, "|" )
	IfNotEqual var_first , %var_lastkey%
	{
		∑Add字符串队列( var_recent, var_lastkey, "|", true, 15 )
		write_ini( "temp.ini", "run", var_recent_keyname, var_recent ) 
	}
}


∑生成下拉列表( var_curInput )
{
	global
	ret =
	if var_curInput =
		return ret
	
	get_first_char( var_curInput, firstChar )
	
	if firstChar = ?
	{
		ret := g_helplist
		GuiControl, Text, _GroupBox, 帮助
	}
	else if firstChar = <
	{
		ret := g_recent_script
		GuiControl, Text, _GroupBox, 最近运行的脚本
	}
	else if ( firstChar == "=" )
	{
		ret := g_recent_calc
		GuiControl, Text, _GroupBox, 最近计算表达式
	}
	else if ( firstChar == ";" )
	{
		ret := g_recent_rundirect
		GuiControl, Text, _GroupBox, 最近直接运行的命令
	}
	else ifinstring var_curInput, http:
	{
		ret := g_recent_web
		GuiControl, Text, _GroupBox, 最近打开的网址
	}
	else ifinstring var_curInput, www.
	{
		ret := g_recent_web
		GuiControl, Text, _GroupBox, 最近打开的网址
	}
	else ifinstring var_curInput, ::
	{
		ret := g_recent_var
		GuiControl, Text, _GroupBox, 最近包含变量的命令
	}
	else if ( var_curInput == g_last || var_curInput == "" )
	{
		ret := g_recent
		GuiControl, Text, _GroupBox, 最近使用的命令
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
						var_title := read_ini( g_inifile, "file", var_search, "搜索命令" )
						
						;; 如果命令中以 \ 开头， 表示该命令对应一个目录， 下拉列表将显示该目录下的所有文件
						if equal_first_char( var_search, "\" )
						{
							var_Attribute := FileExist(var_title)
;							msgbox %var_Attribute% := FileExist(%var_title%)
							ifinstring var_Attribute, D
							{
								StrTrimRight( var_Attribute, "\" )	;; 去掉最右边的 \ 符号
								tempret := ∑生成指定目录的文件列表( var_title )
								if tempret <>
								{
									var_title = [Dir] %var_title%
									GuiControl, Text, _GroupBox, %var_title%
									return tempret
								}							
							}

						}
						var_title := ∑缩短路径( var_title, 50)
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
						var_title := read_ini( g_inifile, "send", var_search, "搜索命令" )
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
						var_title := read_ini( g_inifile, "variable", var_search, "搜索命令" )
						var_title = [Run] %var_title% 
					}				
					var_lastkey := a_loopfield
					StrListAdd( ret, var_lastkey, "|" )
					var_count++
				}
			}
		}
		
		if var_title =
			var_title = 搜索命令
		GuiControl, Text, _GroupBox, %var_title%
	}	
	return ret
}

∑查找标题(var_search)
{
	global
	var_title = 
			
	;; 如果用户输入的目录命令，以"\"符号开头的命令，那么不更新标题
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
				var_title := read_ini( g_inifile, "file", var_search, "搜索命令" )
				var_title := ∑缩短路径( var_title, 50)
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
				var_title := read_ini( g_inifile, "send", var_search, "搜索命令" )
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
				var_title := read_ini( g_inifile, "variable", var_search, "搜索命令" )
				var_title = [Run] %var_title% 
				GuiControl, Text, _GroupBox, %var_title%
				return
			}
		}
	}
	
	GuiControl, Text, _GroupBox, 搜索命令
}

get_ahk_dir()
{
	if a_ahkpath =
	{
		dir =
	}
	else
	{
		;;  从 C:\Program Files\AutoHotkey\AutoHotkey.exe 中分离出目录
		ifInString a_ahkpath, AutoHotkey.exe
		{
			∑分解路径( a_ahkpath, dir, filename, ext )
		}
		else	;; a_ahkpath 本身就是目录 
		{
			dir := a_ahkpath
		}
	}
	return dir
}


∑生成指定目录的文件列表( var_path )
{
	global g_extExlist
	ret =
	FilePattern = %var_path%\*.*
	FileList =  ; Initialize to be blank.
	
	;; 查寻文件夹
	Loop, %FilePattern%
	    FileList = %FileList%%A_LoopFileName%`n
	    
	;; 如果没有匹配的文件，则退出
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
			continue					;; 过滤掉~$开头的文件，可能是Word文档的备份文件
		}
		
		∑分解路径( fileFullName, dir, filename, ext )
		
		if ext =
			continue					;; 过滤掉没有扩展名的文件
		
		ifInstring ext, ~
            continue                    ;;过滤到临时文件（扩展名中包含~）
		
		ifinstring g_extExlist, %ext%
		{
			bInExlist := false
			loop parse, g_extExlist, |
			{
				if ( A_LoopField == ext )
				{
					bInExlist := true	;; 扩展名在过滤列表中，该文件将被过滤掉
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

