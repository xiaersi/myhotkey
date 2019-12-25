change_icon()                           ;; 修改图标

g_title = 音量调节工具
g_min := 0
g_default := 0
g_max := 100
g_text = 音量
g_checkbox = 静音&M
g_bChecked := false
var_tipsound = %A_WinDir%\Media\Windows XP 叮当声.wav

SoundGet, g_default

;; 当前是否静音
SoundGet, master_mute, , mute
if master_mute = On
	g_bChecked := true

#include ../../
#Include ./bin/Slider调节/GuiSlider.aik
#include ./inc/common.aik

【我的功能处理】:
	SoundSet %_MySlider%
	SetTimer 【延时播放声音提示】, 500
	Return

【我的CheckBox处理】:
	Send {Volume_Mute}
	Return


【延时播放声音提示】:
	SetTimer 【延时播放声音提示】, off
	IfExist %var_tipsound%
		SoundPlay, %var_tipsound%
	Return
