;; Source Insight �Ǵ����Ķ�����

#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������
#ifWinActive ahk_class si_Frame  ;; SourceInsight
F11::	;; F11 ͬʱ���ء���ʾ�෽���·����������൱��ȫ��
	send !vp
	send !vo
	send !vr
	return

+F11::	;; ��ʾ�������Ҳ��Project������
	send !vp
	return

^F11::	;; ��ʾ���������·�Context������
	send !vo
	return 

!F11::	;; ��ʾ���������·���Relation������
	send !vr
	return

esc::   ;; �رյ�ǰҳ��
	send ^w
	return 

#ifWinActive
