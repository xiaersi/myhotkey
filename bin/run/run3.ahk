#SingleInstance ignore 						;; ֻ����һ��ʵ������
#NoTrayIcon
Process Priority,,High

g_bAutoSearch := true
g_bAutoFit    := true               		;; �Զ���������
g_bAutoExit   := true                		;; �Զ��˳��Ŀ��أ�������Not Activeʱ�������Ƿ��Զ��˳�

g_title = ���������
g_wintitle = %g_title% ahk_class AutoHotkeyGUI
g_inifile = launchy.ini
g_BackGround := read_ini(g_inifile, "file", "���б���", "" )
g_ExtlistEx  := read_ini(g_inifile, "����", "��չ�������б�", "" )	;; ��չ�������б�, ���磺txt|exe|bat
SECFIELD = 2
KEYFIELD = 1
VALUEFIELD = 3
MEMOFIELD = 4
g_FieldTitle%SECFIELD% = SEC
g_FieldTitle%KEYFIELD% = KEY
g_FieldTitle%VALUEFIELD% = VALUE
g_FieldTitle%MEMOFIELD% = MEMO

g_LVName = SysListView321
g_MaxRecentNum := 20                    	;; ���������¼���������
g_CalcTipTime  = 1000                   	;; ��������������ʾʱ�䣨���룩
g_NotLoadSec = ����,Setting             	;; ����Ҫ��ini�ļ���ȡ������ķ���
g_FiltExt = svn,bak							;; ListView����ʾĿ¼�µ��ļ�ʱ��Ҫ���˵�����չ��
g_FolderSection = $Folder$ 					;; ���������һ����Ч��Ŀ¼ʱ��ListView����ʾ��Ŀ¼�µ��ļ��б���ʱ�ڶ���Section����ʾΪ��ֵ

IfNotExist %g_inifile%
{
	MsgBox ��%g_title%���������ļ������ڣ�
	ExitApp
}

;; ����ȫ�ֱ���
; File_KeyArray                             ;; �����ļ���[File]�ڵ�Key����
; Send_KeyArray                             ;; �����ļ���[Send]�ڵ�Key����
; Var_KeyArray								;; �����ļ���[::]�ڵ�Key����
; File_ValueArray
; Send_ValueArray
; Var_ValueArray
; File_ExtArray
; File_IconArray
; File_PathArray

g_LoadCmdType = run,vim,var,recent,eme,send,calc,start,script,web,dir
g_NotSaveCmdType = ahk,help,add,start      	;; ��Щ���͵��������������б�Ҳ�����浽��ʱ�����ļ���
g_CustomCmdType =                       	;; �û��Զ����������ͣ���ue,eme,vim,��

g_RecentCmd     =                           ;; ���ʹ�õ������б�
g_RecentCalc    =                           ;; ���ʹ�õļ�������
g_RecentWeb     =                        	;; ���ʹ�õ���ַ����
g_RecentScript  =                           ;; ���ʹ�õĽű�����
g_RecentVar     =                           ;; ���ʹ�õİ�������������
g_RecentRunDirect =                         ;; ���ʹ�õ���������
g_Sections =                                ;; �����ļ��У�����Section���ӳɵ��ַ���
g_SearchSections =                          ;; ����������Section�б� Ĭ��Ϊ File,Send,variable

g_cmdList = run ,help ,calc ,script ,var ,start ,vim ,send ,ahk ,add ,
regread g_svndir, HKEY_LOCAL_MACHINE, SOFTWARE\TortoiseSVN, ProcPath  ;; g_svndir��ȡSVNĿ¼
if g_svndir <>
	g_cmdList = %g_cmdList%svn ,svn,


�Ƴ�ʼ��ȫ�ֱ���()
InitIconList( hLVIL )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �Ҽ����ListView�б�ʱ, �����Ҽ��˵�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, MyContextMenu, Add, ����(&R), ���Ҽ����С�
Menu, MyContextMenu, Add, �鿴(&V), ���Ҽ��鿴��
Menu, MyContextMenu, Add, ɾ��(&D), ���Ҽ�ɾ����
Menu, MyContextMenu, Add,
Menu, MyContextMenu, Add, �޸�(&M), ���Ҽ��޸ġ�
Menu, MyContextMenu, Add, ����(&A), ���Ҽ���ӡ�
;Menu, MyContextMenu, Add, ������(&N), ���Ҽ��޸ĵ������ơ�

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ������ʾ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Gui +ToolWindow  +AlwaysOnTop
gui -Caption
gui, font, s10
Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
hGui := WinExist()

