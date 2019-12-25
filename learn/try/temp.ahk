#include ../../
#include .\inc\string.aik
#include .\inc\inifile.aik

g_inifile = mail.ini
g_senderlist := read_ini( g_inifile, "收件人", "@收件人列表@", "" )

Gui, 6:Font, S10 CDefault, Verdana
Gui, 6:Add, Button, x126 y400 w130 h30 g【准备发送窗口：准备邮件发送】, 发送
Gui, 6:Add, Button, x266 y400 w120 h30 g【准备发送窗口：取消邮件发送】, 取消
Gui, 6:Add, Button, x396 y400 w110 h30 , 清空
Gui, 6:Add, Button, x516 y400 w110 h30 , 清空附件
Gui, 6:Add, Button, x531 y21 w90 h30 g【准备发送窗口：添加为快捷收件人】, 加为快捷人
Gui, 6:Add, Edit, x6 y25 w110 h25 v_sender, ;收件人
Gui, 6:Add, Edit, x126 y25 w400 h25 v_sendbox, ;收件箱
Gui, 6:Add, Edit, x126 y60 w500 h330 v_Body, 邮件正文
Gui, 6:Add, Edit, x126 y440 w500 h130 v_attach readonly, ;ATTACH input files here
Gui, 6:Add, Text, x6 y5 w100 h18 , 收件人
Gui, 6:Add, Text, x26 y490 w90 h20 +Right, 附件:
Gui, 6:Add, ListBox, x6 y60 w110 h420 , ListBox
Gui, 6:Add, Text, x126 y5 w100 h18 , 收件箱
; Generated using SmartGUI Creator 4.0
Gui, 6:Show, x343 y118 h576 w641, 准备发送邮件
Return

【准备发送窗口：添加为快捷收件人】:
	Gui, 6:submit, nohide
	if ( _sender != "" && _sendbox !="" )
	{
		var_specialList := read_ini( g_inifile, "快捷收件人", "@收件人列表@", "" )

		if var_specialList =
		{
			var_specialList = %_sender%`,
			write_ini( g_inifile, "快捷收件人", "@收件人列表@", var_specialList )
		}
		else if ( 0 == ∑查找字符串队列( var_specialList, _sender, "," ) )
		{
			if ( StrLastWord( var_specialList, 1) != "," )
			{
				var_specialList = %var_specialList%`,
			}
			var_specialList = %var_specialList%%_sender%`,
			write_ini( g_inifile, "快捷收件人", "@收件人列表@", var_specialList )
		}

		var_sendboxs := read_ini( g_inifile, "快捷收件人", _sender, "" )
		if ( var_sendboxs != _sendbox )
		{
			write_ini( g_inifile, "快捷收件人", _sender, _sendbox, true )
		}
	}
	return

【准备发送窗口：准备邮件发送】:
	Gui, 6:submit, nohide
	if ( _sender != "" && _sendbox !="" )
	{
		if ∑增加字符串队列( g_senderlist, _sender, ",", false )
		{
			write_ini( g_inifile, "收件人", "@收件人列表@", g_senderlist )
		}

		var_sendboxs := read_ini( g_inifile, "收件人", _sender, "" )
		write_ini( g_inifile, "收件人", _sender, var_sendboxs )
	}

6GuiClose:
【准备发送窗口：取消邮件发送】:
ExitApp
