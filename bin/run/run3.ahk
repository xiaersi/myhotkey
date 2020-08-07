#SingleInstance ignore 						;; 只允许一个实例运行
#NoTrayIcon
Process Priority,,High

g_bAutoSearch := true
g_bAutoFit    := true               		;; 自动补充完整
g_bAutoExit   := true                		;; 自动退出的开关，当窗口Not Active时，程序是否自动退出

g_title = 飞扬命令窗口
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_inifile = launchy.ini
g_BackGround := read_ini(g_inifile, "file", "运行背景", "" )
g_ExtlistEx  := read_ini(g_inifile, "设置", "扩展名过滤列表", "" )	;; 扩展名过滤列表, 例如：txt|exe|bat
SECFIELD = 2
KEYFIELD = 1
VALUEFIELD = 3
MEMOFIELD = 4
g_FieldTitle%SECFIELD% = SEC
g_FieldTitle%KEYFIELD% = KEY
g_FieldTitle%VALUEFIELD% = VALUE
g_FieldTitle%MEMOFIELD% = MEMO

g_LVName = SysListView321
g_MaxRecentNum := 20                    	;; 保留最近记录的最大条数
g_CalcTipTime  = 1000                   	;; 计算器计算结果提示时间（毫秒）
g_NotLoadSec = 设置,Setting             	;; 不需要从ini文件读取到数组的分类
g_FiltExt = svn,bak							;; ListView在显示目录下的文件时，要过滤掉的扩展名
g_FolderSection = $Folder$ 					;; 当输入的是一个有效的目录时，ListView中显示该目录下的文件列表，此时第二列Section将显示为该值

IfNotExist %g_inifile%
{
	MsgBox 【%g_title%】的配置文件不存在！
	ExitApp
}

;; 声明全局变量
; File_KeyArray                             ;; 配置文件中[File]节的Key数组
; Send_KeyArray                             ;; 配置文件中[Send]节的Key数组
; Var_KeyArray								;; 配置文件中[::]节的Key数组
; File_ValueArray
; Send_ValueArray
; Var_ValueArray
; File_ExtArray
; File_IconArray
; File_PathArray

g_LoadCmdType = run,vim,var,recent,eme,send,calc,start,script,web,dir
g_NotSaveCmdType = ahk,help,add,start      	;; 这些类型的命令，不产生最近列表，也不保存到临时配置文件中
g_CustomCmdType =                       	;; 用户自定义命令类型，如ue,eme,vim,等

g_RecentCmd     =                           ;; 最近使用的命令列表
g_RecentCalc    =                           ;; 最近使用的计算命令
g_RecentWeb     =                        	;; 最近使用的网址命令
g_RecentScript  =                           ;; 最近使用的脚本命令
g_RecentVar     =                           ;; 最近使用的包含变量的命令
g_RecentRunDirect =                         ;; 最近使用的运行命令
g_Sections =                                ;; 配置文件中，所有Section连接成的字符串
g_SearchSections =                          ;; 参数搜索的Section列表， 默认为 File,Send,variable

g_cmdList = run ,help ,calc ,script ,var ,start ,vim ,send ,ahk ,add ,
regread g_svndir, HKEY_LOCAL_MACHINE, SOFTWARE\TortoiseSVN, ProcPath  ;; g_svndir获取SVN目录
if g_svndir <>
	g_cmdList = %g_cmdList%svn ,svn,


∑初始化全局变量()
InitIconList( hLVIL )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 右键点击ListView列表时, 弹出右键菜单
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, MyContextMenu, Add, 运行(&R), 【右键运行】
Menu, MyContextMenu, Add, 查看(&V), 【右键查看】
Menu, MyContextMenu, Add, 删除(&D), 【右键删除】
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, 修改(&M), 【右键修改】
Menu, MyContextMenu, Add, 新增(&A), 【右键添加】
;Menu, MyContextMenu, Add, 重命名(&N), 【右键修改单词名称】

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 窗口显示
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui +ToolWindow  +AlwaysOnTop
gui -Caption
gui, font, s10
Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
hGui := WinExist()