Gui, Add, Picture, x22 y15 AltSubmit , %g_background%
Gui, Add, Edit, x35 y33 w385 h25  v_edtSearch g���ҵ����д���_�����, %g_recent%
Gui, Add, Button, x420 y33 g��ȷ��ִ�С�, OK
;Gui, Add, Button, x66 y65 w80 h30 hide default  g���ҵ����д���_ȷ����ť��, ȷ��(&Y)
;Gui, Add, Button, x206 y65 w80 h30 hide  g���ҵ����д���_ȡ����ť��, ȡ��(&N)
Gui, Add, GroupBox, x11 y0 w460 h85 v_GroupBox , +%g_title%+
Gui, Add, ListView, x35 y63 w410 h270 +LV0x2 v_KeyListView g���ҵ����д���_ListView��, %g_FieldTitle1%|%g_FieldTitle2%|%g_FieldTitle3%|%g_FieldTitle4%
LV_SetImageList(hLVIL, 1)               ;; ʹ��ImageList��ʹListView�ĸ߶ȸ���
GuiControl, Hide, _KeyListView
LVA_ListViewAdd("_KeyListView", "")

;; �����ȼ�
Hotkey, IfWinActive, %g_wintitle%
Hotkey, F2, 			���ֹ��༭�����ļ���
Hotkey, +F2,			��ʹ�÷���С�ֵ�༭�����ļ���
Hotkey, ~backspace, 	���˸������
Hotkey, ~LButton,		���������
Hotkey, Enter, 			���س��¼�����
Hotkey, MButton,		���м�����
Hotkey, [,   			��ListView��ѡ����һ����
Hotkey, ],				��ListView��ѡ����һ����
Hotkey, ~up,			��UP������
Hotkey, ~Down,			��Down������
Hotkey, ~WheelUp,		��Wheel������
Hotkey, ~WheelDown,		��Wheel������

;; ���ô���͸������ʾ
Gui, Color, EEAA99
WinSet, TransColor, EEAA99
Gui, Show, xCenter yCenter h340  w480, %g_title%

LV_ModifyCol(SECFIELD, 	60)		;; ����ListView��1�еĿ��
LV_ModifyCol(KEYFIELD, 	150)	;; ����ListView��2�еĿ��
LV_ModifyCol(VALUEFIELD,200)	;; ����ListView��3�еĿ��
LVA_SetCell("_KeyListView", 0, VALUEFIELD, "", "0xAAAAAA" )
LVA_SetCell("_KeyListView", 0, SECFIELD, "", "Green" )

OnMessage( 0x06, "WM_ACTIVATE" )
OnMessage("0x4E", "LVA_OnNotify")
LoadIniFile()


;; �л�Ӣ�����뷨
	if RegExMatch(A_OSVersion, "^10")
	{
		;; �����Win10
	    SetCapsLockState,off
        switchime_win10(0)
	}
	else
	{
	switchime("���� (����) - ��ʽ����")
	}


return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �¼���Ӧ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;---��Ӧ�Ҽ���Ϣ------------------------------------------------------------
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _KeyListView  ; Display the menu only for clicks inside the ListView.
	{
		g_CurSelectLine := A_EventInfo

		;; �õ���ǰ��������ǵڼ���
		GetLVCellUnderMouse( hGui, g_LVName, var_CurRow, var_CurCol, var_CellX, var_CellY, var_CellW, var_CellH )

		LV_GetText( g_lvKeyValue, g_CurSelectLine, VALUEFIELD )
		LV_GetText( g_lvSec, g_CurSelectLine, SECFIELD )
		LV_GetText( g_lvKeyName, g_CurSelectLine, KEYFIELD )
		LV_GetText( g_lvMemo, g_CurSelectLine, MEMOFIELD )
		ifInString g_lvSec, $
		{
			Menu, MyContextMenu, disable, ����(&A)
		;	Menu, MyContextMenu, disable, ������(&N)
			Menu, MyContextMenu, disable, �޸�(&M)
		}
		else
		{
			Menu, MyContextMenu, enable, ����(&A)
		;	Menu, MyContextMenu, enable, ������(&N)
			Menu, MyContextMenu, enable, �޸�(&M)
		}
		Menu, MyContextMenu, Show, %A_GuiX%, %A_GuiY%
	}
	RETURN


