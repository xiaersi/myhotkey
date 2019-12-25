;; �༭�������

#NoTrayIcon
#include ..\..\
change_icon()

;; �������������
g_param = %1%

;; ��ʼ��ȫ�ֱ���
g_title = �༭�������
g_WINTITLE = %g_title% ahk_class AutoHotkeyGUI ;; ע�����Դ�Сд����

g_AWinID =                              ;; ��ǰ���ڵ�Ψһ��ʶ
WinGet, g_AWinID, id, A

g_default =

g_checked = checked

g_DefOptions = send|menu|gosub|func|run|clip|submenu|sendByClip|tip:|runby:|launchy:|IfWinActive:|IfWinExist:|IfExist:|name:|sleep:|MAX|MIN|HIDE|WinActivate:

g_Options =

g_bAutoFilt := true   ;; ��ѡ��༭�����������ǣ��Ƿ�Ҫ�Զ������·���Ĭ��ѡ���б�ListBox


;; ��������˲�������������ݲ����޸�ȫ�ֱ���
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

;; ��ȡԤ�������Ĭ�����
OptionList := g_Options
if g_Options <>
	OptionList = |%OptionList%

if g_checked =
	g_preview = 0%OptionList%)%g_default%
else
	g_preview = 1%OptionList%)%g_default%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��ʾ����
Gui, Add, Text, x6 y18 w50 h20 +Right, ����ֵ:
Gui, Add, Edit, x66 y13 w410 h25 v_edtInput g������ֵ�༭��, %g_default%
Gui, Add, Text, x12 y50 w130 h20 , ѡ������:
Gui, Add, Edit, x12 y70 w130 h22 v_edtOptions g��ѡ��༭��,
Gui, Add, ListBox, x12 y100 w130 h170 v_lbDefOptions g��DefOptionsListBox��, %g_DefOptions%
Gui, Add, Text, x206 y50 , ����ѡ��:
Gui, Add, CheckBox, x400 y45 w130 h20 %g_checked% v_bValid g�������Ƿ���Ч��ѡ��, �Ƿ���Ч
Gui, Add, ListBox, x206 y70 w360 h210 v_lbOptions    g��OptionsListBox��,  %g_Options%
Gui, Add, Text, x12 y270 , Ԥ�����ɵķ������:
Gui, Add, Edit, x12 y290 w554 h58 v_edtCmd, %g_preview%

Gui, Add, Button, x486 y10 w80 h30 g��ȷ����, ȷ  ��
Gui, Add, Button, x151 y68 w45 h25 g���������ѡ�, >>
Gui, Add, Button, x151 y100 w45 h25 g��ɾ������ѡ�, <<
Gui, Add, Button, x151 y200 w45 h25 g�����ɷ��������, ����
Gui, Add, Button, x151 y235 w45 h25 g��ִ�з��������, ִ��
; Generated using SmartGUI Creator 4.0
Gui, Add, StatusBar,, �༭�������

Gui, Show, h377 w578, %g_title%

Return



GuiClose:
ExitApp


;;---��Ӧ�Ҽ���Ϣ------------------------------------------------------------
GuiContextMenu:  ; Launched in response to a right-click or press of the Apps key.
	if A_GuiControl = _lbDefOptions
	{
		GuiControl,Text, _edtOptions,
	}
	RETURN


��DefOptionsListBox��:
	Gui, Submit, NoHide

	g_bAutoFilt := false	;; �ڵ��Ĭ��ѡ���б������У���ֹ�Զ���������Ĭ��ѡ���б��
	if A_GuiEvent = DoubleClick
	{
		GuiControl, Text, _edtOptions, %_lbDefOptions%
		gosub ���������ѡ�
	}
	else if A_GuiEvent = Normal
	{
		GuiControl, Text, _edtOptions, %_lbDefOptions%
	}

	;; ����״̬����ʾ��Ϣ
	var_tip = ��ѡ������ѡ������
	SB_SetText( var_tip )
	return



��OptionsListBox��:
	gosub �����ɷ��������
	return


�������Ƿ���Ч��ѡ��:
�����ɷ��������:
	Gui, submit, nohide
	ControlGet, OptionList, List, , ListBox2
	StringReplace OptionList, OptionList, `n, |, all
	if OptionList =
		OptionList = %_bValid%
	else
		OptionList = %_bValid%|%OptionList%
	GuiControl, Text, _edtCmd,  %OptionList%)%_edtInput%
	return


������ֵ�༭��:
	gosub �����ɷ��������
	return


���������ѡ�:
	Gui, submit, nohide
	if _edtOptions <>
	{
		ControlGet, OptionList, List, , ListBox2
		StringReplace OptionList, OptionList, `n, |, all
		var_option := _edtOptions
		ifInstring var_option, :
		{
			;; ����ѡ������ð�ţ���Ҫ�û���ð�ź���������������������Ի�������
			var_input := myinput( "����������ѡ�������", var_option, "" )
			if var_input =
				return

			var_option = %var_option%%var_input%
		}

		;; �������ظ���ѡ��
		if InStrList( OptionList, var_option, "|" ) > 0
		{
			msgbox ����ѡ�� `"%var_option%`" �Ѿ����ڣ�
			return
		}


		OptionList = %OptionList%|%var_option%
		GuiControl ,  , _lbOptions, |
		GuiControl ,  , _lbOptions, %OptionList%

		gosub �����ɷ��������
	}
	return


��ɾ������ѡ�:
	Gui, submit, nohide
	if 	_lbOptions <>
	{
		newOptionList =		;; ɾ��ѡ�е�����ѡ��֮�������ѡ���б�
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
			gosub �����ɷ��������
		}
	}
	return

��ѡ��༭��:  ;; ѡ��༭�����仯���Զ���������ѡ���б�
	if not g_bAutoFilt
	{
		g_bAutoFilt := true
		return   ;; ���g_bAutoFilt=false����ô��ֹ�Զ�����Ĭ��ѡ���б��
	}
	;; g_bAutoFilt=true ѡ��༭�����仯ʱ����������Ĭ��ѡ���б��_lbDefOptions
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

��ȷ����:
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
		tooltip �����Ѿ����Ƶ������壡
		sleep 1000
	}
	gosub GuiClose
	return

��ִ�з��������:
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
			tooltip3( "send ���͵�����ֵ����Ϊ�գ�" )
			return false
		}
	}
	else if InStrList( opt, "gosub", "|" ) > 0
	{
		if not IsLabel( cmdstr )
		{
			tooltip3( "gosub ���͵�����ֵָ���Ĺ���ģ����Ч��" )
			return false
		}
	}
	else if InStrList( opt, "menu", "|" ) > 0
	{
		iniMenumem := IniFileRead( "ShortcutMenu.ini" )
		if SecArrayFromIniMem( iniMenumem, cmdstr, "TempArray" ) = 0
		{
			tooltip3( "��δ���ÿ�ݲ˵���" . cmdstr )
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
			;; var_file ���ܵ�ֵΪ�� abc.exe|exe|c:\work
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
