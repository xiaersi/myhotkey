;; 编辑飞扬命令串

#NoTrayIcon
#include ..\..\
change_icon()

;; 参数：飞扬命令串
g_param = %1%

;; 初始化全局变量
g_title = 编辑飞扬命令串
g_WINTITLE = %g_title% ahk_class AutoHotkeyGUI ;; 注意标题对大小写敏感

g_AWinID =                              ;; 当前窗口的唯一标识
WinGet, g_AWinID, id, A

g_default =

g_checked = checked

g_DefOptions = send|menu|gosub|func|run|clip|submenu|sendByClip|tip:|runby:|launchy:|IfWinActive:|IfWinExist:|IfExist:|name:|sleep:|MAX|MIN|HIDE|WinActivate:

g_Options =

g_bAutoFilt := true   ;; 在选项编辑框输入内容是，是否要自动过滤下方的默认选项列表ListBox


;; 如果传递了参数进来，则根据参数修改全局变量
if g_param <>
{
	g_default := cmdStringSplit( g_param, opt )

	if RegExMatch( opt, "^\d(?=$|\|)", var_match ) > 0
	{
		if var_match =
			g_checked =
		g_Options := RegExReplace( opt, "^\d[$|\|]" )
	}
	else
	{
		g_Options := opt
	}
}

;; 获取预览窗格的默认命令串
OptionList := g_Options
if g_Options <>
	OptionList = |%OptionList%

if g_checked =
	g_preview = 0%OptionList%)%g_default%
else
	g_preview = 1%OptionList%)%g_default%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 显示窗口
Gui, Add, Text, x6 y18 w50 h20 +Right, 命令值:
Gui, Add, Edit, x66 y13 w410 h25 v_edtInput g【命令值编辑框】, %g_default%
Gui, Add, Text, x12 y50 w130 h20 , 选项类型:
Gui, Add, Edit, x12 y70 w130 h22 v_edtOptions g【选项编辑框】,
Gui, Add, ListBox, x12 y100 w130 h170 v_lbDefOptions g【DefOptionsListBox】, %g_DefOptions%
Gui, Add, Text, x206 y50 , 命令选项:
Gui, Add, CheckBox, x400 y45 w130 h20 %g_checked% v_bValid g【命令是否有效复选框】, 是否有效
Gui, Add, ListBox, x206 y70 w360 h210 v_lbOptions    g【OptionsListBox】,  %g_Options%
Gui, Add, Text, x12 y270 , 预览生成的飞扬命令串:
Gui, Add, Edit, x12 y290 w554 h58 v_edtCmd, %g_preview%

Gui, Add, Button, x486 y10 w80 h30 g【确定】, 确  定
Gui, Add, Button, x151 y68 w45 h25 g【添加命令选项】, >>
Gui, Add, Button, x151 y100 w45 h25 g【删除命令选项】, <<
Gui, Add, Button, x151 y200 w45 h25 g【生成飞扬命令串】, 生成
Gui, Add, Button, x151 y235 w45 h25 g【执行飞扬命令串】, 执行
; Generated using SmartGUI Creator 4.0
Gui, Add, StatusBar,, 编辑飞扬命令串

Gui, Show, h377 w578, %g_title%

Return



GuiClose:
ExitApp


;;---响应右键消息------------------------------------------------------------
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _lbDefOptions
	{
		GuiControl,Text, _edtOptions,
	}
	RETURN


【DefOptionsListBox】:
	Gui, Submit, NoHide

	g_bAutoFilt := false	;; 在点击默认选项列表框过程中，禁止自动搜索过滤默认选项列表框
	if A_GuiEvent = DoubleClick
	{
		GuiControl, Text, _edtOptions, %_lbDefOptions%
		gosub 【添加命令选项】
	}
	else if A_GuiEvent = Normal
	{
		GuiControl, Text, _edtOptions, %_lbDefOptions%
	}

	;; 设置状态栏提示信息
	var_tip = 请选择命令选项类型
	SB_SetText( var_tip )
	return



【OptionsListBox】:
	gosub 【生成飞扬命令串】
	return


【命令是否有效复选框】:
【生成飞扬命令串】:
	Gui, submit, nohide
	ControlGet, OptionList, List, , ListBox2
	StringReplace OptionList, OptionList, `n, |, all
	if OptionList =
		OptionList = %_bValid%
	else
		OptionList = %_bValid%|%OptionList%
	GuiControl, Text, _edtCmd,  %OptionList%)%_edtInput%
	return


【命令值编辑框】:
	gosub 【生成飞扬命令串】
	return


【添加命令选项】:
	Gui, submit, nohide
	if _edtOptions <>
	{
		ControlGet, OptionList, List, , ListBox2
		StringReplace OptionList, OptionList, `n, |, all
		var_option := _edtOptions
		ifInstring var_option, :
		{
			;; 命令选项中有冒号，需要用户在冒号后面添加其他条件，弹出对话框输入
			var_input := myinput( "请输入命令选项的条件", var_option, "" )
			if var_input =
				return

			var_option = %var_option%%var_input%
		}

		;; 不能有重复的选项
		if InStrList( OptionList, var_option, "|" ) > 0
		{
			msgbox 命令选项 `"%var_option%`" 已经存在！
			return
		}


		OptionList = %OptionList%|%var_option%
		GuiControl ,  , _lbOptions, |
		GuiControl ,  , _lbOptions, %OptionList%

		gosub 【生成飞扬命令串】
	}
	return


