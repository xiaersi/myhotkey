#include ../../
#include .\inc\string.aik
#include .\inc\inifile.aik

g_inifile = mail.ini
g_senderlist := read_ini( g_inifile, "�ռ���", "@�ռ����б�@", "" )

Gui, 6:Font, S10 CDefault, Verdana
Gui, 6:Add, Button, x126 y400 w130 h30 g��׼�����ʹ��ڣ�׼���ʼ����͡�, ����
Gui, 6:Add, Button, x266 y400 w120 h30 g��׼�����ʹ��ڣ�ȡ���ʼ����͡�, ȡ��
Gui, 6:Add, Button, x396 y400 w110 h30 , ���
Gui, 6:Add, Button, x516 y400 w110 h30 , ��ո���
Gui, 6:Add, Button, x531 y21 w90 h30 g��׼�����ʹ��ڣ����Ϊ����ռ��ˡ�, ��Ϊ�����
Gui, 6:Add, Edit, x6 y25 w110 h25 v_sender, ;�ռ���
Gui, 6:Add, Edit, x126 y25 w400 h25 v_sendbox, ;�ռ���
Gui, 6:Add, Edit, x126 y60 w500 h330 v_Body, �ʼ�����
Gui, 6:Add, Edit, x126 y440 w500 h130 v_attach readonly, ;ATTACH input files here
Gui, 6:Add, Text, x6 y5 w100 h18 , �ռ���
Gui, 6:Add, Text, x26 y490 w90 h20 +Right, ����:
Gui, 6:Add, ListBox, x6 y60 w110 h420 , ListBox
Gui, 6:Add, Text, x126 y5 w100 h18 , �ռ���
; Generated using SmartGUI Creator 4.0
Gui, 6:Show, x343 y118 h576 w641, ׼�������ʼ�
Return

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
		else if ( 0 == �Ʋ����ַ�������( var_specialList, _sender, "," ) )
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
	if ( _sender != "" && _sendbox !="" )
	{
		if �������ַ�������( g_senderlist, _sender, ",", false )
		{
			write_ini( g_inifile, "�ռ���", "@�ռ����б�@", g_senderlist )
		}

		var_sendboxs := read_ini( g_inifile, "�ռ���", _sender, "" )
		write_ini( g_inifile, "�ռ���", _sender, var_sendboxs )
	}

6GuiClose:
��׼�����ʹ��ڣ�ȡ���ʼ����͡�:
ExitApp