Gui, Add, Picture, x22 y15 AltSubmit , %g_background%
Gui, Add, Edit, x35 y33 w385 h25  v_edtSearch g【我的运行窗口_输入框】, %g_recent%
Gui, Add, Button, x420 y33 g【确定执行】, OK
;Gui, Add, Button, x66 y65 w80 h30 hide default  g【我的运行窗口_确定按钮】, 确定(&Y)
;Gui, Add, Button, x206 y65 w80 h30 hide  g【我的运行窗口_取消按钮】, 取消(&N)
Gui, Add, GroupBox, x11 y0 w460 h85 v_GroupBox , +%g_title%+
Gui, Add, ListView, x35 y63 w410 h270 +LV0x2 v_KeyListView g【我的运行窗口_ListView】, %g_FieldTitle1%|%g_FieldTitle2%|%g_FieldTitle3%|%g_FieldTitle4%
LV_SetImageList(hLVIL, 1)               ;; 使用ImageList将使ListView的高度更高
GuiControl, Hide, _KeyListView
LVA_ListViewAdd("_KeyListView", "")

;; 设置热键
Hotkey, IfWinActive, %g_wintitle%
Hotkey, F2, 			【手工编辑配置文件】
Hotkey, +F2,			【使用飞扬小字典编辑配置文件】
Hotkey, ~backspace, 	【退格键处理】
Hotkey, ~LButton,		【左键处理】
Hotkey, Enter, 			【回车事件处理】
Hotkey, MButton,		【中键处理】
Hotkey, [,   			【ListView中选择上一条】
Hotkey, ],				【ListView中选择下一条】
Hotkey, ~up,			【UP键处理】
Hotkey, ~Down,			【Down键处理】
Hotkey, ~WheelUp,		【Wheel键处理】
Hotkey, ~WheelDown,		【Wheel键处理】

;; 设置窗口透明并显示
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, xCenter yCenter h340  w480, %g_title%

LV_ModifyCol(SECFIELD, 	60)		;; 设置ListView第1列的宽度
LV_ModifyCol(KEYFIELD, 	150)	;; 设置ListView第2列的宽度
LV_ModifyCol(VALUEFIELD,200)	;; 设置ListView第3列的宽度
LVA_SetCell("_KeyListView", 0, VALUEFIELD, "", "0xAAAAAA" )
LVA_SetCell("_KeyListView", 0, SECFIELD, "", "Green" )

OnMessage( 0x06, "WM_ACTIVATE" )
OnMessage("0x4E", "LVA_OnNotify")
LoadIniFile()


;; 切换英文输入法
	if RegExMatch(A_OSVersion, "^10")
	{
		;; 如果是Win10
	    SetCapsLockState,off
        switchime_win10(0)
	}
	else
	{
	switchime("中文 (简体) - 美式键盘")
	}


