; <COMPILER: v1.0.48.5>
#NoTrayIcon
; #include ..\..\

change_icon()


g_title = 日志查看器
g_fileName = %1%
g_fileSize = 0
g_fileData =
g_view =
g_statustip =
g_VarPrefix = g_var_

g_curPage = 1
g_PageLines = 100
g_PageNum = 1
g_PageSource = raw

ADD_FILE_PRE = 【追加文件】
ADD_FILE_LINE = +++++++++++++++++++++++++++++++++++++++++++++

g_PageLableList = 176,216,256,296,336,376,416,456,496,536
StringSplit g_XArray, g_PageLableList, `,



g_LVTitle = $变量名|L左边字符|R右边字符|保留条件|过滤条件
g_GuiID =
g_lvOptions =  x410 y40 w321 h110 r30
EnableSingleClick = 1
LV_ED = Edit12
LV_ST = Static26



Menu, MyContextMenu, Add, 复制(&C),  【右键复制】
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, 复制->过滤条件->保留框(&R),  【复制到过滤条件保留框】
Menu, MyContextMenu, Add, 复制->过滤条件->过滤框(&F),  【复制到过滤条件过滤框】
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, 复制->求最值->变量左边(&1),  【复制到求最值变量左边】
Menu, MyContextMenu, Add, 复制->求最值->变量右边(&2),  【复制到求最值变量右边】
Menu, MyContextMenu, Add, 复制->求最值->包含条件(&3),  【复制到求最值包含条件】
Menu, MyContextMenu, Add, 复制->求最值->过滤条件(&4),  【复制到求最值过滤条件】
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, 复制->表达式->开始条件(&5), 【循环开始条件】
Menu, MyContextMenu, Add, 复制->表达式->变量名称(&6), 【添加变量的名称】
Menu, MyContextMenu, Add, 复制->表达式->左边字符(&7), 【添加变量的左边字符】
Menu, MyContextMenu, Add, 复制->表达式->右边字符(&8), 【添加变量的右边字符】
Menu, MyContextMenu, Default, 复制(&C)



gui +resize
Gui, Add, Edit, x6 y190 w741 h336 v_MyEdit,
Gui, Add, StatusBar,, 状态栏


Gui, Add, Text, x10 y168 w50 h20 +Center v_lblSource, 原始内容
Gui, Add, Button, x66 y165 w50 h20 	g【上一页】, 上一页
Gui, Add, Button, x116 y165 w50 h20	g【下一页】, 下一页
Gui, Add, Text, x%g_XArray1% y168 w30 h20 +Center  v_lbl1 	g【Page1】, 1
Gui, Add, Text, x%g_XArray2% y168 w30 h20 +Center  v_lbl2 	g【Page2】, 2
Gui, Add, Text, x%g_XArray3% y168 w30 h20 +Center  v_lbl3 	g【Page3】, 3
Gui, Add, Text, x%g_XArray4% y168 w30 h20 +Center  v_lbl4 	g【Page4】, 4
Gui, Add, Text, x%g_XArray5% y168 w30 h20 +Center  v_lbl5 	g【Page5】, 5
Gui, Add, Text, x%g_XArray6% y168 w30 h20 +Center  v_lbl6 	g【Page6】, 6
Gui, Add, Text, x%g_XArray7% y168 w30 h20 +Center  v_lbl7 	g【Page7】, 7
Gui, Add, Text, x%g_XArray8% y168 w30 h20 +Center  v_lbl8 	g【Page8】, 8
Gui, Add, Text, x%g_XArray9% y168 w30 h20 +Center  v_lbl9 	g【Page9】, 9
Gui, Add, Text, x%g_XArray10% y168 w30 h20 +Center  v_lbl10 g【Page10】, 10
Gui, Add, Button, x576 y165 w50 h20 g【上十页】, 上十页
Gui, Add, Button, x626 y165 w50 h20 g【下十页】, 下十页
Gui, Add, Text, x676 y168 w100 h20 +Center  v_lblAllPage, 总页数
Gui, Add, Text, x576 y168 w30 h15 +Center  v_lblCur  +Border cBlue , Search




Gui, Add, Tab2, x6 y10 w741 h150 v_MyTab, 【首页】|过滤条件|求最值|表达式|计算器|配置|帮助
Gui, Tab, 【首页】
Gui, Add, Button, x26 y45 	w100 h30 v_btn_OpenFile	g【打开】, 打  开
Gui, Add, Button, x136 y45 w100 h30	 v_btn_AddFile	g【追加文件】, 追加文件

Gui, Add, Button, x26 y80 	w100 h30 v_btn_SaveFile g【另存为】, 另存为
Gui, Add, Button, x136 y80 	w100 h30 v_btn_Clear	g【清空内容】, 清空内容

Gui, Add, Button, x26 y115 	w70 h30  g【查看原始内容】, 原始内容
Gui, Add, Button, x96 y115 	w70 h30  g【查看处理内容】, 缓存内容
Gui, Add, Button, x166 y115 w70 h30  g【查看临时缓存】, 临时缓存

Gui, Add, Text, x250 y32 w90 h15, 文件列表
Gui, Add, ListBox, x250 y45 w481 h110 v_MyListbox


Gui, Tab, 过滤条件
Gui, Add, Text, x16 y35 w280 v_lblRe, 要保留的内容
Gui, Add, Edit, x16 y50 w298 h100 	v_edtRe,
Gui, Add, Text, x438 y35 w300 v_lblFi, 要过滤的内容
Gui, Add, Edit, x438 y50 w298 h100 	v_edtFi, %ADD_FILE_PRE%`r`n%ADD_FILE_LINE%
Gui, Add, Button, x338 y45 w80 h25 	v_btnFile 	g【查看原始内容】, 　还原　
Gui, Add, Button, x338 y70 w80 h25 	v_btnRe 	g【仅保留包含指定内容的行】, ＜查找　
Gui, Add, Button, x338 y95 w80 h25 	v_btnBoth 	g【保留与过滤按钮同时生效】, ＜同时＞
Gui, Add, Button, x338 y120 w80 h25 v_btnFi 	g【过滤包含指定内容的行】, 　过滤＞

Gui, Tab, 求最值
Gui, Add, Text, x350 y65 w40 h20 , <变量>
Gui, Add, Text, x16 y40 w310 h20 , 变量左边的字符
Gui, Add, Text, x396 y40 w310 h20 +Right, 变量右边的字符
Gui, Add, Text, x345 y95 w48 h20 , 过滤条件
Gui, Add, Text, x16 y95 w48 h20 , 包含条件
Gui, Add, Edit, x396 y60 w320 h23 v_mmRight,
Gui, Add, Edit, x16 y60 w320 h23 v_mmLeft,
Gui, Add, Edit, x66 y90 w270 h23 v_mmRe,
Gui, Add, Edit, x396 y90 w320 h23 v_mmFi,

Gui, Add, Text, x105 y130 w10 h20 , 前
Gui, Add, Edit, x120 y125 w100 h23 v_mmBefore,
Gui, Add, Text, x505 y130 w10 h20 , 后
Gui, Add, Edit, x520 y125 w100 h23 v_mmAfter,

Gui, Add, Button, x235 y120 w100 h30 v_btn_FindMax 	g【查找最大值】, 查找最大值
Gui, Add, Button, x395 y120 w100 h30 v_btn_FindMin	g【查找最小值】, 查找最小值
Gui, Add, Button, x16 y122 w50 h26  g【求最值帮助】, 帮助
Gui, Add, CheckBox, x650 y120 w90 h30 v_mm_bFileData, 使用原始数据

Gui, Tab, 表达式
Gui, Add, Edit, x76 y40 w300 h25 v_expStart
Gui, Add, Edit, x76 y80 w300 h25 v_express
Gui, Add, Text, x16 y43 w50 h20 +Right , 开始条件
Gui, Add, Text, x16 y83 w50 h20 , 表达式

Gui, Add, Button, x76 y120 w90 h30 	v_btn_express 	g【求满足表达式的数据】, 表达式
Gui, Add, Button, x176 y120 w90 h30 v_btn_expmax  	g【显示表达式最大值的记录】, 最大值
Gui, Add, Button, x276 y120 w90 h30 v_btn_expmin 	g【显示表达式最小值的记录】, 最小值
Gui, Add, Button, x16 y122 w50 h26 	g【表达式帮助】, 帮助







SysGet,SM_CXVSCROLL,2

if g_lvOptions =
	g_lvOptions = r20 w525

EditingLV = SysListView321

LVS_SINGLESEL = 0x4
LVS_SHOWSELALWAYS = 0x8
LVS_EX_FULLROWSELECT = LV0x20

listOptions =
   (Join`s LTrim
      +AltSubmit
      -Checked
      -%LVS_EX_FULLROWSELECT%
      -%LVS_SHOWSELALWAYS%
      +%LVS_SINGLESEL%
   )

AutoTrim,Off
DetectHiddenWindows,On
Gui,+LastFound
g_GuiID := WinExist()
GroupAdd,editKeypress,ahk_id %g_GuiID%
Gui, Add, ListView, %g_lvOptions% %listOptions% v_MyListView g【点击MyListView】,%g_LVTitle%
Gui, Add, Edit, x0 y-50 vCellEdit g【通过Edit实时修改MyListView对应单元格的值】
Gui, Add, Text, x0 y-50 vCellHighlight +Border cBlue -Wrap
ControlGetPos,lx,ly,lw,lh,%EditingLV%,ahk_id %g_GuiID%

; #include .\inc\listview\guiaddeditListView.aik

Gui, Add, Text, x400 y15 w340 h20
Gui, Add, Text, x400 y10 w10 h23 , $
Gui, Add, Text, x482 y10 w10 h23 , L
Gui, Add, Text, x572 y10 w10 h23 , R
Gui, Add, Edit, x410 y10 w70 h23 	v_expVar, 变量名
Gui, Add, Edit, x490 y10  w80 h23 	v_expL
Gui, Add, Edit, x580 y10  w80 h23 	v_expR
Gui, Add, Button, x665 y10 w33 h25 g【ListView中增加变量】, 增
Gui, Add, Button, x697 y10 w33 h25 g【删除ListView选中的变量】, 删


Gui, Tab, 计算器
Gui, Add, Text, x120 y35 w280 , 请输入计算内容：
Gui, Add, Edit, x120 y50 w610 h100 	v_edtCalc
Gui, Add, Button, x16 y60 w100 h50  g【开始计算】, 计   算
Gui, Add, Button, x16 y122 w50 h26 	g【计算器帮助】, 帮助
Gui, Add, Button, x66 y122 w50 h26 	g【清空计算器】, 清空

Gui, Tab, 配置
Gui, Add, Button, x26 y45 w90 h30  g【加载配置】, 加载配置
Gui, Add, Button, x136 y45 w90 h30 g【保存配置】, 保存配置

Gui, Add, Button, x26 y80 w90 h30   g【刷新配置】, 刷新配置
Gui, Add, Button, x136 y80 w90 h30  g【删除配置】, 删除配置

Gui, Add, Text, x60 y125 w70 h30 +Right	, 每页行数
Gui, Add, Edit,  x135 y120 w90 h25   vg_PageLines g【每页显示行数】, %g_PageLines%

Gui, Add, ListBox, x250 y45 w481 h110 v_CfgListbox g【配置ListBox响应】
Gui, Add, Button, x26 y120 w50 h26  g【配置帮助】, 帮助

Gui, Tab, 帮助
Gui, Add, Button, x26 y45 w90 h30 	g【简介】, 简  介
Gui, Add, Button, x116 y45 w90 h30 	g【首页帮助】, 首页帮助?
Gui, Add, Button, x206 y45 w90 h30 	g【过滤条件帮助】, 过滤条件?
Gui, Add, Button, x296 y45 w90 h30 	g【求最值帮助】, 求最值?
Gui, Add, Button, x386 y45 w90 h30 	g【表达式帮助】, 表达式?
Gui, Add, Button, x476 y45 w90 h30 	g【计算器帮助】, 计算器?
Gui, Add, Button, x566 y45 w90 h30 	g【配置帮助】, 配  置?

InitPage( 1, g_curPage )

Gui, Show, h556 w756, %g_title%



if g_fileName =
{
	gosub 【首页帮助】
}
else
{
	ClearRawArray()
	OpenFile( g_fileName )
}

gosub 【刷新配置】

Return



GuiClose:
ExitApp


GuiSize:

	GuiControlGet, EditPos, Pos, _MyEdit
	width := A_GuiWidth - 15
	edt_height := a_GuiHeight - 30 - EditPosY
	if edt_height < 10
		edt_height = 10

	GuiControl, MoveDraw, _MyTab, w%width%
	GuiControl, MoveDraw, _MyEdit, w%width% h%edt_height%


	width := A_GuiWidth - 25 - 250
	GuiControl, MoveDraw, _MyListbox, w%width%

	GuiControl, MoveDraw, _CfgListbox, w%width%


	width := A_GuiWidth - 25 - 410
	GuiControl, MoveDraw, _MyListView, w%width%


	re_left := A_GuiWidth/2 - 40
	GuiControl, MoveDraw, _btnRe, x%re_left%
	GuiControl, MoveDraw, _btnBoth, x%re_left%
	GuiControl, MoveDraw, _btnFi, x%re_left%
	GuiControl, MoveDraw, _btnFile, x%re_left%

	re_width := A_GuiWidth/2 - 80
	GuiControl, MoveDraw, _edtRe, w%re_width%

	fi_left := re_left + 100
	GuiControl, MoveDraw, _edtFi, x%fi_left% w%re_width%
	GuiControl, MoveDraw, _lblFi, x%fi_left%


	width := A_GuiWidth - 25 - 120
	GuiControl, MoveDraw, _edtCalc, w%width%

	gosub 【调整ListView大小】

	return


GuiContextMenu:

	if A_GuiControl = _MyEdit
	{
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	return


GuiDropFiles:

	if A_GuiControl = _MyEdit
	{
		Loop, parse, A_GuiEvent, `n
		{
		    FirstFile = %A_LoopField%
		    Break
		}
		if FirstFile <>
		{
			ClearRawArray()
			OpenFile( FirstFile )
		}
	}

	else if A_GuiControl = _MyListBox
	{
		Loop, parse, A_GuiEvent, `n
		{
		    ifexist %A_LoopField%
		    {
		    	AddFile( A_LoopField )
		    }
		}
	}
	return



【打开】:
	FileSelectFile, g_fileName, 3, %A_WorkingDir%, 打开文本文件, Text Documents (*.txt; *.log )
	if g_fileName =
	{
		return
	}
	ClearRawArray()
	OpenFile( g_fileName )
	return

【追加文件】:
	FileSelectFile, g_fileName, 3, %A_WorkingDir%, 打开文本文件, Text Documents (*.txt; *.log )
	if g_fileName =
	{
		return
	}
	AddFile( g_fileName )
	return

【另存为】:
	gui, submit, nohide

	if g_PageSource = raw
	{
		if g_rawArray0 = 0
		{
			msgbox 原始内容为空，无法保存！
			return
		}
	}
	else if g_PageSource = view
	{
		if g_viewArray0 = 0
		{
			msgbox 缓存内容为空，不能保存！
			return
		}
	}
	else if g_PageSource = temp
	{
		if g_tempArray0 = 0
		{
			msgbox 临时缓存内容为空，无法保存！
			return
		}
	}
	else
	{
		msgbox 当前没有数据来源，保存失败！
		return
	}

	FileSelectFile, fileName, S16, %A_WorkingDir%, 打开文本文件, Text Documents (*.txt; *.log )
	if fileName =
		return

	ifexist %fileName%
	{
		msgbox 4, 替换文件, `"%fileName%`" 已经存在`n`n是否替换?
		ifmsgbox no
		{
			return
		}
		FileDelete %fileName%
	}
	SB_SetText( "正在保存内容到文件 " . filename . " ......" )
	GuiControl, Disable, _MyTab
    SaveArrayToFile( g_PageSource, fileName )
	GuiControl, Enable, _MyTab
	SB_SetText("")
	return


【查看原始内容】:

	SB_SetText("准备显示文件的原始内容...")
	ShowRawPage( 1 )
	SB_SetText("")
	return

【查看处理内容】:
	SB_SetText("正在准备显示处理后的内容...")
	ShowViewPage( 1 )
	SB_SetText("")
	return

【查看临时缓存】:
	SB_SetText("正在准备临时缓存的内容...")
	ShowTempPage( 1 )
	SB_SetText("")
	return

【清空内容】:
	SB_SetText("正在清空内容...")
	Init()
	GuiControl, Text, _MyEdit, %g_view%
	guicontrol, , _MyListBox, |
	SB_SetText("")
	return

【仅保留包含指定内容的行】:
	g_view =
	SB_SetText("正在执行【查找】按钮，仅保留包含指定内容的行...")
	GuiControl, Disable, _btnRe
	GuiControl, Disable, _btnBoth
	GuiControl, Disable, _btnFi
	gui submit, nohide
    JustFind()
    ShowViewPage( 1 )
	GuiControl, Enable, _btnRe
	GuiControl, Enable, _btnBoth
	GuiControl, Enable, _btnFi
	SB_SetText("")
	return

【保留与过滤按钮同时生效】:
	g_view =
	SB_SetText("正在执行【同时】按钮，【保留】和【过滤】按钮将同时生效...")
	GuiControl, Disable, _btnRe
	GuiControl, Disable, _btnBoth
	GuiControl, Disable, _btnFi
	gui submit, nohide
	FindFilt( )
    ShowViewPage( 1 )
	GuiControl, Enable, _btnRe
	GuiControl, Enable, _btnBoth
	GuiControl, Enable, _btnFi
	SB_SetText("")
	return


【过滤包含指定内容的行】:
	g_view =
	gui submit, nohide
	SB_SetText("正在执行【过滤】按钮，将过滤掉指定内容的行...")
	GuiControl, Disable, _btnRe
	GuiControl, Disable, _btnBoth
	GuiControl, Disable, _btnFi
    JustFilt()
    ShowViewPage( 1 )
	GuiControl, Enable, _btnRe
	GuiControl, Enable, _btnBoth
	GuiControl, Enable, _btnFi
	SB_SetText("")
	return





【配置ListBox响应】:
	if A_GuiEvent = DoubleClick
	{
		gosub 【加载配置】
	}
	else if A_GuiEvent = Normal
	{

	}
	return


【刷新配置】:
	GuiControl, , _CfgListbox, |
	read_sec( var_cfglines, "temp.ini", "日志查看器", false, false )
	loop parse, var_cfglines, `n
	{
		if a_loopfield =
			continue

		StringReplace line, a_loopfield, |, ★, All
		GuiControl, , _CfgListbox, %line%
	}
	return

【加载配置】:
	Gui, submit, nohide
	ifinstring _CfgListBox, =
	{
		StringReplace line, _CfgListBox, ★, |, All
		line := StrRight2Sub( line, "=" )
		if ParseCFGLine( line )
			msgbox 配置加载成功！
		else
			msgbox 配置加载失败！
	}
	else
	{
		KeyName := myinput( "配置名称", "请指定你要加载的配置名称：" )
		if KeyName =
			return

		var_Read := ReadTempIni("日志查看器", KeyName, "" )
		if var_Read =
			msgbox %KeyName% 不存在！
		else
			ParseCFGLine( var_Read )

	}
	return

【删除配置】:
	Gui, submit, nohide
	ifinstring _CfgListBox, =
	{
		line := _CfgListBox
		line := StrLeft2Sub( line, "=" )
		msgbox 4, 确定删除配置, 确定要删除配置[%line%]吗？
		ifmsgbox no
		{
			return
		}
		if line <>
		{
			if del_ini( "temp.ini", "日志查看器", line, false )
				msgbox 配置[%line%]删除成功！
			else
				msgbox 配置[%line%]删除失败！
			gosub 【刷新配置】
		}
		else
		{
			msgbox 缺少配置名称！
		}
	}
	else
	{
		msgbox 没有选中配置！
	}
	return

【保存配置】:
	KeyName := myinput( "配置名称", "当前配置保存成什么名称？" )
	if KeyName =
		return

	var_Read := ReadTempIni("日志查看器", KeyName, "" )
	if var_read <>
	{

		msgbox 4, 配置名重复, 输入的配置名称<%KeyName%>已经存在，`n`n%keyName% = %var_read%`n`n是否要替换之?
		if msgbox no
		{
			return
		}
	}

	var_cfg := CreateCurCFG()


	read_sec( _OutSections, "temp.ini", "日志查看器" , false, false )
	loop parse, _OutSections, `n
	{
		if a_loopfield =
			continue
		pos := instr( a_loopfield, "=" )
		if ( pos > 0 )
		{
			StringMid KeyValue, a_loopfield, pos+1
			if ( KeyValue == var_cfg && KeyValue != "" )
			{
				msgbox 4, 重复配置, 当前配置在配置文件中已经存在!`n`n%a_loopfield%`n`n是否还要添加？
				ifmsgbox no
					return
				break
			}
		}
	}
	WriteTempIni("日志查看器", KeyName, var_cfg )
	gosub 【刷新配置】
	return


【开始计算】:
	gui, submit, nohide
	if _edtCalc =
	{
		GuiControl, Text, _MyEdit, 请在上面的编辑框里输入要运算的内容！
		GuiControl Focus, _edtCalc
	}
	else
	{
		var_buf := CalcText( _edtCalc )
		GuiControl, Text, _MyEdit, %var_buf%
	}
	return

【清空计算器】:
	guicontrol text, _edtCalc
	guicontrol text, _myedit
	return

【每页显示行数】:
	gui, submit, nohide
	ShowPage( g_PageSource, 1 )
	return


【Page1】:
	GuiControlGet, nPage , , _lbl1
	ShowPage( g_PageSource, nPage )
	return
【Page2】:
	GuiControlGet, nPage , , _lbl2
	ShowPage( g_PageSource, nPage )
	return
【Page3】:
	GuiControlGet, nPage , , _lbl3
	ShowPage( g_PageSource, nPage )
	return
【Page4】:
	GuiControlGet, nPage , , _lbl4
	ShowPage( g_PageSource, nPage )
	return
【Page5】:
	GuiControlGet, nPage , , _lbl5
	ShowPage( g_PageSource, nPage )
	return
【Page6】:
	GuiControlGet, nPage , , _lbl6
	ShowPage( g_PageSource, nPage )
	return
【Page7】:
	GuiControlGet, nPage , , _lbl7
	ShowPage( g_PageSource, nPage )
	return
【Page8】:
	GuiControlGet, nPage , , _lbl8
	ShowPage( g_PageSource, nPage )
	return
【Page9】:
	GuiControlGet, nPage , , _lbl9
	ShowPage( g_PageSource, nPage )
	return
【Page10】:
	GuiControlGet, nPage , , _lbl10
	ShowPage( g_PageSource, nPage )
	return

【上一页】:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage - 1 )
	return

