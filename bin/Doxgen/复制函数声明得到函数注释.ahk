#NoTrayIcon
#include ../../
#include .\inc\string.aik


;; ����ͼ��
change_icon()


bShowMsgbox := true
g_paramArr =
g_outArr =
g_commentArr =
g_paramCount = 0
g_funName =
g_funExplain =
g_return =
g_returnExplain =
g_lineHeadSpace =                                   ;; ���溯�����������������Ա����ɵ�ע��Ҳ����

;; g_oldclip����ɵļ��������ݣ��Ա�������Ƽ����������
g_oldclip := clipboard

WinGet, g_active_id, ID, A

;; ����ѡ������ݵ�������
send ^c
clipwait 1, 1
sleep 100

ifnotinstring clipboard, (
{
	MyShow( "���Ƶ����ݲ��Ǻ������޷������õ�����ע��", bShowMsgbox )
	clipboard := g_oldclip
	exitapp
}

;; ȥ�����з�
var_oldclip := clipboard
stringreplace var_clip, var_oldclip, `n, , All
stringreplace var_clip, var_clip, `r, , All

;; ʹ��������ʽ��ȡ���������������� g_lineHeadSpace
RegExMatch( var_clip, "^\s+", g_lineHeadSpace )

;; �ֽ��������var_fun�Ͳ����б�var_paramlist
StringGetPos, varPos, var_clip, (
if  errorlevel
{
	MyShow( "�ֽ⺯����ʱ��û���ҵ� ( ���ţ�����ע�ͻ�ȡʧ�ܣ�", bShowMsgbox )
	exitapp
}
stringleft var_fun, var_clip, %varPos%

ifinstring var_fun, *
{
	var_fun := StrRight2Sub( var_fun, "*" )
}

ifinstring var_fun, `:`:
{
	g_funName := StrRight2Sub( var_fun, "`:`:" )
}
else
{
	g_funName := GetLastWord2( var_fun )
}

if g_funName =
{
	MyShow( "�ֽ�õ��ĺ�����Ϊ�գ�����ע������ʧ�ܣ�", bShowMsgbox )
	exitapp
}



varLen := strlen(var_fun)
varLen := strlen(var_clip) - varLen - 1
stringright var_paramlist, var_clip, %varLen%

StringGetPos, varPos, var_paramlist, )
if  errorlevel
{
	MyShow( "�ֽ⺯�������б�ʱ��û���ҵ� ) ���ţ�����ע�ͻ�ȡʧ�ܣ�", bShowMsgbox )
	exitapp
}

stringleft var_paramlist, var_paramlist, %varPos%

Loop parse, var_paramlist, `,
{
	g_paramCount ++
	var_temp := a_loopfield
	ifinstring var_temp, =
	{
		var_temp := StrLeft2sub( var_temp, "=" )
	}
	ifinstring var_temp, &
	{
		g_outArr%g_paramCount% := true
		var_temp := StrRight2Sub( var_temp, "&" )
		StrTrim( var_temp )
	}
	else
	{
		var_temp := GetLastWord2( var_temp )
	}
	g_paramArr%g_paramCount% = %var_temp%

}


�����������޸ĺ���ע����Ϣ��:
;; �����Ի���
gui, add, Text
gui, add, Text, ,����
Loop %g_paramCount%
{
	gui, add, Text, , ����%a_index%
}

gui, add, Text, y+68,����ֵ
;------------------------------------------------------------------
gui, add, Text, ym, Out
gui, add, Text,
Loop %g_paramCount%
{
	Gui, Add, Checkbox, y+14 vg_outArr%a_index%
}
;------------------------------------------------------------------
gui, add, Text, ym, ����
gui, add, Edit, w150 R1 vg_funName,  %g_funName%
Loop %g_paramCount%
{
	var_temp := g_paramArr%a_index%
	gui, add, Edit,w150 R1 vg_paramArr%a_index%, %var_temp%
}
gui, add, button, y+20 h28 g�����Ӳ�����, [ + ] ���Ӳ���


gui, add, Edit, y+20 w150 vg_return
gui, add, Button,  y+25 w100 h28 default, ����ע��
gui, add, Button,   w100 h28, ȡ���˳�
;------------------------------------------------------------------
gui, add, Text, ym , ˵��
gui, add, Edit, w320 vg_funExplain, %g_funExplain%
Loop %g_paramCount%
{
	var_temp := g_commentArr%a_index%
	gui, add, Edit,w320 vg_commentArr%a_index%, %var_temp%
}
gui, add, button,y+21 h28 g�����ٲ�����, [ - ] ���ٲ���
gui, add, Edit, y+20 w320 h100 vg_returnExplain, %g_returnExplain%
gui, add, Text
;------------------------------------------------------------------
gui, show, center , ���ɺ���ע��

GuiControl, Focus, g_funExplain   ;; �����㶨λ������˵���ı༭���ϡ�

clipboard := g_oldclip                  ;; ����ʾ����֮�󣬻ָ������������
return


�����Ӳ�����:
	Gui, Submit, nohide
	g_paramCount++
	Gui, Destroy
	goto �����������޸ĺ���ע����Ϣ��
	return

�����ٲ�����:
	Gui, Submit, nohide
	if g_paramCount > 0
	{
		g_paramCount--
		Gui, Destroy
		goto �����������޸ĺ���ע����Ϣ��
	}
	return


button����ע��:
	Gui, Submit, hide
	var_brief = `/** `r`n * @brief	%g_funExplain%
	var_params =
	bBrief := true		; �����ɵ���ע��/** @brief	%g_funExplain% */, ������˵����Ϊ��ʱ
	loop %g_paramCount%
	{
		var_temp := g_commentArr%a_index%
		if ( bBrief == true && var_temp != "")
		{
			bBrief := false
		}
		var_paramname := g_paramArr%a_index%
		var_out := g_outArr%a_index%
		if var_out
			var_params = %var_params%`r`n * @param[out]	%var_paramname%  %var_temp%
		else
			var_params = %var_params%`r`n * @param[in]	%var_paramname%  %var_temp%
	}
	var_return =

	if g_return <>
	{
		var_return = `r`n * @return	%g_return%
		if bBrief
			bBrief := false
	}
	else if g_returnExplain <>
	{
		var_return = `r`n * @return	%g_return%
		if bBrief
			bBrief := false
	}

	if g_returnExplain <>
	{
		stringreplace var_temp, g_returnExplain, `r, , All
		loop parse, var_temp, `n
		{
			var_return = %var_return%`r`n *      %a_loopfield%
		}
		if bBrief
			bBrief := false
	}
	var_output = %var_brief%%var_params%%var_return%`r`n */
	if bBrief ; ������˵����Ϊ��ʱ, �����ɵ���ע��
		clipboard = `/** @brief	%g_funExplain% *`/
	else
		clipboard = %var_output%

	AutoTrim, off
	;; ������Ƶĺ��������������ע�͵�ÿһ��Ҳ����
	if g_lineHeadSpace <>
	{
		StringReplace clipboard, clipboard, `r`n, `r`n%g_lineHeadSpace%, All
		Clipboard := g_lineHeadSpace . Clipboard
	}
	;; �����Ƶ�ԭ�������������ӵ�ע����һ��
	clipboard = %clipboard%`r`n%var_oldclip%
	AutoTrim, on

;	��ɾ���ַ���ĩβ�Ļس�����(clipboard)
	tooltip �ѽ����ɵĺ���ע�͸��Ƶ�������
	WinGet, var_ThisID, ID, ahk_pid %g_active_id%
	winactivate ahk_id %var_ThisID%
	sleep 300
	send ^v

buttonȡ���˳�:
GuiClose:
ExitApp



;;----��غ���-------------------------------------------------
GetLastWord2( InputString )
{
	var_ret =
	varLen := strlen(InputString)
	Loop %varLen%
	{
		var_index := varLen - a_index + 1
		StringMid var_char, InputString, %var_index%, 1
		if var_ret =
		{
			if var_char is not space
				var_ret := var_char
		}
		else
		{
			if var_char is space
				break
			else if var_char in `,
				break
			else
				var_ret = %var_char%%var_ret%
		}

	}
	return var_ret
}

MyShow( var_tip,  bMsgBox = 1 )
{
	if bMsgBox = 1
	{
		msgbox %var_tip%
	}
	else
	{
		tooltip %var_tip%
		sleep 1000
		tooltip
	}
}


