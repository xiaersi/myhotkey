

;msgbox ���Ѿ�������ACDsee3.1���ȼ��ļ�`,����ӳ������:`nw��s��a��d�ֱ��Ӧ�������Ҽ�`nf��r��ӦPagedown��PageUP`nj��c��Ӧ�������ּ�/��ʹ��ͼƬ��Ӧ���� `nk��v��Ӧ���ּ�*����ԭʼͼ���С�鿴`nh��e��Ӧ���ּ�+���Ŵ�ͼƬ `nl��q��Ӧ���ּ�-����СͼƬ`ngȫ�� `tm �ƶ�ͼƬ `txɾ��ͼƬ`n����԰�F4+4��Alt+esc�رձ��ȼ����ܡ�
::kugoogeci::
::kugougeci::
::;geci::
	WinGetActiveTitle, OutputVar 
	sleep 100
	ifwinexist ahk_class TfrmMain
	{
	winactivate
	sleep 200
	send !R
;	sleep 200
	winactivate %OutputVar%
	}
	return
#ifwinactive ahk_class TfrmMain

f4 & 4::
!esc::exitapp

F4::
	tooltip ɾ����ѡ�еĸ���
	send +{del}
;	winwait ���� ahk_class #32770,�Ƿ�ȷ����Ӳ����ɾ��ѡ�е�,3
;	if not errorlevel 
;	{
;	controlclick Button1, ���� ahk_class #32770,�Ƿ�ȷ����Ӳ����ɾ��ѡ�е�
;	}
	sleep 500
	tooltip
	return

#ifwinactive

