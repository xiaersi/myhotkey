
;; ���������ڱ��⣬������
#singleinstance ignore
#notrayicon
#include ..\..\

g_title = ��ӻ������ƽ��ô���

;; �ж������ļ��Ƿ���ڣ�������������˳�
g_inifile = AutoHotString.ini
ifNotExist %g_inifile%
{
	MsgBox, 16, %g_title%,  �����ļ� %g_inifile% �����ڣ�
	exitapp
}

;; ����ͼ��
change_icon()



;; ��ȡ�����ļ�
g_AWinList_keyname = Active�����б�
g_EWinList_keyname = Exist�����б�
g_MouseGesture_Section = ��������
g_AWinList := read_ini( g_inifile, g_MouseGesture_Section, g_AWinList_keyname, "" )
g_EWinList := read_ini( g_inifile, g_MouseGesture_Section, g_EWinList_keyname, "" )


WinGetActiveTitle, g_ATitle
WinGetClass, g_AClass, A

g_newTitle = %g_ATitle% ahk_class %g_AClass%

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ��ʾ����

Gui, Add, GroupBox, x6 y17 w355 h80 , ������Ϣ

Gui, Add, Radio, x16 y35 w80 h20 checked v_RadioTitle	g��ѡ����˵�ǰ���ڱ��⡿, ���ڱ���
Gui, Add, Radio, x16 y65 w80 h20 v_RadioClass			g��ѡ����˵�ǰͬ�ര�ڡ�, ������
Gui, Add, Edit, x96 y35 w250 h18 v_edtTitle				g���޸ĵ�ǰ���ڱ��⡿, %g_ATitle%
Gui, Add, Edit, x96 y65 w250 h18 v_edtClass				g���޸ĵ�ǰ�����ࡿ, %g_AClass%

Gui, Add, Button, x370 y25 w90 h30 g��ȷ����, ȷ  ��
Gui, Add, Button, x370 y65 w90 h30 g��ȡ����, ȡ  ��

Gui, Add, Radio, x16 y120 w380 h20 v_RadioAWin checked	g��ѡ����ӵ�AWinList��, AddTo: ����ڹ����б� �� IfWinActive ��
Gui, Add, Radio, x16 y250 w390 h20 v_RadioEWin			g��ѡ����ӵ�EWinList��, AddTo: �ǻ���ڹ����б� IfWinExist ��

Gui, Add, ListBox, x6 y140 w460 h100 v_lbActive, %g_newTitle%|%g_AWinList%
Gui, Add, ListBox, x6 y270 w460 h100 v_lbExist,  %g_EWinList%

; Generated using SmartGUI Creator 4.0
Gui, Show, h377 w477, %g_title%


Return



��ȡ����:
GuiClose:
ExitApp


��ȷ����:
	gui submit, nohide
	newtitle := GetNewTitle()
	if _RadioAWin
	{
		if InStrList( g_AWinList, newtitle, "|" ) > 0
		{

			msgBox, 48, %g_title%,    ����ڽ����б����Ѿ�����ָ������: `n`"%newtitle%`"
			return
		}
		g_AWinList = %newtitle%|%g_AWinList%
		write_ini( g_inifile, g_MouseGesture_Section, g_AWinList_keyname, g_AWinList )
		msgBox, 4, %g_title%,   `"%newtitle%`"`n`n�ɹ����������ڽ����б�IfWinActive��`n`n�Ƿ����������ȼ�ʹ֮��Ч��
		ifmsgbox yes
			send ^!+{f5}
		ExitApp
	}
	else if _RadioEWin
	{
		if InStrList( g_EWinList, newtitle, "|"  ) > 0
		{
			msgBox, 48, %g_title%,    �ǻ���ڽ����б����Ѿ�����ָ������: `n`"%newtitle%`"
			return
		}
		g_EWinList = %newtitle%|%g_EWinList%
		write_ini( g_inifile, g_MouseGesture_Section, g_EWinList_keyname, g_EWinList )
		msgBox, 64, %g_title%,   `"%newtitle%`"`n`n�ɹ�������ǻ���ڽ����б�IfWinExist����`n`n�Ƿ����������ȼ�ʹ֮��Ч��
		ifmsgbox yes
			send ^!+{f5}
		ExitApp
	}
	return


#include .\inc\common.aik
#include .\inc\inifile.aik

;; ���ݽ������ɣ���Ҫ��ӵ�������ƽ����б�ģ����ڱ���
GetNewTitle()
{
	local newtitle
	if _edtClass <>
		newtitle = ahk_class %_edtClass%

	if _RadioTitle
		newtitle = %_edtTitle% %newtitle%

	return newtitle
}


;; ˢ�½����б�
RefreshList( bBoth = false )
{
	local newtitle := GetNewTitle()
	if _RadioAWin
	{
		guicontrol , , _lbActive, |
		guicontrol , , _lbActive, %newtitle%|%g_AWinList%
	}
	else if bBoth
	{
		guicontrol , , _lbActive, |
		guicontrol , , _lbActive, %g_AWinList%
	}

	if _RadioEWin
	{
		guicontrol , , _lbExist, |
		guicontrol , , _lbExist, %newtitle%|%g_EWinList%
	}
	else if bBoth
	{
		guicontrol , , _lbExist, |
		guicontrol , , _lbExist, %g_EWinList%
	}
}

;;
��ѡ����˵�ǰ���ڱ��⡿:
��ѡ����˵�ǰͬ�ര�ڡ�:
	gui submit, nohide
	RefreshList( false )
	return

���޸ĵ�ǰ���ڱ��⡿:
	gui submit, nohide
	if _RadioAWin
		RefreshList( false )
	return

���޸ĵ�ǰ�����ࡿ:
	gui submit, nohide
	if _RadioEWin
		RefreshList( false )
	return

��ѡ����ӵ�AWinList��:
��ѡ����ӵ�EWinList��:
	gui submit, nohide
	RefreshList( true )
	return
