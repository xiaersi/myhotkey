; <COMPILER: v1.0.48.5>
#NoTrayIcon
; #include ..\..\

change_icon()


g_title = ��־�鿴��
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

ADD_FILE_PRE = ��׷���ļ���
ADD_FILE_LINE = +++++++++++++++++++++++++++++++++++++++++++++

g_PageLableList = 176,216,256,296,336,376,416,456,496,536
StringSplit g_XArray, g_PageLableList, `,



g_LVTitle = $������|L����ַ�|R�ұ��ַ�|��������|��������
g_GuiID =
g_lvOptions =  x410 y40 w321 h110 r30
EnableSingleClick = 1
LV_ED = Edit12
LV_ST = Static26



Menu, MyContextMenu, Add, ����(&C),  ���Ҽ����ơ�
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, ����->��������->������(&R),  �����Ƶ���������������
Menu, MyContextMenu, Add, ����->��������->���˿�(&F),  �����Ƶ������������˿�
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, ����->����ֵ->�������(&1),  �����Ƶ�����ֵ������ߡ�
Menu, MyContextMenu, Add, ����->����ֵ->�����ұ�(&2),  �����Ƶ�����ֵ�����ұߡ�
Menu, MyContextMenu, Add, ����->����ֵ->��������(&3),  �����Ƶ�����ֵ����������
Menu, MyContextMenu, Add, ����->����ֵ->��������(&4),  �����Ƶ�����ֵ����������
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, ����->���ʽ->��ʼ����(&5), ��ѭ����ʼ������
Menu, MyContextMenu, Add, ����->���ʽ->��������(&6), ����ӱ��������ơ�
Menu, MyContextMenu, Add, ����->���ʽ->����ַ�(&7), ����ӱ���������ַ���
Menu, MyContextMenu, Add, ����->���ʽ->�ұ��ַ�(&8), ����ӱ������ұ��ַ���
Menu, MyContextMenu, Default, ����(&C)



gui +resize
Gui, Add, Edit, x6 y190 w741 h336 v_MyEdit,
Gui, Add, StatusBar,, ״̬��


Gui, Add, Text, x10 y168 w50 h20 +Center v_lblSource, ԭʼ����
Gui, Add, Button, x66 y165 w50 h20 	g����һҳ��, ��һҳ
Gui, Add, Button, x116 y165 w50 h20	g����һҳ��, ��һҳ
Gui, Add, Text, x%g_XArray1% y168 w30 h20 +Center  v_lbl1 	g��Page1��, 1
Gui, Add, Text, x%g_XArray2% y168 w30 h20 +Center  v_lbl2 	g��Page2��, 2
Gui, Add, Text, x%g_XArray3% y168 w30 h20 +Center  v_lbl3 	g��Page3��, 3
Gui, Add, Text, x%g_XArray4% y168 w30 h20 +Center  v_lbl4 	g��Page4��, 4
Gui, Add, Text, x%g_XArray5% y168 w30 h20 +Center  v_lbl5 	g��Page5��, 5
Gui, Add, Text, x%g_XArray6% y168 w30 h20 +Center  v_lbl6 	g��Page6��, 6
Gui, Add, Text, x%g_XArray7% y168 w30 h20 +Center  v_lbl7 	g��Page7��, 7
Gui, Add, Text, x%g_XArray8% y168 w30 h20 +Center  v_lbl8 	g��Page8��, 8
Gui, Add, Text, x%g_XArray9% y168 w30 h20 +Center  v_lbl9 	g��Page9��, 9
Gui, Add, Text, x%g_XArray10% y168 w30 h20 +Center  v_lbl10 g��Page10��, 10
Gui, Add, Button, x576 y165 w50 h20 g����ʮҳ��, ��ʮҳ
Gui, Add, Button, x626 y165 w50 h20 g����ʮҳ��, ��ʮҳ
Gui, Add, Text, x676 y168 w100 h20 +Center  v_lblAllPage, ��ҳ��
Gui, Add, Text, x576 y168 w30 h15 +Center  v_lblCur  +Border cBlue , Search




Gui, Add, Tab2, x6 y10 w741 h150 v_MyTab, ����ҳ��|��������|����ֵ|���ʽ|������|����|����
Gui, Tab, ����ҳ��
Gui, Add, Button, x26 y45 	w100 h30 v_btn_OpenFile	g���򿪡�, ��  ��
Gui, Add, Button, x136 y45 w100 h30	 v_btn_AddFile	g��׷���ļ���, ׷���ļ�

Gui, Add, Button, x26 y80 	w100 h30 v_btn_SaveFile g�����Ϊ��, ���Ϊ
Gui, Add, Button, x136 y80 	w100 h30 v_btn_Clear	g��������ݡ�, �������

Gui, Add, Button, x26 y115 	w70 h30  g���鿴ԭʼ���ݡ�, ԭʼ����
Gui, Add, Button, x96 y115 	w70 h30  g���鿴�������ݡ�, ��������
Gui, Add, Button, x166 y115 w70 h30  g���鿴��ʱ���桿, ��ʱ����

Gui, Add, Text, x250 y32 w90 h15, �ļ��б�
Gui, Add, ListBox, x250 y45 w481 h110 v_MyListbox


Gui, Tab, ��������
Gui, Add, Text, x16 y35 w280 v_lblRe, Ҫ����������
Gui, Add, Edit, x16 y50 w298 h100 	v_edtRe,
Gui, Add, Text, x438 y35 w300 v_lblFi, Ҫ���˵�����
Gui, Add, Edit, x438 y50 w298 h100 	v_edtFi, %ADD_FILE_PRE%`r`n%ADD_FILE_LINE%
Gui, Add, Button, x338 y45 w80 h25 	v_btnFile 	g���鿴ԭʼ���ݡ�, ����ԭ��
Gui, Add, Button, x338 y70 w80 h25 	v_btnRe 	g������������ָ�����ݵ��С�, �����ҡ�
Gui, Add, Button, x338 y95 w80 h25 	v_btnBoth 	g����������˰�ťͬʱ��Ч��, ��ͬʱ��
Gui, Add, Button, x338 y120 w80 h25 v_btnFi 	g�����˰���ָ�����ݵ��С�, �����ˣ�

Gui, Tab, ����ֵ
Gui, Add, Text, x350 y65 w40 h20 , <����>
Gui, Add, Text, x16 y40 w310 h20 , ������ߵ��ַ�
Gui, Add, Text, x396 y40 w310 h20 +Right, �����ұߵ��ַ�
Gui, Add, Text, x345 y95 w48 h20 , ��������
Gui, Add, Text, x16 y95 w48 h20 , ��������
Gui, Add, Edit, x396 y60 w320 h23 v_mmRight,
Gui, Add, Edit, x16 y60 w320 h23 v_mmLeft,
Gui, Add, Edit, x66 y90 w270 h23 v_mmRe,
Gui, Add, Edit, x396 y90 w320 h23 v_mmFi,

Gui, Add, Text, x105 y130 w10 h20 , ǰ
Gui, Add, Edit, x120 y125 w100 h23 v_mmBefore,
Gui, Add, Text, x505 y130 w10 h20 , ��
Gui, Add, Edit, x520 y125 w100 h23 v_mmAfter,

Gui, Add, Button, x235 y120 w100 h30 v_btn_FindMax 	g���������ֵ��, �������ֵ
Gui, Add, Button, x395 y120 w100 h30 v_btn_FindMin	g��������Сֵ��, ������Сֵ
Gui, Add, Button, x16 y122 w50 h26  g������ֵ������, ����
Gui, Add, CheckBox, x650 y120 w90 h30 v_mm_bFileData, ʹ��ԭʼ����

Gui, Tab, ���ʽ
Gui, Add, Edit, x76 y40 w300 h25 v_expStart
Gui, Add, Edit, x76 y80 w300 h25 v_express
Gui, Add, Text, x16 y43 w50 h20 +Right , ��ʼ����
Gui, Add, Text, x16 y83 w50 h20 , ���ʽ

Gui, Add, Button, x76 y120 w90 h30 	v_btn_express 	g����������ʽ�����ݡ�, ���ʽ
Gui, Add, Button, x176 y120 w90 h30 v_btn_expmax  	g����ʾ���ʽ���ֵ�ļ�¼��, ���ֵ
Gui, Add, Button, x276 y120 w90 h30 v_btn_expmin 	g����ʾ���ʽ��Сֵ�ļ�¼��, ��Сֵ
Gui, Add, Button, x16 y122 w50 h26 	g�����ʽ������, ����







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
Gui, Add, ListView, %g_lvOptions% %listOptions% v_MyListView g�����MyListView��,%g_LVTitle%
Gui, Add, Edit, x0 y-50 vCellEdit g��ͨ��Editʵʱ�޸�MyListView��Ӧ��Ԫ���ֵ��
Gui, Add, Text, x0 y-50 vCellHighlight +Border cBlue -Wrap
ControlGetPos,lx,ly,lw,lh,%EditingLV%,ahk_id %g_GuiID%

; #include .\inc\listview\guiaddeditListView.aik

Gui, Add, Text, x400 y15 w340 h20
Gui, Add, Text, x400 y10 w10 h23 , $
Gui, Add, Text, x482 y10 w10 h23 , L
Gui, Add, Text, x572 y10 w10 h23 , R
Gui, Add, Edit, x410 y10 w70 h23 	v_expVar, ������
Gui, Add, Edit, x490 y10  w80 h23 	v_expL
Gui, Add, Edit, x580 y10  w80 h23 	v_expR
Gui, Add, Button, x665 y10 w33 h25 g��ListView�����ӱ�����, ��
Gui, Add, Button, x697 y10 w33 h25 g��ɾ��ListViewѡ�еı�����, ɾ


Gui, Tab, ������
Gui, Add, Text, x120 y35 w280 , ������������ݣ�
Gui, Add, Edit, x120 y50 w610 h100 	v_edtCalc
Gui, Add, Button, x16 y60 w100 h50  g����ʼ���㡿, ��   ��
Gui, Add, Button, x16 y122 w50 h26 	g��������������, ����
Gui, Add, Button, x66 y122 w50 h26 	g����ռ�������, ���

Gui, Tab, ����
Gui, Add, Button, x26 y45 w90 h30  g���������á�, ��������
Gui, Add, Button, x136 y45 w90 h30 g���������á�, ��������

Gui, Add, Button, x26 y80 w90 h30   g��ˢ�����á�, ˢ������
Gui, Add, Button, x136 y80 w90 h30  g��ɾ�����á�, ɾ������

Gui, Add, Text, x60 y125 w70 h30 +Right	, ÿҳ����
Gui, Add, Edit,  x135 y120 w90 h25   vg_PageLines g��ÿҳ��ʾ������, %g_PageLines%

Gui, Add, ListBox, x250 y45 w481 h110 v_CfgListbox g������ListBox��Ӧ��
Gui, Add, Button, x26 y120 w50 h26  g�����ð�����, ����

Gui, Tab, ����
Gui, Add, Button, x26 y45 w90 h30 	g����顿, ��  ��
Gui, Add, Button, x116 y45 w90 h30 	g����ҳ������, ��ҳ����?
Gui, Add, Button, x206 y45 w90 h30 	g����������������, ��������?
Gui, Add, Button, x296 y45 w90 h30 	g������ֵ������, ����ֵ?
Gui, Add, Button, x386 y45 w90 h30 	g�����ʽ������, ���ʽ?
Gui, Add, Button, x476 y45 w90 h30 	g��������������, ������?
Gui, Add, Button, x566 y45 w90 h30 	g�����ð�����, ��  ��?

InitPage( 1, g_curPage )

Gui, Show, h556 w756, %g_title%



if g_fileName =
{
	gosub ����ҳ������
}
else
{
	ClearRawArray()
	OpenFile( g_fileName )
}

gosub ��ˢ�����á�

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

	gosub ������ListView��С��

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



���򿪡�:
	FileSelectFile, g_fileName, 3, %A_WorkingDir%, ���ı��ļ�, Text Documents (*.txt; *.log )
	if g_fileName =
	{
		return
	}
	ClearRawArray()
	OpenFile( g_fileName )
	return

��׷���ļ���:
	FileSelectFile, g_fileName, 3, %A_WorkingDir%, ���ı��ļ�, Text Documents (*.txt; *.log )
	if g_fileName =
	{
		return
	}
	AddFile( g_fileName )
	return

�����Ϊ��:
	gui, submit, nohide

	if g_PageSource = raw
	{
		if g_rawArray0 = 0
		{
			msgbox ԭʼ����Ϊ�գ��޷����棡
			return
		}
	}
	else if g_PageSource = view
	{
		if g_viewArray0 = 0
		{
			msgbox ��������Ϊ�գ����ܱ��棡
			return
		}
	}
	else if g_PageSource = temp
	{
		if g_tempArray0 = 0
		{
			msgbox ��ʱ��������Ϊ�գ��޷����棡
			return
		}
	}
	else
	{
		msgbox ��ǰû��������Դ������ʧ�ܣ�
		return
	}

	FileSelectFile, fileName, S16, %A_WorkingDir%, ���ı��ļ�, Text Documents (*.txt; *.log )
	if fileName =
		return

	ifexist %fileName%
	{
		msgbox 4, �滻�ļ�, `"%fileName%`" �Ѿ�����`n`n�Ƿ��滻?
		ifmsgbox no
		{
			return
		}
		FileDelete %fileName%
	}
	SB_SetText( "���ڱ������ݵ��ļ� " . filename . " ......" )
	GuiControl, Disable, _MyTab
    SaveArrayToFile( g_PageSource, fileName )
	GuiControl, Enable, _MyTab
	SB_SetText("")
	return