return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 事件响应
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;---响应右键消息------------------------------------------------------------
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _KeyListView  ; Display the menu only for clicks inside the ListView.
	{
		g_CurSelectLine := A_EventInfo

		;; 得到当前鼠标点击的是第几列
		GetLVCellUnderMouse( hGui, g_LVName, var_CurRow, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )

		LV_GetText( g_lvKeyValue, g_CurSelectLine, VALUEFIELD )
		LV_GetText( g_lvSec, g_CurSelectLine, SECFIELD )
		LV_GetText( g_lvKeyName, g_CurSelectLine, KEYFIELD )
		LV_GetText( g_lvMemo, g_CurSelectLine, MEMOFIELD )
		ifInString g_lvSec, $
		{
			Menu, MyContextMenu, disable, 新增(&A)
		;	Menu, MyContextMenu, disable, 重命名(&N)
			Menu, MyContextMenu, disable, 修改(&M)
		}
		else
		{
			Menu, MyContextMenu, enable, 新增(&A)
		;	Menu, MyContextMenu, enable, 重命名(&N)
			Menu, MyContextMenu, enable, 修改(&M)
		}
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	RETURN


【我的运行窗口_输入框】:
	SetTimer 【延时查找用户输入并显示】, off
	Gui, submit, nohide
	if _edtSearch =
	{
		GuiControl, , _GroupBox, +%g_title%+
		GuiControl, Hide, _KeyListView
	}
	else if g_bAutoSearch
	{
		CommandSplit( _edtSearch, g_cmdType, g_cmdName, "cmdParamArray" )
;tooltip [%g_cmdType%] = CommandSplit( %_edtSearch%) =  [%g_cmdName%]
		if ( IsExeCmdType(g_cmdType) )
		{
			;; 根据当前输入的长度，确定延时查找的时间，输入内容越长，则搜索的结果越少，于是将延时时间设置小一些
			var_temp := strlen( cmdName )
			if var_temp < 5
				var_temp := 5 - var_temp
			else
				var_temp := 1
			var_temp := var_temp * 50
			if var_temp > 80
			{
				GuiControlGet, g_bVisible, Visible, _KeyListView
				if g_bVisible
				{
					var_temp := 80
				}
			}

			;; 延时搜索，目的是使用户输入优先，否则将结果集很大时可能会干扰用户的输入
			SetTimer 【延时查找用户输入并显示】, %var_temp%
		}
		else if g_cmdType in add
		{
			GuiControl, Hide, _KeyListView
		}
		else if g_cmdType in dir
		{
			var_temp := get_file_ext( g_cmdName )

			;; 如果 g_cmdName 时远程目录或无效的目录，则显示最近使用列表
			if ( instr(g_cmdName, "\\") == 1 || var_temp != "$Dir$"  )
			{
				∑查找并显示最近命令( g_cmdType, g_cmdName )
			}
			;; 如果 g_cmdName 是有效的目录，则显示该目录下的所有文件
			else
			{
				∑显示目录下的文件( g_cmdName )
			}
		}
		else
		{
			∑查找并显示最近命令( g_cmdType, g_cmdName )
		}
		;; 提示命令类型、命令及参数信息
		var_tip = 类型[%g_cmdType%]  命令{ %g_cmdName% }
		loop %cmdParamArray0%
		{
			var_temp := cmdParamArray%a_index%
			var_tip = %var_tip% P%a_index%=%var_temp%,
		}
		GuiControl, , _GroupBox, %var_tip%
	}
	g_bAutoSearch := true
	return


【我的运行窗口_确定按钮】:
【我的运行窗口_取消按钮】:
	return


【我的运行窗口_ListView】:
	if ( A_GuiEvent == "DoubleClick"  )
	{
		GetLVCellUnderMouse( hGui, g_LVName, var_CurRow, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )
		LV_GetText( g_lvKeyValue, var_CurRow, VALUEFIELD )
		LV_GetText( g_lvSec, var_CurRow, SECFIELD )
		LV_GetText( g_lvKeyName, var_CurRow, KEYFIELD )
		LV_GetText( g_lvMemo, var_CurRow, MEMOFIELD )
		if ( g_lvSec == g_FolderSection )
		{
			var_temp = %g_lvKeyValue%
			myrun( var_temp )
		}
		else if g_lvSec = variable
		{
			;; 在输入了变量时，双击variable类型的行直接运行之
			if cmdParamArray0 > 0
			{
				GoSub 【右键运行】
			}
			;; 在没有输入变量的情况下，双击variable类型的行，要求输入变量值，然后运行
            else
			{
				StringReplace var_temp, g_lvKeyValue, $var$, 变量, all
				var_temp = 请为下面的内容输入变量值. `n%var_temp%
				EnableBox( true )
				InputBox, var_temp , 输入变量值, %var_temp%, , , 150
				EnableBox( false )

				if not ErrorLevel
				{
					if var_temp <>
					{
						StringReplace var_temp, g_lvKeyValue, $var$, %var_temp%, all
						myrun ( var_temp )
					}
				}
			}
		}
		else
		{
			GoSub 【右键运行】
		}
	}
	return


GuiEscape:
	GuiControlGet, bVisible, Visible, _KeyListView
	if ( bVisible )
		GuiControl, Hide, _KeyListView
	Else
		Gosub 【退出程序】
	return


【退出程序】:
	tooltip
	SetTimer 【延时查找用户输入并显示】, off
	settimer 【延时自动填充KeyName】, off
	ExitApp
	Return

GuiClose:
	ExitApp

【延时查找用户输入并显示】:
	Gui, submit, nohide
	SetTimer 【延时查找用户输入并显示】, off
	if ( IsExeCmdType(g_cmdType) )
	{
		var_bVariable := false       ;; 指定是否只搜索Variable或var两个分节

		;; 判断输入的命令是否var类型的命令( g_cmdType为空且 g_cmdName之后有空格 )
		if ( g_cmdType == "" && g_cmdName <> "" && _edtSearch <> g_cmdName )
		{
			StringMid var_char, _edtSearch, StrLen( g_cmdName ) + 1, 1
			; tooltip var_char [%var_char%] ; `n_edtSearch [%_edtSearch%] <> [%g_cmdName%] g_cmdName
			if ( var_char == A_Space )
			{
				;; 如果输入框内输入的命令包含了空格，则认为的Var类型的命令
				;; 那么只搜索并显示Variable或var两个分节下的命令
				var_bVariable := true
			}
		}
		;; 调用函数搜索并显示相关命令
		∑查找用户输入并显示( g_cmdName, var_bVariable )
	}
	Return


【右键运行】:
	Sleep 50
	curRow := LV_GetNext(0, "Focused")
	if curRow > 0
	{
		CommandSplit( _edtSearch, _cmdType, _cmdName, "cmdParamArray" )
		if ( LV_run( _cmdType, curRow, "cmdParamArray" ) )
		{
			gosub 【退出程序】
		}
	}
	return

【右键查看】:

	return


【右键修改】:
	;; 过滤掉非file,send,variable的关键字
	if g_lvSec not in %g_SearchSections%
	{
		return
	}
	if g_lvKeyName =
	{
		return
	}
	var_value := read_ini( g_inifile, g_lvSec, g_lvKeyName, "" )
	if var_value =
	{
		return
	}

	;; 窗口失去焦点时，不允许自动退出程序，否则将无法弹出其他交互窗口
	EnableBox( true )

	;; 点击第一列修改关键字的名称
	if var_CurCol = 1
	{
		bMod := false
		loop
		{
			var_input := myinput("更改KeyName", "请输入新的关键字名：", g_lvKeyName )
			if var_input =
				break
			var_read := read_ini( g_inifile, g_lvSec, var_input, "" )
			if var_read <>
			{
				var_tip = 输入的关键字<%var_input%>已经存在，其值为：`n`n   %var_tead%`n`n是否要替换？Yes替换 	No重新输入	Cancel取消
				msgbox 3, 关键字已经存在, %var_tip%
                ifMsgBox Yes            ;; 强制替换
				{
					bMod := true
					break
				}
                else ifMsgBox cancel    ;; 取消
				{
					bMod := false
					break
				}
                ;; else ifMsgbox No     ;; 不替换，换一个关键字
                ;; 		continue
			}
			else
			{
				bMod := true
				break
			}
		}
		;; 保存到配置文件
		if bMod
		{
			write_ini( g_inifile, g_lvSec, var_input, var_value)
			del_ini( g_inifile, g_lvSec, g_lvKeyName )

			;; 更新数组，刷新Listview
			ArrayName = %g_lvSec%_keyArray
			var_pos := SearchArray( ArrayName, g_lvKeyName, true )
			if var_pos > 0
			{
				%ArrayName%%var_pos% := var_input
				g_PreSearch = ￥强制刷新￥
				GoSub 【延时查找用户输入并显示】	;; 刷新ListView
			}
		}
	}
	;; 其他列修改关键字的值
	else
	{
		var_tip = 请为 %g_lvKeyName% 输入新的值：
		InputBox, OutputVar, 修改 %g_lvKeyName% 的值, %var_tip%, , ,120 , , , , , %var_value%
		if not ErrorLevel
		{
			write_ini( g_inifile, g_lvSec, g_lvKeyName, var_value)

			;; 更新数组，刷新Listview
			ArrayName = %g_lvSec%_valueArray
			var_pos := SearchArray( ArrayName, g_lvKeyValue, true )
			if var_pos > 0
			{
				if g_lvSec = file
				{
					ClearArray( "TempArray" )
					StringSplit, TempArray, var_value, |
					If TempArray2 = 0
						TempArray2 =
					file_valueArray%var_pos% := TempArray1
					file_ExtArray%var_pos% := TempArray2
					file_PathArray%var_pos% := TempArray3
				}
				else
				{
					%ArrayName%%var_pos% := var_value
				}
				g_PreSearch = ￥强制刷新￥
				GoSub 【延时查找用户输入并显示】	;; 刷新ListView
			}
		}
	}
    ;; 窗口失去焦点时，允许自动退出
	EnableBox( false )

	return

【右键删除】:
	if g_lvSec =
	{
		return
	}
    if g_lvSec in %g_SearchSections%    ;; file,send,variable
	{
		if g_lvKeyName <>
		{
			;; 从g_inifile 配置文件中删除
			del_ini( g_inifile, g_lvSec, g_lvKeyName )

			;; 从内存数组中删除相关内容
			ArrayName = %g_lvSec%_keyArray
			var_index := SearchArray( ArrayName, g_lvKeyName, true )
			if var_index > 0
			{
				if g_lvSec = file
				{
					file_valueArray%var_index% =
					file_ExtArray%var_index% =
					file_PathArray%var_index% =
				}
				else
				{
					%g_lvSec%_valueArray%var_index% =
				}
			}

			g_PreSearch = ￥强制刷新￥
			GoSub 【延时查找用户输入并显示】	;; 刷新ListView
		}
	}
    else ifInString g_lvSec, $          		;; 自定义类型
	{
		StringReplace var_sec, g_lvSec, $, , All
		if var_sec not in %g_NotSaveCmdType%  	;; 非ahk,help,add的自定义类型
		{
			ArrayName = %g_lvSec%_valueArray
			if ( RemoveArray( ArrayName, g_lvKeyValue, true ) )
			{
				WriteRecentArray( ArrayName, var_sec ) ;; 将更新后的最新列表保存到配置文件
				∑查找并显示最近命令( var_sec, g_cmdName )
			}
		}
	}
	return

【右键添加】:
	var_run := ∑获取根目录()
	var_run = %var_run%\bin\run\addrun.ahk
	run_ahk( var_run, cmdName, a_workingdir )
	return


【确定执行】:
	g_runsuccess := RunInput( _edtSearch )
	var_tip =  `"%_edtSearch%`" 执行
	if g_runsuccess
	{
		gosub 【退出程序】
	}
	else
	{
		var_tip = %var_tip% 失败！
		tooltip %var_tip%, 35, 65, 7
		SetTimer, RemoveToolTip7, 2000
	}
	return


【延时自动填充KeyName】:
	Gui, submit, nohide
	LV_GetText( var_newtext, 1, 1 )
	IfInstring var_newtext, %_edtSearch%
	{
		∑为编辑框设置并选择新文本( g_wintitle, "Edit1", _edtSearch, var_newtext )
	}
	settimer 【延时自动填充KeyName】, off
	return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 函数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include ..\..\
#include .\bin\run\run3_active.aik
#include .\bin\run\run_func.aik
#include .\bin\run\run_cmdrun.aik
#include .\bin\run\TrotoiseCommand.aik

#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\run.aik
#include .\inc\tip.aik
#include .\inc\path.aik
#include .\inc\expression.aik

#Include .\inc\listview\LVA.aik
#Include .\inc\listview\iconlist.aik
#Include .\inc\listview\lvfunc.aik
#include .\inc\Array.aik
#include .\inc\cmdString.aik
#include .\inc\window.aik




