#NoTrayIcon
#include ../../


change_icon()                           ;; ����ͼ��


iniread _author, temp.ini, doxgen, author
if	_author = ERROR
	_author =

_date	= %a_yyyy%.%a_mm%.%a_dd%

Gui, Add, Text, , �ļ�����
Gui, Add, Text, , ���ߣ�
Gui, Add, Text, , ���ڣ�
Gui, Add, Text, , ��Ҫ˵����
Gui, Add, Text, , ��ϸ˵����
Gui, Add, Edit,w400 v_file ym  ; The ym option starts a new column of controls.
Gui, Add, Edit,w400 v_author, %_author%
Gui, Add, Edit,w400 v_date,	%_date%
Gui, Add, Edit,w400 v_brief
Gui, Add, Edit,w400 h100 v_detail
Gui, Add, Button,x90 y230 w100 h30 default, ����
Gui, Add, Button,x310 y230 w100 h30, ȡ��
Gui, Show, h280, ���Doxgen�ļ�ע��
return  ; End of auto-execute section. The script is idle until the user does something.

Button����:
	Gui, Submit
	if _author <>
		iniwrite %_author%, temp.ini, doxgen, author
	clipboard =
(
`/**`r
 *@file    %_file%`r
 *@author  %_author%`r
 *@date    %_date%`r
 *@brief   %_brief%
)
	if _detail <>
	{
		clipboard = %clipboard%`r`n
		loop parse, _detail, `n
		{
			if a_index = 1
				clipboard = %clipboard% *`r`n * %a_loopfield%
			else
				clipboard = %clipboard%`r`n *- %a_loopfield%
		}
	}

	clipboard = %clipboard%`r`n *`/
	sleep 200
	send ^v

Buttonȡ��:
GuiClose:
ExitApp


#include ./inc/common.aik