���鿴ԭʼ���ݡ�:

	SB_SetText("׼����ʾ�ļ���ԭʼ����...")
	ShowRawPage( 1 )
	SB_SetText("")
	return

���鿴�������ݡ�:
	SB_SetText("����׼����ʾ����������...")
	ShowViewPage( 1 )
	SB_SetText("")
	return

���鿴��ʱ���桿:
	SB_SetText("����׼����ʱ���������...")
	ShowTempPage( 1 )
	SB_SetText("")
	return

��������ݡ�:
	SB_SetText("�����������...")
	Init()
	GuiControl, Text, _MyEdit, %g_view%
	guicontrol, , _MyListBox, |
	SB_SetText("")
	return

������������ָ�����ݵ��С�:
	g_view =
	SB_SetText("����ִ�С����ҡ���ť������������ָ�����ݵ���...")
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

����������˰�ťͬʱ��Ч��:
	g_view =
	SB_SetText("����ִ�С�ͬʱ����ť�����������͡����ˡ���ť��ͬʱ��Ч...")
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


�����˰���ָ�����ݵ��С�:
	g_view =
	gui submit, nohide
	SB_SetText("����ִ�С����ˡ���ť�������˵�ָ�����ݵ���...")
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





������ListBox��Ӧ��:
	if A_GuiEvent = DoubleClick
	{
		gosub ���������á�
	}
	else if A_GuiEvent = Normal
	{

	}
	return


