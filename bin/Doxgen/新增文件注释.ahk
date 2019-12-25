#NoTrayIcon
#include ../../


change_icon()                           ;; 设置图标


iniread _author, temp.ini, doxgen, author
if	_author = ERROR
	_author =

_date	= %a_yyyy%.%a_mm%.%a_dd%

Gui, Add, Text, , 文件名：
Gui, Add, Text, , 作者：
Gui, Add, Text, , 日期：
Gui, Add, Text, , 简要说明：
Gui, Add, Text, , 详细说明：
Gui, Add, Edit,w400 v_file ym  ; The ym option starts a new column of controls.
Gui, Add, Edit,w400 v_author, %_author%
Gui, Add, Edit,w400 v_date,	%_date%
Gui, Add, Edit,w400 v_brief
Gui, Add, Edit,w400 h100 v_detail
Gui, Add, Button,x90 y230 w100 h30 default, 插入
Gui, Add, Button,x310 y230 w100 h30, 取消
Gui, Show, h280, 添加Doxgen文件注释
return  ; End of auto-execute section. The script is idle until the user does something.

Button插入:
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

Button取消:
GuiClose:
ExitApp


#include ./inc/common.aik
