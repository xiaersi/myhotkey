;;��������ģʽ���ü������������������Լ���������ȹ��ܼ�ӳ�䵽����λ�ã�������ӳ�䵽����λ��

#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������

#ifwinactive Windows Media Player ahk_class WMPlayerApp
~rbutton::
	send t
	return

#ifwinactive


#ifWinexist Windows Media Player ahk_class WMPlayerApp

#home::Media_Play_Pause
;#end::Media_Stop
#pgup::Media_Prev
#pgdn::Media_Next

#numpaddel::Volume_Mute
^!left::Media_Prev
^!right::Media_Next
^!up::Volume_Up
^!down::Volume_down

#ifWinexist



#ifWinexist ahk_class Baofeng_StormPlayer

::`;s::
::`;p::
!p::
	winget awin_id, ID, A
	winactivate ahk_class Baofeng_StormPlayer
	send {space}
	WinSet, AlwaysOnTop, on, ahk_class Baofeng_StormPlayer
	winactivate ahk_id %awin_id%
	return


^\::
	winget awin_id, ID, A
	winactivate ahk_class Baofeng_StormPlayer
	send {space}
	winactivate ahk_id %awin_id%
	return

!t::
^+6::
::`;t::
	winget awin_id, ID, A
	winactivate ahk_class Baofeng_StormPlayer
	WinSet, AlwaysOnTop, Toggle, ahk_class Baofeng_StormPlayer
	winactivate ahk_id %awin_id%
	return

::`;1::
!1::
	winmove ahk_class Baofeng_StormPlayer, , 600, 0
	return 

::`;2::
!2::
	winmove ahk_class Baofeng_StormPlayer, , 950, 0
	return

::`;3::
!3::
	winmove ahk_class Baofeng_StormPlayer, , 1110, 0
	return

::`;0::
!0::
	winmove ahk_class Baofeng_StormPlayer, , 400, 0
	return

![::
	WinGetPos , winX, , , , ahk_class Baofeng_StormPlayer
	winmove ahk_class Baofeng_StormPlayer, , winX - 50, 0
	return

!]::
	WinGetPos , winX, , , , ahk_class Baofeng_StormPlayer
	winmove ahk_class Baofeng_StormPlayer, , winX + 50, 0
	return

#ifWinexist