��ˢ�����á�:
	GuiControl, , _CfgListbox, |
	read_sec( var_cfglines, "temp.ini", "��־�鿴��", false, false )
	loop parse, var_cfglines, `n
	{
		if a_loopfield =
			continue

		StringReplace line, a_loopfield, |, ��, All
		GuiControl, , _CfgListbox, %line%
	}
	return

���������á�:
	Gui, submit, nohide
	ifinstring _CfgListBox, =
	{
		StringReplace line, _CfgListBox, ��, |, All
		line := StrRight2Sub( line, "=" )
		if ParseCFGLine( line )
			msgbox ���ü��سɹ���
		else
			msgbox ���ü���ʧ�ܣ�
	}
	else
	{
		KeyName := myinput( "��������", "��ָ����Ҫ���ص��������ƣ�" )
		if KeyName =
			return

		var_Read := ReadTempIni("��־�鿴��", KeyName, "" )
		if var_Read =
			msgbox %KeyName% �����ڣ�
		else
			ParseCFGLine( var_Read )

	}
	return

��ɾ�����á�:
	Gui, submit, nohide
	ifinstring _CfgListBox, =
	{
		line := _CfgListBox
		line := StrLeft2Sub( line, "=" )
		msgbox 4, ȷ��ɾ������, ȷ��Ҫɾ������[%line%]��
		ifmsgbox no
		{
			return
		}
		if line <>
		{
			if del_ini( "temp.ini", "��־�鿴��", line, false )
				msgbox ����[%line%]ɾ���ɹ���
			else
				msgbox ����[%line%]ɾ��ʧ�ܣ�
			gosub ��ˢ�����á�
		}
		else
		{
			msgbox ȱ���������ƣ�
		}
	}
	else
	{
		msgbox û��ѡ�����ã�
	}
	return

���������á�:
	KeyName := myinput( "��������", "��ǰ���ñ����ʲô���ƣ�" )
	if KeyName =
		return

	var_Read := ReadTempIni("��־�鿴��", KeyName, "" )
	if var_read <>
	{

		msgbox 4, �������ظ�, �������������<%KeyName%>�Ѿ����ڣ�`n`n%keyName% = %var_read%`n`n�Ƿ�Ҫ�滻֮?
		if msgbox no
		{
			return
		}
	}

	var_cfg := CreateCurCFG()


	read_sec( _OutSections, "temp.ini", "��־�鿴��" , false, false )
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
				msgbox 4, �ظ�����, ��ǰ�����������ļ����Ѿ�����!`n`n%a_loopfield%`n`n�Ƿ�Ҫ��ӣ�
				ifmsgbox no
					return
				break
			}
		}
	}
	WriteTempIni("��־�鿴��", KeyName, var_cfg )
	gosub ��ˢ�����á�
	return


����ʼ���㡿:
	gui, submit, nohide
	if _edtCalc =
	{
		GuiControl, Text, _MyEdit, ��������ı༭��������Ҫ��������ݣ�
		GuiControl Focus, _edtCalc
	}
	else
	{
		var_buf := CalcText( _edtCalc )
		GuiControl, Text, _MyEdit, %var_buf%
	}
	return

����ռ�������:
	guicontrol text, _edtCalc
	guicontrol text, _myedit
	return

��ÿҳ��ʾ������:
	gui, submit, nohide
	ShowPage( g_PageSource, 1 )
	return


��Page1��:
	GuiControlGet, nPage , , _lbl1
	ShowPage( g_PageSource, nPage )
	return
��Page2��:
	GuiControlGet, nPage , , _lbl2
	ShowPage( g_PageSource, nPage )
	return
��Page3��:
	GuiControlGet, nPage , , _lbl3
	ShowPage( g_PageSource, nPage )
	return
��Page4��:
	GuiControlGet, nPage , , _lbl4
	ShowPage( g_PageSource, nPage )
	return
��Page5��:
	GuiControlGet, nPage , , _lbl5
	ShowPage( g_PageSource, nPage )
	return
��Page6��:
	GuiControlGet, nPage , , _lbl6
	ShowPage( g_PageSource, nPage )
	return
��Page7��:
	GuiControlGet, nPage , , _lbl7
	ShowPage( g_PageSource, nPage )
	return
��Page8��:
	GuiControlGet, nPage , , _lbl8
	ShowPage( g_PageSource, nPage )
	return
��Page9��:
	GuiControlGet, nPage , , _lbl9
	ShowPage( g_PageSource, nPage )
	return
��Page10��:
	GuiControlGet, nPage , , _lbl10
	ShowPage( g_PageSource, nPage )
	return

����һҳ��:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage - 1 )
	return

����һҳ��:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage + 1 )
	return

����ʮҳ��:
	GuiControlGet, nPage , , _lblCur
	ShowPage( g_PageSource, nPage - 10 )
	return

����ʮҳ��:
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
		GuiControl, text, _lblSource, ԭʼ����
		InitPage( g_rawArray0, var_curpage )
	}
	else if var_source = view
	{
		g_PageSource = view
		GuiControl, text, _lblSource, ��������
		InitPage( g_viewArray0, var_curpage )
	}
	else if var_source = temp
	{
		g_PageSource = temp
		GuiControl, text, _lblSource, ��ʱ����
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
; #include .\bin\�ı��ļ�����\��־�鿴��_ҳ������.aik

���������ֵ��:
	gui submit, nohide
	SB_SetText("���ڲ��ұ���ֵ��[��]���С�����")
	GuiControl, Disable, _btn_FindMax
	GuiControl, Disable, _btn_FindMin
	lineIndex := �Ƽ�������Сֵ( 1 )
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


��������Сֵ��:
	gui submit, nohide
	SB_SetText("���ڲ��ұ���ֵ��<С>���С�����")
	GuiControl, Disable, _btn_FindMax
	GuiControl, Disable, _btn_FindMin
	lineIndex := �Ƽ�������Сֵ( 0 )
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

�Ƽ�������Сֵ( bMax )
{

	global
	local var_max = -9999999999999999
	local var_min = 9999999999999999
	local var_maxline =
	local var_minline =
	g_statustip =

	if ( g_rawArray0 <= 0  )
	{
		msgbox ��δ�����ļ����ݣ�
		return false
	}
	if ( _mm_bFileData == false && g_viewArray0 <= 0 )
	{
		msgbox ����������Ϊ�գ�`n��û�й������ݻ������ݣ�`n�������ǹ�ѡ��ԭʼ���ݡ���ѡ��
		return false
	}
	if ( _mmLeft == "" && _mmRight == "" )
	{
		msgbox û��ָ������ǰ����ַ�
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
			g_statustip = �������ֵΪ��%var_max%

		}
		else
		{
			g_statustip = û���ҵ����ֵ
			var_index =
		}
	}
	else
	{
		if var_min < 9999999999999999
		{
			g_statustip = ������СֵΪ��%var_min%

		}
		else
		{
			g_statustip = û���ҵ���Сֵ
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
; #include .\bin\�ı��ļ�����\��־�鿴��_��ֵ.aik


#ifwinactive ��־�鿴�� ahk_class AutoHotkeyGUI
LWin::
^+c::
	clipboard =
	ControlGetFocus, var_FocusControl, ��־�鿴�� ahk_class AutoHotkeyGUI
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
		gosub ���޸�MyListView��Ԫ���˳��༭״̬��
	}

	else
	{
		send {NumpadEnter}
	}
	return

PgUp::
	gosub ����һҳ��
	return

PgDn::
	gosub ����һҳ��
	return


+PgUp::
	gosub ����ʮҳ��
	return

+PgDn::
	gosub ����ʮҳ��
	return

#ifwinactive


���Ҽ����ơ�:
	GuiControl, +Redraw, _MyEdit
	return

�����Ƶ���������������:
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

�����Ƶ������������˿�:
	if clipboard <>
	{
		var_temp = %_edtFi%`r`n%clipboard%
		GuiControl, Text, _edtFi, %var_temp%
		GuiControl, Choose, _MyTab, 2
	}
	GuiControl, +Redraw, _MyEdit
	return

�����Ƶ�����ֵ������ߡ�:
	if clipboard <>
	{
		GuiControl, Text,_mmLeft, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

�����Ƶ�����ֵ�����ұߡ�:
	if clipboard <>
	{
		GuiControl, Text,_mmRight, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

�����Ƶ�����ֵ����������:
	if clipboard <>
	{
		GuiControl, Text,_mmRe, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

�����Ƶ�����ֵ����������:
	if clipboard <>
	{
		GuiControl, Text,_mmFi, %clipboard%
		GuiControl, Choose, _MyTab, 3
	}
	GuiControl, +Redraw, _MyEdit
	return

��ѭ����ʼ������:
	if clipboard <>
	{
		GuiControl, Text,_expStart, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
	GuiControl, +Redraw, _MyEdit
	return

����ӱ��������ơ�:
	if clipboard <>
	{
		GuiControl, Text,_expVar, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
	GuiControl, +Redraw, _MyEdit
	return

����ӱ���������ַ���:
	if clipboard <>
	{
		GuiControl, Text,_expL, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
	GuiControl, +Redraw, _MyEdit
	return

����ӱ������ұ��ַ���:
	if clipboard <>
	{
		GuiControl, Text,_expR, %clipboard%
		GuiControl, Choose, _MyTab, 4
	}
    GuiControl, +Redraw, _MyEdit
	return
; #include .\bin\�ı��ļ�����\��־�鿴��_��ݼ�.aik
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
		msgbox ���ȴ��ı��ļ���
		return false
	}
	if g_viewArray0 <= 0
	{
		msgbox ���Ƚ��й��˲�����
		return false
	}
	g_VarArrayCount = 0
	gui, submit, nohide
	if _expStart =
	{
		msgbox ��ָ��ѭ����ʼ������
		return false
	}
	if _express =
	{
		msgbox ��������ʽ!
		return false
	}
	if ( LV_GetCount() <= 0 )
	{
		msgbox ��û�������κα���!
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
	    	msgbox �� %a_index% �еı�����Ϊ�գ�
	    	return false
	    }
	    if var_left =
	    {
	    	g_VarArrayCount = 0
	    	msgbox �� %a_index% �еı�����ߵ��ַ�Ϊ�գ�
	    	return false
	    }
	    if var_right =
	    {
	    	g_VarArrayCount = 0
	    	msgbox �� %a_index% �еı������ұߵ��ַ�Ϊ�գ�
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
	    			msgbox �� %a_index% �еı������ظ���
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
			msgbox 4, û��$����, �Ƿ������ڱ�����ǰ���ǰ׺ $ ��?
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
							var_show = %var_show%`n----���ʽ =��%var_exp%��-------------------------------`n%cur_text%`n
						}
                        else if ( flag == 1 && var_exp > var_max )
						{
							var_max := var_exp
							var_show = ----���ʽ���ֵ =��%var_exp%��-------------------------------`n%cur_text%
						}
                        else if ( flag == 2 && var_exp < var_min )
						{
							var_min := var_exp
							var_show = ----���ʽ��Сֵ =��%var_exp%��-------------------------------`n%cur_text%
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
					var_show = %var_show%`n----���ʽ =��%var_exp%��-------------------------------`n%cur_text%`n
				}
                else if ( flag == 1 && var_exp > var_max )
				{
					var_max := var_exp
					var_show = ----���ʽ���ֵ =��%var_exp%��-------------------------------`n%cur_text%
				}
                else if ( flag == 2 && var_exp < var_min )
				{
					var_min := var_exp
					var_show = ----���ʽ��Сֵ =��%var_exp%��-------------------------------`n%cur_text%
				}
			}
		}

		SB_SetText("���ʽ �������, ׼����ʾ���......")
		ShowTempText( var_show )
		var_show =
	}
}

��ListView�����ӱ�����:
	gui submit, nohide
	if ( _expVar == "" || _expVar == "������" )
	{
		msgbox �������������!
		return
	}
	if _expL =
	{
		msgbox �������������ַ�!
		return
	}
	if _expR =
	{
		msgbox ����������ұ��ַ�!
		return
	}
	if not equal_first_char( _expVar, "$" )
	{
		_expVar = $%_expVar%
	}
	LV_Add("", _expVar, _expL, _expR )
	return

��ɾ��ListViewѡ�еı�����:
	GetLVInfo( g_GuiID, EditingLV, TotalNumOfRows, NumOfRows, topIndex )
	if ( currRow > 0 && currRow <= TotalNumOfRows )
	{
		if ( currRow >= topIndex && currRow <= topIndex + NumOfRows )
		{
			LV_Delete( currRow )
		}
		else
		{
			msgbox ��ǰ�в�����ʾ��Χ�ڣ�
		}
	}
	return


����������ʽ�����ݡ�:
	SB_SetText("���ڲ������� ���ʽ ������......")
	GuiControl, Disable, _btn_express
	CalcExpress( 0 )
	GuiControl, Enable, _btn_express
	SB_SetText("���ʽ �������!")
	return

����ʾ���ʽ���ֵ�ļ�¼��:
	SB_SetText("���ڲ���ʹ ���ʽ���ֵ �ļ�¼......")
	GuiControl, Disable, _btn_expmax
	CalcExpress( 1 )
	GuiControl, Enable, _btn_expmax
	SB_SetText("���ֵ�������!")
	return


����ʾ���ʽ��Сֵ�ļ�¼��:
	SB_SetText("���ڲ���ʹ ���ʽ��Сֵ �ļ�¼......")
	GuiControl, Disable, _btn_expmin
	CalcExpress( 2 )
	GuiControl, Enable, _btn_expmin
	SB_SetText("��Сֵ�������!")
	return
; #include .\bin\�ı��ļ�����\��־�鿴��_���ʽ.aik


����ҳ������:
var_help =
(

  ��ӭʹ�� ����־�鿴���� ��
--------------------------------------


@ʹ�ò���@

1������ͨ�����򿪡���ť����һ���ı��ļ���
2���ڡ�����������ѡ��У����Թ��˺Ͳ������ݣ�
3�����ݾ�������֮�󣬿��Ը���ָ���Ĺ���ȡ�ñ���ֵ����ʾ��������������Сֵ���У�
4������и����ӵ����󣬽��롰���ʽ��ѡ�������������ö�������Լ������ӵı��ʽ��



@ѡ�˵��@

1����ҳ�����ء����桢ά�����ݣ�
2���������������ˡ��������ݣ�
3������ֵ��ָ��������ʽ�����Ұ�������������Сֵ���У�
           ��Ҫ�������ı����ݺ󣬲�������ֵ��
4�����ʽ����ָ����������ĸ�ʽ��ָ�����ӵı��ʽ��
           ���Ҳ���ʾʹ�ñ��ʽ�������������ݣ�
           ���Ҳ���ʾʹ���ʽ������Сֵ��������ݣ�
           ��Ҫ���ز�����������֮�󣬷��ɲ�����
5�������������ɵ���ѧ��������֧�ֳ�����ѧ��������ϵ���㡢�߼����㣡
6�����ã�  ��������ÿҳ��ʾ�����У����Խ���������������ֵ�����ʽ��صĲ������б�������ء�
7��������  �ɴ������ҵ����еİ�������.



@��ҳ�еİ�ť˵��@

���򿪡����򿪺ͼ���һ���ı��ļ�����֮ǰ�������ǰ�����ݡ�
          ���ļ�Ҳ����ͨ�����ı��ļ��Ϸŵ����ĵ��ı���ʾ����ʵ�֡�
          
��׷���ļ�������һ���ı��ļ�����������׷�ӵ���ǰ���ݵĺ��档
          Ҳ�����϶�����ı��ļ������ļ��б����б���У�һ����׷�Ӷ���ļ��ļ���
          �������˹�������ʱ��׷���ı�����֮ǰ����˵�����������������ݡ�
          
�����Ϊ��������־��ʾ���ڵ����ݱ�����Ϊ�ı��ļ���
          
��ԭʼ���ݡ�����ʾ���ļ��м��ص�ԭʼ���ݡ�

���������ݡ�����ʾ�������˴��������ݡ�

��������ݡ������ԭʼ���ݺ͹���֮������ݡ�
          

--------------------------------------
  ���������������������ѡ���
  
  
  
)	
GuiControl, Text, _MyEdit, %var_help%
return


����������������:
var_help =
(


//___@ ������������ @____________________________________________________

  ������������ѡ��ڣ��������ò������������������
  
  �ڡ�Ҫ���������ݡ��༭�����������������һ��Ϊһ��������
  �ڡ�Ҫ���˵����ݡ��༭��������Ҫ���˵�������һ��Ϊһ��������
  
  ֮����԰���<���ҡ���ťִ�в������񣬰�������>��ִ�й������񣬰���<ͬʱ>�����Ҳ����ˡ�

   ��<���ҡ���ťִ�н������ԭʼ�����У�����������һ�����������ļ�¼��ʾ�����������뻺�棻
   
   ������>����ťִ�н����������������һ�����������ļ�¼���˵����������ʾ���������뻺�棻
   
   ��<ͬʱ>�������൱��ͬʱִ�в��Һ͹��˹��ܣ���������������Լ���������������ļ�¼��ʾ
            ���������뻺�档��һ����¼ͬʱ������������͹�������ʱ�����ᱻ���˵���
            
   ����ԭ����ť�롰��ҳ��ѡ��еġ�ԭʼ���ݡ���ť����һ�£���ʾ���ļ����ص�ԭʼ���ݡ�
   
   ͨ����<���ҡ���������>������<ͬʱ>�������õ��Ļ������ݣ��ǡ�����ֵ���������ʽ����ǰ�ᡣ
   
)
GuiControl, Text, _MyEdit, %var_help%
return


������ֵ������:
var_help =
(

//___@ ����ֵ���� @______________________________________________________

  �ڼ����ı��ļ��󣬿����ڡ�����ֵ��ѡ���ָ��������ʽ���Լ�����������������
���¡��������ֵ���򡾲�����Сֵ����ť֮�󣬳������ҳ����������ʽ�������ı�����
���������������ֵ����Сֵ����һ����ʾ������


//___@ ʹ��ԭʼ���� @____________________________________________________

  ��ʹ��ԭʼ���ݡ���ѡ������ָ��������Դ��
��ѡ�ˡ�ʹ��ԭʼ���ݡ���ѡ��֮�󣬽��ڴ��ļ��м��ص�ԭʼ�����в��ұ�����
���򽫴Ӿ������˴���֮��������в��ұ�����


//___@ ���� @____________________________________________________________

  ����ĳ����־�ļ������������ݣ�
[2010-08-23 11:29:42 ] :  58328927  :-( ת��ʧ�ܣ� ԭ���ǣ�Read0044() ʧ���ļ�����10000k������ת����
[2010-08-23 11:29:59 ] :  58328932  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı� 
[2010-08-23 17:04:51 ] :  58323252  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ���޷���Ҫת����PDFԴ�ļ�
[2010-08-23 10:01:42 ] :  58321836  ת���ɹ�.
[2010-08-23 10:01:45 ] :  58321863  ת���ɹ�.
[2010-08-23 10:02:32 ] :  58321906  :-( ת��ʧ�ܣ� ԭ���ǣ��ļ����ͱ����˵�������ת��
[2010-08-23 10:02:32 ] :  58321910  :-( ת��ʧ�ܣ� ԭ���ǣ��ļ����ͱ����˵�������ת��
[2010-08-23 11:26:10 ] :  58328828  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı� 
[2010-08-23 11:26:13 ] :  58328829  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı� 
  
  �����������־��һ��Ϊһ����¼����ת��ʧ�ܵļ�¼������ͬ�ĸ�ʽ����[ʱ��]: ���ֱ��� :-( ת��ʧ�ܣ� ...��
  
  �����ֱ����������ǹ��ĵ����ݣ����������ҵ����ֱ������ֵ����һ�У������������£�
  
  1�������ı��ļ�
  
  2���ڡ�����������ѡ��еġ�Ҫ���˵����ݡ����У����롰ת���ɹ�����
     Ȼ���¡�����>�����˵�������ת���ɹ����������У�
     
  3�����롰����ֵ��ѡ����ڡ���������ַ����ı༭�������롰 ] :  ����
     �ڡ������ұ��ַ����ı༭�������롰  :-( ת��ʧ�ܣ�����
     
  4�����������ֵ������ʾ��[2010-08-23 11:29:59 ] :  58328932  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı� 
     ��������Сֵ������ʾ��[2010-08-23 10:02:32 ] :  58321906  :-( ת��ʧ�ܣ� ԭ���ǣ��ļ����ͱ����˵�������ת��
     
  5����������ڰ�����ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı��������в��ұ�����
     ��ô��Ҫָ���������������롰���������������ݣ����磺
     ��������������"PDF ��û���ҵ��ı�"
     ��������������"����ת��|����ת��"
     
    ��ʱ������ֵ�Ľ�������仯��
    ���������ֵ������ʾ��[2010-08-23 11:29:59 ] :  58328932  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı� 
    ��������Сֵ������ʾ��[2010-08-23 11:26:10 ] :  58328828  :-( ת��ʧ�ܣ� ԭ���ǣ�ת��������Ϣ��PDF ��û���ҵ��ı� 
  	
//___@ ע�� @____________________________________________________________

  1����ʹ������ֵ����֮ǰ����Ҫ�ȼ����ı��ļ���
  
  2����û�й�ѡ��ʹ��ԭʼ���ݡ���ѡ�������£�����Ҫ�ڡ�����������ѡ��У�
     ���ù������������й��˴���֮�󣬷���ʹ������ֵ���ܡ�
     
  3�����ж�������������������ʱ����|���зָ���
  	
  	
  
)
GuiControl, Text, _MyEdit, %var_help%
return


�����ʽ������:
var_help =
(

//___@ ���ʽ���� @______________________________________________________
  
  �ɳ����¼����־��һ�����ѭ���ԣ�����һ�β�����¼һ����¼��
��һ���ظ��������ּ�¼һ�����ݡ������ʽ��ѡ����������ڣ�����
�����ı��ʽ���г�������ʽ����һ����������ݡ�


//___@ ʹ�ò��� @________________________________________________________
  
  1��ָ��һ�β����ĵ�һ����¼����ѭ���Ŀ�ʼ��
  2���趨һ��ѭ���ڵ�һЩ������
  3��ʹ����Щ��������һ�����ʽ��
  4�����°�ť�������ݣ�
    �����ʽ����ť������������ʽ���������εļ�¼��
    �����ֵ����ť���ҳ�ʹ�ñ��ʽ��ֵ������һ����¼��
    ����Сֵ����ť���ҳ�ʹ�ñ��ʽ��ֵ��С����һ����¼��

	
//___@ ���� @____________________________________________________________

  ����ĳ�����������������־��
  x[12]
  y(34)
  z{36}
  x[6]
  y(89)
  z{456}
  x[182]
  y(334)
  z{306}
  ������־���ǿ��Է��֣�������x[...]��y(...)��z{...}ѭ���ģ�ѭ����x[...]��ʼ��
  
  �����������ҳ� x + y + z ֵ����������¼�������������£�
  
  1�������ı��ļ�
  
  2���趨�������������й��˲���������û����Ҫ���˵�����ʱ������趨һ�������ڵĹ������ݽ��й��ˣ�
  
  3�����롰���ʽ��ѡ����ڡ���ʼ�������༭�������롰x[��
  
  4������x,y,z���������ĸ�ʽ���ο�����ֵ�ı������ø�ʽ�������簴����ĸ�ʽ��д�����б�ListView��
  
     ������ | ����ַ� | �ұ��ַ� | �������� | ��������
     $x     | [        | ]        |          | 			
     $y     | (        | )        |          | 			
     $z     | {        | }        |          | 			
     
  5�����ݱ��������趨���ʽ���ڱ��ʽ�༭�������룺�� $x + $y + $z��
     
  6���������ֵ����ť����ʹ�� $x + $y + $z ��ֵΪ������һ����¼�����Ϊ��
		x[182]
		y(334)
		z{306}

     ������Сֵ�����ҵ��Ľ��Ϊ��
		x[12]
		y(34)
		z{36}
  
  7����дһ������һЩ�ı��ʽ����$z > $y && sin2( $x ) > 0��
    �������ʽ����ť������ʹ�� z > y ���� sin( x �� ) > 0 �����Ķ����μ�¼�����Ϊ��

	-----------------------------------
	  x[12]
	  y(34)
	  z{36}

	-----------------------------------
	  x[6]
	  y(89)
	  z{456}    
	  
//___@ ע�� @____________________________________________________________	  

  1�����б��ʽ����֮ǰ�����ȼ����ı��ļ����ݣ����ҽ��й��˲�����
  
  2���趨����ʱ��������Ӧ����$��ʼ��



)
GuiControl, Text, _MyEdit, %var_help%
return


����顿:
var_help =
(


  ��ѡ��ʹ����־�鿴��������ʮ�ֵĸ��ˣ�˵���ҵ����Ŭ�����м�ֵ�ģ�
  
  
  ��־�鿴������ AutoHotkey �ű������д��Ŀ�����ڰ����û��鿴������־�ļ����Ӷ��ҳ��������ڡ�

  ��־�鿴������ͬʱ���ض���ı��ļ������Թ��˵������ĵ����ݣ�Ҳ�������ɵشӺ�嫵���־��¼����������Ҫ�����ݡ�

  ���⣬��ȷ��ָ����ʽ�󣬿��Դ���־��ʶ�����֣����ұȽ����֣�������������С���ֵ����ҳ�����

  ��Ҳ���Խ���ͬ��ʽ���������óɲ�ͬ�ı���������Щ��������һ�����ʽ��Ȼ����ҳ�ʹ���ʽ�����Ķ�����¼�����߲��ҵ�ʹ���ʽ��ֵ������С����һ����¼��

  

)
GuiControl, Text, _MyEdit, %var_help%
return


��������������:
var_help =
(

//___@ ������˵�� @______________________________________________________

  ����������־��ѯ���޹�ϵ��������ʵ�֡����ʽ�����ܵĸ���Ʒ�����ڷ�����־����Ա
������а�������˽�����ӵ�����־�鿴���С�


//___@ �ص� @____________________________________________________________
  
  ��������������ͬ���ǣ�������������Ϊ��λ���м��㣬���Լ�����У�����ʹ�ñ�����
֧�ֹ�ϵ���㡢�߼����㣬֧��������ѧ������ʹ�ã�sqrt,abs,log,ln,mod,round,
sin,cos,tan,asin,acos,atan,ceil,exp,floor,sin2,cos2,tan2


//___@ ʹ�÷��� @________________________________________________________

  1���ڡ���������ѡ��ڵı༭��������Ҫ���������
  
  2���������㡿��ť�����򽫸��еĽ����ʾ���·�����־��ʾ���ڡ�
  
  �������룺 log( 128 * 2 - ( 30 + 23 ) )
  �����㡿֮���·�����ʾ����ʾ�����2.307496

  3������ʹ�ñ����Ͷ��еļ��㣬�����룺
		$x = 12
		$y = -3
		$a = sqrt( $x**2 + $y**2 )
		$z = 5
		$c = $a * $z / 2
		$d = atan( $c )
		$z > $d && $x + $y < 10
     
     �����㡿���Ϊ��
		$x  = 12
		$y  =  -3
		$a  = 12.369317
		$z  = 5
		$c  = 30.923292
		$d  = 1.538470
		1

//___@ ע������ @________________________________________________________

   1��֧�� +-*/ �Լ��˷���**����ѧ���㣻
      ֧�� >=��>�� <=�� <�� != ��= ��ϵ���㣻
      ֧�� &&��|| �߼����㣻
      ֧��ʹ������()������֧��[]��{}��ʹ�ã�
      ֧�ֳ��ú�����ʹ�á�
   
   2��ʹ�ñ���ʱ��������Ӧ������ĸ�����֡�_��$���ɣ�����$��ͷ��
      �м䲻���пո�������ŵ��������š�
      �����������$��ʼ����ֹ�û�������������������ͬ����ɴ���
   
   3����������ֵʱ�� �������� = ���ʽ�� �ĸ�ʽ�����������Υ���˹���
      ������Ϊ = ��ϵ���㣬 ���  a + b = c + d �У�a + b ������Ϊһ����������
      ��˽� a + b = c + d ��Ϊһ�����ʽ��
      
   4��ʹ�ú���ʱ����������ͽ���()��֮�䲻���пո�
      �� sin  ( 30 ) �ǲ���ȷ�ģ�Ӧ��д�� sin( 30 )
      
   5��sin,cos,tan ���Ǻ����Ĳ����ĵ�λ���Ի��ȣ�
      sin2,cos2,tan2 �Ĳ����ĵ�λ�ǽǶȡ�
      
   6����ϵ�������߼�����Ľ����1���棩 0���٣�




)
GuiControl, Text, _MyEdit, %var_help%
return


�����ð�����:
var_help =
(

//___@ ����ѡ� @______________________________________________________

  ������ѡ�������־�鿴�������ù�������������־��ʾ��ÿҳ��ʾ����(Ĭ��100��)��
���Ա��浱ǰ�����ã����߼�����ǰ����������á�



//___��ť˵��____________________________________________________________

���������á�����ѡ�е����ã��ֽⲢ��䵽��������������ֵ�����ʽ��ѡ���

���������á�������ǰ���ñ��浽�����ļ��У���Щ���ð�����
          ������������ѡ���Ҫ������������Ҫ���˵����ݣ�
          ������ֵ��ѡ��е����ã�
          �����ʽ��ѡ��е����ã�
          
��ˢ�����á����������ļ������¼��ز���ʾ��ʷ���á�

��ɾ�����á����������ļ��У�ɾ����ǰѡ�е����á�



)
GuiControl, Text, _MyEdit, %var_help%
return
; #include .\bin\�ı��ļ�����\��־�鿴��_����.aik

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
		SB_SetText("���ڴ��ļ�...")
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
			gosub ���鿴ԭʼ���ݡ�
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
			tooltip7( "׷�ӵ��ļ��Ѿ�����!" )
			return
		}
	}


	RawArrayPushBack( "   " )
	line = %ADD_FILE_PRE% %fileName%
	RawArrayPushBack( line )
	line = %ADD_FILE_LINE%%ADD_FILE_LINE%
	RawArrayPushBack( line )

	var_tip = ���ڴ򿪲�׷���ļ� %fileName% ...
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
	gosub ���鿴ԭʼ���ݡ�
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
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_buf%


	var_buf := _edtFi
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmLeft
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmRight
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmRe
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _mmFi
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _expStart
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
	}
	var_cfg = %var_cfg%|%var_buf%


	var_buf := _express
	if var_buf <>
	{
		�ƴ����ַ����е�ת���ַ�( var_buf, true)
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
; #include .\bin\�ı��ļ�����\��־�鿴��_����.aik



g_isInstall_autohotkey =

���Ƿ�װ��AutoHotkey()
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
		  InputBox, var_time, ���õȴ�ʱ��,��Ҫ��ͣ��ã�������ʱ��,,300,120,,,,,3000
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
	MsgBox, 4,ini�ļ������ظ���key, %var_text%
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
	SetTimer, ���봰�ڽ���궨λ����������,100
	return MyInput(vartitle, varPrompt, varDefault, varWidth, varHeight)
	return
���봰�ڽ���궨λ����������:
	ifwinexist %vartitle%,%varPrompt%
	{
		winactivate
		send {end}
		SetTimer, ���봰�ڽ���궨λ����������, Off
	}
	return
}


MyInputBox(vartitle,varPrompt,varDefault="",varXPos=0, varYPos=0, varWidth=260, varHeight=120)
{
	var_user := ""
	SetTimer, ����MyInputBox����͸����,100
	if varWidth <=0 or varHeight <= 0
	{
		inputbox,var_user,%vartitle%,%varPrompt%,,,, , , , ,%varDefault%
	}
	else
	{
		inputbox,var_user,%vartitle%,%varPrompt%,,%varWidth%,%varHeight%, , , , ,%varDefault%
	}
	return var_user

����MyInputBox����͸����:
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
	SetTimer, ����MyInputBox����͸����, Off
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

	var_temp = `n `"+*`%^/\=`,:?!`'()<&|>[]``{}`;������������������������������������
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
,2,&,��,",',(,-,��,_,?,��,),=,$,��,��,*,~,#,{,[,|,``,\,^,@,],},;,:,!,?,.,/,��,<,>,vkBC
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


��ɾ���ַ���ĩβ�Ļس�����(byref string)
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


�������ַ���(Byref _LongStr, substr_, ConnectStr_="")
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

�Ʒ���ȫ���滻����ַ���( varString, SearchText, ReplaceText)
{
	StringReplace, var_temp, varString, %SearchText%, %ReplaceText%, All
	return var_temp
}

��ɾ���ַ����������Ӵ�(byref varString, subString)
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
	var_temp = ��ǰ�����ļ� %LineFile%
	AddString(_LongStr, var_temp, true)
	var_temp = ��ǰ���ں��� %ThisFunc%
	AddString(_LongStr, var_temp, true)
	var_temp = ��ǰ������: [%LineNumber%]
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

���ַ������һ���(varString, subString)
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
				endpos = �ҵ��ָ���
			}

		}
		else if endpos = �ҵ��ָ���
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

	if ( index == 1 && startpos =="" && endpos <> "�ҵ��ָ���" && endpos >= 1 )
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
				startpos = �ҵ��ָ���
		}
		else if startpos = �ҵ��ָ���
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

	if ( endpos == "" && startpos <> "�ҵ��ָ���" && startpos >= 1 )
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







