
;; 参数：窗口标题，窗口类
#singleinstance ignore
#notrayicon
#include ..\..\

g_title = 添加画屏手势禁用窗口

;; 判断配置文件是否存在，如果不存在则退出
g_inifile = AutoHotString.ini
ifNotExist %g_inifile%
{
	MsgBox, 16, %g_title%,  配置文件 %g_inifile% 不存在！
	exitapp
}

;; 更换图标
change_icon()



;; 读取配置文件
g_AWinList_keyname = Active禁用列表
g_EWinList_keyname = Exist禁用列表
g_MouseGesture_Section = 画屏手势
g_AWinList := read_ini( g_inifile, g_MouseGesture_Section, g_AWinList_keyname, "" )
g_EWinList := read_ini( g_inifile, g_MouseGesture_Section, g_EWinList_keyname, "" )


WinGetActiveTitle, g_ATitle
WinGetClass, g_AClass, A

g_newTitle = %g_ATitle% ahk_class %g_AClass%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 显示窗口

Gui, Add, GroupBox, x6 y17 w355 h80 , 窗口信息

Gui, Add, Radio, x16 y35 w80 h20 checked v_RadioTitle	g【选择过滤当前窗口标题】, 窗口标题
Gui, Add, Radio, x16 y65 w80 h20 v_RadioClass			g【选择过滤当前同类窗口】, 窗口类
Gui, Add, Edit, x96 y35 w250 h18 v_edtTitle				g【修改当前窗口标题】, %g_ATitle%
Gui, Add, Edit, x96 y65 w250 h18 v_edtClass				g【修改当前窗口类】, %g_AClass%

Gui, Add, Button, x370 y25 w90 h30 g【确定】, 确  定
Gui, Add, Button, x370 y65 w90 h30 g【取消】, 取  消

Gui, Add, Radio, x16 y120 w380 h20 v_RadioAWin checked	g【选择添加到AWinList】, AddTo: 活动窗口过滤列表 （ IfWinActive ）
Gui, Add, Radio, x16 y250 w390 h20 v_RadioEWin			g【选择添加到EWinList】, AddTo: 非活动窗口过滤列表（ IfWinExist ）

Gui, Add, ListBox, x6 y140 w460 h100 v_lbActive, %g_newTitle%|%g_AWinList%
Gui, Add, ListBox, x6 y270 w460 h100 v_lbExist,  %g_EWinList%

; Generated using SmartGUI Creator 4.0
Gui, Show, h377 w477, %g_title%


Return



【取消】:
GuiClose:
ExitApp


【确定】:
	gui submit, nohide
	newtitle := GetNewTitle()
	if _RadioAWin
	{
		if InStrList( g_AWinList, newtitle, "|" ) > 0
		{

			msgBox, 48, %g_title%,    活动窗口禁用列表中已经包含指定窗口: `n`"%newtitle%`"
			return
		}
		g_AWinList = %newtitle%|%g_AWinList%
		write_ini( g_inifile, g_MouseGesture_Section, g_AWinList_keyname, g_AWinList )
		msgBox, 4, %g_title%,   `"%newtitle%`"`n`n成功添加至活动窗口禁用列表（IfWinActive）`n`n是否重启飞扬热键使之生效？
		ifmsgbox yes
			send ^!+{f5}
		ExitApp
	}
	else if _RadioEWin
	{
		if InStrList( g_EWinList, newtitle, "|"  ) > 0
		{
			msgBox, 48, %g_title%,    非活动窗口禁用列表中已经包含指定窗口: `n`"%newtitle%`"
			return
		}
		g_EWinList = %newtitle%|%g_EWinList%
		write_ini( g_inifile, g_MouseGesture_Section, g_EWinList_keyname, g_EWinList )
		msgBox, 64, %g_title%,   `"%newtitle%`"`n`n成功添加至非活动窗口禁用列表（IfWinExist））`n`n是否重启飞扬热键使之生效？
		ifmsgbox yes
			send ^!+{f5}
		ExitApp
	}
	return


#include .\inc\common.aik
#include .\inc\inifile.aik

;; 根据界面生成（将要添加到鼠标手势禁用列表的）窗口标题
GetNewTitle()
{
	local newtitle
	if _edtClass <>
		newtitle = ahk_class %_edtClass%

	if _RadioTitle
		newtitle = %_edtTitle% %newtitle%

	return newtitle
}


;; 刷新禁用列表
RefreshList( bBoth = false )
{
	local newtitle := GetNewTitle()
	if _RadioAWin
	{
		guicontrol , , _lbActive, |
		guicontrol , , _lbActive, %newtitle%|%g_AWinList%
	}
	else if bBoth
	{
		guicontrol , , _lbActive, |
		guicontrol , , _lbActive, %g_AWinList%
	}

	if _RadioEWin
	{
		guicontrol , , _lbExist, |
		guicontrol , , _lbExist, %newtitle%|%g_EWinList%
	}
	else if bBoth
	{
		guicontrol , , _lbExist, |
		guicontrol , , _lbExist, %g_EWinList%
	}
}

;;
【选择过滤当前窗口标题】:
【选择过滤当前同类窗口】:
	gui submit, nohide
	RefreshList( false )
	return

【修改当前窗口标题】:
	gui submit, nohide
	if _RadioAWin
		RefreshList( false )
	return

【修改当前窗口类】:
	gui submit, nohide
	if _RadioEWin
		RefreshList( false )
	return

【选择添加到AWinList】:
【选择添加到EWinList】:
	gui submit, nohide
	RefreshList( true )
	return
