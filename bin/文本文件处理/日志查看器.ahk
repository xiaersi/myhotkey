#NoTrayIcon 
#include ..\..\

change_icon()                           ;; ����ͼ��

;;---ȫ�ֱ���----------------------------------------------------------------
g_title = ��־�鿴��
g_fileName = %1%						;; �ļ�����
g_fileSize = 0
g_fileData =                            ;; �����ļ�ԭʼ����
g_view =                                ;; ������ʾ���ļ�
g_statustip =							;; ״̬����ʱ��ʾ����
g_VarPrefix = g_var_                    ;; �û����õı������Զ���$�滻�ɸ�ǰ׺

g_curPage = 1							;; ��ǰ��ʾ��ҳ��
g_PageLines = 100						;; ����һҳ��ʾ������
g_PageNum = 1							;; ��ҳ�� 
g_PageSource = raw						;; ��ǰ��ʾ����ԭʼ����(raw)���ǻ�������(view)

ADD_FILE_PRE = ��׷���ļ��� 
ADD_FILE_LINE = +++++++++++++++++++++++++++++++++++++++++++++

g_PageLableList = 176,216,256,296,336,376,416,456,496,536
StringSplit g_XArray, g_PageLableList, `,


;;---���ÿɱ༭ListView������------------------------------------------------
g_LVTitle = $������|L����ַ�|R�ұ��ַ�|��������|��������	;; ListView����
g_GuiID =    							;; ��Ŵ���GuiID
g_lvOptions =  x410 y40 w321 h110 r30 	;; ListView��λ��
EnableSingleClick = 1   ;; whether or not to do cell highlighting on singleclick
LV_ED = Edit12			;; ָ����ListView��ص�Edit����
LV_ST = Static26		;; ָ����ListView��ص�Text����


;;---׼�����Ҽ������־��ʾ��Ŀ�ݲ˵�--------------------------------------
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


;;---��ʾ����----------------------------------------------------------------
gui +resize
Gui, Add, Edit, x6 y190 w741 h336 v_MyEdit, 
Gui, Add, StatusBar,, ״̬��

;;---��ҳ���----------------------------------------------------------------
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



;;---������ҳѡ�----------------------------------------------------------
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

;Gui, Add, ListView, x410 y40 w320 h110 -ReadOnly Grid v_MyListView, $������|����ַ�|�ұ��ַ�
#include .\inc\listview\guiaddeditListView.aik ;; ��ӿɱ༭ListView

Gui, Add, Text, x400 y15 w340 h20	;; �������ڵ�Tabѡ��Ϸ�����
Gui, Add, Text, x400 y10 w10 h23 , $
Gui, Add, Text, x482 y10 w10 h23 , L
Gui, Add, Text, x572 y10 w10 h23 , R
Gui, Add, Edit, x410 y10 w70 h23 	v_expVar, ������
Gui, Add, Edit, x490 y10  w80 h23 	v_expL
Gui, Add, Edit, x580 y10  w80 h23 	v_expR
Gui, Add, Button, x665 y10 w33 h25 g��ListView�����ӱ�����, ��
Gui, Add, Button, x697 y10 w33 h25 g��ɾ��ListViewѡ�еı�����, ɾ

/*
LV_Add("", "$var2", "aaa", "1111")
LV_Add("", "$var2", "bbb", "2222")
LV_Add("", "$var2", "ccc", "3333")
*/

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
; Generated using SmartGUI Creator 4.0
Gui, Show, h556 w756, %g_title%

                                    
;;---�������ʱ���в������򽫲�����ΪҪ�򿪵��ļ���֮----------------------
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


;;---�˳��¼�----------------------------------------------------------------
GuiClose:
ExitApp

;;---���ڴ�С�����¼�--------------------------------------------------------
GuiSize:
	;; ����ѡ��롢�༭���λ��
	GuiControlGet, EditPos, Pos, _MyEdit
	width := A_GuiWidth - 15
	edt_height := a_GuiHeight - 30 - EditPosY
	if edt_height < 10
		edt_height = 10
		
	GuiControl, MoveDraw, _MyTab, w%width% 
	GuiControl, MoveDraw, _MyEdit, w%width% h%edt_height%
	
	;; ������ҳ�ļ��б�Ŀ��
	width := A_GuiWidth - 25 - 250
	GuiControl, MoveDraw, _MyListbox, w%width% 
	;; ��������ѡ��������б�
	GuiControl, MoveDraw, _CfgListbox, w%width% 	;; ����ListView�Ĵ�С������ʡ��

	;; �������ʽѡ��еı����б�
	width := A_GuiWidth - 25 - 410
	GuiControl, MoveDraw, _MyListView, w%width% 	;; ����ListView�Ĵ�С������ʡ��
	
	;; ���������ˡ�ѡ��еĿؼ�λ��
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

	;; �������������ڵĴ�С
	width := A_GuiWidth - 25 - 120
	GuiControl, MoveDraw, _edtCalc, w%width% 

	gosub ������ListView��С��
	
	return	
	
;;---��Ӧ�Ҽ����------------------------------------------------------------
GuiContextMenu:  
	;; �Ҽ��������־��ʾ��
	if A_GuiControl = _MyEdit
	{
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	return

;;---��ק�¼���Ӧ------------------------------------------------------------
GuiDropFiles:
	;; �����ק����־��ʾ����򿪸��ļ� 
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
	;; �����ק���ļ��б��������ק���ļ�
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


;;---���򿪡���ť------------------------------------------------------------
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
    SaveArrayToFile( g_PageSource, fileName )       ;; ���ڱ���
	GuiControl, Enable, _MyTab
	SB_SetText("") 	
	return
	
	
���鿴ԭʼ���ݡ�:
;   msgbox �鿴ԭʼ���� g_rawArray[%g_rawArray0%]
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
    JustFind()                          ;; �����ұ��������ݣ������浽����
    ShowViewPage( 1 )                   ;; ��ʾ�ող��ҳ���������
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
	FindFilt( )							;; ���Ҳ����ˣ������浽����
    ShowViewPage( 1 )                   ;; ��ʾ�ող��ҳ���������
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
    JustFilt()                          ;; ������ָ�������ݣ������浽����
    ShowViewPage( 1 )                   ;; ��ʾ�ող��ҳ���������
	GuiControl, Enable, _btnRe
	GuiControl, Enable, _btnBoth	
	GuiControl, Enable, _btnFi    
	SB_SetText("")		
	return
	
;; ������Ϣ����temp.ini�ļ���[��־�鿴��]һ���У���ʽ�磺
;; �������� = ��������|��������|��������ַ�|�����ұ��ַ�|��������|��������|��ʼ����|���ʽ|
;;            $����1����`����1���ַ�`����1���ַ�`��������`��������\n
;;            $����2����`����2���ַ�`����2���ַ�`��������`��������\n ......
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
		;; ������������Ƿ��Ѿ�����
		msgbox 4, �������ظ�, �������������<%KeyName%>�Ѿ����ڣ�`n`n%keyName% = %var_read%`n`n�Ƿ�Ҫ�滻֮?
		if msgbox no
		{
			return
		}		
	}
	;; ����ǰ����������Ϊһ���ַ���
	var_cfg := CreateCurCFG()
	
	;; ��������ļ����Ƿ��Ѿ������������
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


#include .\bin\�ı��ļ�����\��־�鿴��_ҳ������.aik
#include .\bin\�ı��ļ�����\��־�鿴��_��ֵ.aik
#include .\bin\�ı��ļ�����\��־�鿴��_��ݼ�.aik
#include .\bin\�ı��ļ�����\��־�鿴��_���ʽ.aik
#include .\bin\�ı��ļ�����\��־�鿴��_����.aik
#include .\bin\�ı��ļ�����\��־�鿴��_����.aik
#include .\inc\string.aik
#include .\inc\ListView\EditListViewBody.aik
#include .\inc\expression.aik
#include .\inc\inifile.aik
#include .\inc\tip.aik