��Add�ַ�������( byref _strlist_, newstr_, separator, bFront = true, maxcount = 50 )
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
			�������ַ���( var_temp, a_LoopField, separator )
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
			�������ַ���( var_temp, a_LoopField, separator )
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
			�������ַ���( var_temp, newstr, separator )
		}
		else
		{
			�������ַ���( var_temp, a_LoopField, separator )
		}
	}
	if ( bFind == true && bAdd == true )
	{
		var_temp = %var_temp%%separator%%newstr%
	}
	strlist := var_temp
}



��Find�ַ�������( strlist, searchstr, separator )
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


��GetAt�ַ�������( strlist, var_index, separator )
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
			�������ַ���( var_temp, a_LoopField, separator )
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
			�������ַ���( var_temp, newstr, separator )
		}
		else
		{
			�������ַ���( var_temp, a_LoopField, separator )
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
			�������ַ���( var_temp, newstr, separator )
			bInsert := true
		}

		�������ַ���( var_temp, a_LoopField, separator )
	}


	if not bInsert
	{
		�������ַ���( var_temp, newstr, separator )
	}

	strlist := var_temp
}


�ƽ��س���ͳһ��Windows���( byref Hotstring )
{
	StringReplace, Hotstring, Hotstring, `r`n,$rn$, All
	StringReplace, Hotstring, Hotstring, `r, $rn$, All
	StringReplace, Hotstring, Hotstring, `n, $rn$, All
	StringReplace, Hotstring, Hotstring, $rn$, `r`n, All
}

