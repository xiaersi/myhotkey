

;; google ��ɽ�ʰ�
#ifwinexist �ȸ��ɽ�ʰԺ����� ahk_class #32770

;; �ùȸ��ɽ�ʰԲ���ѡ�еĵ���
AppsKey::
#F9::	
	clipboard=
	sleep 100
	send ^c
	sleep 200
	if clipboard<>
	{
		ControlSetText, Edit1, %clipboard%, �ȸ��ɽ�ʰԺ����� ahk_class #32770
		winactivate �ȸ��ɽ�ʰԺ����� ahk_class #32770
		sleep 100
		send {enter}
	}
	return
	
#ifwinexist