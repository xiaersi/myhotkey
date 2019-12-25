#include ../../

;-------׼������--------------------------------
g_inifile = mail.ini
g_senderlist := read_ini( g_inifile, "�ռ���", "@�ռ����б�@", "" )

g_txtfile = %A_WorkingDir%\temp�ļ������б�.txt     ;txt files
g_binfile = %A_WorkingDir%\temp�����Ƹ����б�.txt      ;binary files
g_inlfile = %A_WorkingDir%\temp�ʼ�����.txt   ;body
g_attachfile = %A_WorkingDir%\temp�ʼ������б�.txt

ifexist,%g_txtfile%
  filedelete,%g_txtfile%
ifexist,%g_binfile%
  filedelete,%g_binfile%

ifnotexist,%g_txtfile%
  Fileappend,,%g_txtfile%
ifnotexist,%g_binfile%
  Fileappend,,%g_binfile%

;-------������ʾGUI---------------------------------
Gui, 6:Font, S10 CDefault, Verdana
Gui, 6:Add, Button, x130 y397 w140 h36 g��׼�����ʹ��ڣ�׼���ʼ����͡�, ����
Gui, 6:Add, Button, x280 y397 w140 h36 g��׼�����ʹ��ڣ�ȡ���ʼ����͡�, ȡ��
Gui, 6:Add, Button, x430 y397 w140 h36 g��׼�����ʹ��ڣ�������ġ�, ���
Gui, 6:Add, Button, x580 y397 w140 h36 g��׼�����ʹ��ڣ���ո�����, ��ո���
Gui, 6:Add, Button, x631 y21 w90 h30 g��׼�����ʹ��ڣ����Ϊ����ռ��ˡ�, ��Ϊ�����
Gui, 6:Add, Edit, x6 y25 w110 h25 v_sender, ;�ռ���
Gui, 6:Add, Edit, x126 y25 w500 h25 v_sendbox, ;�ռ���
Gui, 6:Add, Edit, x126 y60 w600 h25 v_subject, ������
Gui, 6:Add, Edit, x126 y95 w600 h295 v_Body, �ʼ�����
Gui, 6:Add, Edit, x126 y440 w600 h130 v_attach readonly, ;ATTACH input files here
Gui, 6:Add, Text, x6 y5 w100 h18 , �ռ���
Gui, 6:Add, Text, x26 y490 w90 h20 +Right, ����:
Gui, 6:Add, ListBox, x6 y60 w110 h420 , ListBox
Gui, 6:Add, Text, x126 y5 w100 h18 , �ռ���

fileread, var_body, %g_inlfile%
GuiControl,6:, _Body, %var_body%

fileread, var_attach, %g_attachfile%
GuiControl, 6:, _attach, %var_attach%

; Generated using SmartGUI Creator 4.0
Gui, 6:Show, x343 y118 h576 w741, ׼�������ʼ�
Return


;--------��Ӧ�ļ���ק, ���Ϊ����--------------------------
6GuiDropFiles:
	Gui,6:submit,nohide

	Loop, parse, A_GuiEvent, `n
    {
		ifnotinstring SelectedFileName, %A_LoopField%
		{
			SelectedFileName = %SelectedFileName%%A_LoopField%`r`n     ;write files-names
	;		SplitPath,A_loopfield, name, dir, ext, name_no_ext, drive
		}
    }
	GuiControl,6:,_attach,%SelectedFileName%
	return

;--------��ť��Ӧ---------------------------------------
��׼�����ʹ��ڣ�������ġ�:
	guicontrol , 6:, _Body, %nothing%
	return

��׼�����ʹ��ڣ���ո�����:
	SelectedFileName =
	guicontrol , 6:, _attach, %nothing%
	return


��׼�����ʹ��ڣ����Ϊ����ռ��ˡ�:
	Gui, 6:submit, nohide
	if ( _sender != "" && _sendbox !="" )
	{
		var_specialList := read_ini( g_inifile, "����ռ���", "@�ռ����б�@", "" )

		if var_specialList =
		{
			var_specialList = %_sender%`,
			write_ini( g_inifile, "����ռ���", "@�ռ����б�@", var_specialList )
		}
		else if ( 0 == ��Find�ַ�������( var_specialList, _sender, "," ) )
		{
			if ( StrLastWord( var_specialList, 1) != "," )
			{
				var_specialList = %var_specialList%`,
			}
			var_specialList = %var_specialList%%_sender%`,
			write_ini( g_inifile, "����ռ���", "@�ռ����б�@", var_specialList )
		}

		var_sendboxs := read_ini( g_inifile, "����ռ���", _sender, "" )
		if ( var_sendboxs != _sendbox )
		{
			write_ini( g_inifile, "����ռ���", _sender, _sendbox, true )
		}
	}
	return

��׼�����ʹ��ڣ�׼���ʼ����͡�:
	Gui, 6:submit, nohide

	;; �������б��ı��Ͷ������ļ����з��࣬�ֱ𱣴���g_txtfile��g_binfile�ļ���
	var_TextExts =
	iniread var_TextExts, var.ini, mail, TextExts
	if ( var_TextExts == "" || var_TextExts == "ERROR" )
	{
		var_TextExts = txt
		write_ini ( "var.ini", "mail", "TextExts", "txt" )
	}

	Loop parse, _Attach, `r`n
	{
		�Ʒֽ�·��( a_LoopField, var_dir, var_name, var_ext )
		if var_ext in %var_TextExts%
		{
			Fileappend,%A_LoopField%`,,%g_txtfile%
		}
		else
		{
			Fileappend,%A_LoopField%`,,%g_binfile%
		}
	}

	;; ׼�������ʼ��ĸ����б�
	var_af =
	var_atf =

	ifexist %g_binfile%
		var_af := g_binfile

	ifexist %g_txtfile%
		var_atf := g_txtfile

	;; ���÷����ʼ��ĺ���
	Loop parse, v_sendbox, `;
	{
		SendEmail( _subject, "", A_LoopField, "", "", g_inlfile, "", var_af, var_atf, "" )
	}

	
	;; ��������ռ�����Ϣ���Ա��պ�ʹ��
	if ( _sender != "" && _sendbox !="" )
	{
		if ��Add�ַ�������( g_senderlist, _sender, ",", false )
		{
			write_ini( g_inifile, "�ռ���", "@�ռ����б�@", g_senderlist )
		}

		var_sendboxs := read_ini( g_inifile, "�ռ���", _sender, "" )
		write_ini( g_inifile, "�ռ���", _sender, var_sendboxs )
	}

6GuiClose:
��׼�����ʹ��ڣ�ȡ���ʼ����͡�:
ExitApp


#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\path.aik
#include .\inc\mail.aik