�ƴ����ַ����е�ת���ַ�( byref HotString, bEnter = false)
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





�����MyListView��:
   CoordMode,MOUSE,RELATIVE
   MouseGetPos,mx,my,oID,oCNN
   If(A_GuiEvent = "DoubleClick")
   {   Gosub ��˫��ListView��
   }
   Else If(A_GuiEvent = "Normal" && EnableSingleClick )
   {
   		Gosub ������ListView��
   }
   Else If A_GuiEvent In S,s,RightClick,ColClick,D,d,e
   {
   		GuiControl,Hide,%LV_ST%
       	GuiControl,Hide,%LV_ED%
   }

Return

��˫��ListView��:
   GuiControl,Hide,%LV_ED%
   GuiControl,Hide,%LV_ST%
   DispControl := LV_ED
   spacer =
   Gosub CellReSize
   Gosub CellPosition
   GuiControl,Focus,%DispControl%
   SetTimer,isEditFocused,75
Return

������ListView��:
   GuiControl,Hide,%LV_ED%
   GuiControl,Hide,%LV_ST%
   DispControl := LV_ST
   spacer = %A_Space%
   Gosub CellReSize
   Gosub CellPosition
   GuiControl,Focus,%EditingLV%
Return

������ListView��С��:
	GetLVCellUnderMouse( g_GuiID, EditingLV, currRow, currCol, RowX, RowY, currColWidth, currColHeight )
	GetLVInfo( g_GuiID, EditingLV, TotalNumOfRows, NumOfRows, topIndex )
	return

