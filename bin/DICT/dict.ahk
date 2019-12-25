#NoTrayIcon
#SingleInstance off                     ;; ������ʵ��ͬʱ����


change_icon()                           ;; ����ͼ��

;FileInstall, dict.ico,%A_ScriptDir%\dict.ico

g_TIPMAXLINE := 100                     ;; �����������ʾ��ÿ���������󳤶�

g_RICHTEXTHEAD = .RichText
g_HideSection := 0 			;; ������������
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ����1: inifile|section list,sec1,sec2,sec3|titile|cursec|curkey
g_param1 = %1%
g_pInifile =
g_pTitle =
g_pSecList =
g_pCurSec =
g_pCurkey =
g_SubDir =



if g_param1 <>
{
	;; GetValueFromParams() �Ӳ����б��У���ѯָ���ؼ��ֵĲ���ֵ
	g_SubDir   := GetValueFromParams( g_param1, "SubDir" )
	g_pInifile := GetValueFromParams( g_param1, "file" )
	g_pSecList := GetValueFromParams( g_param1, "seclist" )
	g_pTitle   := GetValueFromParams( g_param1, "title" )
	g_pCurSec  := GetValueFromParams( g_param1, "cursec" )
	g_pCurkey  := GetValueFromParams( g_param1, "curkey" )
	g_Title    := g_pTitle
	g_INIFILE  := g_pInifile

	;; ����hidesec�Ƿ���ʾ�����������ɲ���ָ�����ڷ����б�g_pSecList�н�ָ����һ������
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
	g_INIFILE := read_ini("temp.ini", "�ҵ��ֵ�", "file", "dict.dic")
}


if g_HideSection
{
	_hideSec = hide
}
else
{
	_hideSec = 
}


;;------ȫ�ֱ���------------------------------------------------------------
g_OLDTITLE =                            ;; ��¼�����ֵ�Ĵ��ڣ��Ա㷵��
WinGetActiveTitle  g_OLDTITLE

g_PreIniFile =                          ;; �л��ֵ�󣬸ñ��������л�֮ǰ���ֵ��ļ�G


if g_Title =
{
	SplitPath g_INIFILE, OutFileName
	g_Title = %OutFileName% -- ����С�ֵ�
}
g_WINTITLE = %g_TITLE% ahk_class AutoHotkeyGUI ;; ע�����Դ�Сд����
IfWinExist %g_WINTITLE%
{
	WinActivate %g_WINTITLE%
	CoordMode, ToolTip, Screen
	ToolTip, �� %g_Title% ��`n--------------------------------`n�����ֵ��Ѵ�`n���Ҫ���´����밴��Alt����`n, A_ScreenWidth - 230, A_ScreenHeight - 120
	KeyWait, LAlt,D T2
	if not GetKeyState("LAlt", "p"])
	{
		ExitApp
	}
	ToolTip
}

; Gosub �������ȼ���

g_WINX := readTempIni("�ҵ��ֵ�", "winx", "")
g_WINY := readTempIni("�ҵ��ֵ�", "winy", "")
g_FAVORITE := readTempIni("�ҵ��ֵ�", "favorite", "")
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
        CONTINUE                        ;; ���˵���ʱ�ļ�
	}
	if A_LOOPFileName <>
	{
		�������ַ���(g_DICTLIST, A_LOOPFileName, "|")
	}
}

g_IsHelp := false                       ;; �Ƿ���ʾ��æ��Ϣ��
g_SearchHistory =                       ;; ��ʷ����
g_StatusTip =                           ;; ״̬������ʾ������

g_CurSelectLine := 0                    ;; ��ǰ˫��ListView�е���
g_ShowDetail := false					;; ��ǰListView�Ƿ���ʾչ���ĵ���ѡ��
g_CurKey =
g_GuiID =
g_LVName = SysListView321


;;---����INI�ļ�������-------------------------------------------------------
g_IniArray =                            ;; ����INI�е�����
g_iSecArray =                           ;; �� g_IniArray
g_secList =                             ;; ��ǰini�ļ������е�section, g_secList = sec1|sec2|....


