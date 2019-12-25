MODIFIED  = 20090601
Filename1 = Blat Email-Send Drag&Drop Example attachment

/*
http://www.blat.net/
http://www.blat.net/?faq/index.html
http://sourceforge.net/project/showfiles.php?group_id=81910
*/


#NoEnv
#SingleInstance force
SetBatchLines,-1
setworkingdir, %a_scriptdir%
AutoTrim Off

SENDTO=chen.jianping@qq.com      ;  for test your email

blatx=D:\Program Files\MyHotkey\bin\blat\blat.exe 
ifnotexist,%blatx%
  goto, blatx1

FileLog=_blat.log
txtfil =_FileText.txt     ;txt files
binfil =_Filebin.txt      ;binary files
inlfil =_FileInline.txt   ;body


ifexist,%FileLog%
  filedelete,%Filelog%
ifexist,%txtfil%
  filedelete,%txtfil%
ifexist,%binfil%
  filedelete,%binfil%

ifnotexist,%txtfil%
  Fileappend,,%txtfil%
ifnotexist,%binfil%
  Fileappend,,%binfil%


Gui,3:default
;Gui,3:Color, 000000
Gui,3:Font,S10 CDefault,Verdana

Gui 3:Add, Button,      x10   y10   w90   h25  gSend1    , SEND
Gui 3:Add, Button,      x570  y10   w90   h25  gClearBody, CLEAR


Black1 = 0x000000
Lime1  = 0x00FF00
Gui,3:Color, ControlColor, %Black1%
Gui 3:Add, Edit,c%lime1%  x6    y40   w750  h250 vBody     ,
Gui,3: Color,Gray



Gui 3:Add, Text,        x100  y410         cWhite         , ATTACHMENTS put here
Gui 3:Add, Button,      x570  y305   w90   h25  gClearMSG2, CLEAR-ATT
Gui 3:Add, Edit,cWhite  x6    y340   w750  h210 vMsg2 readonly,              ;ATTACH input files her

Gui 3:Add, Edit,cWhite  x6    y560   w750  h150 vLog readonly,               ;Logfile message

Gui 3:Show,        x1   y1  w770  h740         ,%filename1%
GuiControl,3:Focus,Body
Return
;---------------
3GuiClose:
3GuiEscape:
ExitApp
;-----------------



SEND1:
gui,3:submit,nohide
ifexist,%inlfil%
 filedelete,%inlfil%
ifexist,%Filelog%
 Filedelete,%Filelog%
stringreplace,body,body,`n,`r`n,all
fileappend,%body%`r`n,%inlfil%
;SplashImage,SEND,m2,Wait....`nBlat-mailer is now sending to %SendTo%
GuiControl,3:,Log,Send email to >> %sendto%
Runwait,%comspec% /c Blat - -body "hallo garry" -subject "Greetings" -to %SENDTO% -attachi %inlfil% -atf %txtfil% -af %binfil% -log %FileLog% -timestamp -u cwin@foxmail.com -pw janruhai, D:\Program Files\MyHotkey\bin\blat, hide
;SplashImage, Off
fileread,AAA,%Filelog%
GuiControl,3:,Log,%AAA%
return


CLEARBODY:
GuiControl,3:,body,%nothing%
return



CLEARMSG2:
Gui,3:submit,nohide
Selectedfilename=
GuiControl,3:,MSG2,%nothing%
ifexist,%txtfil%
  filedelete,%txtfil%
ifexist,%binfil%
  filedelete,%binfil%
ifnotexist,%txtfil%
  Fileappend,,%txtfil%
ifnotexist,%binfil%
  Fileappend,,%binfil%
return


3GuiDropFiles:
Gui,3:submit,nohide

Loop, parse, A_GuiEvent, `n
    {
    SelectedFileName = %SelectedFileName%`r`n%A_LoopField%     ;write files-names
    SplitPath,A_loopfield, name, dir, ext, name_no_ext, drive
    if ext=txt
         Fileappend,%A_LoopField%`,,%txtfil%
      else
         Fileappend,%A_LoopField%`,,%binfil%
    }

GuiControl,3:,MSG2,%SelectedFileName%
return
;---------------------------------------------------------------------------



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
;============================================================================



/*
-attach <file>  : attach binary file(s) to message (filenames comma separated)
-attacht <file> : attach text file(s) to message (filenames comma separated)
-attachi <file> : attach text file(s) as INLINE (filenames comma separated)
-embed <file>   : embed file(s) in HTML.  Object tag in HTML must specify
                  content-id using cid: tag.  eg: <img src="cid:image.jpg">
-af <file>      : file containing list of binary file(s) to attach (comma
                  separated)
-atf <file>     : file containing list of text file(s) to attach (comma
                  separated)
-aef <file>     : file containing list of embed file(s) to attach (comma
                  separated)
*/