��ͨ��Editʵʱ�޸�MyListView��Ӧ��Ԫ���ֵ��:
    Gui,Submit,NoHide
    CellX_save = Col%CellX_LV%
    LV_Modify(CellY_LV,CellX_save,CellEdit)
    Return


#IfWinActive ahk_group editKeypress
+Enter::
Enter::
NumpadEnter::
���޸�MyListView��Ԫ���˳��༭״̬��:
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

   settimer ����ʱѡ�пɱ༭�����ݡ�, 55
Return

����ʱѡ�пɱ༭�����ݡ�:
	if ( DispControl == LV_ED )
	{
		send {home}{shift down}{end}{shift up}
	}
	settimer ����ʱѡ�пɱ༭�����ݡ�, off
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
		 		var_exp = ���ñ��� [ %var_name% = %var_exp% ] ʱ����
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
			var_text = %Filename_%�ļ���%Section_%���У�
			var_text = %var_text%`n%Key_%�Ѿ����ڣ�Ҫ�滻�� ��
			var_text = %var_text%`n`n<%Key_%>��ֵ����`nԭʼֵ��%var_read%`n�滻Ϊ��%Value_%

			MsgBox, 4,ini�ļ������ظ���key, %var_text%
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
			var_text = %Filename_%�ļ���[%Section_%]���У�`n%Key_% = %var_read%`n`n��ȷ��Ҫɾ��<%Key_%>�� ��
			MsgBox, 4, Ini�ļ�ɾ��key, %var_text%
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
			var_text = ׼��ɾ��%Filename_%�ļ���[%Section_%]`n`n��ȷ��Ҫɾ������Section �� ��
			MsgBox, 4, Ini�ļ�ɾ��Section,  %var_text%
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
					�������ַ���( var_secqueue, cur_sec, separator )
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

settooltipvar(byref var_tooltip,var_text="����ʾ����",var_time=1000)
{

	var_temp:=var_tooltip
	var_tooltip:=var_text
	sleep %var_time%
	var_tooltip:=var_temp
	return
}



tooltipshow(var_temp="����ʾ����",var_time=800,var_tipnum=2)
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
		settimer , ��RemoveToolTipX��, %var_time%
	}
}


tipword(string="����ʾ����",var_time=2000)
{
	tooltip3(string,var_time)
}



talkshow(var_text="����ʾ����",var_title="",var_time=5000)
{
	TrayTip, %var_title%, %var_text%
	SetTimer, RemoveTrayTip, %var_time%
	return

	RemoveTrayTip:
	SetTimer, RemoveTrayTip, Off
	TrayTip
	return
}



tooltip7(string="����ʾ����",var_time=2500)
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


tooltip5(string="����ʾ����",var_time=2000)
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


tooltip3(string="����ʾ����",var_time=2000)
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

��RemoveToolTipX��:
	SetTimer ��RemoveToolTipX��, off
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