【下一页】:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage + 1 )
	return

【上十页】:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage - 10 )
	return

【下十页】:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage + 10 )
	return

g_PageNum = 0



InitPage( var_lineCount, byref _curPage )
{
	global

	if var_lineCount < 1
		var_lineCount = 1


	g_PageNum := 1 + var_lineCount // g_PageLines
	if ( _curPage > g_PageNum )
	{
		_curPage := g_PageNum
	}

	GuiControl , text, _lblAllPage, %_curPage% / %g_PageNum%


	GuiControlGet, nPage , , _lblCur


	nHilight := ( nPage - 1 ) // 10
	nCur := ( _curPage - 1 ) // 10
	nAll := ( g_PageNum - 1 ) // 10


	loops := 10
	if ( nCur == nAll )
	{
		loops := 1 + mod( (g_PageNum - 1 ), 10 )
	}


	GuiControl , text, _lblCur, %_curPage%
	xCur := 1 + mod( (_curPage-1), 10 )
	if xCur < 1
		xCur = 1
	if xCur > 10
		xCur = 10
	xCur := g_XArray%xCur%
	GuiControl, MoveDraw, _lblCur, x%xCur%




	loop %loops%
	{
		var_temp := nCur * 10 + a_index
		GuiControl, , _lbl%a_index%, %var_temp%
		GuiControl, show, _lbl%a_index%
	}


	loops := 10 - loops
	loop %loops%
	{
		index := 10 - a_index + 1
		var_temp := nCur * 10 + index
		GuiControl, hide, _lbl%index%
	}
}

SetPage( var_source, byref var_curpage )
{
	global

	if var_source =
	 	var_source := g_PageSource

	if ( var_curpage < 1 )
		var_curpage := 1

	if var_source = raw
	{
		g_PageSource = raw
		GuiControl, text, _lblSource, 原始内容
		InitPage( g_rawArray0, var_curpage )
	}
	else if var_source = view
	{
		g_PageSource = view
		GuiControl, text, _lblSource, 缓存内容
		InitPage( g_viewArray0, var_curpage )
	}
	else if var_source = temp
	{
		g_PageSource = temp
		GuiControl, text, _lblSource, 临时缓存
		InitPage( g_tempArray0, var_curpage )
	}
}

ShowPage( var_source, var_curpage )
{
	if var_source = raw
	{
		ShowRawPage( var_curpage )
	}
	else if var_source = view
	{
		ShowViewPage( var_curpage )
	}
	else if var_source = temp
	{
		ShowTempPage( var_curpage )
	}
}

ShowRawPage( var_page )
{
	global

	SetPage( "raw", var_page )

	local var_loops, var_buff, start, var_end

	start := 1 + g_PageLines * ( var_page - 1 )
	if ( start > g_rawArray0 )
	{
		start := 1
		g_rawCurPage := 0
	}
	var_end   := start + g_PageLines
	if ( var_end > g_rawArray0 )
	{

		var_end := g_rawArray0
	}
	else
	{

	}
	var_buff =
	var_loops := var_end - start + 1
	loop %var_loops%
	{
		index := start + a_index - 1
		var_line := g_rawArray%index%
		var_buff = %var_buff%%var_line%`r`n
	}
	GuiControl, -Redraw, _MyEdit
	GuiControl, Text, _MyEdit, %var_buff%
	GuiControl, +Redraw, _MyEdit
	var_buff =
}

ShowViewPage( var_page)
{
	global

	SetPage( "view", var_page )

	local var_loops, var_buff
	start := 1 + g_PageLines * ( var_page - 1 )
	if ( start > g_viewArray0 )
	{
		start := 1
		g_viewCurPage := 1
	}
	end   := start + g_PageLines
	if ( end > g_viewArray0 )
	{
		end := g_viewArray0
	}
	var_buff =
	var_loops := end - start + 1
	loop %var_loops%
	{
		index := start + a_index - 1
		var_line := g_viewArray%index%
		var_buff = %var_buff%%var_line%`r`n
	}
	GuiControl, -Redraw, _MyEdit
	GuiControl, Text, _MyEdit, %var_buff%
	GuiControl, +Redraw, _MyEdit
	var_buff =
}

ShowTempPage( var_page )
{
	global

	SetPage( "temp", var_page )

	local var_loops, var_buff
	start := 1 + g_PageLines * ( var_page - 1 )
	if ( start > g_tempArray0 )
	{
		start := 1
		g_viewCurPage := 1
	}
	end   := start + g_PageLines
	if ( end > g_tempArray0 )
	{
		end := g_tempArray0
	}
	var_buff =
	var_loops := end - start + 1
	loop %var_loops%
	{
		index := start + a_index - 1
		var_line := g_tempArray%index%
		var_buff = %var_buff%%var_line%`r`n
	}
	GuiControl, -Redraw, _MyEdit
	GuiControl, Text, _MyEdit, %var_buff%
	GuiControl, +Redraw, _MyEdit
	var_buff =
}

ShowTempText( byref var_lines )
{
	global
	g_tempArray0 = 0
	loop parse, var_lines, `n
	{
		g_tempArray0++
		g_tempArray%g_tempArray0% := a_loopfield
	}
	ShowTempPage( 1 )
}


SetTempArrayByLine( var_source, lineIdx, nBefore, nAfter )
{
	global
	ClearTempArray( )
	if lineIdx is integer
	{
		if lineIdx >= 1
		{
			start := lineIdx
			end := lineIdx
			if nBefore is integer
			{
				if nBefore > 0
				{
					start := lineIdx - nBefore
					if start < 1
						start := 1
				}
			}
			if nAfter is integer
			{
				if nAfter > 0
				{
					end := lineIdx + nAfter
				}
			}
			if var_source = raw
			{
				if ( end > g_rawArray0 )
					 end := g_rawArray0

				loops := end - start + 1
				loop %loops%
				{
					index := start + a_index - 1
					if ( index == lineIdx && end > start )
					{
						TempArrayPushBack( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" )
						TempArrayPushBack( g_rawArray%index% )
						TempArrayPushBack( "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" )
					}
					else
						TempArrayPushBack( g_rawArray%index% )
				}
			}
			else if var_source = view
			{
				if ( end > g_viewArray0 )
					 end := g_viewArray0

				loops := end - start + 1
				loop %loops%
				{
					index := start + a_index - 1
					if ( index == lineIdx && end > start )
					{
						TempArrayPushBack( ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" )
						TempArrayPushBack( g_viewArray%index% )
						TempArrayPushBack( "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" )
					}
					else
						TempArrayPushBack( g_viewArray%index% )
				}
			}
		}
	}
}
; #include .\bin\文本文件处理\日志查看器_页数管理.aik

【查找最大值】:
	gui submit, nohide
	SB_SetText("正在查找变量值最[大]的行。。。")
	GuiControl, Disable, _btn_FindMax
	GuiControl, Disable, _btn_FindMin
	lineIndex := ∑检查最大最小值( 1 )
	if _mm_bFileData
		SetTempArrayByLine( "raw", lineIndex, _mmBefore, _mmAfter )
	else
		SetTempArrayByLine( "view", lineIndex, _mmBefore, _mmAfter )
	ShowTempPage( 1 )
	GuiControl, Enable, _btn_FindMax
	GuiControl, Enable, _btn_FindMin
	SB_SetText( g_statustip )
	g_statustip =
	return


【查找最小值】:
	gui submit, nohide
	SB_SetText("正在查找变量值最<小>的行。。。")
	GuiControl, Disable, _btn_FindMax
	GuiControl, Disable, _btn_FindMin
	lineIndex := ∑检查最大最小值( 0 )
	if _mm_bFileData
		SetTempArrayByLine( "raw", lineIndex, _mmBefore, _mmAfter )
	else
		SetTempArrayByLine( "view", lineIndex, _mmBefore, _mmAfter )
	ShowTempPage( 1 )
	GuiControl, Enable, _btn_FindMax
	GuiControl, Enable, _btn_FindMin
	SB_SetText( g_statustip )
	g_statustip =
	return

∑检查最大最小值( bMax )
{

	global
	local var_max = -9999999999999999
	local var_min = 9999999999999999
	local var_maxline =
	local var_minline =
	g_statustip =

	if ( g_rawArray0 <= 0  )
	{
		msgbox 尚未加载文件数据！
		return false
	}
	if ( _mm_bFileData == false && g_viewArray0 <= 0 )
	{
		msgbox 处理后的数据为空！`n是没有过滤数据或处理数据？`n还是忘记勾选【原始数据】复选框？
		return false
	}
	if ( _mmLeft == "" && _mmRight == "" )
	{
		msgbox 没有指定变量前后的字符
		return false
	}
	var_index = 0
	if _mm_bFileData
	{
		Loop %g_rawArray0%
		{
			line := g_rawArray%a_index%
			if line =
				continue


			var_re := GetVarFromLine( line, _mmLeft, _mmRight, _mmRe, _mmFi )
			if var_re is not number
				continue
			if var_re
			{
				if bMax > 0
				{
					if ( var_max < var_re )
					{
						var_max := var_re
						var_maxline := line
						var_index := a_index
					}
				}
				else
				{
					if ( var_min > var_re )
					{
						var_min := var_re
						var_minline := line
						var_index := a_index
					}
				}
			}
		}
	}
	else
	{
		Loop %g_viewArray0%
		{
			line := g_viewArray%a_index%

			if line =
				continue


			var_re := GetVarFromLine( line, _mmLeft, _mmRight, _mmRe, _mmFi )
			if var_re is not number
				continue
			if var_re
			{
				if bMax
				{
					if ( var_max < var_re )
					{
						var_max := var_re
						var_maxline := line
						var_index := a_index
					}
				}
				else
				{
					if ( var_min > var_re )
					{
						var_min := var_re
						var_minline := line
						var_index := a_index
					}
				}
			}
		}
	}

	if bMax
	{
		if var_max > -9999999999999999
		{
			g_statustip = 变量最大值为：%var_max%

		}
		else
		{
			g_statustip = 没有找到最大值
			var_index =
		}
	}
	else
	{
		if var_min < 9999999999999999
		{
			g_statustip = 变量最小值为：%var_min%

		}
		else
		{
			g_statustip = 没有找到最小值
			var_index =
		}
	}

	return var_index
}


GetLineVar( var_line, byref var_out )
{
	global
	local var_re =


	if _mmFi <>
	{
		loop parse, _mmFi, |
		{
			if a_loopfield =
				continue

			ifinstring var_line, %a_loopfield%
				return false
		}
	}


	if _mmRe <>
	{
		local bfind := false
		loop parse, _mmRe, |
		{
			if a_loopfield =
				continue
			ifinstring var_line, %a_loopfield%
			{
				bfind := true
				break
			}
		}
		if not bfind
		{
			return false
		}
	}


	if _mmLeft =
	{

		if _mmRight =
			return false

		var_re := strleft2sub( var_line, _mmRight )
	}

	else if _mmRight =
	{
		var_re := strRight2sub( var_line, _mmLeft )
	}

	else
	{
		var_re := strMid2sub( var_line, _mmLeft, _mmRight )
	}

	if var_re =
	{
		return false
	}
	if var is not digit
	{
		return false
	}
	var_out := var_re
	return true
}
; #include .\bin\文本文件处理\日志查看器_最值.aik


#ifwinactive 日志查看器 ahk_class AutoHotkeyGUI
LWin::
^+c::
	clipboard =
	ControlGetFocus, var_FocusControl, 日志查看器 ahk_class AutoHotkeyGUI
	if not ErrorLevel
	{
		send ^c

	    if var_FocusControl = Edit1
		{
			gui submit, nohide
			Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
		}
	}
	return


enter::

	GuiControlGet,fControl,Focus
	If(fControl = DispControl)
	{
		gosub 【修改MyListView单元格并退出编辑状态】
	}

	else
	{
		send {NumpadEnter}
	}
	return

PgUp::
	gosub 【上一页】
	return

PgDn::
	gosub 【下一页】
	return


+PgUp::
	gosub 【上十页】
	return

+PgDn::
	gosub 【下十页】
	return

#ifwinactive


【右键复制】:
	GuiControl, +Redraw, _MyEdit
	return

【复制到过滤条件保留框】:
	if clipboard <>
	{
		if _edtRe =
			var_temp = %clipboard%
		else
			var_temp = %_edtRe%`r`n%clipboard%

		GuiControl, Text, _edtRe, %var_temp%
		GuiControl, Choose, _MyTab, 2
	}
	GuiControl, +Redraw, _MyEdit
	return

【复制到过滤条件过滤框】:
	if clipboard <>
	{
		var_temp = %_edtFi%`r`n%clipboard%
		GuiControl, Text, _edtFi, %var_temp%
		GuiControl, Choose, _MyTab, 2
	}
	GuiControl, +Redraw, _MyEdit
	return

【复制到求最值变量左边】:
	if clipboard <>
	{
		GuiControl, Text,_mmLeft, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

【复制到求最值变量右边】:
	if clipboard <>
	{
		GuiControl, Text,_mmRight, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

【复制到求最值包含条件】:
	if clipboard <>
	{
		GuiControl, Text,_mmRe, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

【复制到求最值过滤条件】:
	if clipboard <>
	{
		GuiControl, Text,_mmFi, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

【循环开始条件】:
	if clipboard <>
	{
		GuiControl, Text,_expStart, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
	GuiControl, +Redraw, _MyEdit
	return

【添加变量的名称】:
	if clipboard <>
	{
		GuiControl, Text,_expVar, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
	GuiControl, +Redraw, _MyEdit
	return

【添加变量的左边字符】:
	if clipboard <>
	{
		GuiControl, Text,_expL, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
	GuiControl, +Redraw, _MyEdit
	return

【添加变量的右边字符】:
	if clipboard <>
	{
		GuiControl, Text,_expR, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
    GuiControl, +Redraw, _MyEdit
	return
; #include .\bin\文本文件处理\日志查看器_快捷键.aik
g_VarNameArray =
g_VarLeftArray =
g_VarRightArray =
g_VarArrayCount =
g_VarPrefix = g_var_


CheckExpSetting()
{
	global
	if g_rawArray0 <= 0
	{
		msgbox 请先打开文本文件！
		return false
	}
	if g_viewArray0 <= 0
	{
		msgbox 请先进行过滤操作！
		return false
	}
	g_VarArrayCount = 0
	gui, submit, nohide
	if _expStart =
	{
		msgbox 请指定循环开始条件！
		return false
	}
	if _express =
	{
		msgbox 请输入表达式!
		return false
	}
	if ( LV_GetCount() <= 0 )
	{
		msgbox 还没有设置任何变量!
		return false
	}
	Loop % LV_GetCount()
	{
	    LV_GetText(var_name, 	A_Index, 1)
	    LV_GetText(var_left, 	a_index, 2)
	    LV_GetText(var_right, 	a_index, 3 )
	    LV_GetText(var_re, 		a_index, 4 )
	    LV_GetText(var_fi, 		a_index, 5 )
	    StrTrim( var_name )
	    if var_name =
	    {
	    	g_VarArrayCount = 0
	    	msgbox 第 %a_index% 行的变量名为空！
	    	return false
	    }
	    if var_left =
	    {
	    	g_VarArrayCount = 0
	    	msgbox 第 %a_index% 行的变量左边的字符为空！
	    	return false
	    }
	    if var_right =
	    {
	    	g_VarArrayCount = 0
	    	msgbox 第 %a_index% 行的变量名右边的字符为空！
	    	return false
	    }

	    if ( equal_first_char( var_name, "$" ) )
	    {
	    	StringReplace, var_name, var_name, $ , g_var_
	    }
	    if g_VarArrayCount > 0
	    {
	    	loop %g_VarArrayCount%
	    	{
	    		if ( g_VarNameArray%a_index% == var_name )
	    		{
	    			g_VarArrayCount = 0
	    			msgbox 第 %a_index% 行的变量名重复！
	    			return false
	    		}
	    	}
	    }
	    g_VarArrayCount++
		g_VarNameArray%g_VarArrayCount% 	:= var_name
		g_VarLeftArray%g_VarArrayCount% 	:= var_left
		g_VarRightArray%g_VarArrayCount% 	:= var_right
		g_VarReArray%g_VarArrayCount%		:= var_re
		g_VarFiArray%g_VarArrayCount%		:= var_fi
	}
	return true
}





CalcExpress( flag )
{
	global




	loop %g_VarArrayCount%
	{
		var_name := g_VarNameArray%a_index%
		%var_name% =
	}

	if ( CheckExpSetting() )
	{
		local var_show
		local var_temp
		local var_buf
		local var_name
		local var_left
		local var_right
		local var_min = 2147483647
		local var_max = -2147483648
		local cur_text =

		local bHaveEmptyVar := false


		ifnotinstring _express, $
		{
			msgbox 4, 没有$符号, 是否忘记在变量名前添加前缀 $ 了?
			ifmsgbox yes
				return
		}

		var_express := _express
		StringReplace, var_express, var_express, $ , g_var_ , ALL


		StringSplit arrStart, _expStart, |

		Loop %g_viewArray0%
		{
			line := g_viewArray%a_index%

			if line =
				continue


			bNewRound := true
			loop %arrStart0%
			{
				var_temp := arrStart%a_index%
				if var_temp =
					continue

				ifnotinstring line, %var_temp%
				{
					bNewRound := false
					break
				}
			}


			if bNewRound
			{



				bHaveEmptyVar := false
				loop %g_VarArrayCount%
				{
					var_name := g_VarNameArray%a_index%
					var_temp := %var_name%
					if var_temp is not number
					{
                        bHaveEmptyVar := true

						break
					}
				}
				if not bHaveEmptyVar
				{

					var_exp := mycalc1( var_express )


					if var_exp is number
					{


						if ( flag == 0 && var_exp != 0 )
						{
							var_show = %var_show%`n----表达式 =【%var_exp%】-------------------------------`n%cur_text%`n
						}
                        else if ( flag == 1 && var_exp > var_max )
						{
							var_max := var_exp
							var_show = ----表达式最大值 =【%var_exp%】-------------------------------`n%cur_text%
						}
                        else if ( flag == 2 && var_exp < var_min )
						{
							var_min := var_exp
							var_show = ----表达式最小值 =【%var_exp%】-------------------------------`n%cur_text%
						}
					}
				}


				cur_text =


				loop %g_VarArrayCount%
				{
					var_name := g_VarNameArray%a_index%
					%var_name% =
				}
			}


			if line =
				break


			loop %g_VarArrayCount%
			{
				var_temp := GetVarFromLine( line, g_VarLeftArray%a_index%, g_VarRightArray%a_index%, g_VarReArray%a_index%, g_VarFiArray%a_index% )
				if var_temp is number
				{
					var_name := g_VarNameArray%a_index%
					%var_name% := var_temp

				}
			}
			cur_text = %cur_text%%line%`n
		}

		bHaveEmptyVar := false
		loop %g_VarArrayCount%
		{
			var_name := g_VarNameArray%a_index%
			var_temp := %var_name%
			if var_temp is not number
			{
                bHaveEmptyVar := true
				break
			}
		}

		if not bHaveEmptyVar
		{
			var_exp := mycalc1( var_express )

			if var_exp is number
			{
                if ( flag == 0 && var_exp != 0 )
				{
					var_show = %var_show%`n----表达式 =【%var_exp%】-------------------------------`n%cur_text%`n
				}
                else if ( flag == 1 && var_exp > var_max )
				{
					var_max := var_exp
					var_show = ----表达式最大值 =【%var_exp%】-------------------------------`n%cur_text%
				}
                else if ( flag == 2 && var_exp < var_min )
				{
					var_min := var_exp
					var_show = ----表达式最小值 =【%var_exp%】-------------------------------`n%cur_text%
				}
			}
		}

		SB_SetText("表达式 查找完毕, 准备显示结果......")
		ShowTempText( var_show )
		var_show =
	}
}

