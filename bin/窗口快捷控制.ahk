#SingleInstance force
var_tip =
(
1���������ڿ��Ʋ˵��ķ���
  a.��ݼ� Win+Appskey �� Win+�Ҽ�
  b.�ڵ�ǰ�������� `;WinMenu ��س�
2������Ҽ��϶����ڱ�Ե����ͬ����������ڴ�С
3������Ҽ��϶��������������ˮƽ������
4��Alt + �Ҽ��϶����ڱ�Ե�����Ŵ���
5��Alt + �Ҽ��϶������м���ƶ�����
6��Win + Esc �˳�
)

TrayTip , �����������ڿ�ݿ���, %var_tip%, 3
settimer ����ʱ�ر���ʾ��, 4000

::`;winmenu::
#Appskey::
	run .\�Ҽ��˵�\�������ڴ�СΪԤ��ֵ.exe
	return
	
#esc::
	ExitApp
	
	
����ʱ�ر���ʾ��:
	TrayTip
	settimer ����ʱ�ر���ʾ��, off
	return
	
	
#include ..\
#include .\inc\common.aik
#include .\lib\MButton.aik
	
	