;; g_bAutoSearch �޸ķ��ࡢKeyName��KeyValue�༭��ʱ���Ƿ�ʵʱ�Զ�������
;; �������Զ�������Щ�༭��ʱ������Ը���Զ�����������Ӧ�������ñ༭���ֵ֮ǰ
;; ��g_bAutoSearch��ֵ��Ϊ false���������֮���ٽ���ֵ��Ϊtrue
g_bAutoSearch := true
g_EnterExit   := 0                  	;; 0 ���л�״̬�� 1 �����������л����ҵ�С���ڣ�-1 �����Ǵ��ֵ䴰���л�����������
g_WindowWidth =                         ;; ��¼��ǰ���ڵĿ�ȣ� �Թ�����ListView���п���
g_bShortCol1 := false					;; ��һ�п�����Զ��������ٴ���С
g_bShortCol2 := false					;;
g_iLocalPos  := 0	                    ;; ���������֮�󣬽��ӿ���ʾ���ڼ���
KeyValueFieldTitle = ������
SectionFieldTitle = ����
KeyNameFieldTitle = ����

g_SecEditWidth = 120			    ;; ָ���������ؼ��Ŀ��
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �����˵������ڣ� ����ʾ����
#include ../../
#include .\bin\Dict\dict_CreateUI.aik

;; ʹ��ListView����ɫ�������׽��棬���лҰ׽���

; LVA_ListViewAdd("_KeyListView", "AR AC cbsilver")

LVA_ListViewAdd("_KeyListView")
LVA_SetCell("_KeyListView", 0, 1, "", "Green" )
LVA_SetCell("_KeyListView", 0, 2, "", "0x3366BB" )
LVA_SetCell("_KeyListView", 0, 3, "", "0x666666" )

OnMessage("0x4E", "LVA_OnNotify")
OnMessage( 0x06, "WM_ACTIVATE" )
ControlSetText Edit4, %g_INIFILE%, %g_WINTITLE%	; ����ComboBoxĬ��ֵ

ShowText()  ;; ����RichEdit�༭��
GuiControl, Hide, _btnSingleValue

if g_pSecList =
{
	GoSub ����ȡini�ļ���
}
else	;; �������ָ������ʾ��Section�б�Ĭ��ѡ���Section �� Key
{
	Init()

	�Ƽ���INI�ļ�( g_pSecList )

	GuiControl,, _SecListBox, |
	GuiControl,, _SecListBox, %g_secList%

	g_bAutoSearch := false
	GuiControl, Text, _INIFILE, %g_INIFILE%
	g_bAutoSearch := true


	GuiControl, disable, _IniFile
	;;___���ô����±�����ȼ�________________________________________________
	Gui, Show, , %g_TITLE%
	Gosub �������ȼ���
}

if g_pCurSec <>
	guicontrol, text, _Section, %g_pCurSec%

if g_pCurKey <>
	Guicontrol, text, _keyname, %g_pCurKey%

RETURN

;;---�������ڵĴ�С---------------------------------------------------------
GuiSize:
�����»��ƴ��ڡ�:
	;; �����ش�����λ�õĿؼ����������֮������ʾ��Ŀ���Ǳ�����˸
	GuiControlGet, bListViewVisible, Visible, _KeyListView  ;; bListViewVisible����_KeyListView��ǰ��ʾ״̬���Ա����ָ�
	bMultiKeyValue := ��keyValue��ʾ����()

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
	;; �����ؼ�λ��
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
	GuiControl, MoveDraw, _KeyListView , x%var_x% h%var_Height% w%var_Width% ;; ListView�Ĵ�С����
	GuiControl, MoveDraw, _KeyValue , x%var_x% w%var_Width%
	GuiControl, MoveDraw, _lbl_KeyValue , x%var_x2%

	if g_HideSection
		var_x += 3
	ControlMove, , var_x, , var_Width, var_Height, ahk_id %g_hRichEdit%

	var_Width := var_Width - 25 						;; KeyValue�ĺ������ӡ�+����ť������Ҫ��С25������
	var_Height := bMultiKeyValue ? ( var_Height + 30 ) : 25

	GuiControl, MoveDraw, _KeyValue , w%var_Width% h%var_Height%		;; KeyValue�༭��Ŀ�ȵ���
 	LV_ModifyCol(3, var_Width)          				;; ����_KeyListView�б�����еĿ��

	var_left := A_GuiWidth - 30
	GuiControl, MoveDraw, _btnAdd2 , x%var_left%
	GuiControl, MoveDraw, _btnSingleValue , x%var_left%


	;; ��Ҫ����������
	if not g_HideSection
	{
		var_Height := A_GuiHeight - 148
		GuiControl, MoveDraw, _SecListBox , h%var_Height% w%g_SecEditWidth%	;; �������ListBox�ĸ߶�
		GuiControl, MoveDraw, _Section ,  w%g_SecEditWidth%

		;; �����·���ť�͸�ѡ���Topλ��
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

	;; ��ʾ������Ŀ���
	GuiControl, show, _btnAdd
	GuiControl, show, _btnAdd2
	GuiControl, show, _btnMod
	GuiControl, show, _btnDel
	GuiControl, show, _btnCopy
	GuiControl, show, _btnInsert
	GuiControl, show, _btnClose
	GuiControl, show, _BtnGroup
	GuiControl, show, _btnHideSec


	;; �ָ�_KeyListView��RichEdit����ʾ
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

;; ���ļ���ק���ҵ�С�ֵ���
GuiDropFiles:
	;; �����ק����־��ʾ����򿪸��ļ�

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
		GoTo �����¼����ֵ䡿
	}
	return