【ListView中增加变量】:
	gui submit, nohide
	if ( _expVar == "" || _expVar == "变量名" )
	{
		msgbox 请先输入变量名!
		return
	}
	if _expL =
	{
		msgbox 请输入变量左边字符!
		return
	}
	if _expR =
	{
		msgbox 请输入变量右边字符!
		return
	}
	if not equal_first_char( _expVar, "$" )
	{
		_expVar = $%_expVar%
	}
	LV_Add("", _expVar, _expL, _expR )
	return

【删除ListView选中的变量】:
	GetLVInfo( g_GuiID, EditingLV, TotalNumOfRows, NumOfRows, topIndex )
	if ( currRow > 0 && currRow <= TotalNumOfRows )
	{
		if ( currRow >= topIndex && currRow <= topIndex + NumOfRows )
		{
			LV_Delete( currRow )
		}
		else
		{
			msgbox 当前行不在显示范围内！
		}
	}
	return


【求满足表达式的数据】:
	SB_SetText("正在查找满足 表达式 的数据......")
	GuiControl, Disable, _btn_express
	CalcExpress( 0 )
	GuiControl, Enable, _btn_express
	SB_SetText("表达式 查找完毕!")
	return

【显示表达式最大值的记录】:
	SB_SetText("正在查找使 表达式最大值 的记录......")
	GuiControl, Disable, _btn_expmax
	CalcExpress( 1 )
	GuiControl, Enable, _btn_expmax
	SB_SetText("最大值查找完毕!")
	return


【显示表达式最小值的记录】:
	SB_SetText("正在查找使 表达式最小值 的记录......")
	GuiControl, Disable, _btn_expmin
	CalcExpress( 2 )
	GuiControl, Enable, _btn_expmin
	SB_SetText("最小值查找完毕!")
	return
; #include .\bin\文本文件处理\日志查看器_表达式.aik


【首页帮助】:
var_help =
(

  欢迎使用 “日志查看器” ！
--------------------------------------


@使用步骤@

1、首先通过【打开】按钮，打开一个文本文件；
2、在“过滤条件”选项卡中，可以过滤和查找内容；
3、数据经过过滤之后，可以根据指定的规则取得变量值，显示包含变量最大或最小值的行；
4、如果有更复杂的需求，进入“表达式”选项卡，这里可以设置多个变量以及更复杂的表达式；



@选项卡说明@

1、首页：加载、保存、维护数据；
2、过滤条件：过滤、查找数据；
3、求最值：指定变量格式，查找包含变量最大或最小值的行；
           需要加载了文本数据后，才能求最值。
4、表达式：可指定多个变量的格式，指定复杂的表达式，
           查找并显示使得表达式成立的所有数据；
           查找并显示使表达式最大或最小值的相关数据；
           需要加载并过滤了数据之后，方可操作。
5、计算器：自由的数学计算器，支持常用数学函数、关系运算、逻辑运算！
6、配置：  可以设置每页显示多少行；可以将过滤条件、求最值、表达式相关的参数进行保存与加载。
7、帮助：  可从这里找到所有的帮助内容.



@首页中的按钮说明@

【打开】：打开和加载一个文本文件，打开之前会清空以前的内容。
          打开文件也可以通过将文本文件拖放到正文的文本显示框来实现。
          
【追加文件】：打开一个文本文件，将其内容追加到当前内容的后面。
          也可以拖动多个文本文件到“文件列表”的列表框中，一次性追加多个文件文件。
          在设置了过滤条件时，追加文本内容之前会过滤掉满足过滤条件的数据。
          
【另存为】：将日志显示框内的内容保保存为文本文件。
          
【原始内容】：显示从文件中加载的原始数据。

【过滤内容】：显示经过过滤处理后的数据。

【清空内容】：清空原始数据和过滤之后的内容。
          

--------------------------------------
  更多帮助，请点击“帮助”选项卡！
  
  
  
)	
GuiControl, Text, _MyEdit, %var_help%
return


【过滤条件帮助】:
var_help =
(


//___@ 过滤条件帮助 @____________________________________________________

  “过滤条件”选项卡内，可以设置查找条件与过滤条件。
  
  在“要保留的内容”编辑框中输入查找条件，一行为一个条件；
  在“要过滤的内容”编辑框中输入要过滤的条件，一行为一个条件。
  
  之后可以按【<查找】按钮执行查找任务，按【过滤>】执行过滤任务，按【<同时>】查找并过滤。

   【<查找】按钮执行结果：将原始数据中，包含了任意一条查找条件的记录显示出来，并存入缓存；
   
   【过滤>】按钮执行结果：将包含了任意一条查找条件的记录过滤掉，其余的显示出来并存入缓存；
   
   【<同时>】功能相当于同时执行查找和过滤功能，将满足查找条件以及不满足过滤条件的记录显示
            出来并存入缓存。当一条记录同时满足查找条件和过滤条件时，不会被过滤掉。
            
   【还原】按钮与“首页”选项卡中的【原始内容】按钮功能一致，显示从文件加载的原始数据。
   
   通过【<查找】、【过滤>】、【<同时>】操作得到的缓存数据，是“求最值”、“表达式”的前提。
   
)
GuiControl, Text, _MyEdit, %var_help%
return


