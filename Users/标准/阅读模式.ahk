;;��������ģʽ���ü������������������Լ���������ȹ��ܼ�ӳ�䵽����λ�ã�������ӳ�䵽����λ��

#SingleInstance ignore	;ֻ����һ�Σ���ֹ�������
;#SingleInstance force ; ǿ�����¼��أ���������ʾ����
var_tooltip = ���Ķ�ģʽ��

SetTimer, Movetooltip, 80 
Movetooltip:
	tooltip %var_tooltip%
	return 

#include ../../
#include ./Bin/ReadMode/common.aik