���ҵ����д���_�����:
	SetTimer ����ʱ�����û����벢��ʾ��, off
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
			;; ���ݵ�ǰ����ĳ��ȣ�ȷ����ʱ���ҵ�ʱ�䣬��������Խ�����������Ľ��Խ�٣����ǽ���ʱʱ������СһЩ
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

			;; ��ʱ������Ŀ����ʹ�û��������ȣ����򽫽�����ܴ�ʱ���ܻ�����û�������
			SetTimer ����ʱ�����û����벢��ʾ��, %var_temp%
		}
		else if g_cmdType in add
		{
			GuiControl, Hide, _KeyListView
		}
		else if g_cmdType in dir
		{
			var_temp := get_file_ext( g_cmdName )

			;; ��� g_cmdName ʱԶ��Ŀ¼����Ч��Ŀ¼������ʾ���ʹ���б�
			if ( instr(g_cmdName, "\\") == 1 || var_temp != "$Dir$"  )
			{
				�Ʋ��Ҳ���ʾ�������( g_cmdType, g_cmdName )
			}
			;; ��� g_cmdName ����Ч��Ŀ¼������ʾ��Ŀ¼�µ������ļ�
			else
			{
				����ʾĿ¼�µ��ļ�( g_cmdName )
			}
		}
		else
		{
			�Ʋ��Ҳ���ʾ�������( g_cmdType, g_cmdName )
		}
		;; ��ʾ�������͡����������Ϣ
		var_tip = ����[%g_cmdType%]  ����{ %g_cmdName% }
		loop %cmdParamArray0%
		{
			var_temp := cmdParamArray%a_index%
			var_tip = %var_tip% P%a_index%=%var_temp%,
		}
		GuiControl, , _GroupBox, %var_tip%
	}
	g_bAutoSearch := true
	return


���ҵ����д���_ȷ����ť��:
���ҵ����д���_ȡ����ť��:
	return


���ҵ����д���_ListView��:
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
			;; �������˱���ʱ��˫��variable���͵���ֱ������֮
			if cmdParamArray0 > 0
			{
				GoSub ���Ҽ����С�
			}
			;; ��û���������������£�˫��variable���͵��У�Ҫ���������ֵ��Ȼ������
            else
			{
				StringReplace var_temp, g_lvKeyValue, $var$, ����, all
				var_temp = ��Ϊ����������������ֵ. `n%var_temp%
				EnableBox( true )
				InputBox, var_temp , �������ֵ, %var_temp%, , , 150
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
			GoSub ���Ҽ����С�
		}
	}
	return


GuiEscape:
	GuiControlGet, bVisible, Visible, _KeyListView
	if ( bVisible )
		GuiControl, Hide, _KeyListView
	Else
		Gosub ���˳�����
	return


���˳�����:
	tooltip
	SetTimer ����ʱ�����û����벢��ʾ��, off
	settimer ����ʱ�Զ����KeyName��, off
	ExitApp
	Return

GuiClose:
	ExitApp

����ʱ�����û����벢��ʾ��:
	Gui, submit, nohide
	SetTimer ����ʱ�����û����벢��ʾ��, off
	if ( IsExeCmdType(g_cmdType) )
	{
		var_bVariable := false       ;; ָ���Ƿ�ֻ����Variable��var�����ֽ�

		;; �ж�����������Ƿ�var���͵�����( g_cmdTypeΪ���� g_cmdName֮���пո� )
		if ( g_cmdType == "" && g_cmdName <> "" && _edtSearch <> g_cmdName )
		{
			StringMid var_char, _edtSearch, StrLen( g_cmdName ) + 1, 1
			; tooltip var_char [%var_char%] ; `n_edtSearch [%_edtSearch%] <> [%g_cmdName%] g_cmdName
			if ( var_char == A_Space )
			{
				;; �����������������������˿ո�����Ϊ��Var���͵�����
				;; ��ôֻ��������ʾVariable��var�����ֽ��µ�����
				var_bVariable := true
			}
		}
		;; ���ú�����������ʾ�������
		�Ʋ����û����벢��ʾ( g_cmdName, var_bVariable )
	}
	Return


���Ҽ����С�:
	Sleep 50
	curRow := LV_GetNext(0, "Focused")
	if curRow > 0
	{
		CommandSplit( _edtSearch, _cmdType, _cmdName, "cmdParamArray" )
		if ( LV_run( _cmdType, curRow, "cmdParamArray" ) )
		{
			gosub ���˳�����
		}
	}
	return

���Ҽ��鿴��:

	return