【求最值帮助】:
var_help =
(

//___@ 求最值帮助 @______________________________________________________

  在加载文本文件后，可以在“求最值”选项卡中指定变量格式，以及保留及过滤条件。
按下【查找最大值】或【查找最小值】按钮之后，程序会查找出所有满足格式与条件的变量，
并将包含变量最大值或最小值的那一行显示出来！


//___@ 使用原始数据 @____________________________________________________

  “使用原始数据”复选框，用于指定数据来源。
勾选了“使用原始数据”复选框之后，将在从文件中加载的原始数据中查找变量；
否则将从经过过滤处理之后的数据中查找变量。


//___@ 举例 @____________________________________________________________

  假设某个日志文件中有以下数据：
[2010-08-23 11:29:42 ] :  58328927  :-( 转换失败！ 原因是：Read0044() 失败文件超过10000k，跳过转换！
[2010-08-23 11:29:59 ] :  58328932  :-( 转换失败！ 原因是：转换错误信息，PDF 中没有找到文本 
[2010-08-23 17:04:51 ] :  58323252  :-( 转换失败！ 原因是：转换错误信息，无法打开要转换的PDF源文件
[2010-08-23 10:01:42 ] :  58321836  转换成功.
[2010-08-23 10:01:45 ] :  58321863  转换成功.
[2010-08-23 10:02:32 ] :  58321906  :-( 转换失败！ 原因是：文件类型被过滤掉，无需转换
[2010-08-23 10:02:32 ] :  58321910  :-( 转换失败！ 原因是：文件类型被过滤掉，无需转换
[2010-08-23 11:26:10 ] :  58328828  :-( 转换失败！ 原因是：转换错误信息，PDF 中没有找到文本 
[2010-08-23 11:26:13 ] :  58328829  :-( 转换失败！ 原因是：转换错误信息，PDF 中没有找到文本 
  
  分析上面的日志，一行为一条记录，在转换失败的记录中有相同的格式：“[时间]: 数字变量 :-( 转换失败！ ...”
  
  而数字变量才是我们关心的内容，现在我想找到数字变量最大值的那一行，具体做法如下：
  
  1、加载文本文件
  
  2、在“过滤条件”选项卡中的“要过滤的内容”框中，填入“转换成功”，
     然后按下【过滤>】过滤掉包含“转换成功”字样的行！
     
  3、进入“求最值”选项卡，在“变量左边字符”的编辑框中填入“ ] :  ”；
     在“变量右边字符”的编辑框中填入“  :-( 转换失败！”；
     
  4、【查找最大值】将显示：[2010-08-23 11:29:59 ] :  58328932  :-( 转换失败！ 原因是：转换错误信息，PDF 中没有找到文本 
     【查找最小值】将显示：[2010-08-23 10:02:32 ] :  58321906  :-( 转换失败！ 原因是：文件类型被过滤掉，无需转换
     
  5、如果仅想在包含“原因是：转换错误信息，PDF 中没有找到文本”的行中查找变量，
     那么需要指定“包含条件”与“过滤条件”的内容，例如：
     “包含条件”："PDF 中没有找到文本"
     “过滤条件”："无需转换|跳过转换"
     
    此时，求最值的结果发生变化：
    【查找最大值】将显示：[2010-08-23 11:29:59 ] :  58328932  :-( 转换失败！ 原因是：转换错误信息，PDF 中没有找到文本 
    【查找最小值】将显示：[2010-08-23 11:26:10 ] :  58328828  :-( 转换失败！ 原因是：转换错误信息，PDF 中没有找到文本 
  	
//___@ 注意 @____________________________________________________________

  1、在使用求最值功能之前，需要先加载文本文件。
  
  2、在没有勾选“使用原始数据”复选框的情况下，还需要在“过滤条件”选项卡中，
     设置过滤条件并进行过滤处理之后，方可使用求最值功能。
     
  3、当有多个包含条件或过滤条件时，用|进行分隔。
  	
  	
  
)
GuiControl, Text, _MyEdit, %var_help%
return


【表达式帮助】:
var_help =
(

//___@ 表达式作用 @______________________________________________________
  
  由程序记录的日志，一般具有循环性，比如一次操作记录一批记录，
再一次重复操作，又记录一批数据。“表达式”选项卡的作用在于，根据
给定的表达式，列出满足表达式的那一批或多批数据。


//___@ 使用步骤 @________________________________________________________
  
  1、指定一次操作的第一条记录，即循环的开始；
  2、设定一个循环内的一些变量；
  3、使用这些变量构成一个表达式；
  4、按下按钮查找数据：
    【表达式】按钮将查找满足表达式的所有批次的记录；
    【最大值】按钮查找出使得表达式的值最大的那一批记录；
    【最小值】按钮查找出使得表达式的值最小的那一批记录；

	
//___@ 举例 @____________________________________________________________

  假设某个程序产生了以下日志：
  x[12]
  y(34)
  z{36}
  x[6]
  y(89)
  z{456}
  x[182]
  y(334)
  z{306}
  分析日志我们可以发现，数据以x[...]、y(...)、z{...}循环的，循环以x[...]开始。
  
  现在我们想找出 x + y + z 值最大的那批记录，操作步骤如下：
  
  1、加载文本文件
  
  2、设定过滤条件，进行过滤操作。（当没有需要过滤的内容时，随便设定一个不存在的过滤内容进行过滤）
  
  3、进入“表达式”选项卡，在“开始条件”编辑框中输入“x[”
  
  4、根据x,y,z三个变量的格式（参考求最值的变量设置格式），例如按下面的格式填写变量列表（ListView）
  
     变量名 | 左边字符 | 右边字符 | 保留条件 | 过滤条件
     $x     | [        | ]        |          | 			
     $y     | (        | )        |          | 			
     $z     | {        | }        |          | 			
     
  5、根据变量名，设定表达式，在表达式编辑框中输入：“ $x + $y + $z”
     
  6、按【最大值】按钮查找使得 $x + $y + $z 的值为最大的那一批记录，结果为：
		x[182]
		y(334)
		z{306}

     按【最小值】查找到的结果为：
		x[12]
		y(34)
		z{36}
  
  7、再写一个复杂一些的表达式：“$z > $y && sin2( $x ) > 0”
    按【表达式】按钮将查找使得 z > y 并且 sin( x 度 ) > 0 成立的多批次记录，结果为：

	-----------------------------------
	  x[12]
	  y(34)
	  z{36}

	-----------------------------------
	  x[6]
	  y(89)
	  z{456}    
	  
//___@ 注意 @____________________________________________________________	  

  1、进行表达式操作之前，请先加载文本文件数据，并且进行过滤操作。
  
  2、设定变量时，变量名应该以$开始。



)
GuiControl, Text, _MyEdit, %var_help%
return


【简介】:
var_help =
(


  您选择使用日志查看器，令我十分的高兴，说明我的这份努力是有价值的！
  
  
  日志查看器采用 AutoHotkey 脚本程序编写，目的在于帮助用户查看分析日志文件，从而找出问题所在。

  日志查看器可以同时加载多个文本文件，可以过滤掉不关心的内容，也可以轻松地从浩瀚的日志记录中搜索出重要的内容。

  此外，正确地指定格式后，可以从日志中识别数字，并且比较数字，将包含最大或最小数字的行找出来。

  你也可以将不同格式的数字设置成不同的变量，用这些变量构成一个表达式，然后查找出使表达式成立的多批记录，或者查找到使表达式的值最大或最小的那一批记录。

  

)
GuiControl, Text, _MyEdit, %var_help%
return


【计算器帮助】:
var_help =
(

//___@ 计算器说明 @______________________________________________________

  计算器与日志查询并无关系，但它是实现“表达式”功能的副产品，对于分析日志的人员
或许会有帮助，因此将其添加到了日志查看器中。


//___@ 特点 @____________________________________________________________
  
  与其他计算器不同的是，本计算器以行为单位进行计算，可以计算多行，可以使用变量，
支持关系运算、逻辑运算，支持以下数学函数的使用：sqrt,abs,log,ln,mod,round,
sin,cos,tan,asin,acos,atan,ceil,exp,floor,sin2,cos2,tan2


//___@ 使用方法 @________________________________________________________

  1、在“计算器”选项卡内的编辑框内输入要计算的内容
  
  2、按【计算】按钮，程序将各行的结果显示到下方的日志显示框内。
  
  例如输入： log( 128 * 2 - ( 30 + 23 ) )
  【计算】之后，下方的显示框将显示结果：2.307496

  3、举例使用变量和多行的计算，先输入：
		$x = 12
		$y = -3
		$a = sqrt( $x**2 + $y**2 )
		$z = 5
		$c = $a * $z / 2
		$d = atan( $c )
		$z > $d && $x + $y < 10
     
     【计算】结果为：
		$x  = 12
		$y  =  -3
		$a  = 12.369317
		$z  = 5
		$c  = 30.923292
		$d  = 1.538470
		1

//___@ 注意事项 @________________________________________________________

   1、支持 +-*/ 以及乘方（**）数学运算；
      支持 >=、>、 <=、 <、 != 、= 关系运算；
      支持 &&、|| 逻辑运算；
      支持使用括弧()，但不支持[]和{}的使用；
      支持常用函数的使用。
   
   2、使用变量时，变量名应当由字母、数字、_、$构成，且以$开头，
      中间不能有空格、运算符号等其他符号。
      建议变量名以$开始，防止用户变量名与程序变量名相同而造成错误。
   
   3、给变量赋值时用 “变量名 = 表达式” 的格式，如果变量名违反了规则，
      则将其视为 = 关系运算， 如果  a + b = c + d 中，a + b 不能作为一个变量名，
      因此将 a + b = c + d 视为一个表达式。
      
   4、使用函数时，函数名后就紧跟()，之间不可有空格。
      如 sin  ( 30 ) 是不正确的，应当写成 sin( 30 )
      
   5、sin,cos,tan 三角函数的参数的单位是以弧度；
      sin2,cos2,tan2 的参数的单位是角度。
      
   6、关系运算与逻辑运算的结果：1（真） 0（假）




)
GuiControl, Text, _MyEdit, %var_help%
return


【配置帮助】:
var_help =
(

//___@ 配置选项卡 @______________________________________________________

  “配置选项卡”对日志查看器进配置管理，可以设置日志显示框每页显示行数(默认100行)，
可以保存当前的配置，或者加载以前保存过的配置。



//___按钮说明____________________________________________________________

【加载配置】：将选中的配置，分解并填充到过滤条件、求最值、表达式等选项卡。

【保存配置】：将当前配置保存到配置文件中，这些配置包括：
          “过滤条件”选项卡中要保留的内容与要过滤的内容；
          “求最值”选项卡中的设置；
          “表达式”选项卡中的设置；
          
【刷新配置】：从配置文件中重新加载并显示历史配置。

【删除配置】：从配置文件中，删除当前选中的配置。



)
GuiControl, Text, _MyEdit, %var_help%
return
; #include .\bin\文本文件处理\日志查看器_帮助.aik

g_rawCurPage =
g_viewCurPage =
g_rawArray  =
g_viewArray =
g_tempArray =


ClearRawArray()
{
	global
	Loop %g_rawArray0%
	{
		g_rawArray%a_index% =
	}
	g_rawArray0 = 0
	g_rawCurPage = 1
}

ClearViewArray()
{
	global
	Loop %g_viewArray0%
	{
		g_viewArray%a_index% =
	}
	g_viewArray0 = 0
	g_viewCurPage = 1
}

ClearTempArray()
{
	global
	Loop %g_tempArray0%
	{
		g_tempArray%a_index% =
	}
	g_tempArray0 = 0
}

RawArrayPushBack( var_line )
{
	global
	g_rawArray0++
	g_rawArray%g_rawArray0% := var_line
}

ViewArrayPushBack( var_line )
{
	global
	g_viewArray0++
	g_viewArray%g_viewArray0% := var_line
}

TempArrayPushBack( var_line )
{
	global
	g_tempArray0++
	g_tempArray%g_tempArray0% := var_line
}

SetViewArray( byref var_Lines )
{
	global
	g_viewArray0 = 0
	loop parse, var_lines, `n
	{
		g_viewArray0++
		g_viewArray%g_viewArray0% := a_loopfield
	}
}

SaveArrayToFile( var_source, filename )
{
	global
	local var_buf, line
	if var_source = raw
	{
		Loop %g_rawArray0%
		{
			line := g_rawArray%a_index%
			var_buf = %var_buf%%line%`r`n
		}
	}
	else if var_source = view
	{
		Loop %g_viewArray0%
		{
			line := g_viewArray%a_index%
			var_buf = %var_buf%%line%`r`n
		}
	}
	else if var_source = temp
	{
		Loop %g_tempArray0%
		{
			line := g_tempArray%a_index%
			var_buf = %var_buf%%line%`r`n
		}
	}
	else
	{
		return false
	}

	var_re := false
	if var_buf <>
	{
		FileAppend %var_buf%, %filename%
		if not ErrorLevel
		{
			var_re := true
		}
	}

	line =
	var_buf =
	return var_re
}


OpenFile( fileName )
{
	global
	local var_fileData
	ifexist %fileName%
	{
		SB_SetText("正在打开文件...")
		GuiControl, Disable, _btn_OpenFile
		GuiControl, Disable, _btn_AddFile
		GuiControl, Disable, _btn_SaveFile
		GuiControl, Disable, _btn_Clear

		guicontrol, , _MyListBox, |
		guicontrol, , _MyListBox, %fileName%
		g_fileName := fileName
		FileRead, var_fileData, %fileName%


		StringReplace, var_fileData, var_fileData, `r`n, `n, All
		StringSplit, g_rawArray, var_fileData, `n
        var_fileData =


		if ErrorLevel = 3
		{
			msgbox the system lacks sufficient memory to load the file
		}
		else if ErrorLevel = 2
		{
			msgbox file is locked or inaccessible
		}
		else
		{
			gosub 【查看原始内容】
		}
		GuiControl, Enable, _btn_OpenFile
		GuiControl, Enable, _btn_AddFile
		GuiControl, Enable, _btn_SaveFile
		GuiControl, Enable, _btn_Clear
		SB_SetText("")
	}
}

AddFile( fileName )
{
	global
	gui, submit, nohide
	local var_buf
	ifnotexist %fileName%
		return


	ControlGet, FileList, List, , ListBox1
	Loop, Parse, FileList, `n
	{
		if A_LoopField =
			continue

		var_file := A_LoopField
		if ( fileName == var_file )
		{
			tooltip7( "追加的文件已经存在!" )
			return
		}
	}


	RawArrayPushBack( "   " )
	line = %ADD_FILE_PRE% %fileName%
	RawArrayPushBack( line )
	line = %ADD_FILE_LINE%%ADD_FILE_LINE%
	RawArrayPushBack( line )

	var_tip = 正在打开并追加文件 %fileName% ...
	SB_SetText( var_tip )
	GuiControl, Disable, _btn_OpenFile
	GuiControl, Disable, _btn_AddFile
	GuiControl, Disable, _btn_SaveFile
	GuiControl, Disable, _btn_Clear

	guicontrol, , _MyListBox, %fileName%
	g_fileName := fileName

	if _edtRe <>
	{

		if _edtFi <>
		{
			Loop, read, %fileName%
			{
				line := A_LoopReadLine
				if line =
					continue
				bFind := false
				loop parse, _edtRe, `r`n
				{
					if a_loopfield =
						continue
					ifinstring line, %a_loopfield%
					{
						RawArrayPushBack( line )
						bFind := true
						break
					}
				}
				if not bFind
				{
					loop parse, _edtFi, `r`n
					{
						if a_loopfield =
							continue
						ifinstring line, %a_loopfield%
						{
							bFind := true
							break
						}
					}
					if not bFind
					{
						RawArrayPushBack( line )
					}
				}
			}
		}

        else
		{
			Loop, read, %fileName%
			{
				line := A_LoopReadLine
				if line =
					continue

				loop parse, _edtRe, `r`n
				{
					if a_loopfield =
						continue
					ifinstring line, %a_loopfield%
					{
						RawArrayPushBack( line )
						break
					}
				}
			}
		}
	}

	else if _edtFi <>
	{
		Loop, read, %fileName%
		{
			line := A_LoopReadLine
			if line =
				continue
			bFind := false
			loop parse, _edtFi, `r`n
			{
				if a_loopfield =
					continue
				ifinstring line, %a_loopfield%
				{
					bFind := true
					break
				}
			}
			if not bFind
			{
				RawArrayPushBack( line )
			}
		}
	}

    else
	{
		FileRead, var_buf, %fileName%
		if ErrorLevel = 3
		{
			tooltip the system lacks sufficient memory to load the file
			sleep 1000
			tooltip
		}
		else if ErrorLevel = 2
		{
			tooltip file is locked or inaccessible
			sleep 1000
			tooltip
		}
		else if ErrorLevel = 1
		{
			tooltip  file does not exist
			sleep 1000
			tooltip
		}
		else if var_buf <>
		{
			StringReplace, var_buf, var_buf, `r`n, `n, All
			loop parse, var_buf, `n
			{
				if a_loopfield =
					continue
				line := a_loopfield
				RawArrayPushBack( line )
			}
		}
	}
	gosub 【查看原始内容】
	GuiControl, Enable, _btn_OpenFile
	GuiControl, Enable, _btn_AddFile
	GuiControl, Enable, _btn_SaveFile
	GuiControl, Enable, _btn_Clear
	SB_SetText("")
}


Init()
{
	global
	g_fileSize = 0
	g_fileData =
	g_view =
	g_statustip =
	g_fileName =
	ClearRawArray()
	ClearViewArray()
	ClearTempArray()
	ShowRawPage( 1 )
}


CreateCurCFG()
{
	global
	gui, submit, nohide
	var_cfg =


	var_buf := _edtRe
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_buf%


	var_buf := _edtFi
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmLeft
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmRight
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmRe
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmFi
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _expStart
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _express
	if var_buf <>
	{
		∑处理字符串中的转义字符( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf =
	Loop % LV_GetCount()
	{
		var_temp =
	    LV_GetText( RetrievedText, A_Index, 1 )
		var_temp := RetrievedText
		LV_GetText( RetrievedText, A_Index, 2 )
		var_temp = %var_temp%``%RetrievedText%
		LV_GetText( RetrievedText, A_Index, 3 )
		var_temp = %var_temp%``%RetrievedText%
		LV_GetText( RetrievedText, A_Index, 4 )
		var_temp = %var_temp%``%RetrievedText%
		LV_GetText( RetrievedText, A_Index, 5 )
		var_temp = %var_temp%``%RetrievedText%
		var_buf = %var_buf%\n%var_temp%
	}
	var_cfg = %var_cfg%|%var_buf%
	return var_cfg
}


ParseCFGLine( line )
{
	ifnotinstring line, |
		return false

	cfgCount = 0
	loop parse, line, |
	{
		cfgCount := a_index
		cfg%a_index% := a_loopfield
	}
	StringReplace var_temp, cfg1, ``r``n, `r`n, All
	GuiControl, text, _edtRe, %var_temp%

	StringReplace var_temp, cfg2, ``r``n, `r`n, All
	GuiControl, text, _edtFi, %var_temp%

	GuiControl, text, _mmLeft, %cfg3%
	GuiControl, text, _mmRight, %cfg4%
	GuiControl, text, _mmRe, %cfg5%
	GuiControl, text, _mmFi, %cfg6%
	GuiControl, text, _expStart, %cfg7%
	GuiControl, text, _express, %cfg8%


	lv_delete()
	loop parse, cfg9, \n
	{
		if a_loopfield =
			continue
		var_line := a_loopfield
		loop parse, var_line, ``
		{
			$var%a_index% := a_loopfield
		}
		lv_add( "", $var1, $var2, $var3, $var4, $var5 )
	}


	loop 5
	{
		$var%a_index% =
	}

	loop %cfgCount%
	{
		cfg%a_index% =
	}
	cfgCount = 0
	return true
}



JustFind()
{
	global
    ClearViewArray()
	StringReplace, var_temp, _edtRe, `r`n, `n, all
	StringSplit arrEdtRe, var_temp, `n
	Loop %g_rawArray0%
	{
		line := g_rawArray%a_index%
		loop %arrEdtRe0%
		{
			var_re := arrEdtRe%a_index%
			if var_re =
				continue
			ifinstring line, %var_re%
			{
				ViewArrayPushBack( line )
				break
			}
		}
	}
}


JustFilt()
{
	global
    ClearViewArray()
	StringReplace, var_temp, _edtFi, `r`n, `n, all
	StringSplit arrEdtFi, var_temp, `n
	Loop %g_rawArray0%
	{
		line := g_rawArray%a_index%
		bFind := false
		loop %arrEdtFi0%
		{
			var_fi := arrEdtFi%a_index%
			if var_fi =
				continue

			ifinstring line, %var_fi%
			{

				if var_fi is number
				{
					bPartNumber := false

					fi_len := strlen( var_fi )
					loop
					{
						StringGetPos, pos, line, %var_fi% , L%a_index%
						if errorlevel
						{
							break
						}
						else
						{
							pos++
							StringMid var_temp, line, pos, fi_len + 1
							if var_temp is number
							{
								StringRight LastChar, var_temp, 1
								if LastChar is number
								{
									bPartNumber := true
								}
								break
							}
							StringMid var_temp, line, pos-1, fi_len + 1
							if var_temp is number
							{
								StringLeft FirstChar, var_temp, 1
								if FirstChar is number
								{
									bPartNumber := true
								}
								break
							}
						}
					}

					if bPartNumber
					{
						continue
					}
				}
				bFind := true
				break
			}
		}
		if not bFind
		{
			ViewArrayPushBack( line )
		}
	}
}



FindFilt()
{
	global
    ClearViewArray()
	StringReplace, var_temp, _edtFi, `r`n, `n, all
	StringSplit arrEdtFi, var_temp, `n
	Loop %g_rawArray0%
	{
		line := g_rawArray%a_index%
		bFind := false

		loop %arrEdtRe0%
		{
			var_re := arrEdtRe%a_index%
			if var_re =
				continue
			ifinstring line, %var_re%
			{
				ViewArrayPushBack( line )
				bFind := true
				break
			}
		}

		if bFind
		{
			continue
		}

		bFind := false
		loop %arrEdtFi0%
		{
			var_fi := arrEdtFi%a_index%
			if var_fi =
				continue

			ifinstring line, %var_fi%
			{

				if var_fi is number
				{
					bPartNumber := false

					fi_len := strlen( var_fi )
					loop
					{
						StringGetPos, pos, line, %var_fi% , L%a_index%
						if errorlevel
						{
							break
						}
						else
						{
							pos++
							StringMid var_temp, line, pos, fi_len + 1
							if var_temp is number
							{
								StringRight LastChar, var_temp, 1
								if LastChar is number
								{
									bPartNumber := true
								}
								break
							}
							StringMid var_temp, line, pos-1, fi_len + 1
							if var_temp is number
							{
								StringLeft FirstChar, var_temp, 1
								if FirstChar is number
								{
									bPartNumber := true
								}
								break
							}
						}
					}

					if bPartNumber
					{
						continue
					}
				}
				bFind := true
				break
			}
		}
		if not bFind
		{
			ViewArrayPushBack( line )
		}
	}
}


GetNumFromLine( sLine, sLeft, sRight )
{
	if sLine =
		return

	if sLeft <>
	{
		IfNotInString sLine, %sLeft%
			return
	}
	if sRight <>
	{
		IfNotInString sLine, %sRight%
			return
	}
	if sLeft =
	{
		if sRight =
			return

		subLine := StrRight2Sub( sLine, sRight, "R1" )
		if subLine is number
		{
            return subLine
		}
		return
	}
	if sRight =
	{
		subLine := StrLeft2Sub( sLine, sLeft )
		if subLine is number
		{
            return subLine
		}
		return
	}

	subLine := sLine
	lLen := strlen( sLeft )
	rLen := strlen( sRight )
	Loop
	{

		StringGetPos lpos, subLine, %sLeft%
		if ErrorLevel
			return

		StringMid subLine, subLine, lpos + 1 + lLen
		if subLine =
			return


		StringGetPos, rpos, subLine, %sRight%
		if ErrorLevel
		{
            return
		}


		StringGetPos, lpos, subLine, %sLeft%
		if not ErrorLevel
		{
			if ( lpos < rpos )
				continue
		}

		StringLeft var_temp, subLine, rpos
		if var_temp is number
			return var_temp


		StringMid subLine, subLine, rpos + 1 + rLen

	}
	return
}


GetVarFromLine( sLine, sLeft, sRight, sInclude, sExclude )
{
	if sLine =
		return


	if sExclude <>
	{
		bExclude := false
		StringSplit arrEx, sExclude, |
		loop %arrEx0%
		{
			var_buf := arrEx%a_index%
			ifinstring sLine, %var_buf%
			{
				bExclude := true
				break
			}
		}
		if bExclude
			return
	}

	if sInclude <>
	{
		bExclude := false
		StringSplit arrIn, sInclude, |
		loop %arrIn0%
		{
			var_buf := arrIn%a_index%
			ifnotinstring sLine, %var_buf%
			{
				bExclude := true
				break
			}
		}
		if bExclude
			return
	}

	return GetNumFromLine( sLine, sLeft, sRight )
}
; #include .\bin\文本文件处理\日志查看器_函数.aik



g_isInstall_autohotkey =

∑是否安装了AutoHotkey()
{
	global g_isInstall_autohotkey
	if g_isInstall_autohotkey =
	{
		var_RootKey = HKEY_LOCAL_MACHINE
		var_SubKey = SOFTWARE\AutoHotkey
		regread var_read, %var_RootKey%, %var_SubKey%, InstallDir
		if var_read <>
			g_isInstall_autohotkey := true
		else
			g_isInstall_autohotkey := false
	}
	return g_isInstall_autohotkey
}


cliptext( varDefault = "", bWait=true )
{
	ClipboardOld := ClipboardAll
	Clipboard := varDefault
	send ^c
	if not bWait
		return

	clipwait , 0, 1
	sleep 100
	varClip=%Clipboard%
	Clipboard := ClipboardOld
	return varClip
}


SelectLeftSpaceChar()
{
	autotrim off
	ClipboardOld := Clipboard
	Clipboard = $error$
	send {shift down}{left}{shift up}
	send ^c
	clipwait

	if Clipboard = $error$
	{
		Clipboard := ClipboardOld
		return
	}
	ifInString clipboard, `n
	{
        send {down}
	}
	else if Clipboard is not space
	{
        send {right}
	}
	Clipboard := ClipboardOld
	autotrim on
}


sendbyclip(var_string)
{
	ClipboardOld = %ClipboardAll%
	Clipboard =%var_string%
	sleep 100
	send ^v
	sleep 100
	Clipboard = %ClipboardOld%
}


SelectLine()
{
	send {home}{shift down}{end}{shift up}
}


pleasewait(var_title="",var_text="",var_time=0)
{
	loop
	{
		if (var_time=0)
		  InputBox, var_time, 设置等待时间,你要暂停多久？请输入时间,,300,120,,,,,3000
		if (var_time<500)
		  return
		if (var_title="")
		{
		  sleep %var_time%
		}
		else
		{
		  winwait %var_title%,%var_text%,%var_time%
		}
		var_time=0
	}
}


cout(var_out)
{
   sendinput %var_out%
}



YesNoBox( var_title, var_text )
{
	MsgBox, 4,ini文件存在重复的key, %var_text%
	IfMsgBox Yes
	{
		return true
	}
	return false
}

MyInput(vartitle,varPrompt,varDefault="", varWidth=260, varHeight=120)
{
	Sleep 200
	var_user := ""
	if varWidth <=0 or varHeight <= 0
	{
		inputbox,var_user,%vartitle%,%varPrompt%,,,, , , , ,%varDefault%
	}
	else
	{
		inputbox,var_user,%vartitle%,%varPrompt%,,%varWidth%,%varHeight%, , , , ,%varDefault%
	}
	if ErrorLevel
		var_user =
	return var_user
}

MyInput2(vartitle,varPrompt,varDefault="", varWidth=260, varHeight=120)
{
	SetTimer, 输入窗口将光标定位到输入框最后,100
	return MyInput(vartitle, varPrompt, varDefault, varWidth, varHeight)
	return
输入窗口将光标定位到输入框最后:
	ifwinexist %vartitle%,%varPrompt%
	{
		winactivate
		send {end}
		SetTimer, 输入窗口将光标定位到输入框最后, Off
	}
	return
}


MyInputBox(vartitle,varPrompt,varDefault="",varXPos=0, varYPos=0, varWidth=260, varHeight=120)
{
	var_user := ""
	SetTimer, 设置MyInputBox窗口透明度,100
	if varWidth <=0 or varHeight <= 0
	{
		inputbox,var_user,%vartitle%,%varPrompt%,,,, , , , ,%varDefault%
	}
	else
	{
		inputbox,var_user,%vartitle%,%varPrompt%,,%varWidth%,%varHeight%, , , , ,%varDefault%
	}
	return var_user

设置MyInputBox窗口透明度:
	ifwinexist %vartitle%,%varPrompt%
	{
		if not(varXPos=0 or varYPos=0)
		   winmove %varXPos%,%varYPos%
		winset,AlwaysOnTop, ON
		ifwinactive %vartitle%,%varPrompt%
			WinSet, Transparent,250
		else
			WinSet, Transparent,100
	}
	else
	SetTimer, 设置MyInputBox窗口透明度, Off
	return
}


MyInputBox2(vartitle,varPrompt,varDefault="", varWidth=400, varHeight=160)
{
	return MyInputBox(vartitle,varPrompt,varDefault,0,0,varWidth,varHeight)
}










DebugBox(Text_, DebugGroup_, byref g_group)
{
	if not g_group
	{

		IniRead, ShowMsgBox, var.ini, Debug, %DebugGroup_%, false
		if (ShowMsgBox)
			g_group:= 1
		else
			g_group := -1
	}

	if (g_group = 1)
	{
		MsgBox %Text_%
	}
	return
}




twokeys(key1,key2,var_event)
{

	sendevent,{blind}{%key1% down}
	keywait,%key2%,D L T0.3
	sendevent,%var_event%
	sendevent,{blind}{%key1% up}
}


is_key_down(KeyName_)
{
	GetKeyState, state, %KeyName_%
	if state = D
	{
		return True
	}
	return false
}


loop_send_while_keydown(Key_, SendText_, MilSecond_=100)
{
	Loop
	{
		Send %SendText_%
		Sleep %MilSecond_%
		if not is_key_down(Key_)
		{
			Return
		}
	}
	return
}


loop_func_while_keydown( Key_, FunctionName_, Param_="", MilSecond_=100 )
{
	msgbox loop_func_while_keydown(Key_, FunctionName_, Param_="", MilSecond_=100)

	Loop
	{
		%FunctionName_%(Param_)
		Sleep %MilSecond_%
		if not is_key_down(Key_)
		{
			Return
		}
	}
	Return
}



block_selected_text(FirstString, LastString)
{
	Clipboard =
	sleep 100
	send ^x
	ClipWait 2

	var_temp = %FirstString%%Clipboard%%LastString%
	SendByClip(var_temp)





}


rgbToDec(colorstr, byref var_red, byref var_green, byref var_blue)
{
	StringLeft, var_head, colorstr, 2
	if (var_head == "0x")
	{
		SetFormat, IntegerFast, hex
		StringMid, var_red, colorstr, 3 , 2
		StringMid, var_green, colorstr, 5 ,2
		StringMid, var_blue, colorstr, 7 , 2
		var_red 	= 0x%var_red%
		var_green 	= 0x%var_green%
		var_blue 	= 0x%var_blue%
		SetFormat, IntegerFast, d
		var_red 	+= 0
		var_green 	+= 0
		var_blue 	+= 0
		return true
	}
	return false
}



SwitchIME_index(dwLayout)
{
    DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1))
}


SwitchIME(name)
{
	Loop, HKLM, SYSTEM\CurrentControlSet\Control\Keyboard Layouts,1,1
	{
		IfEqual,A_LoopRegName,Layout Text
		{
			RegRead,Value
			IfInString,value,%name%
			{
				RegExMatch(A_LoopRegSubKey,"[^\\]+$",dwLayout)
				HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
				ControlGetFocus,ctl,A
				SendMessage,0x50,0,HKL,%ctl%,A
				Break
			}
		}
	}
}


SetEditTextAndSelect( NewText, SelectText, bR, EditControl, WinTitle = "A", WinText = "" )
{
	ControlSetText , %EditControl%, %NewText%, %WinTitle%, %WinText%
	ControlFocus , %EditControl%, %WinTitle%, %WinText%
	if selectText =
	{
		return
	}
	ifNotInString NewText, %SelectText%
	{
		return
	}

	var_oldclip := clipboard
	clipboard =
	startPos := 0
	lenNew := strlen( NewText )
	lenSelect := strlen( SelectText )
	count := lenNew - lenSelect
	if bR
	{
		loop %count%
		{
			IfWinNotExist %WinTitle%, %WinText%
				break

			send {end}
			if startPos > 0
			{
				send {left %startPos%}
			}
			loop %lenSelect%
			{
				send {shift down}{left}{shift up}
				send ^c
				if ( clipboard == SelectText )
				{
					clipboard := var_oldclip
					return
				}
			}
			startPos++
		}
	}
	else
	{
		loop %count%
		{
			IfWinNotExist %WinTitle%, %WinText%
				break

			send {home}
			if startPos > 0
			{
				send {right %startPos%}
			}
			loop %lenSelect%
			{
				send {shift down}{right}{shift up}
				send ^c
				if ( clipboard == SelectText )
				{
					clipboard := var_oldclip
					return
				}
			}
			startPos++
		}
	}

	clipboard := var_oldclip
}

ComboBox_Count( var_ComboBox )
{
	SendMessage, 0x0146, 0, 0, %var_ComboBox%
	nRowCount:=ErrorLevel
	return nRowCount
}


ComboBox_choose_next( var_ComboBox, byref var_curRow )
{
	SendMessage, 0x0146, 0, 0, %var_ComboBox%
	nRowCount:=ErrorLevel

	nNextRow := var_curRow + 1
	if (nNextRow > nRowCount )
		nNextRow = 1


	if ( nNextRow != var_curRow )
	{
		var_curRow := nNextRow
		Control, Choose, %nNextRow%, %var_ComboBox%
		return true
	}
	return false
}


is_same_key( var_time = 250 )
{
	If ( A_ThisHotkey == A_PriorHotkey && A_TimeSincePriorHotkey < var_time )
		return true
	return false
}


MouseGetRelaPos( byref rx, byref ry )
{
	CoordMode, Mouse, Relative
	MouseGetPos rx, ry
	CoordMode, Mouse, Screen
}

GetTerminatingCharacters()
{

	var_temp = `n `"+*`%^/\=`,:?!`'()<&|>[]``{}`;　，。；·‘“”’《》【】｛｝、：！
	return var_temp
}


is_digit( var )
{
	if var =
		return false
	if a is not digit
		return false
	return true
}


is_full_screen( var_ahkid )
{
	ifwinexist ahk_id %var_ahkid%
	{
		WinGet, Style, Style, ahk_id %var_ahkid%
		if !(Style & 0xC40000)
		{
			return true
		}
	}
	return false
}


get_ahkid( WinTitle="" )
{
	if WinTitle =
		WinTitle = A
	WinGet, OutputVar , id, %WinTitle%
	return OutputVar
}


get_open_exe( var_document )
{
	VarSetCapacity( exefile, 256 )
	DllCall("Shell32\FindExecutableA", str, var_document, str, "", str, exefile )
	return exefile
}


get_file_ext( var_file )
{


	var_quotation = `"
	if ( instr( var_file, var_quotation ) == 1 )
	{
		StringMid var_temp, var_file, 2
		var_pos := instr( var_temp, var_quotation )
		if var_pos > 0
		{
			StringLeft var_file, var_temp, var_pos - 1
		}
	}

	StringLeft var_temp, var_file, 4
	if var_temp = www.
		return "$Web$"
	if var_temp = http
		return "$Web$"
	AttributeString := FileExist( var_file )
	if AttributeString =
		return
	IfInString AttributeString, D
		return "$Dir$"
	SplitPath, var_file , , , OutExtension
	if OutExtension =
		OutExtension = $NoExt$
	return OutExtension
}

is_folder(Path)
{
	FileGetAttrib, Attrib, %Path%
	IfInString, Attrib, D
	{
		Return 1
	}
	Else
	{
		Return 0
	}
}



change_icon( var_icofile = "", bForce = false )
{

	if a_IsCompiled
	{
		if not bForce
		{
			Return
		}
	}

	if var_icofile =
	{
		SplitPath, a_ScriptFullPath ,  , OutDir, , OutNameNoExt
		var_icofile = %OutDir%\%OutNameNoExt%.ico

	}
	else
	{
		SplitPath, var_icofile, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
		if OutExtension <> ico
		{
			Return
		}
		if Outdir =
		{
			SplitPath, a_ScriptFullPath ,  , OutDir
			var_icofile = %OutDir%\%OutNameNoExt%.ico
		}
	}

	IfExist %var_icofile%
	{
		Menu TRAY, Icon,  %var_icofile%
	}
}




run_ahk( Target, Param="", WorkingDir="", MaxMinHide="" )
{
	var_file = `"%Target%`"

	SplitPath, Target , OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
	if OutExtension in ahk,aik
	{

		if A_IsCompiled
		{
			var_temp = %OutDir%\%OutNameNoExt%.exe
			IfExist %var_temp%
				var_file := var_temp
			Else if a_AhkPath <>
			{
				var_file = %A_AhkPath% %var_file%
			}
			Else
				return 0
		}

		else
		{
			var_file = %A_AhkPath% %var_file%
		}
	}

	if MaxMinHide =
		MaxMinHide = UseErrorLevel
	else IfNotInString MaxMinHide, UseErrorLevel
		MaxMinHide = UseErrorLevel|%UseErrorLevel%

	run %var_file% %Param%, %WorkingDir%, %MaxMinHide%, OutputVarPID

	if ErrorLevel
		return 0

	return OutputVarPID
}


SendToUnderMouse( keys_ )
{
	MouseGetPos,  ,  , UMWID, UMC
	ControlSend %UMC%, %keys_%, ahk_id %UMWID%
}


IsPosInAWin( x_, y_ )
{
	WinGetActiveStats, Title, Width, Height, X, Y
	if ( x_ > X && x_ < ( X + Width ) && y_ > Y && y_ < ( Y + Height ) )
		return true
	msgbox ( %x_%`, %y_%) [ %x%, %y%, %width%, %height% ]
	return false
}


IsMouseInAWin( )
{
	CoordMode, Mouse, Screen
	MouseGetPos,  x, y
	return IsPosInAWin( x, y )
}


GetDeskHeight()
{
	WinGetPos , , Y, , taskH, ahk_class Shell_TrayWnd
	deskH := A_ScreenHeight - taskH
	return deskH
}












BlockKeyboardInputs(state = "On")
{
   static keys
   keys=Space,Enter,Tab,Esc,BackSpace,Del,Ins,Home,End,PgDn,PgUp,Up,Down,Left,Right,CtrlBreak,ScrollLock,PrintScreen,CapsLock
,Pause,AppsKey,LWin,LWin,NumLock,Numpad0,Numpad1,Numpad2,Numpad3,Numpad4,Numpad5,Numpad6,Numpad7,Numpad8,Numpad9,NumpadDot
,NumpadDiv,NumpadMult,NumpadAdd,NumpadSub,NumpadEnter,NumpadIns,NumpadEnd,NumpadDown,NumpadPgDn,NumpadLeft,NumpadClear
,NumpadRight,NumpadHome,NumpadUp,NumpadPgUp,NumpadDel,Media_Next,Media_Play_Pause,Media_Prev,Media_Stop,Volume_Down,Volume_Up
,Volume_Mute,Browser_Back,Browser_Favorites,Browser_Home,Browser_Refresh,Browser_Search,Browser_Stop,Launch_App1,Launch_App2
,Launch_Mail,Launch_Media,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22
,1,2,3,4,5,6,7,8,9,0,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
,2,&,é,",',(,-,è,_,?,à,),=,$,￡,ù,*,~,#,{,[,|,``,\,^,@,],},;,:,!,?,.,/,§,<,>,vkBC
   Loop,Parse,keys, `,
      Hotkey, *%A_LoopField%, KeyboardDummyLabel, %state% UseErrorLevel
   Return

KeyboardDummyLabel:
Return
}








BlockMouseClicks(state = "On")
{
   static keys="RButton,LButton,MButton,WheelUp,WheelDown"
   Loop,Parse,keys, `,
      Hotkey, *%A_LoopField%, MouseDummyLabel, %state% UseErrorLevel
   Return

MouseDummyLabel:
Return
}



StrToNeedleRegEx( _str )
{
	strRet := _str
	if _str contains \,.,*,?,+,[,{,|,(,),},],^,$
	{
		StringReplace strRet, strRet, \, \\, all
		StringReplace strRet, strRet, ., \., all
		StringReplace strRet, strRet, *, \*, all
		StringReplace strRet, strRet, ?, \?, all
		StringReplace strRet, strRet, +, \+, all
		StringReplace strRet, strRet, [, \[, all
		StringReplace strRet, strRet, ], \], all
		StringReplace strRet, strRet, {, \{, all
		StringReplace strRet, strRet, }, \}, all
		StringReplace strRet, strRet, |, \|, all
		StringReplace strRet, strRet, (, \(, all
		StringReplace strRet, strRet, ), \), all
		StringReplace strRet, strRet, ^, \^, all
		StringReplace strRet, strRet, $, \$, all
	}
	return strRet
}

; #include .\inc\common.aik


StrGetAt( var_string, var_pos )
{
	StringMid var_char, var_string, %var_pos%, 1
	return var_char
}

StrGetBetween( varString, startpos, endpos )
{
	if varString =
		return
	if startpos is not integer
		return
	if endpos is not integer
		return
	if ( startpos > 0 && endpos >= startpos )
	{
		StringMid _outword, varString, startpos, endpos - startpos + 1
		return _outword
	}
	return
}

StrGetLeft( varString, endpos )
{
	if varString =
		return
	if endpos is not integer
		return
	if endpos < 1
		return
	StringLeft var_out, varString, endpos
	return var_out
}

StrGetRight( varString, startpos )
{
	if varString =
		return
	if startpos is not integer
		return
	StringMid var_out, varString, startpos
	return var_out
}


StrTrimLeft( byref _Haystack_, trimlist_="" )
{
	_Haystack_ := RegExReplace(_Haystack_, "^\s+", "" )
	if trimlist_ <>
	{
		StringReplace, trimlist_, trimlist_, |, \|, All
		Needle = ^(\s|%trimlist_%)+
		_Haystack_ := RegExReplace(_Haystack_, Needle, "" )
	}
}


StrTrimRight( byref _Haystack_, trimlist_="" )
{
	_Haystack_ := RegExReplace(_Haystack_, "\s+$", "" )
	if trimlist_ <>
	{
		StringReplace, trimlist_, trimlist_, |, \|, All
		Needle = (\s|%trimlist_%)+$
		_Haystack_ := RegExReplace(_Haystack_, Needle, "" )
	}
}


StrTrim( byref InputString, var_trimlist=""  )
{
	StrTrimLeft( InputString, var_trimlist )
	StrTrimRight( InputString, var_trimlist )
}


∑删除字符串末尾的回车符号(byref string)
{
	loop
	{
		if string =
		{
			return
		}
		StringRight, var_char, string, 1
		if ( var_char == "`r" || var_char == "`n" )
		{
			StringLeft string, string, strlen(string) -1
		}
		else
		{
			return
		}
	}
}



AddString(ByRef _LongStr, SubStr_, IsEnter)
{
	if IsEnter
	{
		_LongStr = %_LongStr%`r`n%SubStr_%
	}
	else
	{
		_LongStr = %_LongStr%%SubStr_%
	}
	return _LongStr
}


∑连接字符串(Byref _LongStr, substr_, ConnectStr_="")
{
	if _LongStr =
		_LongStr = %SubStr_%
	else
		_LongStr = %_LongStr%%ConnectStr_%%SubStr_%
}



SubtractString(byref varString, subString)
{
	StringReplace, varString, varString, %subString%,
}

StringReplaceAll(byref varString, SearchText, ReplaceText)
{
	StringReplace, varString, varString, %SearchText%, %ReplaceText%, All
}

∑返回全部替换后的字符串( varString, SearchText, ReplaceText)
{
	StringReplace, var_temp, varString, %SearchText%, %ReplaceText%, All
	return var_temp
}

∑删除字符串中所有子串(byref varString, subString)
{
	StringReplace, varString, varString, %subString%, , All
}

StrReplaceAt( byref varString, pos, InsertText )
{
	if pos is not integer
		return false
	if ( pos > 0 && pos <= len )
	{
		StringLeft var_left, varString, pos - 1
		StringRight var_right, varString, len - pos
		varString = %var_left%%InsertText%%var_right%
		return true
	}
	return false
}

StrInsertAt( byref varString, pos, InsertText )
{
	if pos is not integer
		return false

	if pos <= 1
	{
		varString = %InsertText%%varString%
		return true
	}
	len := strlen( varString )

	if ( pos > len )
	{
		varString = %varString%%InsertText%
		return true
	}

	StringLeft var_left, varString, pos - 1
	StringRight var_right, varString, len - pos + 1
	varString = %var_left%%InsertText%%var_right%
	return true
}





StrReplaceBetween( byref varString, ReplaceText, startpos, endpos )
{

	len := strlen( varString )
	if len <= 0
		return false
	if startpos =
		startpos = 0
	if startpos is not integer
		return false
	if endpos is not integer
		return false
	if ( endpos < startpos )
		return false

	if ( startpos = 0 )
	{
		if ( endpos >= len )
		{
            varString := ReplaceText
            return true
		}
		if endpos > 0
		{
			StringRight var_right, varString, len - endpos
			varString = %ReplaceText%%var_right%
			return true
		}
		return false
	}
	else if ( endpos >= len )
	{
		stringleft var_left, varString, startpos -1
		varString = %var_left%%ReplaceText%
		return true
	}
	else
	{
		stringleft var_left, varString, startpos -1
		stringRight var_right, varString, len - endpos
		varString = %var_left%%ReplaceText%%var_right%
		return true
	}
	return false
}


DelSubString(varString, subString)
{
	StringReplace, varTemp, varString, %subString%,
	return varTemp
}


AddString_LineInfo(ByRef _LongStr, LineFile, ThisFunc, LineNumber)
{
	AddString(_LongStr, "`n-------------------------------------", true)
	var_temp = 当前运行文件 %LineFile%
	AddString(_LongStr, var_temp, true)
	var_temp = 当前所在函数 %ThisFunc%
	AddString(_LongStr, var_temp, true)
	var_temp = 当前所在行: [%LineNumber%]
	AddString(_LongStr, var_temp, true)
}


StrLeft2Sub(varString,subString)
{
	StringGetPos, varPos, varString, %subString%
	if  errorlevel
	{
		return ""
	}
	stringleft varReturn,varString,%varPos%
	return %varReturn%




}

StrMid2Sub(varString,subString1,subString2)
{
	varTemp =
	StringGetPos, varPos, varString, %subString1%
	if ErrorLevel
	{
		return varTemp
	}
	varLen := strlen(subString1)
	varTemp := substr(varString,varPos+varLen+1)

	ifinstring varTemp,%subString2%
	{
		varTemp := StrLeft2Sub(varTemp,subString2)
	}
	else
	{
		varTemp =
		return varTemp
	}

	return varTemp




}


StrRight2Sub(varString,subString, LR="R1")
{
	StringGetPos varPos, varString, %subString%, %LR%
	if ErrorLevel
	{
		return ""
	}
	stringleft varTemp,varString,%varPos%
	varLen := strlen(varTemp)
	varLen := strlen(varString) - varLen - strlen(subString)
	stringright varReturn,varString,%varLen%
	return %varReturn%




}

StrSplit2Sub( varString, subString, byref OutStringLeft, byref OutStringRight )
{
	StringGetPos, varPos, varString, %subString%
	if  errorlevel
	{
		return false
	}
	stringleft OutStringLeft, varString,%varPos%
	stringMid, OutStringRight, varString, varPos + strlen(subString) + 1
	return true




}

∑字符串左右互换(varString, subString)
{
	ifinstring varString, %subString%
	{
		StrSplit2Sub( varString, subString, var_left, var_right)
		var_temp = %var_right%%subString%%var_left%
		return var_temp
	}
	return varString
}


StrLastWord(InputString_, Count_)
{
	OutputVar =
	if Count_ > 0
	{
		StringRight , OutputVar, InputString_, Count_
	}
	else
	{
		varLen := strlen(InputString_)
		var_index = 0
		Loop %varLen%
		{
			var_index := varLen - a_index + 1
			var_char := StrGetAt( InputString_, var_index )
			if OutputVar =
			{
				if var_char is not space
				{
					Outputvar = %var_char%
				}
			}
			else
			{
				if var_char is not space
				{
					Outputvar = %var_char%%Outputvar%
				}
				else
				{
					break
				}
			}
		}
	}
	return OutputVar
}

StrFirstWord(InputString_, Count_)
{
	StringLeft , OutputVar, InputString_, Count_
	return OutputVar
}


get_first_char( Haystack, byref var_char)
{
	return RegExMatch( Haystack, "^\S", var_char )
}


equal_first_char( Haystack, Char_ )
{
	if RegExMatch( Haystack, "^\S", var_char ) > 0
	{
		if var_char = %Char_%
			return true
	}
	return false
}

StrHaveChars( InputString, CharList="" )
{
	if CharList =
	{
		pos := instr( InputString, " " )
		if pos > 0
			return true
		pos := instr( InputString, "	" )
		if pos > 0
			return true
		return false
	}

	loop
	{
		len := Strlen( InputString )
		if len <= 0
			return false
		StringMid var_char, InputString, 1, 1
		ifinstring CharList, %var_char%
		{
			return true
		}
		StringReplace InputString, InputString, %var_char%, , All
		continue
	}
	return false
}

StrHaveTerminatChar( InputString )
{
	CharList := GetTerminatingCharacters()
	loop
	{
		len := Strlen( InputString )
		if len <= 0
			return false
		StringMid var_char, InputString, 1, 1
		ifinstring CharList, %var_char%
		{
			return true
		}
		StringReplace InputString, InputString, %var_char%, , All
		continue
	}
	return false
}



is_terminate_pos( InputString, pos, TerminatingCharacters="" )
{
	len := strlen( InputString )

	if TerminatingCharacters =
	{
		TerminatingCharacters := GetTerminatingCharacters()
	}

	if ( pos > 0 && pos <= len )
	{
		StringMid var_char, InputString, %pos%, 1
		if var_char is space
		{
			return 1
		}
		ifinstring TerminatingCharacters, %var_char%
		{
			return 1
		}
	}

	if ( pos > 0 && pos < len )
	{
		StringMid var_char, InputString, %pos%, 2
		ifinstring TerminatingCharacters, %var_char%
		{
			return 2
		}
	}
	return 0
}


find_pre_word( InputString, offset, byref _outword, byref _startpos, byref _endpos )
{
	if offset < 2
		return false

	startpos =
	endpos =
	len := strlen(InputString)


	if ( offset > len )
	{
		loop %len%
		{
			index := len - a_index + 1
			var_re := is_terminate_pos( InputString, index )
			if endpos =
			{
				if var_re = 0
				{
					if index > 1
					{
						if ( 2 == is_terminate_pos( InputString, index -1 ) )
							continue
					}
					endpos := index
				}
			}
			else if var_re = 1
			{
				startpos := index + 1
			}
			else if var_re = 2
			{
				startpos := index + 2
			}
		}
		if endpos > 0
		{
			if startpos =
				startpos = 1
			if ( endpos >= startpos )
			{
				_startpos := startpos
				_endpos := endpos
				StringMid _outword, InputString, %startpos%, endpos - startpos + 1
				return true
			}
		}
		return false
	}


	Loop %offset%
	{
		index := offset - a_index +1

		var_re := is_terminate_pos( InputString, index )
		if endpos =
		{
			if var_re > 0
			{
				endpos = 找到分隔符
			}

		}
		else if endpos = 找到分隔符
		{
			if var_re = 0
			{
				if index <= 1
				{
					endpos := index
				}
				else
				{
					var_re := is_terminate_pos( InputString, index -1 )
					if var_re = 2
					{
						continue
					}
					else
					{
						endpos := index
					}
				}
			}

		}
		else
		{
            if var_re = 1
			{
				startpos := index+1
				break
			}
            else if var_re = 2
			{
				startpos := index + 2
				break
			}
		}
	}

	if ( index == 1 && startpos =="" && endpos <> "找到分隔符" && endpos >= 1 )
	{
		startpos = 1
	}


	if startpos is integer
	{
		if endpos is integer
		{
			if ( endpos >= startpos && startpos > 0 && endpos <= offset )
			{
				_startpos := startpos
				_endpos := endpos
				StringMid _outword, InputString, %startpos%, endpos - startpos + 1
				return true
			}
		}
	}

    return false
}


find_next_word( InputString, offset, byref _outword, byref _startpos, byref _endpos )
{
	if InputString =
		return false

	len := strlen(InputString)

	if ( offset >= len )
		return false

	startpos =
	endpos =


	if offset <= 0
	{
		loop %len%
		{
			var_re 	:= is_terminate_pos( InputString, a_index )
			if startpos =
			{
				var_char := StrGetAt( InputString, a_index )
				if ( var_re == 0 )
				{

					if a_index > 1
					{
						if ( 2 == is_terminate_pos( InputString, a_index -1 ) )
							continue
					}
					startpos := a_index
				}
				else if ( var_char == "-" )
				{
					startpos := a_index
				}
			}
		}
		if  startpos > 0
		{
			if endpos =
				endpos := len
			if ( endpos >= startpos )
			{
				_startpos := startpos
				_endpos := endpos
				StringMid _outword, InputString, %startpos%, endpos - startpos + 1
				return true
			}
		}

		return false
	}


	loops := len - offset + 1
	loop %loops%
	{
		index 	:= offset + a_index - 1
		var_re 	:= is_terminate_pos( InputString, index )
		if startpos =
		{
			if var_re > 0
				startpos = 找到分隔符
		}
		else if startpos = 找到分隔符
		{
			if var_re = 0
			{

				var_re := is_terminate_pos( InputString, index -1 )
				if var_re = 2
				{
					continue
				}
				else
				{
					startpos := index
				}
			}
		}
		else
		{
            if var_re > 0
            {
				endpos := index - 1
				break
			}
		}
	}

	if ( endpos == "" && startpos <> "找到分隔符" && startpos >= 1 )
	{
		endpos := len
	}

	if startpos is integer
	{
		if endpos is integer
		{
			if ( endpos >= startpos && startpos >= offset && endpos <= len )
			{
				_startpos := startpos
				_endpos := endpos
				StringMid _outword, InputString, %startpos%, endpos - startpos + 1
				return true
			}
		}
	}
	return false
}







∑Add字符串队列( byref _strlist_, newstr_, separator, bFront = true, maxcount = 50 )
{
	Local var_count, var_item, var_newlist, nFind, i
	if newstr_ =
		return false
	if _strlist_ =
	{
		_strlist_ = %newstr%%separator%
		return true
	}

	StrSplit( "TempArray", _strlist_, separator )
	loops := maxcount
	if ( TempArray0 < loops )
		loops := TempArray0

	nFind := 0
	loop %loops%
	{
		if ( a_index >= maxcount + nFind )
		{
			break
		}
		if bFront
			i := a_index
		else
			i := loops - a_index + 1

		var_item := TempArray%i%
		if ( var_item <> newstr_ )
		{
			if var_newlist =
				var_newlist = %var_item%
			else if bFront
				var_newlist = %var_newlist%%separator%%var_item%
			else
				var_newlist = %var_item%%separator%%var_newlist%
		}
		else
		{
			nFind++
		}
	}
	if bFront
		_strlist_ = %newstr_%%separator%%var_newlist%
	else
		_strlist_ = %var_newlist%%separator%%newstr_%

	return true

}



StrListAdd( byref strlist, newstr, separator, bFront = false )
{
	if newstr =
	{
		return false
	}
	if strlist =
	{
		strlist = %newstr%
		return true
	}


	if InStrList( strlist, newstr, separator ) > 0
	{
		Return false
	}

	if bFront
	{
		strlist = %newstr%%separator%%strlist%
	}
	else
	{
		strlist = %strlist%%separator%%newstr%
	}
	return true
}



StrListDel( byref strlist, delstr, separator )
{
	if delstr =
		return false


	ifnotinstring strlist, %delstr%
		return false


	var_temp =
	loop parse, strlist, %separator%
	{
		ifnotinstring a_loopfield, %delstr%
		{
			∑连接字符串( var_temp, a_LoopField, separator )
		}
	}
	if ( strlist == var_temp )
	{
		return false
	}
	strlist := var_temp
	return true
}


StrListDelete( byref strlist, delstr, separator )
{
	if delstr =
		return false

	ifnotinstring strlist, %delstr%
		return false

	var_temp =
	loop parse, strlist, %separator%
	{
		if ( a_loopfield != delstr )
		{
			∑连接字符串( var_temp, a_LoopField, separator )
		}
	}
	if ( strlist == var_temp )
	{
		return false
	}
	strlist := var_temp
	return true
}

StrListMod( byref strlist, oldstr, newstr, separator, bAdd = false )
{
	if oldstr =
		return
	if (oldstr == newstr )
		return

	if (strlist == oldstr || strlist == "" )
	{
		strlist := newstr
		return
	}

	ifnotinstring strlist, %oldstr%
	{
		if bAdd
		{
			strlist = %strlist%%separator%%newstr%
		}
		return
	}

	var_temp =
	bFind := false
	loop parse, strlist, %separator%
	{
		if ( a_loopfield == oldstr )
		{
			bFind := true
			∑连接字符串( var_temp, newstr, separator )
		}
		else
		{
			∑连接字符串( var_temp, a_LoopField, separator )
		}
	}
	if ( bFind == true && bAdd == true )
	{
		var_temp = %var_temp%%separator%%newstr%
	}
	strlist := var_temp
}



∑Find字符串队列( strlist, searchstr, separator )
{
	return StrListFind( strlist, searchstr, separator )
}

StrListFind( strlist, searchstr, separator )
{
	loop parse, strlist, %separator%
	{
		if ( a_loopfield == searchstr )
		{
			return a_index
		}
	}
	return 0
}


∑GetAt字符串队列( strlist, var_index, separator )
{
	return StrListGetAt( strlist, var_index, separator )
}

StrListGetAt( strlist, var_index, separator )
{
	Loop parse, strlist, %separator%
	{
		if ( a_index == var_index )
		{
			return a_LoopField
		}
		else if ( a_index > var_index )
		{
			return
		}
	}
}


StrListEraseAt( byref strlist, var_index, separator )
{
	var_temp =
	Loop parse, strlist, %separator%
	{
		if ( a_index != var_index )
		{
			∑连接字符串( var_temp, a_LoopField, separator )
		}
	}
	strlist := var_temp
}

StrListSetAt( byref strlist, var_index, newstr, separator )
{
	if strlist =
	{
		strlist := newstr
	}

	var_temp =
	Loop parse, strlist, %separator%
	{
		if ( a_index == var_index )
		{
			∑连接字符串( var_temp, newstr, separator )
		}
		else
		{
			∑连接字符串( var_temp, a_LoopField, separator )
		}
	}
	strlist := var_temp
}

StrListInsertAt( byref strlist, var_index, newstr, separator )
{
	if strlist =
	{
		strlist := newstr
	}
	bInsert := false
	var_temp =
	Loop parse, strlist, %separator%
	{
		if ( a_index == var_index )
		{
			∑连接字符串( var_temp, newstr, separator )
			bInsert := true
		}

		∑连接字符串( var_temp, a_LoopField, separator )
	}


	if not bInsert
	{
		∑连接字符串( var_temp, newstr, separator )
	}

	strlist := var_temp
}


∑将回车符统一成Windows风格( byref Hotstring )
{
	StringReplace, Hotstring, Hotstring, `r`n,$rn$, All
	StringReplace, Hotstring, Hotstring, `r, $rn$, All
	StringReplace, Hotstring, Hotstring, `n, $rn$, All
	StringReplace, Hotstring, Hotstring, $rn$, `r`n, All
}

∑处理字符串中的转义字符( byref HotString, bEnter = false)
{
	StringReplace, Hotstring, Hotstring, ``, ````, All
	StringReplace, Hotstring, Hotstring, %A_Tab%, ``t, All
	StringReplace, Hotstring, Hotstring, `;, ```;, All
	StringReplace, Hotstring, Hotstring, `%, ```%, All


	if bEnter
	{
		StringReplace, Hotstring, Hotstring, `r`n,$rn$, All
		StringReplace, Hotstring, Hotstring, `r, $rn$, All
		StringReplace, Hotstring, Hotstring, `n, $rn$, All
		StringReplace, Hotstring, Hotstring, $rn$, ``r``n, All
	}
}





InStrMatch( Haystack, Needle, bRegEx = false,  StartingPos = 1, CaseSensitive = false  )
{
	if bRegEx
		return RegExMatch( Haystack, Needle , "", StartingPos )
	return InStr( Haystack, Needle, CaseSensitive, StartingPos )
}

StrSplit( arrName, string, DelimiterStr_ , OmitChars = "", CaseSensitive = true )
{
	Local count, pos, var_temp, len

	if string =
		return false

	if DelimiterStr_ =
		return false

	if strlen(DelimiterStr_) = 1
	{
		stringsplit %arrName%, string, %DelimiterStr_%, %OmitChars%
		return true
	}

	len := strlen( DelimiterStr_ )
	count := %arrName%0
	loop %count%
	{
		 %arrName%%a_index% =
	}
	%arrName%0 =
	count := 0

	loop
	{
		count++
		%arrName%0 := count
		pos := instr( string, DelimiterStr_, CaseSensitive )
		if pos <= 0
		{
			%arrName%%count% := string
			break
		}
		else
		{
			StringLeft %arrName%%count%, string, pos -1
			StringMid string, string , pos + len
		}
	}
	return true
}


InStrList( Haystack, NeedleList, Delimiters, CaseSensitive = false, StartingPos = 1  )
{
	local Needle,  var_pos, retPos, sperator
	local bRet := true
	sperator := StrToNeedleRegEx(Delimiters)
	StrSplit("NeedleArray", NeedleList, Delimiters )

	loop %NeedleArray0%
	{
		Needle := NeedleArray%a_index%

		if Needle <>
		{
			Needle := StrToNeedleRegEx(Needle)

			NeedleRegEx = (?<=%sperator%|^)%Needle%(?=%sperator%|$)
			if not CaseSensitive
				NeedleRegEx = i)%NeedleRegEx%

			var_pos := RegExMatch(Haystack, NeedleRegEx , "", StartingPos )

			if var_pos <= 0
			{
				retPos := 0
				break
			}
			else if retPos =
			{
				retPos := var_pos
			}
		}
	}
	return retPos
}


StrListInStrList( strList1, Delimiter1, strList2, Delimiter2, CaseSensitive = false, CaseSpace = false )
{
	StringSplit arrA, strList1, %Delimiter1%
	if arrA0 <= 0
		return false

	StringSplit arrB, strList2, %Delimiter2%
	if arrB0 <= 0
		return false

	loop %arrA0%
	{
		str1 := arrA%a_index%
		if ( str1 == "" && !CaseSpace )
			Continue

		loop %arrB0%
		{
			str2 := arrB%a_index%
			if ( str2 == "" && !CaseSpace )
				Continue
			if CaseSensitive
			{
				if ( str1 == str2 )
					return true
			}
			else
			{
				if str1 = %str2%
					return true
			}
		}
	}
	return false
}


StrAddQuot( byref _str_, l_ = "", r_ = "" )
{
	if l_ =
	{
		l_ = `"
		lNeedle = `"
	}
	else
	{
		StringReplace, lNeedle, l_, |, \|, All
	}
	if r_ =
	{
		r_ = `"
		rNeedle = `"
	}
	else
	{
		StringReplace, rNeedle, r_, |, \|, All
	}
	lNeedle = ^\s*%lNeedle%
	rNeedle = %rNeedle%\s*$
	if RegExMatch( _str_, lNeedle  ) > 0
		return false
	if RegExMatch( _str_, rNeedle  ) > 0
		return false
	_str_ := l_ . _str_ . r_
	return true
}


StrInsert@( byref _str_, needle_, newtext_=" ", offset_=0, CaseSensitive_ = true )
{
	ifNotInstring needle_, @
	{
		return false
	}
	AutoTrim off

	bRet := false
	StringReplace needle1, needle_, @, , all
	needle2 := needle_



	loop 10000
	{
		var_re := RegExMatch( _str_, needle1, var_match  )


		if var_re > 0
		{
			bFind := false
			loops := strlen( var_match ) + 1 - offset_
			loop %loops%
			{
				idx := a_index + offset_
				StringLeft lstr, var_match, idx-1
				StringMid rstr, var_match, idx
				var_temp = %lStr%@%rstr%
				var_re := RegExMatch( var_temp, needle2, var_match2  )

				if var_re = 1
				{
					bFind := true
					replaceText := lstr . newtext_ . rstr
					break
				}
			}
			if bFind
			{
				needle := StrToNeedleRegEx( var_match )
				if not CaseSensitive_
					needle := "i)" . needle

				var_temp := RegExReplace( _str_, needle , replaceText )


				if ( var_temp <> _str_ )
				{

					_str_ := var_temp
					bRet := true
					continue
				}
			}
		}
		break
	}
	AutoTrim on
	return bRet
}
; #include .\inc\string.aik






GetLVInfo( var_GuiID, var_ListView, byref _nTotalRows, byref _nDisplayRows, byref _TopIndex )
{
	LVM_GETITEMCOUNT = 4100
	LVM_GETCOUNTPERPAGE = 4136
	LVM_GETTOPINDEX = 4135
	SendMessage,LVM_GETITEMCOUNT,0,0,%var_ListView%,ahk_id %var_GuiID%
	_nTotalRows := ErrorLevel
	SendMessage,LVM_GETCOUNTPERPAGE,0,0,%var_ListView%,ahk_id %var_GuiID%
	_nDisplayRows := ErrorLevel
	SendMessage,LVM_GETTOPINDEX,0,0,%var_ListView%,ahk_id %var_GuiID%
	_TopIndex := ErrorLevel
}


GetLVAllRows( var_GuiID, var_ListView )
{
	LVM_GETITEMCOUNT = 4100
	SendMessage,LVM_GETITEMCOUNT,0,0,%var_ListView%,ahk_id %var_GuiID%
	TotalRows := ErrorLevel
	return TotalRows
}

GetLVColWidth( var_GuiID, var_row )
{
	SendMessage, 0x1029, %var_row%, 0,, ahk_id %var_GuiID%
  	return ErrorLevel
}


GetLVColumnWidth( var_GuiID, var_ListView, var_col )
{
	LVM_GETSUBITEMRECT = 4152
	LVIR_LABEL = 0x0002
	VarSetCapacity(XYstruct, 16, 0)
	InsertInteger( LVIR_LABEL, XYstruct, 0 )
	InsertInteger( var_col -1, XYstruct, 4 )
	SendMessage,LVM_GETSUBITEMRECT, 0, &XYstruct,%var_ListView%, ahk_id %var_GuiID%
	_CellX    	:= ExtractInteger(XYstruct,0,4)
	RowX2    	:= ExtractInteger(XYstruct,8,4)
	_CellW 		:= RowX2 - _CellX
	return _CellW
}


LV_GetCellRect( var_GuiID, var_ListView,  var_row, var_col, ArrayRect )
{
	Local LVM_GETTOPINDEX, LVM_GETSUBITEMRECT, LVIR_LABEL
	Local TopIndex, XYstruct, which, lx, ly, lw, lh
	LVM_GETTOPINDEX = 4135
	LVM_GETSUBITEMRECT = 4152
	LVIR_LABEL = 0x0002
	ControlGetPos,lx,ly,lw,lh,%var_ListView%,ahk_id %var_GuiID%
	SendMessage,LVM_GETTOPINDEX,0,0,%var_ListView%,ahk_id %var_GuiID%
	TopIndex := ErrorLevel

	VarSetCapacity(XYstruct, 16, 0)
	InsertInteger( LVIR_LABEL, XYstruct, 0 )
	InsertInteger( var_col , XYstruct, 4 )
	SendMessage,LVM_GETSUBITEMRECT, 0, &XYstruct,%var_ListView%, ahk_id %var_GuiID%


	which 		:= var_row -1
	InsertInteger(LVIR_LABEL  ,XYstruct,0)
	InsertInteger( var_col - 1, XYstruct,4)
	SendMessage, LVM_GETSUBITEMRECT,%which%,&XYstruct,%var_ListView%,ahk_id %var_GuiID%
	ArrayRect1    		:= ExtractInteger(XYstruct,0,4)    + lx
	ArrayRect2   		:= ExtractInteger(XYstruct,4,4) 	+ ly
	ArrayRect3    		:= ExtractInteger(XYstruct,8,4)  	+ lx
	ArrayRect4    		:= ExtractInteger(XYstruct,12,4) 	+ ly
}


GetLVCellUnderMouse( var_GuiID, var_ListView, byref _CurRow, byref _CurCol, byref _CellX, byref _CellY, byref _CellW, byref _CellH )
{

	CoordMode,MOUSE,RELATIVE
	MouseGetPos,mx,my,oID,oCNN


   	LVM_GETITEMCOUNT = 4100
	LVM_GETCOUNTPERPAGE = 4136
	LVM_GETTOPINDEX = 4135
	ControlGetPos,lx,ly,lw,lh,%var_ListView%,ahk_id %var_GuiID%
	SendMessage,LVM_GETITEMCOUNT,0,0,%var_ListView%,ahk_id %var_GuiID%
	nTotalRows := ErrorLevel
	SendMessage,LVM_GETCOUNTPERPAGE,0,0,%var_ListView%,ahk_id %var_GuiID%
	nDisplayRows := ErrorLevel
	SendMessage,LVM_GETTOPINDEX,0,0,%var_ListView%,ahk_id %var_GuiID%
	TopIndex := ErrorLevel


	LVM_GETSUBITEMRECT = 4152
	LVIR_LABEL = 0x0002
	VarSetCapacity(XYstruct, 16, 0)
	Loop,%nDisplayRows%
	{
		which := topIndex + A_Index -1
		InsertInteger(LVIR_LABEL  ,XYstruct,0)
		InsertInteger(A_Index-1   ,XYstruct,4)
		SendMessage,LVM_GETSUBITEMRECT,%which%,&XYstruct,%var_ListView%,ahk_id %var_GuiID%
		_CellY   := ExtractInteger(XYstruct,4,4) + ly
		RowY2    := ExtractInteger(XYstruct,12,4) + ly
		_CellH 	 := RowY2 - _CellY
		If( my <= RowY2 )
		{
			_CurRow    := which   +1
			currRow0   := which
			Break
		}
	}

	VarSetCapacity(XYstruct, 16, 0)
	Loop % LV_GetCount("Col")
	{
		InsertInteger(LVIR_LABEL  ,XYstruct,0)
		InsertInteger(A_Index-1   ,XYstruct,4)
		SendMessage,LVM_GETSUBITEMRECT,%currRow0%,&XYstruct,%var_ListView%,ahk_id %var_GuiID%
		_CellX    	:= ExtractInteger(XYstruct,0,4) + lx
		RowX2    	:= ExtractInteger(XYstruct,8,4) + lx
		If(mx <= RowX2 )
		{
			_CurCol := A_Index
			_CellW 		:= RowX2 - _CellX
		 	Break
		}

	}
}


GetMovedCellX( var_GuiID, var_ListView, var_CellRow, var_CellCol, var_CellX )
{
	LVM_SCROLL = 4116
	LVIR_LABEL = 0x0002
	LVM_GETSUBITEMRECT = 4152

	ControlGetPos,lx,ly,lw,lh,%var_ListView%,ahk_id %var_GuiID%
	hscrollVal := var_CellX - lx - 4
	SendMessage,LVM_SCROLL,%hscrollVal%,0,%var_ListView%,ahk_id %var_GuiID%
	VarSetCapacity(XYstruct, 16, 0)
	InsertInteger(LVIR_LABEL   ,XYstruct,0)
	InsertInteger(var_CellCol-1      ,XYstruct,4)
	currRow0 := var_CellRow - 1
	SendMessage,LVM_GETSUBITEMRECT,%currRow0%,&XYstruct,%var_ListView%,ahk_id %var_GuiID%
	return ExtractInteger(XYstruct,0,4) + lx
}

InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4)


{
    Loop %pSize%
        DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF)
}

ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4)





{
    Loop %pSize%
        result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1)
    if (!pIsSigned OR pSize > 4 OR result < 0x80000000)
        return result

    return -(0xFFFFFFFF - result + 1)
}

; #include .\inc\listview\lvfunc.aik





【点击MyListView】:
   CoordMode,MOUSE,RELATIVE
   MouseGetPos,mx,my,oID,oCNN
   If(A_GuiEvent = "DoubleClick")
   {   Gosub 【双击ListView】
   }
   Else If(A_GuiEvent = "Normal" && EnableSingleClick )
   {
   		Gosub 【单击ListView】
   }
   Else If A_GuiEvent In S,s,RightClick,ColClick,D,d,e
   {
   		GuiControl,Hide,%LV_ST%
       	GuiControl,Hide,%LV_ED%
   }

Return

【双击ListView】:
   GuiControl,Hide,%LV_ED%
   GuiControl,Hide,%LV_ST%
   DispControl := LV_ED
   spacer =
   Gosub CellReSize
   Gosub CellPosition
   GuiControl,Focus,%DispControl%
   SetTimer,isEditFocused,75
Return

【单击ListView】:
   GuiControl,Hide,%LV_ED%
   GuiControl,Hide,%LV_ST%
   DispControl := LV_ST
   spacer = %A_Space%
   Gosub CellReSize
   Gosub CellPosition
   GuiControl,Focus,%EditingLV%
Return

【调整ListView大小】:
	GetLVCellUnderMouse( g_GuiID, EditingLV, currRow, currCol, RowX, RowY, currColWidth, currColHeight )
	GetLVInfo( g_GuiID, EditingLV, TotalNumOfRows, NumOfRows, topIndex )
	return

【通过Edit实时修改MyListView对应单元格的值】:
    Gui,Submit,NoHide
    CellX_save = Col%CellX_LV%
    LV_Modify(CellY_LV,CellX_save,CellEdit)
    Return


#IfWinActive ahk_group editKeypress
+Enter::
Enter::
NumpadEnter::
【修改MyListView单元格并退出编辑状态】:
	GuiControlGet,fControl,Focus
	If(fControl = DispControl)
	{   Gui,Submit,NoHide
		CellX_save = Col%CellX_LV%
		LV_Modify(CellY_LV,CellX_save,CellEdit)
		Gosub CellHide
	}
	Return

Esc::
   Gosub CellHide
Return

#IfWinActive


CellHide:

   GuiControl, MoveDraw, CellEdit, Y-100
   GuiControl, MoveDraw, CellHighlight, Y-100
   GuiControl,Focus, %EditingLV%
Return

isEditFocused:
   GuiControlGet,cFoc,Focus
   If(cFoc != DispControl)
   {   SetTimer,isEditFocused,Off
      Gosub CellHide
   }
Return


CellReSize:
	ControlGetPos,lx,ly,lw,lh,%EditingLV%,ahk_id %g_GuiID%
	GetLVInfo( g_GuiID, EditingLV, TotalNumOfRows, NumOfRows, topIndex )
	GetLVCellUnderMouse( g_GuiID, EditingLV, currRow, currCol, RowX, RowY, currColWidth, currColHeight )

   	If(RowX < lx)
   	{
      	RowX    := GetMovedCellX( g_GuiID, EditingLV, currRow, currCol, RowX )

   	}
   	scrollWidth := TotalNumOfRows > NumOfRows ? SM_CXVSCROLL : 0
   	If(RowX+currColWidth > lx+lw-scrollWidth)
   	{
		currColWidth -= ((RowX+currColWidth) - (lx+lw-scrollWidth)) + 3
   	}
Return

CellPosition:
   CellX_LV := currCol
   CellY_LV := currRow
   LV_GetText(coltxt,CellY_LV,CellX_LV)
   edW := currColWidth
   edH := currColHeight + 1
   edX := RowX + 2
   edY := RowY + 1

   ControlMove,%DispControl%,edX,edY,edW,edH
   GuiControl,,%DispControl%,%spacer%%colTxt%
   GuiControl,Show,%DispControl%

   settimer 【延时选中可编辑的内容】, 55
Return

【延时选中可编辑的内容】:
	if ( DispControl == LV_ED )
	{
		send {home}{shift down}{end}{shift up}
	}
	settimer 【延时选中可编辑的内容】, off
Return
; #include .\inc\ListView\EditListViewBody.aik

g_VarPrefix = g_var_


get_gvar( varname )
{
	var_name := g_var_%varname%
	return GetGlobalVar( var_name )
}

set_gvar( varname, var_value )
{
	var_name := g_var_%varname%
	return SetGlobalVar( var_name, var_value )
}




GetGlobalVar( varname )
{
	global

	StrTrim(varname)
	var_temp := %varname%
	return var_temp
}


SetGlobalVar( varname, var_value )
{
	global

	StrTrim(varname)
	if varname =
		return false
	if varname is number
		return false

	if StrHaveTerminatChar( varname )
		return false
	%varname% := var_value
	return true
}


; #include .\inc\string.aik





CheckValueBeforeOp1( byref a )
{
	if a =
		return false

	if a is not number
	{
        bNegative := false
		StringLeft var_char, a, 1
		if var_char = -
		{
			bNegative := true
			StringMid, a, a, 2
		}
		a := GetGlobalVar( a )
		if a =
			return false
		if a is not number
			return false
		if bNegative
			a := -a
	}
	return true
}

CheckValueBeforeOp2( byref a, byref b )
{
	if ( CheckValueBeforeOp1( a ) && CheckValueBeforeOp1( b ) )
	{
		return true
	}
	return false
}

myadd(a,b)
{

	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	return a+b
}

mysub( a, b )
{

	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	return a-b
}

mymul( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	return a * b
}

mymul2( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	return a ** b
}

mydiv( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	if b = 0
		return "EXP_ERROR"
	return a / b
}

mydiv2( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	if b = 0
		return "EXP_ERROR"
	return a // b
}


myRelaOper( operator, a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"

	if ( operator == ">=" )
		return a >= b
	else if ( operator == ">" )
		return a > b
	else if ( operator == "<=" )
		return a <= b
	else if ( operator == "<" )
		return a < b
	return "EXP_ERROR"
}

myEqual( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	if ( a == b )
		return true
	return false
}

myNotEqual( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"
	if ( a != b )
		return true
	return false
}


myAnd( a, b )
{
	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"

	if ( a && b )
		return true
	return false
}

myOr( a, b )
{

	if not CheckValueBeforeOp2(a, b)
		return "EXP_ERROR"

	if ( a || b )
		return true
	return false
}

mymath( FuncName, Params )
{
	lParam =
	rParam =
	ifinstring Params, `,
	{
		StrSplit2Sub( Params, "`,", lParam, rParam )

		lParam := mycalc0( lParam )
		if ( lParam == "EXP_ERROR" )
        	return "EXP_ERROR"

		rParam := mycalc0( rParam )
		if ( rParam == "EXP_ERROR" )
        	return "EXP_ERROR"

		if not CheckValueBeforeOp2( lParam, rParam )
		{
			return "EXP_ERROR"
		}
	}
	else
	{
		Params := mycalc0( Params )
		if ( Params == "EXP_ERROR" )
        	return "EXP_ERROR"

		if not CheckValueBeforeOp1( Params )
		{
			return "EXP_ERROR"
		}
	}

	if FuncName = Sqrt
		return Sqrt( Params )
	else if FuncName = Round
	{
		if rParam <>
			return Round( lparam, rparam )
		else
			return Round( Params )
	}
	else if FuncName = Mod
	{
		if lParam is not integer
			return "EXP_ERROR"
		if rParam is not integer
			return "EXP_ERROR"
		return Mod( lParam, rParam )
	}
	else if FuncName = Sin
		return Sin( Params )
	else if FuncName = Sin2
		return Sin( Params * 3.1415926 / 180 )
	else if FuncName = Cos
		return Cos( Params )
	else if FuncName = Cos2
		return Cos( Params * 3.1415926 / 180  )
	else if FuncName = Tan
		return Tan( Params )
	else if FuncName = Tan2
		return Tan( Params * 3.1415926 / 180  )
	else if FuncName = Abs
		return Abs( Params )
	else if FuncName = Ceil
		return Ceil( Params )
	else if FuncName = Exp
		return Exp( Params )
	else if FuncName = Floor
		return Floor( Params )
	else if FuncName = Log
		return Log( Params )
	else if FuncName = Ln
		return Ln( Params )
	else if FuncName = ASin
	{
		if ( Params >= -1 && Params <= 1 )
			return ASin( Params )
		return "EXP_ERROR"
	}
	else if FuncName = ACos
	{
		if ( Params >= -1 && Params <= 1 )
			return ACos( Params )
		return "EXP_ERROR"
	}
	else if FuncName = ATan
		return ATan( Params )

	return "EXP_ERROR"
}


TryRelaOper( byref var_exp )
{
	loop
	{

		var_oper =
		len := strlen( var_exp )
		var_pos := len + 1

		TempPos := instr( var_exp, ">=" )
		if ( TempPos > 0 && TempPos < var_pos )
		{
			var_oper := ">="
			var_pos := TempPos
		}

		TempPos := instr( var_exp, "<=" )
		if ( TempPos > 0 && TempPos < var_pos )
		{
			var_oper := "<="
			var_pos := TempPos
		}
		TempPos := instr( var_exp, ">" )
		if ( TempPos > 0 && TempPos < var_pos )
		{
			var_oper := ">"
			var_pos := TempPos
		}
		TempPos := instr( var_exp, "<" )
		if ( TempPos > 0 && TempPos < var_pos )
		{
			var_oper := "<"
			var_pos := TempPos
		}

		if var_oper =
			return true

		if var_oper in >=,<=,>,<
		{
			if ( var_pos > 0 && var_pos < len )
			{
				if not find_pre_word(var_exp, var_pos, aa, _spos0, _epos0 )
					return "EXP_ERROR"
				if not find_next_word(var_exp, var_pos, bb, _spos1, _epos1 )
					return "EXP_ERROR"
				if ( aa == "" || bb == "" )
					return "EXP_ERROR"
				var_re := myRelaOper( var_oper, aa, bb )

				if ( var_re == "EXP_ERROR" || var_re == "" )
					return "EXP_ERROR"
				if var_re is not number
				{
					return "EXP_ERROR"
				}
				if ( _spos0 >= _epos1 || _spos0 <= 0 || _epos1 > len )
					return "EXP_ERROR"
				if StrReplaceBetween( var_exp, var_re, _spos0, _epos1 )
	        		continue
			}
		}

		return "EXP_ERROR"
	}
}

CalcOneLoop( var_exp, pos, operator, byref _startpos, byref _endpos )
{

	if not find_pre_word(var_exp, pos, aa, _spos0, _epos0 )
		return "EXP_ERROR"
	if not find_next_word(var_exp, pos, bb, _spos1, _epos1 )
		return "EXP_ERROR"
	if ( aa == "" || bb == "" )
		return "EXP_ERROR"

	if operator = **
		var_re := mymul2( aa, bb )
	else if operator = *
		var_re := mymul( aa, bb )
	else if operator = //
		var_re := mydiv2( aa, bb )
	else if operator = /
		var_re := mydiv( aa, bb )
	else if operator = +
		var_re := myadd( aa, bb )
	else if operator = -
	{
		var_re := mysub( aa, bb )
	}
	else if ( operator == "!=" )
	{
		var_re := myNotEqual( aa, bb )
	}
	else if ( operator == "=" )
	{
		var_re := myEqual( aa, bb )
	}
	else if ( operator == "&&" )
	{
		var_re := myAnd( aa, bb )
	}
	else if ( operator == "||" )
	{

		var_re := myOr( aa, bb )
	}
	else
		return "EXP_ERROR"

	if ( var_re == "EXP_ERROR" || var_re == "" )
		return "EXP_ERROR"

	if var_re is not number
	{
		return "EXP_ERROR"
	}

	if ( _spos0 >= _epos1 )
		return "EXP_ERROR"


	_startpos := _spos0
	_endpos := _epos1



	return var_re
}



mycalc0( var_exp )
{
	var_tempexp := var_exp
	StrTrim( var_tempexp )
	if var_tempexp =
		return "EXP_ERROR"


    loop
    {
    	StringGetPos temppos, var_tempexp, -, L%a_index%

    	if errorlevel
    		break


    	var_char := StrGetAt( var_tempexp, temppos )
    	if var_char is not space
    	{
    		StrInsertAt( var_tempexp, temppos + 1, " ")
    	}
    }


	loop
	{



		if var_tempexp is number
			return var_tempexp


		StringGetPos, pos, var_tempexp, **
    	if not ErrorLevel
        {
			var_re := CalcOneLoop( var_tempexp, pos+1, "**", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
	        }
        	return "EXP_ERROR"
        }

		StringGetPos, pos, var_tempexp, *
    	if not ErrorLevel
        {
        	divpos := instr( var_tempexp, "/" )
        	if ( divpos > 0 && divpos < ( pos + 1 ) )
        	{

        	}
        	else
        	{
				var_re := CalcOneLoop( var_tempexp, pos+1, "*", _startpos, _endpos )
				if ( var_re != "EXP_ERROR" )
				{
			    	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
			    		continue
	        	}
	        	return "EXP_ERROR"
        	}
        }


		StringGetPos, pos, var_tempexp, /
    	if not ErrorLevel
        {
			var_re := CalcOneLoop( var_tempexp, pos+1, "/", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }


		StringGetPos, pos, var_tempexp, //
    	if not ErrorLevel
        {
        	var_re := CalcOneLoop( var_tempexp, pos+1, "//", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }


		StringGetPos, pos, var_tempexp, -
    	if not ErrorLevel
        {
        	bFindSub := true
            pos++


			if not find_pre_word(var_tempexp, pos, var_temp, _spos0, _epos0 )
			{

				loop % strlen( var_tempexp ) - pos
				{
					var_char := StrGetAt( var_tempexp, pos + 1 )
					if var_char is space
					{
						StrReplaceAt( var_tempexp, pos + 1, "" )
						continue
					}
					break
				}


				pos++
				StringGetPos, pos, var_tempexp, -, L2
				if ErrorLevel
				{

					bFindSub := false
				}
				else
				{

					pos++
				}
			}

            if bFindSub
			{
	        	addpos := instr( var_tempexp, "+" )
	        	if ( addpos > 0 && addpos < ( pos + 1 ) )
	        	{

	        	}
	        	else
	        	{

	        		temppos := pos + 1
	        		loop
	        		{
	        			var_char := StrGetAt( var_tempexp, temppos )
	        			if var_char is not space
	        			{
	        				StrInsertAt( var_tempexp, temppos, " " )
	        			}
	        			StringGetPos temppos, var_tempexp, -, L, temppos
	        			if not errorlevel
	        			{
	        				temppos := temppos + 2
	        				continue
	        			}
	        			break
	        		}


					var_re := CalcOneLoop( var_tempexp, pos, "-", _startpos, _endpos )
					if ( var_re != "EXP_ERROR" )
					{

			        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
			        		continue
		        	}
		        	return "EXP_ERROR"
	        	}
        	}

        }


		StringGetPos, pos, var_tempexp, +
		if not ErrorLevel
        {

			var_re := CalcOneLoop( var_tempexp, pos+1, "+", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }


		var_re := TryRelaOper( var_tempexp )
		if ( var_re == "EXP_ERROR")
			return "EXP_ERROR"



		StringGetPos, pos, var_tempexp, !=
		if not ErrorLevel
        {

			var_re := CalcOneLoop( var_tempexp, pos+1, "!=", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }



		StringGetPos, pos, var_tempexp, =
		if not ErrorLevel
        {

			var_re := CalcOneLoop( var_tempexp, pos+1, "=", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }


		StringGetPos, pos, var_tempexp, &&
		if not ErrorLevel
        {

			var_re := CalcOneLoop( var_tempexp, pos+1, "&&", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }


		StringGetPos, pos, var_tempexp, ||
		if not ErrorLevel
        {

			var_re := CalcOneLoop( var_tempexp, pos+1, "||", _startpos, _endpos )
			if ( var_re != "EXP_ERROR" )
			{
	        	if StrReplaceBetween( var_tempexp, var_re, _startpos, _endpos )
	        		continue
        	}
        	return "EXP_ERROR"
        }


        if find_next_word(var_tempexp, 0, _outword, _startpos, _endpos )
        {


        	if find_next_word( var_tempexp, _endpos, var_temp, startpos, endpos )
        	{
        		return "EXP_ERROR"
        	}

        	if _outword <>
        	{
        		if _outword is number
        		{
        			return _outword
        		}
                else
				{
					_outword := GetGlobalVar( _outword )
					if _outword <>
					{
						if _outword is number
							return _outword
					}
				}
        	}
        }
		return "EXP_ERROR"
	}


	if var_tempexp is not number
		return "EXP_ERROR"

	return var_tempexp
}



mycalc1( var_exp )
{
	var_tempexp := var_exp


	loop
	{
		StringGetPos rpos, var_tempexp, ), L%a_index%
		if errorlevel
		{
			break
		}
		rpos++
		loop % strlen( var_tempexp ) - rpos
		{
			var_char := StrGetAt( var_tempexp, rpos + a_index )
			if var_char is not space
			{
				if var_char = (
				{
					StrInsertAt( var_tempexp, rpos + a_index, "*" )
				}
				break
			}
		}
	}


	loop
	{

	    lpos =
		rpos := InStr( var_tempexp, ")" )

		if rpos = 0
		{
			lpos := InStr( var_tempexp, "(" )

			if lpos = 0
			{
				return mycalc0( var_tempexp )
			}
	        else
				return "EXP_ERROR"
		}
		else
		{
			StringLeft var_temp, var_tempexp, rpos
			StringGetPos, lpos, var_temp, ( , R
	        if ErrorLevel
			{
				return "EXP_ERROR"
			}
			lpos++

			if ( is_terminate_pos( var_tempexp, lpos - 1 ) == 0 )
			{
				if ( find_pre_word( var_tempexp, lpos, _preword, _startpos, _endpos ) )
				{
					if ( _endpos == ( lpos - 1 ) && _preword != "" )
					{
						StringLower, _preword, _preword



						if _preword in sqrt,abs,log,ln,mod,round,sin,cos,tan,asin,acos,atan,ceil,exp,floor,sin2,cos2,tan2
						{
							var_params =
							StringMid var_params, var_tempexp, lpos +1, rpos - lpos - 1
							var_temp := mymath( _preword, var_params )

							if ( var_temp != "EXP_ERROR" && CheckValueBeforeOp1( var_temp ) )
							{

					        	if StrReplaceBetween( var_tempexp, var_temp, _startpos, rpos )
					        		continue
				        	}
							return "EXP_ERROR"
						}
					}
				}
			}

			var_params =
			StringMid var_params, var_tempexp, lpos +1, rpos - lpos - 1
			var_temp := mycalc0( var_params )

			if ( var_temp != "EXP_ERROR" && CheckValueBeforeOp1( var_temp ) )
			{
	        	if StrReplaceBetween( var_tempexp, var_temp, lpos, rpos )
	        		continue
        	}
			return "EXP_ERROR"
		}
		return "EXP_ERROR"
	}
	return var_tempexp
}


CalcLine( line )
{

	if line =
		return

	StringReplace line, line, $, g_var_, ALL

	pos := instr( line, "=" )

	var_name =
	var_exp := line
	len := strlen( line )

	if pos >= 1
	{
		StringLeft var_name, line, pos -1
		StringRight var_exp, line, len - pos
	}
	StrTrim( var_exp )
	if var_exp <>
	{
		var_exp := mycalc1( var_exp )
	}

	if pos <= 0
	{
		line := var_exp
	}
	else
	{
		if var_name <>
		{
		 	if not SetGlobalVar( var_name, var_exp )
		 	{
		 		var_exp = 设置变量 [ %var_name% = %var_exp% ] 时出错
		 	}
		}
		line = %var_name% = %var_exp%
	}
	StringReplace line, line, g_var_, $, ALL
	return line
}


CalcText( var_Text )
{
	var_re =
	StringReplace var_text, var_text, `r, , All
	loop parse, var_Text, `n
	{
		if a_loopfield =
			continue
		line := CalcLine( a_loopfield )
		var_re = %var_re%%line%`r`n
	}
	return var_re
}
; #include .\inc\expression.aik
; #include .\inc\common.aik
; #include .\inc\string.aik


read_ini(Filename_, Section_, Key_, Default_ = "")
{
	IniRead var_temp, %Filename_%, %Section_%, %Key_%, %Default_%
	if ( var_temp == "ERROR" )
		var_temp := Default_
	Return var_temp
}
ReadTempIni( var_sec, var_key, var_default = "" )
{
	IniRead var_temp, temp.ini, %var_sec%, %var_key%, %var_default%
	if ( var_temp == "ERROR" )
		var_temp := var_default
	Return var_temp
}


write_ini(Filename_, Section_, Key_, Value_, isAsk = false )
{
	if isAsk
	{
		var_read := read_ini( Filename_, Section_, Key_, "" )
		if var_read <>
		{
			var_text = %Filename_%文件的%Section_%节中，
			var_text = %var_text%`n%Key_%已经存在，要替换吗 ？
			var_text = %var_text%`n`n<%Key_%>的值将从`n原始值：%var_read%`n替换为：%Value_%

			MsgBox, 4,ini文件存在重复的key, %var_text%
			IfMsgBox No
			{
				return false
			}
		}
	}
	IniWrite, %Value_%, %Filename_%, %Section_%, %Key_%
	return true
}

WriteTempIni( var_sec, var_key, var_value )
{
	IniWrite, %var_value%, temp.ini, %var_sec%, %var_key%
}


del_ini( Filename_, Section_, Key_, isAsk = false )
{
	if Key_ <>
	{
		if isAsk
		{
			var_read := read_ini( Filename_, Section_, Key_, "" )
			var_text = %Filename_%文件的[%Section_%]节中，`n%Key_% = %var_read%`n`n你确定要删除<%Key_%>吗 ？
			MsgBox, 4, Ini文件删除key, %var_text%
			IfMsgBox No
			{
				return false
			}
		}
		IniDelete %Filename_%, %Section_%, %Key_%
	}
	else
	{
		if isAsk
		{
			var_text = 准备删除%Filename_%文件的[%Section_%]`n`n你确定要删除整个Section 吗 ？
			MsgBox, 4, Ini文件删除Section,  %var_text%
			IfMsgBox No
			{
				return false
			}
		}
		IniDelete %Filename_%, %Section_%
	}
	return true
}


read_seckeys( byref OutSeckeys, Filename_, Section_ , bCaseSense = false )
{
	return read_sec( OutSeckeys, Filename_, Section_ , bCaseSense, true )
}


read_sec( byref var_sec, Filename_, Section_ , bCaseSense = false, bKeysOnly = false )
{
	count = 0
	if  bCaseSense = 1
	{
		StringCaseSense, On
	}


	bFindSec := false
	var_sec =
	cur_sec =
	Loop, read, %Filename_%
	{

		var_pos := get_first_char(A_LoopReadLine, var_char)
 		If ( var_char == "[" )
		{
			IfInString A_LoopReadLine, ]
			{

				cur_sec := StrMid2Sub( A_LoopReadLine, "[", "]" )


				continue
			}
		}

		if ( cur_sec == Section_ )
		{
			StringGetPos, varPos, A_LoopReadLine, =
			if not errorlevel
			{
				count++
				if bKeysOnly = 1
				{
					stringleft var_key, A_LoopReadLine, %varPos%
					var_sec = %var_sec%`n%var_key%


				}
				else
				{
					var_sec = %var_sec%%A_LoopReadLine%`n
				}
			}
		}
	}
	StringCaseSense, Off









	return count
}




read_sections( byref var_secqueue, inifile, separator = "|", CaseSense = false )
{
	ifnotexist %inifile%
	{
		return
	}
	count = 0
	var_secqueue =
	if  bCaseSense = 1
	{
		StringCaseSense, On
	}

	bFindSec := false
	var_sec =
	cur_sec =
	Loop, read, %inifile%
	{
		var_pos := get_first_char(A_LoopReadLine, var_char)
 		If ( var_char == "[" )
		{
			IfInString A_LoopReadLine, ]
			{
				cur_sec := StrMid2Sub( A_LoopReadLine, "[", "]" )
				if cur_sec <>
				{
					count++
					∑连接字符串( var_secqueue, cur_sec, separator )
				}
			}
		}
	}
	StringCaseSense, Off
	return count
}




read_inikeys( byref var_keys, Filename_, bCaseSense = false )
{
	count = 0
	if  bCaseSense = 1
	{
		StringCaseSense, On
	}

	var_keys =
	Loop, read, %Filename_%
	{
		StringGetPos, varPos, A_LoopReadLine, =
		if not errorlevel
		{
			stringleft var_key, A_LoopReadLine, %varPos%
			var_keys = %var_keys%%var_key%`n
			count++
		}
	}
	StringCaseSense, Off

	return count
}



IniFileRead( var_fileName )
{
	FileRead var_fileContent, %var_fileName%
	if ErrorLevel
	Return

	if var_fileContent =
	Return

	var_newContent =
	StringReplace var_fileContent, var_fileContent, `r, , All
	loop parse, var_fileContent, `n
	{
		if a_loopfield =
		Continue


		var_line := RegExReplace( a_loopfield, "(\s|^)`;.*", "" )
		if var_line =
		Continue


		IfNotInString var_line, =
		{
			if ( RegExMatch( var_line, "^\[.+\]") == 0 )
			{
				Continue
			}
		}
		var_newContent = %var_newContent%%var_line%`n
	}
	Return var_newContent
}



SecArrayFromIniMem( _inimem, _section, _arrname )
{
	global
	local loops := %_arrname%0
	local var_sec =
	local i
	local var_line
	local var_match
	loop %loops%
	{
		%_arrname%%a_index% =
	}
	%_arrname%0 := 0

	if _inimem =
		Return 0

	if _section =
		Return 0


	Loop parse, _inimem, `n
	{
		if a_loopfield =
			continue

		var_line := A_LoopField

		if ( RegExMatch( var_line, "^\[.+\]", var_match ) > 0 )
		{
			var_sec := RegExReplace(var_match,"[\[\]]","")
		}
		else if var_sec = %_section%
		{
			%_arrname%0 ++
			i := %_arrname%0
			%_arrname%%i% := var_line
		}
	}
	i := %_arrname%0
	return i
}


FindFromIniMem( _inimem, _section, _keyName, _default = "" )
{
	if _inimem =
		Return _default

	if _section =
		Return _default

	if _keyName =
		Return _default


	Loop parse, _inimem, `n
	{
		var_line := A_LoopField

		if ( RegExMatch( var_line, "^\[.+\]", var_match ) > 0 )
		{
			var_sec := RegExReplace(var_match,"[\[\]]","")
		}
		else if var_sec = %_section%
		{
			varPos := InStr( var_line, "=" )
			if varPos > 0
			{
				stringleft keyname, var_line, varPos - 1
				if keyname = %_keyName%
				{
					StringMid keyvalue, var_line, varPos + 1
					Return keyvalue
				}
			}
		}
	}
	return _default
}
; #include .\inc\inifile.aik
g_RemoveToolTipList =

settooltipvar(byref var_tooltip,var_text="无提示内容",var_time=1000)
{

	var_temp:=var_tooltip
	var_tooltip:=var_text
	sleep %var_time%
	var_tooltip:=var_temp
	return
}



tooltipshow(var_temp="无提示内容",var_time=800,var_tipnum=2)
{
	tooltip %var_temp%,,,%var_tipnum%
	sleep %var_time%
	tooltip,,,%var_tipnum%
}



tooltipx( idx, text="", var_time=2500 )
{
	global g_RemoveToolTipList
	tooltip %text%,,,%idx%


	if text <>
	{
		StrListAdd( g_RemoveToolTipList, idx, "|" )
		settimer , 【RemoveToolTipX】, %var_time%
	}
}


tipword(string="无提示内容",var_time=2000)
{
	tooltip3(string,var_time)
}



talkshow(var_text="无提示内容",var_title="",var_time=5000)
{
	TrayTip, %var_title%, %var_text%
	SetTimer, RemoveTrayTip, %var_time%
	return

	RemoveTrayTip:
	SetTimer, RemoveTrayTip, Off
	TrayTip
	return
}



tooltip7(string="无提示内容",var_time=2500)
{
	if string =
		Return

	tooltip %string%,,,7
	SetTimer, RemoveToolTip7, %var_time%
	return

	RemoveToolTip7:
	SetTimer, RemoveToolTip7, Off
	tooltip ,,,,7
	return
}


tooltip5(string="无提示内容",var_time=2000)
{
	if string =
		Return

	tooltip %string%,,,5
	SetTimer, RemoveToolTip5, %var_time%
	return

	RemoveToolTip5:
	SetTimer, RemoveToolTip5, Off
	tooltip ,,,,5
	return
}


tooltip3(string="无提示内容",var_time=2000)
{
	if string =
		Return

	tooltip %string%,,,3
	SetTimer, RemoveToolTip3, %var_time%
	return

	RemoveToolTip3:
	SetTimer, RemoveToolTip3, Off
	tooltip ,,,,3
	return
}


GestureTip( str="", var_time=800 )
{
	tooltipx( 19, str, var_time )
}

CmdStringTip( str="", var_time=1200 )
{
	tooltipx( 18, str, var_time )
}

【RemoveToolTipX】:
	SetTimer 【RemoveToolTipX】, off
	loop parse, g_RemoveToolTipList, |
	{
		idx := a_loopfield
		if idx is integer
		{
			tooltip ,,,,%idx%
		}
	}
	return
; #include .\inc\tip.aik
