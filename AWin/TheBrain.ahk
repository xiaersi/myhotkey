#ifwinactive ahk_class SunAwtFrame
>!h::
	send {F3}
	sleep 80
	send {left}
	return

>!j::
	send {F3}
	sleep 80
	send {down}
	return

>!k::
	send {F3}
	sleep 80
	send {up}
	return

>!l::
	send {F3}
	sleep 80
	send {right}
	return

>!o::
	send {F5}
	send {ctrl down}{end}{ctrl up}
	return


+F6::	;; �����Ӵ��⣬���л��������������봴������
	send {F6}
	sleep 200
	send {Alt down}
	sleep 100
	send {Tab}
	sleep 100
	send {Alt up}
	sleep 200
	winactivate ahk_class SunAwtDialog
	return

!F6::	;; ��������PMP���롢�����뼼��������Ĵ���
	send ^c
	send {F6}
	sleep 200
	if clipboard =
		return
	var_clip := clipboard
	clipboard = %var_clip%--����
	winactivate ahk_class SunAwtDialog
	send ^v
	sleep 100
	send {tab}{space}
	sleep 100
	send {down 6}
	send {enter}
	sleep 50
	send {enter}
	sleep 800

	send {F6}
	sleep 200
	clipboard = %var_clip%--�����뼼��
	winactivate ahk_class SunAwtDialog
	send ^v
	sleep 100
	send {tab}{space}
	sleep 100
	send {down 5}
	send {enter}
	sleep 50
	send {enter}
	sleep 800

	send {F6}
	sleep 200
	clipboard = %var_clip%--���
	winactivate ahk_class SunAwtDialog
	send ^v
	sleep 100
	send {tab}{space}
	sleep 100
	send {down 7}
	send {enter}{enter}
		/**/
	return
#ifwinactive