���Ҽ��޸ġ�:
	;; ���˵���file,send,variable�Ĺؼ���
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

	;; ����ʧȥ����ʱ���������Զ��˳����򣬷����޷�����������������
	EnableBox( true )

	;; �����һ���޸Ĺؼ��ֵ�����
	if var_CurCol = 1
	{
		bMod := false
		loop
		{
			var_input := myinput("����KeyName", "�������µĹؼ�������", g_lvKeyName )
			if var_input =
				break
			var_read := read_ini( g_inifile, g_lvSec, var_input, "" )
			if var_read <>
			{
				var_tip = ����Ĺؼ���<%var_input%>�Ѿ����ڣ���ֵΪ��`n`n   %var_tead%`n`n�Ƿ�Ҫ�滻��Yes�滻 	No��������	Cancelȡ��
				msgbox 3, �ؼ����Ѿ�����, %var_tip%
                ifMsgBox Yes            ;; ǿ���滻
				{
					bMod := true
					break
				}
                else ifMsgBox cancel    ;; ȡ��
				{
					bMod := false
					break
				}
                ;; else ifMsgbox No     ;; ���滻����һ���ؼ���
                ;; 		continue
			}
			else
			{
				bMod := true
				break
			}
		}
		;; ���浽�����ļ�
		if bMod
		{
			write_ini( g_inifile, g_lvSec, var_input, var_value)
			del_ini( g_inifile, g_lvSec, g_lvKeyName )

			;; �������飬ˢ��Listview
			ArrayName = %g_lvSec%_keyArray
			var_pos := SearchArray( ArrayName, g_lvKeyName, true )
			if var_pos > 0
			{
				%ArrayName%%var_pos% := var_input
				g_PreSearch = ��ǿ��ˢ�£�
				GoSub ����ʱ�����û����벢��ʾ��	;; ˢ��ListView
			}
		}
	}
	;; �������޸Ĺؼ��ֵ�ֵ
	else
	{
		var_tip = ��Ϊ %g_lvKeyName% �����µ�ֵ��
		InputBox, OutputVar, �޸� %g_lvKeyName% ��ֵ, %var_tip%, , ,120 , , , , , %var_value%
		if not ErrorLevel
		{
			write_ini( g_inifile, g_lvSec, g_lvKeyName, var_value)

			;; �������飬ˢ��Listview
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
				g_PreSearch = ��ǿ��ˢ�£�
				GoSub ����ʱ�����û����벢��ʾ��	;; ˢ��ListView
			}
		}
	}
    ;; ����ʧȥ����ʱ�������Զ��˳�
	EnableBox( false )

	return

���Ҽ�ɾ����:
	if g_lvSec =
	{
		return
	}
    if g_lvSec in %g_SearchSections%    ;; file,send,variable
	{
		if g_lvKeyName <>
		{
			;; ��g_inifile �����ļ���ɾ��
			del_ini( g_inifile, g_lvSec, g_lvKeyName )

			;; ���ڴ�������ɾ���������
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

			g_PreSearch = ��ǿ��ˢ�£�
			GoSub ����ʱ�����û����벢��ʾ��	;; ˢ��ListView
		}
	}
    else ifInString g_lvSec, $          		;; �Զ�������
	{
		StringReplace var_sec, g_lvSec, $, , All
		if var_sec not in %g_NotSaveCmdType%  	;; ��ahk,help,add���Զ�������
		{
			ArrayName = %g_lvSec%_valueArray
			if ( RemoveArray( ArrayName, g_lvKeyValue, true ) )
			{
				WriteRecentArray( ArrayName, var_sec ) ;; �����º�������б��浽�����ļ�
				�Ʋ��Ҳ���ʾ�������( var_sec, g_cmdName )
			}
		}
	}
	return

���Ҽ���ӡ�:
	var_run := �ƻ�ȡ��Ŀ¼()
	var_run = %var_run%\bin\run\addrun.ahk
	run_ahk( var_run, cmdName, a_workingdir )
	return


��ȷ��ִ�С�:
	g_runsuccess := RunInput( _edtSearch )
	var_tip =  `"%_edtSearch%`" ִ��
	if g_runsuccess
	{
		gosub ���˳�����
	}
	else
	{
		var_tip = %var_tip% ʧ�ܣ�
		tooltip %var_tip%, 35, 65, 7
		SetTimer, RemoveToolTip7, 2000
	}
	return


����ʱ�Զ����KeyName��:
	Gui, submit, nohide
	LV_GetText( var_newtext, 1, 1 )
	IfInstring var_newtext, %_edtSearch%
	{
		��Ϊ�༭�����ò�ѡ�����ı�( g_wintitle, "Edit1", _edtSearch, var_newtext )
	}
	settimer ����ʱ�Զ����KeyName��, off
	return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ����
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