;;---���Section ListBox�б�, ѡ��Section--------------------------------------------
SectionListBox:
	Gui, Submit, NoHide
	if A_GuiEvent = DoubleClick
	{
		SetTimer, ����ʱ����KeyName��, Off

		g_isHelp := false
		g_bAutoSearch := false
		Gosub �����������
		g_bAutoSearch := true
		Sleep 100
		Gosub ������KeyName��
	}
	else if A_GuiEvent = Normal
	{
		g_bAutoSearch := false
		GuiControl, Text, _Section, %_SecListBox%
		g_bAutoSearch := true
		;SetTimer, ����ʱ����KeyName��, 200
	}
	RETURN

;;---���KeyListView�б�, ѡ��ע��--------------------------------------------
KeyListView:
	if ( A_GuiEvent == "DoubleClick"  )
	{
		gui, submit, nohide

		g_ShowTip := false              ;; ʹ��ʱ��ʾ[��ʱչ������ʾ����]ʧЧ
		tipx( 7 )				;; ���������ʾ��tooltip

		if ( A_EventInfo > LV_GetCount() || A_EventInfo <= 0 )
		{
			RETURN
		}
		g_CurSelectLine := A_EventInfo

		;; ��ListView�л�ȡkeyValue, ����䵽keyValue�༭����
		LV_GetText( var_RowKeyValue, A_EventInfo, 3 )
		g_bAutoSearch := false
		GuiControl, Text, _KeyValue,  %var_RowKeyValue%
		g_bAutoSearch := true

		;; ���ListView������ʾ���ǰ�����Ϣ�����ڽ�ѡ�е�������ʾ�������keyValue֮�󣬲��ٽ�����������
		if g_IsHelp
		{
			g_bAutoSearch := true
			RETURN
		}

		;; ��ListView��Section������䵽����༭��
		LV_GetText( var_RowSec, A_EventInfo, 1 )
		if ( _Section != var_RowSec )
		{
		    g_bAutoSearch := false      ;; ��ͣʵʱ�������������ű༭�������µ�ֵ
		    GuiControl, Text, _Section, %var_RowSec%
	        g_bAutoSearch := true       ;; ���һ���༭�򣬿ɴ�ʵʱ��������
		}

		;; ��ListView�е�ǰ�е�keyNameֵ���õ�������
		LV_GetText( var_RowKeyName, A_EventInfo, 2 )
		if ( _keyName != var_RowKeyName && var_RowKeyName != "" )
		{
			;;___������ʷ����________________________________________________________
			if ��Add�ַ�������( g_SearchHistory, var_RowKeyName, "|", true, 20 )
			{
				GuiControl,, _KeyName, |
				GuiControl,, _KeyName, %g_SearchHistory%
				write_ini("temp.ini", "�ҵ��ֵ�", g_INIFILE, g_SearchHistory, false )
			}
		}
		g_bAutoSearch := false
		GuiControl, Text, _KeyName, %var_RowKeyName%
		Sleep 50 	;; ��Ҫ��ʱһ�㣬 �������ȡ����_keyName��ֵ
		g_bAutoSearch := true


		g_DBClickListView := true


		if !g_showdetail
		{
            ;sleep 50                    ;; ��ʱһ�㣬˫���б���ʾ�ĵ����������״̬�������Զ�չ������Ҫ����˫����չ����
			bNeedRichText := false 
			if var_RowKeyValue <>
			{
				ifInstring var_RowKeyValue, %g_RICHTEXTHEAD%
					bNeedRichText := true
				else if instr( var_RowKeyValue, "{\rtf1\" ) == 1
					bNeedRichText := true
			}


            if bNeedRichText            ;; ��Ҫʹ��RichEdit��ʾ��ϸ����
			{
				GoTo ���Ҽ��鿴��
			}
            else                        ;; չ��������
			{
				Gosub ������KeyName��
				��չ��������( var_RowSec, var_RowKeyName, var_RowKeyValue )
			}
		}
		else if var_RowKeyValue <>
		{
			if ( InStr( var_RowKeyValue, "`;" ) > 0 or strlen(var_RowKeyValue) > 50 )
			{
            	GoTo ���Ҽ��鿴��       ;; ��չ��������֮��˫��ListView�������Ի�����ʾKeyValue��ֵ������������ʾ��������ݣ��Ķ�������
            }
		}
	}
	RETURN

;;---��Ӧ�Ҽ���Ϣ------------------------------------------------------------
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _KeyListView  ; Display the menu only for clicks inside the ListView.
	{
		;; ���浱ǰѡ����е� g_iLocalPos
		GetLVCellUnderMouse( g_GuiID, g_LVName, g_iLocalPos, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )

		ifNotexist %g_INIFILE%
			RETURN

		g_CurSelectLine := A_EventInfo
		GetLVCellUnderMouse( g_GuiID, g_LVName, var_CurRow, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )
		LV_GetText( var_RowKeyValue, g_CurSelectLine, 3 )
		LV_GetText( var_RowSec, g_CurSelectLine, 1 )
		LV_GetText( var_RowKeyName, g_CurSelectLine, 2 )
		if ( var_RowSec == "����" && var_RowKeyName == "Key" && var_RowKeyValue == "KeyValue" )
		{
			RETURN
		}
		if ( var_RowSec == "" || var_RowKeyName == "" )
		{
			Menu, MyContextMenu, disable, ����(&I)
			Menu, MyContextMenu, disable, �޸�(&E)
			Menu, MyContextMenu, disable, ɾ��(&D)
			Menu, MyContextMenu, disable, ���(&A)
			Menu, MyContextMenu, disable, ������������(&N)
		}
		else
		{
			Menu, MyContextMenu, disable, ����(&I)

			if g_IsHelp
			{
				Menu, MyContextMenu, disable, �޸�(&E)
				Menu, MyContextMenu, disable, ɾ��(&D)
				Menu, MyContextMenu, disable, ���(&A)
				Menu, MyContextMenu, disable, ������������(&N)
			}
			else
			{
				Menu, MyContextMenu, Enable, �޸�(&E)
				Menu, MyContextMenu, Enable, ɾ��(&D)
				Menu, MyContextMenu, Enable, ���(&A)
				Menu, MyContextMenu, Enable, ������������(&N)
				if g_ShowDetail
					Menu, MyContextMenu, Enable, ����(&I)
			}
		}
		if var_RowKeyValue =
		{
			Menu, MyContextMenu, disable, ����(&C)
			Menu, MyContextMenu, disable, ����ճ��(&P)
		}
		else
		{
			Menu, MyContextMenu, Enable, ����(&C)
			Menu, MyContextMenu, Enable, ����ճ��(&P)
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

;; ������ʾ����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �����ǰ�ť���ȼ�����Ӧ

;;---�رմ���----------------------------------------------------------------
���رհ�ť��:
GuiEscape:
GuiClose:
	WinGetPos winx, winy, , , %g_WINTITLE%
	WriteTempIni("�ҵ��ֵ�", "winx", winx)
	WriteTempIni("�ҵ��ֵ�", "winy", winy)
ExitApp



;;---��Ӧ������ť,���¼���ini�ֵ��ļ�----------------------------------------
�����¼����ֵ䡿:
	ControlSetText, Edit1, , %g_WINTITLE%
������ȫ����:
	ControlSetText, Edit3, , %g_WINTITLE%		;; ���Setion�༭��
�����¼������ݲ�������:
	Gui submit, nohide
	ifnotexist %g_INIFILE%
	{
		g_Sections =
		msgbox �ֵ��ļ�%g_INIFILE%������, �����ֵ�ʧ��!
		RETURN
	}
	else if ( g_pSecList == "" && g_INIFILE != read_ini("temp.ini", "�ҵ��ֵ�", "file", "dict.dic") )
	{  ;; ��g_pSecListΪ��ʱ����ʾ��ʱ���ֵ䣬�����浽���ʹ�õ�file������
		write_ini("temp.ini", "�ҵ��ֵ�", "file", g_INIFILE, false)
	}
	GuiControl, Text, _KeyValue,
;	ControlSetText, Edit2, , %g_WINTITLE%		;; ���KeyValue�༭��

	var_cursec := _section
	var_curkey := _keyName
	var_ShowDetail := g_ShowDetail

	Gosub ����ȡini�ļ���


	g_ShowDetail := var_ShowDetail
	;; �Ƿ���Ҫչ��������
	if g_ShowDetail
	{
		sleep 100
		var_keyValue := ��FindIniContent( var_cursec, var_curkey )
		��չ��������( var_cursec, var_curkey, var_keyValue )
	}
	Else
	{
		Gosub ������keyName��

		g_bAutoSearch := false
		GuiControl, Text, _KeyName, %var_CurKey%
		GuiControl, Text, _Section, %var_cursec%
		g_bAutoSearch := true
	}
	Return

����ȡini�ļ���:
	Init()

	var_seclist =
	if ( g_pInifile == g_inifile )
	{
		var_seclist := g_pSecList
		g_Title := g_pTitle
	}
	else
		g_Title =

	�Ƽ���INI�ļ�( var_seclist )

	GuiControl,, _SecListBox, |
	GuiControl,, _SecListBox, %g_secList%

	g_bAutoSearch := false
	GuiControl, Text, _INIFILE, %g_INIFILE%
	g_bAutoSearch := true


	;;___��������������������ʷ______________________________________________
	g_SearchHistory := read_ini("temp.ini", "�ҵ��ֵ�", g_INIFILE, "")
	GuiControl,, _KeyName, |
	GuiControl,, _KeyName, %g_SearchHistory%
	GuiControl,Text,_keyName, %g_CurKey%

	;;___���ô����±�����ȼ�________________________________________________
	if g_Title =
	{
		SplitPath g_INIFILE, OutFileName
		g_Title = %OutFileName% -- ����С�ֵ�
	}
	g_WINTITLE = %g_TITLE% ahk_class AutoHotkeyGUI ;; ע�����Դ�Сд����
	Gui, Show, , %g_TITLE%
	Gosub �������ȼ���

Return



;; ��ť���ȼ�Ӱ�����
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

��ȡ���ȼ���:
	if g_PreIniFile <>
	{
		SplitPath g_PreIniFile, OutFileName
		preTitle = %OutFileName% -- �ҵ�С�ֵ�
		preWINTITLE = %preTitle% ahk_class AutoHotkeyGUI ;; ע�����Դ�Сд����

		Hotkey, IfWinActive, %preWINTITLE%
		Hotkey, F1, 			����С���ҵ�С�ֵ䡿, off
		Hotkey, F3, 			������ȫ����, off
		Hotkey, F4, 			����ʼ�����б༭��, Off
		Hotkey, F5, 			�����¼������ݲ�������, Off
		Hotkey, F6, 			����������������ʷ��¼��, off
		Hotkey, Enter, 			���س���Ӧ��, off
		Hotkey, numpadenter, 	���س���Ӧ��, off
		Hotkey, !Enter, 		��ALT�س���Ӧ��, off
		Hotkey, ^PGUP,			��keyValue��ʾ���С�, Off
		Hotkey, ^PGDN,			��keyValue��ʾ���С�, Off
		Hotkey, ^o,				 MenuFileOpen, off
		Hotkey, ^e, 			�����ı��༭���򿪡�, off
		Hotkey, ^i, 			�����밴ť��, off
		Hotkey, ^=, 			�����Ӱ�ť��, off
		Hotkey, #Tab,			������������, Off
		Hotkey, ^Tab,			������KeyValue��, Off
		Hotkey, ins & end, 		�����Ӱ�ť��, off
		Hotkey, !4, 			�����Ӱ�ť��, off
		Hotkey, NumpadAdd, 		�����Ӱ�ť��, off
		Hotkey, ^s, 			������KeyValue������ע�͵�ֵ�������ڡ�, off
		Hotkey, ~BS, 			���˸�����𵥴��, off
		Hotkey, ^up, 			��ListView��һ�С�, off
		Hotkey, ![,				��ListView��һ�С�, off
		Hotkey, ^Down,			��ListView��һ�С�, off
		Hotkey, !],				��ListView��һ�С�, off
		Hotkey, !0, 			��ȡ���ö��Ͱ�͸����, off
		Hotkey, ~LButton, 		��������������Ӧ��, off
		Hotkey, ~WheelDown, 	���ر�Timer_��ʱչ������ʾ���ݡ�, off
		Hotkey, ~WheelUP, 		���ر�Timer_��ʱչ������ʾ���ݡ�, off
		Hotkey, <^LButton,		����ק�ı����������ڡ�, off
		loop 12
		{
			var_temp = !F%a_index%
			Hotkey, %var_temp%, ����ݼ����ղء�, off
		}
		Hotkey, IfWinExist, %preWINTITLE%
		Hotkey, #v, 			��������������ѡ�е����ݵ�����С�ֵ䡿, off
		Hotkey, ^!+2, 			��ճ��������С�ֵ�KeyValue����, off
		Hotkey, ^!+3, 			��ճ��Ϊ����С�ֵ�KeyValue���ע�͡�, off
		Hotkey, ^!+1, 			��ճ��������С�ֵ�KeyName��, off
		hotkey, ins & home, 	��������������ѡ�е����ݵ��ֵ���������С�, off
		Hotkey, ins & PGUP, 	��������������ѡ�е����ݵ��ֵ��KeyValue���С�, off
		Hotkey, ins & PGDN, 	���������������е����ݵ�KeyValue��ĩβ��Ϊע�͡�, off
		Hotkey, NumpadPgup,		���������������е����ݵ�KeyValue��ĩβ��Ϊע�͡�, off
		Hotkey, NumpadHome, 	��������������ѡ�е����ݵ��ֵ����������������, off
		Hotkey, NumpadUp,		�����������ڸ���ѡ�����ݵ��ҵ�С�ֵ��KeyValue���С�, off
		Hotkey, !c,				���������ѡ�е����ݵ��ҵ�С�ֵ䡿, off
		Hotkey, NumpadLeft,		��������������ѡ�е�����_ת��Ϊ��д��ճ�����ֵ���������С�, off
		Hotkey, NumpadClear,	��������������ѡ�е�����_��Ϊע����ӵ�KeyValue��ĩβ���Զ���ӡ�, off
		Hotkey, !j,				��Alt_J��Ӧ��, off
	}
Return

�������ȼ���:
	Hotkey, IfWinActive, %g_wintitle%
	Hotkey, F1, 			����С���ҵ�С�ֵ䡿
	Hotkey, F3, 			������ȫ����
	Hotkey, F4, 			����ʼ�����б༭��
	Hotkey, F5, 			�����¼������ݲ�������
	Hotkey, F6, 			����������������ʷ��¼��
	Hotkey, Enter, 			���س���Ӧ�� 	;��չ��ListView��ʾ�ĵ�һ�е����
	Hotkey, numpadenter, 	���س���Ӧ��	;��չ��ListView��ʾ�ĵ�һ�е����
	Hotkey, !Enter, 		��ALT�س���Ӧ��
	Hotkey, ^PGUP,			��keyValue��ʾ���С�
	Hotkey, ^PGDN,			��keyValue��ʾ���С�
	Hotkey, ^o,			 	MenuFileOpen
	Hotkey, ^e, 			�����ı��༭���򿪡�
	Hotkey, ^i, 			�����밴ť��
	Hotkey, ^=, 			�����Ӱ�ť��
	Hotkey, #Tab,			������������
	Hotkey, ^Tab,			������KeyValue��
	Hotkey, ins & end, 		�����Ӱ�ť��
	Hotkey, !4, 			�����Ӱ�ť��
	Hotkey, NumpadAdd, 		�����Ӱ�ť��
	Hotkey, ^s, 			������KeyValue������ע�͵�ֵ�������ڡ�
	Hotkey, ~BS, 			���˸�����𵥴��
	Hotkey, ^up, 			��ListView��һ�С�
	Hotkey, ![,				��ListView��һ�С�
	Hotkey, ^Down,			��ListView��һ�С�
	Hotkey, !],				��ListView��һ�С�
	Hotkey, !0, 			��ȡ���ö��Ͱ�͸����
	Hotkey, ~LButton, 		��������������Ӧ��
	Hotkey, ~WheelDown, 	���ر�Timer_��ʱչ������ʾ���ݡ�
	Hotkey, ~WheelUP, 		���ر�Timer_��ʱչ������ʾ���ݡ�
	Hotkey, <^LButton,		����ק�ı����������ڡ�
	Hotkey, !j,				��Alt_J��Ӧ��
	loop 12
	{
		var_temp = !F%a_index%
		Hotkey, %var_temp%, ����ݼ����ղء�
	}

	;Hotkey, F6, [F6]
	Hotkey, IfWinExist, %g_wintitle%
	Hotkey, #v, 			��������������ѡ�е����ݵ�����С�ֵ䡿
	Hotkey, ^!+2, 			��ճ��������С�ֵ�KeyValue����, on
	Hotkey, ^!+3, 			��ճ��Ϊ����С�ֵ�KeyValue���ע�͡�, on
	Hotkey, ^!+1, 			��ճ��������С�ֵ�KeyName��, on
	
	hotkey, ins & home, 	��������������ѡ�е����ݵ��ֵ���������С�
	Hotkey, ins & PGUP, 	��������������ѡ�е����ݵ��ֵ��KeyValue���С�
	Hotkey, ins & PGDN, 	���������������е����ݵ�KeyValue��ĩβ��Ϊע�͡�
	Hotkey, NumpadPgup,		���������������е����ݵ�KeyValue��ĩβ��Ϊע�͡�
	Hotkey, NumpadHome, 	��������������ѡ�е����ݵ��ֵ����������������
	Hotkey, NumpadUp,		�����������ڸ���ѡ�����ݵ��ҵ�С�ֵ��KeyValue���С�
	Hotkey, !c,				���������ѡ�е����ݵ��ҵ�С�ֵ䡿
	Hotkey, NumpadLeft,		��������������ѡ�е�����_ת��Ϊ��д��ճ�����ֵ���������С�
	Hotkey, NumpadClear,	��������������ѡ�е�����_��Ϊע����ӵ�KeyValue��ĩβ���Զ���ӡ�
Return


���ֵ�༭��:
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
	
	;;___��ʾ������������Ӧ�ľ�������________________________________________

	ifinstring var_preInput, .dic
	{
		SetIniFile( _INIFILE )
		ControlGetText, g_CurDict, Edit4, %g_WINTITLE%
		LV_Delete()
		IfExist %g_CurDict%
		{
			GoSub �����¼����ֵ䡿
			Control HideDropDown, , ComboBox2, 
			GuiControl,,_INIFILE, |
			GuiControl,,_INIFILE, %g_DICTLIST%			
			GuiControl, Text, _INIFILE, %var_curInput%
		}
		return
	}
	else
	{
		findList := �����������б�( var_curInput )
		if ( g_preList == findList )
		{
			return
		}
		g_preList := findList

		;;___��ʾ�����б�________________________________________________________
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


��KeyNameEdit��:
	if g_bAutoSearch
	{
		Gui submit, nohide
		GuiControl, Text, _KeyValue,
	;	ControlSetText Edit2, , %g_WINTITLE% 	;; ���Value��
		GoSub ������KeyName��
	}
	RETURN

��SectionEdit��:
	if g_bAutoSearch
	{
		Gosub ������KeyName��
	}
	RETURN

��KeyValueEdit��:
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
                LV_Modify( a_Index, "Select")   ;; ѡ������������
				if ( nNum == 1 )
				{
                    LV_Modify( a_Index, "Vis")  ;; ������ֱ����������λ����һ���ҵ�����
				}
			}
		}
	}
	RETURN

�������������:
	g_HideSection := !g_HideSection
	�����»��ƴ���()
	return

����С�������ȡ�:
	g_SecEditWidth -= 20
	if g_SecEditWidth < 80 
		g_SecEditWidth := 50
	�����»��ƴ���()
	return

�������������ȡ�:
	g_SecEditWidth += 20
	if g_SecEditWidth > a_guiwidth * 2 / 3
		g_SecEditWidth := a_guiwidth * 2 / 3
	�����»��ƴ���()
	return

�������������ȡ�:
	gui submit, nohide
	if _section is digit
		if ( _section > 80 && _section < a_screenwidth / 2 )
		{
			g_SecEditWidth := _section
			�����»��ƴ���()
		}
	return

�����»��ƴ���()
{	
	global
	WinGetPos , , , width, , %g_WinTitle%
	WinMove, %g_WinTitle%, , , , width + 1
	WinMove, %g_WinTitle%, , , , width
}


�����������б�( curInput_ )
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
