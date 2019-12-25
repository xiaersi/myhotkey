#include ../../

;-------准备参数--------------------------------
g_inifile = mail.ini
g_senderlist := read_ini( g_inifile, "收件人", "@收件人列表@", "" )

g_txtfile = %A_WorkingDir%\temp文件附件列表.txt     ;txt files
g_binfile = %A_WorkingDir%\temp二进制附件列表.txt      ;binary files
g_inlfile = %A_WorkingDir%\temp邮件正文.txt   ;body
g_attachfile = %A_WorkingDir%\temp邮件附件列表.txt

ifexist,%g_txtfile%
  filedelete,%g_txtfile%
ifexist,%g_binfile%
  filedelete,%g_binfile%

ifnotexist,%g_txtfile%
  Fileappend,,%g_txtfile%
ifnotexist,%g_binfile%
  Fileappend,,%g_binfile%

;-------创建显示GUI---------------------------------
Gui, 6:Font, S10 CDefault, Verdana
Gui, 6:Add, Button, x130 y397 w140 h36 g【准备发送窗口：准备邮件发送】, 发送
Gui, 6:Add, Button, x280 y397 w140 h36 g【准备发送窗口：取消邮件发送】, 取消
Gui, 6:Add, Button, x430 y397 w140 h36 g【准备发送窗口：清空正文】, 清空
Gui, 6:Add, Button, x580 y397 w140 h36 g【准备发送窗口：清空附件】, 清空附件
Gui, 6:Add, Button, x631 y21 w90 h30 g【准备发送窗口：添加为快捷收件人】, 加为快捷人
Gui, 6:Add, Edit, x6 y25 w110 h25 v_sender, ;收件人
Gui, 6:Add, Edit, x126 y25 w500 h25 v_sendbox, ;收件箱
Gui, 6:Add, Edit, x126 y60 w600 h25 v_subject, 无主题
Gui, 6:Add, Edit, x126 y95 w600 h295 v_Body, 邮件正文
Gui, 6:Add, Edit, x126 y440 w600 h130 v_attach readonly, ;ATTACH input files here
Gui, 6:Add, Text, x6 y5 w100 h18 , 收件人
Gui, 6:Add, Text, x26 y490 w90 h20 +Right, 附件:
Gui, 6:Add, ListBox, x6 y60 w110 h420 , ListBox
Gui, 6:Add, Text, x126 y5 w100 h18 , 收件箱

fileread, var_body, %g_inlfile%
GuiControl,6:, _Body, %var_body%

fileread, var_attach, %g_attachfile%
GuiControl, 6:, _attach, %var_attach%

; Generated using SmartGUI Creator 4.0
Gui, 6:Show, x343 y118 h576 w741, 准备发送邮件
Return


;--------响应文件拖拽, 添加为附件--------------------------
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

;--------按钮响应---------------------------------------
【准备发送窗口：清空正文】:
	guicontrol , 6:, _Body, %nothing%
	return

【准备发送窗口：清空附件】:
	SelectedFileName =
	guicontrol , 6:, _attach, %nothing%
	return


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
		else if ( 0 == ∑Find字符串队列( var_specialList, _sender, "," ) )
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

	;; 将附件列表按文本和二进制文件进行分类，分别保存在g_txtfile和g_binfile文件中
	var_TextExts =
	iniread var_TextExts, var.ini, mail, TextExts
	if ( var_TextExts == "" || var_TextExts == "ERROR" )
	{
		var_TextExts = txt
		write_ini ( "var.ini", "mail", "TextExts", "txt" )
	}

	Loop parse, _Attach, `r`n
	{
		∑分解路径( a_LoopField, var_dir, var_name, var_ext )
		if var_ext in %var_TextExts%
		{
			Fileappend,%A_LoopField%`,,%g_txtfile%
		}
		else
		{
			Fileappend,%A_LoopField%`,,%g_binfile%
		}
	}

	;; 准备发送邮件的附件列表
	var_af =
	var_atf =

	ifexist %g_binfile%
		var_af := g_binfile

	ifexist %g_txtfile%
		var_atf := g_txtfile

	;; 调用发送邮件的函数
	Loop parse, v_sendbox, `;
	{
		SendEmail( _subject, "", A_LoopField, "", "", g_inlfile, "", var_af, var_atf, "" )
	}

	
	;; 保存最近收件人信息，以便日后使用
	if ( _sender != "" && _sendbox !="" )
	{
		if ∑Add字符串队列( g_senderlist, _sender, ",", false )
		{
			write_ini( g_inifile, "收件人", "@收件人列表@", g_senderlist )
		}

		var_sendboxs := read_ini( g_inifile, "收件人", _sender, "" )
		write_ini( g_inifile, "收件人", _sender, var_sendboxs )
	}

6GuiClose:
【准备发送窗口：取消邮件发送】:
ExitApp


#include .\inc\string.aik
#include .\inc\inifile.aik
#include .\inc\path.aik
#include .\inc\mail.aik

