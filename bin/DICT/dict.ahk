#NoTrayIcon
#SingleInstance off                     ;; 允许多个实例同时运行


change_icon()                           ;; 设置图标

;FileInstall, dict.ico,%A_ScriptDir%\dict.ico

g_TIPMAXLINE := 100                     ;; 点击弹出的提示，每行允许的最大长度

g_RICHTEXTHEAD = .RichText
g_HideSection := 0 			;; 隐藏左侧分类栏
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 参数1: inifile|section list,sec1,sec2,sec3|titile|cursec|curkey
g_param1 = %1%
g_pInifile =
g_pTitle =
g_pSecList =
g_pCurSec =
g_pCurkey =
g_SubDir =



if g_param1 <>
{
	;; GetValueFromParams() 从参数列表中，查询指定关键字的参数值
	g_SubDir   := GetValueFromParams( g_param1, "SubDir" )
	g_pInifile := GetValueFromParams( g_param1, "file" )
	g_pSecList := GetValueFromParams( g_param1, "seclist" )
	g_pTitle   := GetValueFromParams( g_param1, "title" )
	g_pCurSec  := GetValueFromParams( g_param1, "cursec" )
	g_pCurkey  := GetValueFromParams( g_param1, "curkey" )
	g_Title    := g_pTitle
	g_INIFILE  := g_pInifile

	;; 设置hidesec是否显示左侧分类栏，由参数指定或在分类列表g_pSecList中仅指定了一个分类
	g_HideSection := GetValueFromParams( g_param1, "hidesec" )
	if g_HideSection =
		if g_pSecList <>
			ifnotinstring 	g_pSecList, `,
				g_HideSection := 1
}

if g_SubDir <>
	SetWorkingDir %a_WorkingDir%\%g_SubDir% 


if g_INIFILE =
{
	g_INIFILE := read_ini("temp.ini", "我的字典", "file", "dict.dic")
}


if g_HideSection
{
	_hideSec = hide
}
else
{
	_hideSec = 
}


;;------全局变量------------------------------------------------------------
g_OLDTITLE =                            ;; 记录激活字典的窗口，以便返回
WinGetActiveTitle  g_OLDTITLE

g_PreIniFile =                          ;; 切换字典后，该变量保存切换之前的字典文件G


if g_Title =
{
	SplitPath g_INIFILE, OutFileName
	g_Title = %OutFileName% -- 飞扬小字典
}
g_WINTITLE = %g_TITLE% ahk_class AutoHotkeyGUI ;; 注意标题对大小写敏感
IfWinExist %g_WINTITLE%
{
	WinActivate %g_WINTITLE%
	CoordMode, ToolTip, Screen
	ToolTip, 《 %g_Title% 》`n--------------------------------`n飞扬字典已打开`n如果要打开新窗口请按下Alt键！`n, A_ScreenWidth - 230, A_ScreenHeight - 120
	KeyWait, LAlt,D T2
	if not GetKeyState("LAlt", "p"])
	{
		ExitApp
	}
	ToolTip
}

; Gosub 【设置热键】

g_WINX := readTempIni("我的字典", "winx", "")
g_WINY := readTempIni("我的字典", "winy", "")
g_FAVORITE := readTempIni("我的字典", "favorite", "")
g_background = %a_scriptdir%/BG.jpg
if g_WINX <>
	g_WINX = x%g_WINX%

if g_WINY <>
	g_WINY = y%g_WINY%

g_DICTLIST =


LOOP, %a_workingdir%\*.dic
{
	IfInString A_LOOPFileName, .dic~
	{
        CONTINUE                        ;; 过滤掉临时文件
	}
	if A_LOOPFileName <>
	{
		∑连接字符串(g_DICTLIST, A_LOOPFileName, "|")
	}
}

g_IsHelp := false                       ;; 是否显示帮忙信息？
g_SearchHistory =                       ;; 历史搜索
g_StatusTip =                           ;; 状态栏待显示的内容

g_CurSelectLine := 0                    ;; 当前双击ListView中的行
g_ShowDetail := false					;; 当前ListView是否显示展开的单词选项
g_CurKey =
g_GuiID =
g_LVName = SysListView321


;;---缓存INI文件的数据-------------------------------------------------------
g_IniArray =                            ;; 保存INI行的数组
g_iSecArray =                           ;; 与 g_IniArray
g_secList =                             ;; 当前ini文件中所有的section, g_secList = sec1|sec2|....


;; g_bAutoSearch 修改分类、KeyName、KeyValue编辑框时，是否实时自动搜索？
;; 当程序自动设置这些编辑框时，并不愿意自动搜索，于是应该在设置编辑框的值之前
;; 将g_bAutoSearch的值置为 false，设置完毕之后再将其值置为true
g_bAutoSearch := true
g_EnterExit   := 0                  	;; 0 非切换状态， 1 从其他窗口切换到我的小窗口，-1 或许是从字典窗口切换到其他窗口
g_WindowWidth =                         ;; 记录当前窗口的宽度， 以供调整ListView的列宽用
g_bShortCol1 := false					;; 第一列宽度在自动调整后，再次缩小
g_bShortCol2 := false					;;
g_iLocalPos  := 0	                    ;; 在完成搜索之后，将视口显示到第几行
KeyValueFieldTitle = 单词项
SectionFieldTitle = 分类
KeyNameFieldTitle = 单词

g_SecEditWidth = 120			    ;; 指定左侧分类框控件的宽度
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 创建菜单、窗口， 并显示窗口
#include ../../
#include .\bin\Dict\dict_CreateUI.aik

;; 使得ListView背景色隔行银白交替，隔列灰白交替

; LVA_ListViewAdd("_KeyListView", "AR AC cbsilver")

LVA_ListViewAdd("_KeyListView")
LVA_SetCell("_KeyListView", 0, 1, "", "Green" )
LVA_SetCell("_KeyListView", 0, 2, "", "0x3366BB" )
LVA_SetCell("_KeyListView", 0, 3, "", "0x666666" )

OnMessage("0x4E", "LVA_OnNotify")
OnMessage( 0x06, "WM_ACTIVATE" )
ControlSetText Edit4, %g_INIFILE%, %g_WINTITLE%	; 设置ComboBox默认值

ShowText()  ;; 隐藏RichEdit编辑框
GuiControl, Hide, _btnSingleValue

if g_pSecList =
{
	GoSub 【读取ini文件】
}
else	;; 如果参数指定了显示的Section列表及默认选择的Section 和 Key
{
	Init()

	∑加载INI文件( g_pSecList )

	GuiControl,, _SecListBox, |
	GuiControl,, _SecListBox, %g_secList%

	g_bAutoSearch := false
	GuiControl, Text, _INIFILE, %g_INIFILE%
	g_bAutoSearch := true


	GuiControl, disable, _IniFile
	;;___设置窗口新标题和热键________________________________________________
	Gui, Show, , %g_TITLE%
	Gosub 【设置热键】
}

if g_pCurSec <>
	guicontrol, text, _Section, %g_pCurSec%

if g_pCurKey <>
	Guicontrol, text, _keyname, %g_pCurKey%

RETURN

;;---调整窗口的大小---------------------------------------------------------
GuiSize:
【重新绘制窗口】:
	;; 先隐藏待调整位置的控件，调整完毕之后再显示，目的是避免闪烁
	GuiControlGet, bListViewVisible, Visible, _KeyListView  ;; bListViewVisible保存_KeyListView当前显示状态，以便后面恢复
	bMultiKeyValue := ∑keyValue显示多行()

	GuiControl, hide, _btnAdd
	GuiControl, hide, _btnAdd2
	GuiControl, hide, _btnMod
	GuiControl, hide, _btnDel
	GuiControl, hide, _btnCopy
	GuiControl, hide, _btnInsert
	GuiControl, hide, _btnClose
	GuiControl, hide, _SetWinTop
	GuiControl, hide, _SetWinTrans
	GuiControl, hide, _BtnGroup
	GuiControl, hide, _KeyListView
	GuiControl, hide, _SecListBox
	GuiControl, hide, _Section
	GuiControl, hide, _lblSec
	GuiControl, hide, _btnHideSec
	GuiControl, hide, _btnSecLeft
	GuiControl, hide, _btnSecRight
	GuiControl, hide, _btnSecWidth
	;; 调整控件位置
	g_WindowWidth := A_GuiWidth

	var_x := 6
	var_Height := A_GuiHeight - 113
	var_Width := A_GuiWidth - var_x - 5
	
	if not g_HideSection
	{
		var_x := var_x + g_SecEditWidth + 10
		var_Width := var_Width - g_SecEditWidth - 10
		var_x2 := var_x 
	}
	else
	{
		var_x2 := var_x + 28
	}
	GuiControl, MoveDraw, _KeyListView , x%var_x% h%var_Height% w%var_Width% ;; ListView的大小调整
	GuiControl, MoveDraw, _KeyValue , x%var_x% w%var_Width%
	GuiControl, MoveDraw, _lbl_KeyValue , x%var_x2%

	if g_HideSection
		var_x += 3
	ControlMove, , var_x, , var_Width, var_Height, ahk_id %g_hRichEdit%

	var_Width := var_Width - 25 						;; KeyValue的后面增加“+”按钮，所以要减小25个像素
	var_Height := bMultiKeyValue ? ( var_Height + 30 ) : 25

	GuiControl, MoveDraw, _KeyValue , w%var_Width% h%var_Height%		;; KeyValue编辑框的宽度调整
 	LV_ModifyCol(3, var_Width)          				;; 调整_KeyListView列表第三列的宽度

	var_left := A_GuiWidth - 30
	GuiControl, MoveDraw, _btnAdd2 , x%var_left%
	GuiControl, MoveDraw, _btnSingleValue , x%var_left%


	;; 需要隐藏左侧分类
	if not g_HideSection
	{
		var_Height := A_GuiHeight - 148
		GuiControl, MoveDraw, _SecListBox , h%var_Height% w%g_SecEditWidth%	;; 调整左边ListBox的高度
		GuiControl, MoveDraw, _Section ,  w%g_SecEditWidth%

		;; 调整下方按钮和复选框的Top位置
		GuiControl, MoveDraw, _btnClose, y%var_Top%
		var_Top := A_GuiHeight - 48
		GuiControl, MoveDraw, _btnSingleValue , y%var_Top%
		GuiControl, MoveDraw, _SetWinTop, y%var_Top%
		GuiControl, MoveDraw, _SetWinTrans, y%var_Top%
		var_Top := A_GuiHeight - 25
		GuiControl, , _btnHideSec, <<
		GuiControl, MoveDraw, _btnHideSec , y%var_Top% h20
		GuiControl, MoveDraw, _btnSecLeft , y%var_Top% h20
		GuiControl, MoveDraw, _btnSecRight , y%var_Top% h20
		GuiControl, MoveDraw, _btnSecWidth , y%var_Top% h20

		GuiControl, show, _SecListBox
		GuiControl, show, _SetWinTop
		GuiControl, show, _SetWinTrans
		GuiControl, show, _Section
		GuiControl, show, _lblSec
		GuiControl, show, _btnSecLeft
		GuiControl, show, _btnSecRight
		GuiControl, show, _btnSecWidth
	}
	else
	{
		GuiControl, , _btnHideSec, >>
		GuiControl, MoveDraw, _btnHideSec , y49 h20
	}

	;; 显示调整后的控制
	GuiControl, show, _btnAdd
	GuiControl, show, _btnAdd2
	GuiControl, show, _btnMod
	GuiControl, show, _btnDel
	GuiControl, show, _btnCopy
	GuiControl, show, _btnInsert
	GuiControl, show, _btnClose
	GuiControl, show, _BtnGroup
	GuiControl, show, _btnHideSec


	;; 恢复_KeyListView或RichEdit的显示
	if not bMultiKeyValue
	{
		if bListViewVisible
			GuiControl, show, _KeyListView
		Else
		{
			Control, show, , ahk_id %g_hRichEdit%
		}
	}
	RETURN

;; 将文件拖拽到我的小字典中
GuiDropFiles:
	;; 如果拖拽到日志显示框，则打开该文件

	Loop, parse, A_GuiEvent, `n
	{
		FirstFile = %A_LoopField%
		Break
	}
	if FirstFile <>
	{
		ControlSetText Edit4, %FirstFile%, %g_WINTITLE%
		SetIniFile( FirstFile )
		sleep 100
		GoTo 【重新加载字典】
	}
	return

;;---点击Section ListBox列表, 选择Section--------------------------------------------
SectionListBox:
	Gui, Submit, NoHide
	if A_GuiEvent = DoubleClick
	{
		SetTimer, 【延时搜索KeyName】, Off

		g_isHelp := false
		g_bAutoSearch := false
		Gosub 【清空搜索框】
		g_bAutoSearch := true
		Sleep 100
		Gosub 【搜索KeyName】
	}
	else if A_GuiEvent = Normal
	{
		g_bAutoSearch := false
		GuiControl, Text, _Section, %_SecListBox%
		g_bAutoSearch := true
		;SetTimer, 【延时搜索KeyName】, 200
	}
	RETURN

;;---点击KeyListView列表, 选择注释--------------------------------------------
KeyListView:
	if ( A_GuiEvent == "DoubleClick"  )
	{
		gui, submit, nohide

		g_ShowTip := false              ;; 使延时提示[延时展开并提示内容]失效
		tipx( 7 )				;; 清除正在显示的tooltip

		if ( A_EventInfo > LV_GetCount() || A_EventInfo <= 0 )
		{
			RETURN
		}
		g_CurSelectLine := A_EventInfo

		;; 从ListView中获取keyValue, 并填充到keyValue编辑框中
		LV_GetText( var_RowKeyValue, A_EventInfo, 3 )
		g_bAutoSearch := false
		GuiControl, Text, _KeyValue,  %var_RowKeyValue%
		g_bAutoSearch := true

		;; 如果ListView正在显示的是帮助信息，则在将选中的内容显示到上面的keyValue之后，不再进行其他操作
		if g_IsHelp
		{
			g_bAutoSearch := true
			RETURN
		}

		;; 将ListView中Section分类填充到分类编辑框
		LV_GetText( var_RowSec, A_EventInfo, 1 )
		if ( _Section != var_RowSec )
		{
		    g_bAutoSearch := false      ;; 暂停实时搜索，否则会干扰编辑框输入新的值
		    GuiControl, Text, _Section, %var_RowSec%
	        g_bAutoSearch := true       ;; 最后一个编辑框，可打开实时搜索功能
		}

		;; 将ListView中当前行的keyName值设置到搜索框
		LV_GetText( var_RowKeyName, A_EventInfo, 2 )
		if ( _keyName != var_RowKeyName && var_RowKeyName != "" )
		{
			;;___设置历史搜索________________________________________________________
			if ∑Add字符串队列( g_SearchHistory, var_RowKeyName, "|", true, 20 )
			{
				GuiControl,, _KeyName, |
				GuiControl,, _KeyName, %g_SearchHistory%
				write_ini("temp.ini", "我的字典", g_INIFILE, g_SearchHistory, false )
			}
		}
		g_bAutoSearch := false
		GuiControl, Text, _KeyName, %var_RowKeyName%
		Sleep 50 	;; 需要延时一点， 否则后面取不到_keyName的值
		g_bAutoSearch := true


		g_DBClickListView := true


		if !g_showdetail
		{
            ;sleep 50                    ;; 延时一点，双击列表显示的单词项处于收缩状态，不会自动展开，需要两次双击才展开。
			bNeedRichText := false 
			if var_RowKeyValue <>
			{
				ifInstring var_RowKeyValue, %g_RICHTEXTHEAD%
					bNeedRichText := true
				else if instr( var_RowKeyValue, "{\rtf1\" ) == 1
					bNeedRichText := true
			}


            if bNeedRichText            ;; 需要使用RichEdit显示详细内容
			{
				GoTo 【右键查看】
			}
            else                        ;; 展开单词项
			{
				Gosub 【搜索KeyName】
				∑展开单词项( var_RowSec, var_RowKeyName, var_RowKeyValue )
			}
		}
		else if var_RowKeyValue <>
		{
			if ( InStr( var_RowKeyValue, "`;" ) > 0 or strlen(var_RowKeyValue) > 50 )
			{
            	GoTo 【右键查看】       ;; 在展开单词项之后，双击ListView将弹出对话框，显示KeyValue的值，这样可以显示更多的内容，阅读更方便
            }
		}
	}
	RETURN

;;---响应右键消息------------------------------------------------------------
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _KeyListView  ; Display the menu only for clicks inside the ListView.
	{
		;; 保存当前选择的行到 g_iLocalPos
		GetLVCellUnderMouse( g_GuiID, g_LVName, g_iLocalPos, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )

		ifNotexist %g_INIFILE%
			RETURN

		g_CurSelectLine := A_EventInfo
		GetLVCellUnderMouse( g_GuiID, g_LVName, var_CurRow, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )
		LV_GetText( var_RowKeyValue, g_CurSelectLine, 3 )
		LV_GetText( var_RowSec, g_CurSelectLine, 1 )
		LV_GetText( var_RowKeyName, g_CurSelectLine, 2 )
		if ( var_RowSec == "分类" && var_RowKeyName == "Key" && var_RowKeyValue == "KeyValue" )
		{
			RETURN
		}
		if ( var_RowSec == "" || var_RowKeyName == "" )
		{
			Menu, MyContextMenu, disable, 插入(&I)
			Menu, MyContextMenu, disable, 修改(&E)
			Menu, MyContextMenu, disable, 删除(&D)
			Menu, MyContextMenu, disable, 添加(&A)
			Menu, MyContextMenu, disable, 重命名或连接(&N)
		}
		else
		{
			Menu, MyContextMenu, disable, 插入(&I)

			if g_IsHelp
			{
				Menu, MyContextMenu, disable, 修改(&E)
				Menu, MyContextMenu, disable, 删除(&D)
				Menu, MyContextMenu, disable, 添加(&A)
				Menu, MyContextMenu, disable, 重命名或连接(&N)
			}
			else
			{
				Menu, MyContextMenu, Enable, 修改(&E)
				Menu, MyContextMenu, Enable, 删除(&D)
				Menu, MyContextMenu, Enable, 添加(&A)
				Menu, MyContextMenu, Enable, 重命名或连接(&N)
				if g_ShowDetail
					Menu, MyContextMenu, Enable, 插入(&I)
			}
		}
		if var_RowKeyValue =
		{
			Menu, MyContextMenu, disable, 复制(&C)
			Menu, MyContextMenu, disable, 复制粘贴(&P)
		}
		else
		{
			Menu, MyContextMenu, Enable, 复制(&C)
			Menu, MyContextMenu, Enable, 复制粘贴(&P)
		}
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	else if A_GuiControl = _SecListBox
	{
		ControlGetText var_sec, Edit3, %g_WINTITLE%
		if  var_sec <>
		{
			GuiControl, Text, _Section,
		}
	}
	RETURN

;; 窗口显示结束
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 下面是按钮和热键的响应

;;---关闭窗口----------------------------------------------------------------
【关闭按钮】:
GuiEscape:
GuiClose:
	WinGetPos winx, winy, , , %g_WINTITLE%
	WriteTempIni("我的字典", "winx", winx)
	WriteTempIni("我的字典", "winy", winy)
ExitApp



;;---响应搜索按钮,重新加载ini字典文件----------------------------------------
【重新加载字典】:
	ControlSetText, Edit1, , %g_WINTITLE%
【搜索全部】:
	ControlSetText, Edit3, , %g_WINTITLE%		;; 清空Setion编辑框
【重新加载数据并搜索】:
	Gui submit, nohide
	ifnotexist %g_INIFILE%
	{
		g_Sections =
		msgbox 字典文件%g_INIFILE%不存在, 加载字典失败!
		RETURN
	}
	else if ( g_pSecList == "" && g_INIFILE != read_ini("temp.ini", "我的字典", "file", "dict.dic") )
	{  ;; 当g_pSecList为空时，表示临时打开字典，不保存到最近使用的file配置中
		write_ini("temp.ini", "我的字典", "file", g_INIFILE, false)
	}
	GuiControl, Text, _KeyValue,
;	ControlSetText, Edit2, , %g_WINTITLE%		;; 清空KeyValue编辑框

	var_cursec := _section
	var_curkey := _keyName
	var_ShowDetail := g_ShowDetail

	Gosub 【读取ini文件】


	g_ShowDetail := var_ShowDetail
	;; 是否需要展开单词项
	if g_ShowDetail
	{
		sleep 100
		var_keyValue := ∑FindIniContent( var_cursec, var_curkey )
		∑展开单词项( var_cursec, var_curkey, var_keyValue )
	}
	Else
	{
		Gosub 【搜索keyName】

		g_bAutoSearch := false
		GuiControl, Text, _KeyName, %var_CurKey%
		GuiControl, Text, _Section, %var_cursec%
		g_bAutoSearch := true
	}
	Return

【读取ini文件】:
	Init()

	var_seclist =
	if ( g_pInifile == g_inifile )
	{
		var_seclist := g_pSecList
		g_Title := g_pTitle
	}
	else
		g_Title =

	∑加载INI文件( var_seclist )

	GuiControl,, _SecListBox, |
	GuiControl,, _SecListBox, %g_secList%

	g_bAutoSearch := false
	GuiControl, Text, _INIFILE, %g_INIFILE%
	g_bAutoSearch := true


	;;___设置搜索框下拉搜索历史______________________________________________
	g_SearchHistory := read_ini("temp.ini", "我的字典", g_INIFILE, "")
	GuiControl,, _KeyName, |
	GuiControl,, _KeyName, %g_SearchHistory%
	GuiControl,Text,_keyName, %g_CurKey%

	;;___设置窗口新标题和热键________________________________________________
	if g_Title =
	{
		SplitPath g_INIFILE, OutFileName
		g_Title = %OutFileName% -- 飞扬小字典
	}
	g_WINTITLE = %g_TITLE% ahk_class AutoHotkeyGUI ;; 注意标题对大小写敏感
	Gui, Show, , %g_TITLE%
	Gosub 【设置热键】

Return



;; 按钮及热键影响结束
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

【取消热键】:
	if g_PreIniFile <>
	{
		SplitPath g_PreIniFile, OutFileName
		preTitle = %OutFileName% -- 我的小字典
		preWINTITLE = %preTitle% ahk_class AutoHotkeyGUI ;; 注意标题对大小写敏感

		Hotkey, IfWinActive, %preWINTITLE%
		Hotkey, F1, 			【最小化我的小字典】, off
		Hotkey, F3, 			【搜索全部】, off
		Hotkey, F4, 			【初始化所有编辑框】, Off
		Hotkey, F5, 			【重新加载数据并搜索】, Off
		Hotkey, F6, 			【下拉收起搜索历史记录】, off
		Hotkey, Enter, 			【回车响应】, off
		Hotkey, numpadenter, 	【回车响应】, off
		Hotkey, !Enter, 		【ALT回车响应】, off
		Hotkey, ^PGUP,			【keyValue显示单行】, Off
		Hotkey, ^PGDN,			【keyValue显示多行】, Off
		Hotkey, ^o,				 MenuFileOpen, off
		Hotkey, ^e, 			【用文本编辑器打开】, off
		Hotkey, ^i, 			【插入按钮】, off
		Hotkey, ^=, 			【增加按钮】, off
		Hotkey, #Tab,			【复制搜索框】, Off
		Hotkey, ^Tab,			【复制KeyValue】, Off
		Hotkey, ins & end, 		【增加按钮】, off
		Hotkey, !4, 			【增加按钮】, off
		Hotkey, NumpadAdd, 		【增加按钮】, off
		Hotkey, ^s, 			【复制KeyValue不包含注释的值到父窗口】, off
		Hotkey, ~BS, 			【退格键收起单词项】, off
		Hotkey, ^up, 			【ListView上一行】, off
		Hotkey, ![,				【ListView上一行】, off
		Hotkey, ^Down,			【ListView下一行】, off
		Hotkey, !],				【ListView下一行】, off
		Hotkey, !0, 			【取消置顶和半透明】, off
		Hotkey, ~LButton, 		【鼠标左键单击响应】, off
		Hotkey, ~WheelDown, 	【关闭Timer_延时展开并提示内容】, off
		Hotkey, ~WheelUP, 		【关闭Timer_延时展开并提示内容】, off
		Hotkey, <^LButton,		【拖拽文本到其他窗口】, off
		loop 12
		{
			var_temp = !F%a_index%
			Hotkey, %var_temp%, 【快捷键打开收藏】, off
		}
		Hotkey, IfWinExist, %preWINTITLE%
		Hotkey, #v, 			【复制其他窗口选中的内容到飞扬小字典】, off
		Hotkey, ^!+2, 			【粘贴到飞扬小字典KeyValue辑框】, off
		Hotkey, ^!+3, 			【粘贴为飞扬小字典KeyValue框的注释】, off
		Hotkey, ^!+1, 			【粘贴到飞扬小字典KeyName框】, off
		hotkey, ins & home, 	【复制其他窗口选中的内容到字典的搜索框中】, off
		Hotkey, ins & PGUP, 	【复制其他窗口选中的内容到字典的KeyValue框中】, off
		Hotkey, ins & PGDN, 	【复制其他窗口中的内容到KeyValue框末尾作为注释】, off
		Hotkey, NumpadPgup,		【复制其他窗口中的内容到KeyValue框末尾作为注释】, off
		Hotkey, NumpadHome, 	【复制其他窗口选中的内容到字典的搜索框中搜索】, off
		Hotkey, NumpadUp,		【从其他窗口复制选中内容到我的小字典的KeyValue框中】, off
		Hotkey, !c,				【批量添加选中的内容到我的小字典】, off
		Hotkey, NumpadLeft,		【复制其他窗口选中的内容_转化为大写后粘贴到字典的搜索框中】, off
		Hotkey, NumpadClear,	【复制其他窗口选中的内容_作为注释添加到KeyValue框末尾并自动添加】, off
		Hotkey, !j,				【Alt_J响应】, off
	}
Return

【设置热键】:
	Hotkey, IfWinActive, %g_wintitle%
	Hotkey, F1, 			【最小化我的小字典】
	Hotkey, F3, 			【搜索全部】
	Hotkey, F4, 			【初始化所有编辑框】
	Hotkey, F5, 			【重新加载数据并搜索】
	Hotkey, F6, 			【下拉收起搜索历史记录】
	Hotkey, Enter, 			【回车响应】 	;【展开ListView显示的第一行单词项】
	Hotkey, numpadenter, 	【回车响应】	;【展开ListView显示的第一行单词项】
	Hotkey, !Enter, 		【ALT回车响应】
	Hotkey, ^PGUP,			【keyValue显示单行】
	Hotkey, ^PGDN,			【keyValue显示多行】
	Hotkey, ^o,			 	MenuFileOpen
	Hotkey, ^e, 			【用文本编辑器打开】
	Hotkey, ^i, 			【插入按钮】
	Hotkey, ^=, 			【增加按钮】
	Hotkey, #Tab,			【复制搜索框】
	Hotkey, ^Tab,			【复制KeyValue】
	Hotkey, ins & end, 		【增加按钮】
	Hotkey, !4, 			【增加按钮】
	Hotkey, NumpadAdd, 		【增加按钮】
	Hotkey, ^s, 			【复制KeyValue不包含注释的值到父窗口】
	Hotkey, ~BS, 			【退格键收起单词项】
	Hotkey, ^up, 			【ListView上一行】
	Hotkey, ![,				【ListView上一行】
	Hotkey, ^Down,			【ListView下一行】
	Hotkey, !],				【ListView下一行】
	Hotkey, !0, 			【取消置顶和半透明】
	Hotkey, ~LButton, 		【鼠标左键单击响应】
	Hotkey, ~WheelDown, 	【关闭Timer_延时展开并提示内容】
	Hotkey, ~WheelUP, 		【关闭Timer_延时展开并提示内容】
	Hotkey, <^LButton,		【拖拽文本到其他窗口】
	Hotkey, !j,				【Alt_J响应】
	loop 12
	{
		var_temp = !F%a_index%
		Hotkey, %var_temp%, 【快捷键打开收藏】
	}

	;Hotkey, F6, [F6]
	Hotkey, IfWinExist, %g_wintitle%
	Hotkey, #v, 			【复制其他窗口选中的内容到飞扬小字典】
	Hotkey, ^!+2, 			【粘贴到飞扬小字典KeyValue辑框】, on
	Hotkey, ^!+3, 			【粘贴为飞扬小字典KeyValue框的注释】, on
	Hotkey, ^!+1, 			【粘贴到飞扬小字典KeyName框】, on
	
	hotkey, ins & home, 	【复制其他窗口选中的内容到字典的搜索框中】
	Hotkey, ins & PGUP, 	【复制其他窗口选中的内容到字典的KeyValue框中】
	Hotkey, ins & PGDN, 	【复制其他窗口中的内容到KeyValue框末尾作为注释】
	Hotkey, NumpadPgup,		【复制其他窗口中的内容到KeyValue框末尾作为注释】
	Hotkey, NumpadHome, 	【复制其他窗口选中的内容到字典的搜索框中搜索】
	Hotkey, NumpadUp,		【从其他窗口复制选中内容到我的小字典的KeyValue框中】
	Hotkey, !c,				【批量添加选中的内容到我的小字典】
	Hotkey, NumpadLeft,		【复制其他窗口选中的内容_转化为大写后粘贴到字典的搜索框中】
	Hotkey, NumpadClear,	【复制其他窗口选中的内容_作为注释添加到KeyValue框末尾并自动添加】
Return


【字典编辑框】:
	Gui submit, nohide
	
	var_curInput := _INIFILE
	if var_curInput =
	{
		Control HideDropDown, , ComboBox2, 
	}
	if (var_preInput == var_curInput)
	{
		return
	}
	var_preInput := var_curInput
	
	;;___显示输入内容所对应的具体内容________________________________________

	ifinstring var_preInput, .dic
	{
		SetIniFile( _INIFILE )
		ControlGetText, g_CurDict, Edit4, %g_WINTITLE%
		LV_Delete()
		IfExist %g_CurDict%
		{
			GoSub 【重新加载字典】
			Control HideDropDown, , ComboBox2, 
			GuiControl,,_INIFILE, |
			GuiControl,,_INIFILE, %g_DICTLIST%			
			GuiControl, Text, _INIFILE, %var_curInput%
		}
		return
	}
	else
	{
		findList := ∑生成下拉列表( var_curInput )
		if ( g_preList == findList )
		{
			return
		}
		g_preList := findList

		;;___显示下拉列表________________________________________________________
		Control HideDropDown, , ComboBox2, 
		GuiControl,,_INIFILE, |
		if findList <>
		{	
			GuiControl,,_INIFILE, %findList%
			Control ShowDropDown, , ComboBox2, %g_wintitle%
		;	ControlFocus,  Edit1, %g_wintitle%
		}
		else
		{
			GuiControl,,_INIFILE, %var_strList%
		}
		GuiControl, Text, _INIFILE, %var_curInput%
		send {end}

	}
	

	RETURN


【KeyNameEdit】:
	if g_bAutoSearch
	{
		Gui submit, nohide
		GuiControl, Text, _KeyValue,
	;	ControlSetText Edit2, , %g_WINTITLE% 	;; 清空Value框
		GoSub 【搜索KeyName】
	}
	RETURN

【SectionEdit】:
	if g_bAutoSearch
	{
		Gosub 【搜索KeyName】
	}
	RETURN

【KeyValueEdit】:
	if not g_bAutoSearch
		RETURN
	LV_Modify( 0, "-Select")
	Gui submit, nohide
	if _KeyValue <>
	{
		nNum := 0
		LOOPs := LV_GetCount()
		LOOP %LOOPs%
		{
			LV_GetText( var_temp, a_Index, 3 )
			IfInString var_temp, %_KeyValue%
			{
				nNum++
                LV_Modify( a_Index, "Select")   ;; 选中搜索到的行
				if ( nNum == 1 )
				{
                    LV_Modify( a_Index, "Vis")  ;; 滚动垂直滚动条，定位到第一个找到的行
				}
			}
		}
	}
	RETURN

【隐藏左侧栏】:
	g_HideSection := !g_HideSection
	∑重新绘制窗口()
	return

【减小左侧栏宽度】:
	g_SecEditWidth -= 20
	if g_SecEditWidth < 80 
		g_SecEditWidth := 50
	∑重新绘制窗口()
	return

【增加左侧栏宽度】:
	g_SecEditWidth += 20
	if g_SecEditWidth > a_guiwidth * 2 / 3
		g_SecEditWidth := a_guiwidth * 2 / 3
	∑重新绘制窗口()
	return

【设置左侧栏宽度】:
	gui submit, nohide
	if _section is digit
		if ( _section > 80 && _section < a_screenwidth / 2 )
		{
			g_SecEditWidth := _section
			∑重新绘制窗口()
		}
	return

∑重新绘制窗口()
{	
	global
	WinGetPos , , , width, , %g_WinTitle%
	WinMove, %g_WinTitle%, , , , width + 1
	WinMove, %g_WinTitle%, , , , width
}


∑生成下拉列表( curInput_ )
{
	global g_DICTLIST
	loop, parse, g_DICTLIST, |
	{
		if a_loopfield =
			continue

		ifinstring a_loopfield, %curInput_%
			if newlist =
				newlist := a_loopfield
			else
				newlist = %newlist%|%a_loopfield%
	}
	if newlist =
		newlist := g_DICTLIST
	return newlist
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#include .\bin\Dict\dict_menu.aik
#include .\bin\Dict\dict_function.aik
#Include .\bin\Dict\dict_lables2.aik

#include .\inc\listview\LVA.aik
#include .\inc\listview\lvfunc.aik
#include .\inc\Array.aik
#include .\inc\inifile.aik
#include .\inc\string.aik
#include .\inc\tip.aik
#include .\inc\window.aik
#include .\SubUI\20MuiltiBox.aik

::{rtf::
::\rtf::
::/rtf::
	var_temp = `/`*%g_RICHTEXTHEAD%`*`/
	sendbyclip( var_temp )
	return
