change_icon()                           ;; �޸�ͼ��

g_title = �������ڹ���
g_min := 0
g_default := 0
g_max := 100
g_text = ����
g_checkbox = ����&M
g_bChecked := false
var_tipsound = %A_WinDir%\Media\Windows XP ������.wav

SoundGet, g_default

;; ��ǰ�Ƿ���
SoundGet, master_mute, , mute
if master_mute = On
	g_bChecked := true

#include ../../
#Include ./bin/Slider����/GuiSlider.aik
#include ./inc/common.aik

���ҵĹ��ܴ���:
	SoundSet %_MySlider%
	SetTimer ����ʱ����������ʾ��, 500
	Return

���ҵ�CheckBox����:
	Send {Volume_Mute}
	Return


����ʱ����������ʾ��:
	SetTimer ����ʱ����������ʾ��, off
	IfExist %var_tipsound%
		SoundPlay, %var_tipsound%
	Return