【删除命令选项】:
	Gui, submit, nohide
	if 	_lbOptions <>
	{
		newOptionList =		;; 删除选中的命令选项之后的命令选项列表
		ControlGet, OptionList, List, , ListBox2
		loop parse, OptionList, `n
		{
			if ( a_loopfield != _lbOptions )
			{
				if newOptionList =
					newOptionList := a_loopfield
				else
					newOptionList = %newOptionList%|%a_loopfield%
			}
		}
		if ( newOptionList != OptionList )
		{
			GuiControl ,  , _lbOptions, |
			GuiControl ,  , _lbOptions, %newOptionList%
			gosub 【生成飞扬命令串】
		}
	}
	return

【选项编辑框】:  ;; 选项编辑框发生变化，自动搜索过滤选项列表
	if not g_bAutoFilt
	{
		g_bAutoFilt := true
		return   ;; 如果g_bAutoFilt=false，那么禁止自动过滤默认选项列表框
	}
	;; g_bAutoFilt=true 选项编辑框发生变化时，搜索过滤默认选项列表框_lbDefOptions
	Gui, Submit, NoHide
	GuiControl, , _lbDefOptions, |
	if _edtOptions =
	{
		GuiControl, , _lbDefOptions, %g_DefOptions%
	}
	Else
	{
		var_temp =
		loop parse, g_DefOptions, |
		{
			IfInString A_LoopField, %_edtOptions%
			{
				var_temp = %var_temp%|%A_LoopField%
			}
		}
		GuiControl, , _lbDefOptions, %var_temp%
	}
	Return

【确定】:
	Gui, submit, nohide
	clipboard := _edtCmd
	ifWinExist ahk_id %g_AWinID%
	{
		IfWinNotActive, ahk_id %g_AWinID%, , WinActivate, ahk_id %g_AWinID%,
		WinWaitActive, ahk_id %g_AWinID%,
		Gui, hide
		send ^v
	}
	else
	{
		tooltip 命令已经复制到剪贴板！
		sleep 1000
	}
	gosub GuiClose
	return

【执行飞扬命令串】:
	Gui, submit, nohide
	if CheckCmd( _edtCmd )
	{
		run_cmd( _edtCmd )
	}
	return


CheckCmd( cmdstr_ )
{
	bRet := true
	cmdstr := cmdStringSplit( cmdstr_, opt )
	if InStrList( opt, "0", "|" ) > 0
	{
		return false
	}

	if InStrList( opt, "send", "|" ) > 0
	{
		if cmdstr =
		{
			tooltip3( "send 类型的命令值不能为空！" )
			return false
		}
	}
	else if InStrList( opt, "gosub", "|" ) > 0
	{
		if not IsLabel( cmdstr )
		{
			tooltip3( "gosub 类型的命令值指定的功能模块无效！" )
			return false
		}
	}
	else if InStrList( opt, "menu", "|" ) > 0
	{
		iniMenumem := IniFileRead( "ShortcutMenu.ini" )
		if SecArrayFromIniMem( iniMenumem, cmdstr, "TempArray" ) = 0
		{
			tooltip3( "尚未配置快捷菜单：" . cmdstr )
			return false
		}
	}


	if RegExMatch( opt, "i)(?<=IfExist:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		ifExist %var_martch%
			bRet := true
		else
			return false
	}
	if RegExMatch( opt, "i)(?<=IfWinActive:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		IfWinActive %var_martch%
			bRet := true
		else
			return false
	}
	if RegExMatch( opt, "i)(?<=IfWinNotActive:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		IfWinNotActive %var_martch%
			bRet := true
		else
			return false
	}
	if RegExMatch( opt, "i)(?<=IfWinExist:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		IfWinExist %var_martch%
			bRet := true
		else
			return false
	}
	if RegExMatch( opt, "i)(?<=IfWinNotExist:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		IfWinNotExist %var_martch%
			bRet := true
		else
			return false
	}
	if RegExMatch( opt, "i)(?<=runby:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		bRet := false
		ifexist %var_martch%
			bRet := true
		else
			return false
	}
	else if RegExMatch( opt, "i)(?<=launchy:).*?(?=$|\)|\|)", var_martch ) > 0
	{
		var_read := read_ini( "launchy.ini", "file", var_martch, "" )
		if var_read <>
		{
			;; var_file 可能的值为： abc.exe|exe|c:\work
			loop parse, var_read, |
			{
				if a_loopfield <>
				{
					var_file := a_loopfield
					ifExist %var_file%
						bRet := true
					else
						return false
				}
				else
				{
					return false
				}
				break
			}
		}
		else
		{
			return false
		}
	}

	return true
}

#include .\inc\array.aik
#include .\inc\window.aik
#include .\inc\tip.aik
#include .\inc\string.aik
#include .\inc\cmdstring.aik
