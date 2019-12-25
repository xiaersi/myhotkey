
blatx=%A_scriptdir%\blat.exe
ifnotexist,%blatx%
  goto, blatx1


Gui, Add, Edit, x126 y50 w290 h20 vServer, smtp.foxmail.com
Gui, Add, Edit, x126 y90 w290 h20 vMailAddr, youname@foxmail.com
Gui, Add, Edit, x126 y130 w90 h20 vRepeat, 2
Gui, Add, Edit, x326 y130 w90 h20 vPort, 25
Gui, Add, Text, x26 y50 w90 h20 +Right , 服务器：
Gui, Add, Text, x26 y90 w90 h20 +Right , 邮箱地址：
Gui, Add, Text, x26 y130 w90 h20 +Right , 重复次数：
Gui, Add, Text, x266 y130 w50 h20 +Right , 端口：
Gui, Add, Button, x86 y180 w100 h30 + default gOkButton, 确定
Gui, Add, Button, x276 y180 w100 h30 gCancelButton, 取消
Gui, Add, Text, x26 y10 w390 h20 +Center, 设置Blat邮箱信息
Gui, Show, x275 y177 h251 w477, 注册邮箱信息 
Return

GuiClose:
ExitApp

OkButton:
	gui, submit, nohide
	runwait,%comspec% /c blat -install %Server% %MailAddr% %Repeat% %Port%, ,Hide
	return


CancelButton:
	ExitAPP
	return




;================= DOWNLOAD http://sourceforge.net/project/showfiles.php?group_id=81910 ===================
Blatx1:
{
   text31=
   (
   Download blat.exe
   from
   http://sourceforge.net/project/showfiles.php?group_id=81910
   )
msgbox, 262180, Start URL,%text31%
ifmsgbox,NO
   exitapp
else
   {
   run,http://sourceforge.net/project/showfiles.php?group_id=81910
   exitapp
   }
}
return
