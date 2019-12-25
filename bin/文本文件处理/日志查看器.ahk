#NoTrayIcon 
#include ..\..\

change_icon()                           ;; 设置图标

;;---全局变量----------------------------------------------------------------
g_title = 日志查看器
g_fileName = %1%						;; 文件名称
g_fileSize = 0
g_fileData =                            ;; 保存文件原始数据
g_view =                                ;; 保存显示的文件
g_statustip =							;; 状态栏临时显示内容
g_VarPrefix = g_var_                    ;; 用户设置的变量，自动将$替换成该前缀

g_curPage = 1							;; 当前显示的页数
g_PageLines = 100						;; 设置一页显示多少行
g_PageNum = 1							;; 总页数 
g_PageSource = raw						;; 当前显示的是原始数据(raw)还是缓存数据(view)

ADD_FILE_PRE = 【追加文件】 
ADD_FILE_LINE = +++++++++++++++++++++++++++++++++++++++++++++

g_PageLableList = 176,216,256,296,336,376,416,456,496,536
StringSplit g_XArray, g_PageLableList, `,


;;---设置可编辑ListView的属性------------------------------------------------
g_LVTitle = $变量名|L左边字符|R右边字符|保留条件|过滤条件	;; ListView标题
g_GuiID =    							;; 存放窗口GuiID
g_lvOptions =  x410 y40 w321 h110 r30 	;; ListView的位置
EnableSingleClick = 1   ;; whether or not to do cell highlighting on singleclick
LV_ED = Edit12			;; 指定与ListView相关的Edit名称
LV_ST = Static26		;; 指定与ListView相关的Text名称


;;---准备好右键点击日志显示框的快捷菜单--------------------------------------
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


;;---显示窗口----------------------------------------------------------------
gui +resize
Gui, Add, Edit, x6 y190 w741 h336 v_MyEdit, 
Gui, Add, StatusBar,, 状态栏

;;---分页相关----------------------------------------------------------------
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



;;---产生分页选项卡----------------------------------------------------------
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

;Gui, Add, ListView, x410 y40 w320 h110 -ReadOnly Grid v_MyListView, $变量名|左边字符|右边字符
#include .\inc\listview\guiaddeditListView.aik ;; 添加可编辑ListView

Gui, Add, Text, x400 y15 w340 h20	;; 仅用于遮挡Tab选项卡上方横线
Gui, Add, Text, x400 y10 w10 h23 , $
Gui, Add, Text, x482 y10 w10 h23 , L
Gui, Add, Text, x572 y10 w10 h23 , R
Gui, Add, Edit, x410 y10 w70 h23 	v_expVar, 变量名
Gui, Add, Edit, x490 y10  w80 h23 	v_expL
Gui, Add, Edit, x580 y10  w80 h23 	v_expR
Gui, Add, Button, x665 y10 w33 h25 g【ListView中增加变量】, 增
Gui, Add, Button, x697 y10 w33 h25 g【删除ListView选中的变量】, 删

/*
LV_Add("", "$var2", "aaa", "1111")
LV_Add("", "$var2", "bbb", "2222")
LV_Add("", "$var2", "ccc", "3333")
*/

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
; Generated using SmartGUI Creator 4.0
Gui, Show, h556 w756, %g_title%

                                    
;;---如果运行时带有参数，则将参数作为要打开的文件打开之----------------------
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


;;---退出事件----------------------------------------------------------------
GuiClose:
ExitApp

;;---窗口大小调整事件--------------------------------------------------------
GuiSize:
	;; 调整选项卡与、编辑框的位置
	GuiControlGet, EditPos, Pos, _MyEdit
	width := A_GuiWidth - 15
	edt_height := a_GuiHeight - 30 - EditPosY
	if edt_height < 10
		edt_height = 10
		
	GuiControl, MoveDraw, _MyTab, w%width% 
	GuiControl, MoveDraw, _MyEdit, w%width% h%edt_height%
	
	;; 调整首页文件列表的宽度
	width := A_GuiWidth - 25 - 250
	GuiControl, MoveDraw, _MyListbox, w%width% 
	;; 调整配置选项卡的配置列表
	GuiControl, MoveDraw, _CfgListbox, w%width% 	;; 调整ListView的大小，不能省略

	;; 调整表达式选项卡中的变量列表
	width := A_GuiWidth - 25 - 410
	GuiControl, MoveDraw, _MyListView, w%width% 	;; 调整ListView的大小，不能省略
	
	;; 调整“过滤”选项卡中的控件位置
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

	;; 调整计算器窗口的大小
	width := A_GuiWidth - 25 - 120
	GuiControl, MoveDraw, _edtCalc, w%width% 

	gosub 【调整ListView大小】
	
	return	
	
;;---响应右键点击------------------------------------------------------------
GuiContextMenu:  
	;; 右键点击了日志显示框
	if A_GuiControl = _MyEdit
	{
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	return

;;---拖拽事件响应------------------------------------------------------------
GuiDropFiles:
	;; 如果拖拽到日志显示框，则打开该文件 
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
	;; 如果拖拽到文件列表，则添加拖拽的文件
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


;;---【打开】按钮------------------------------------------------------------
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
    SaveArrayToFile( g_PageSource, fileName )       ;; 正在保存
	GuiControl, Enable, _MyTab
	SB_SetText("") 	
	return
	
	
【查看原始内容】:
;   msgbox 查看原始内容 g_rawArray[%g_rawArray0%]
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
    JustFind()                          ;; 仅查找保留的内容，并保存到缓存
    ShowViewPage( 1 )                   ;; 显示刚刚查找出来的内容
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
	FindFilt( )							;; 查找并过滤，并保存到缓存
    ShowViewPage( 1 )                   ;; 显示刚刚查找出来的内容
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
    JustFilt()                          ;; 仅过滤指定的内容，并保存到缓存
    ShowViewPage( 1 )                   ;; 显示刚刚查找出来的内容
	GuiControl, Enable, _btnRe
	GuiControl, Enable, _btnBoth	
	GuiControl, Enable, _btnFi    
	SB_SetText("")		
	return
	
;; 配置信息放在temp.ini文件的[日志查看器]一节中；格式如：
;; 配置名称 = 保留条件|过滤条件|变量左边字符|变量右边字符|包含条件|过滤条件|开始条件|表达式|
;;            $变量1名称`变量1左字符`变量1右字符`包含条件`过滤条件\n
;;            $变量2名称`变量2左字符`变量2右字符`包含条件`过滤条件\n ......
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
		;; 检查配置名称是否已经存在
		msgbox 4, 配置名重复, 输入的配置名称<%KeyName%>已经存在，`n`n%keyName% = %var_read%`n`n是否要替换之?
		if msgbox no
		{
			return
		}		
	}
	;; 将当前的配置生成为一个字符串
	var_cfg := CreateCurCFG()
	
	;; 检查配置文件中是否已经保存过该配置
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


#include .\bin\文本文件处理\日志查看器_页数管理.aik
#include .\bin\文本文件处理\日志查看器_最值.aik
#include .\bin\文本文件处理\日志查看器_快捷键.aik
#include .\bin\文本文件处理\日志查看器_表达式.aik
#include .\bin\文本文件处理\日志查看器_帮助.aik
#include .\bin\文本文件处理\日志查看器_函数.aik
#include .\inc\string.aik
#include .\inc\ListView\EditListViewBody.aik
#include .\inc\expression.aik
#include .\inc\inifile.aik
#include .\inc\tip.aik
