

SetingReg(var_valuename)
{
	iniread var_temp,setup.ini,regedit,%var_valuename%
	if (var_temp="") {
		tooltip %var_valuename%�����ڣ�û�����óɹ�
		sleep 1000
		tooltip
		return
	}
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders,%var_valuename%,%var_temp%
}

;var_RootKey = HKEY_CURRENT_USER
;var_SubKey =  Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders

;;���� �ҵ��ĵ�
SetingReg("Personal")

;;�����ղؼ�
SetingReg("Favorites")

;;����Cookies
SetingReg("Cookies")

;;����Desktop
SetingReg("Desktop")


;;���� �ҵ�ͼƬ�ղ�
SetingReg("My Pictures")

;;���� ���͵�
SetingReg("SendTo")

;;���� ������
SetingReg("Startup")

;;���� �ҵ�����
SetingReg("My Music")
SetingReg("My Video")

;;���� Ӧ�ó�������Ŀ¼
SetingReg("AppData")

;;���� ��ʷ��¼Ŀ¼
SetingReg("History")

;;���� ��ʼ�˵�
;SetingReg("Start Menu")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ���� ϵͳ����ʱ��������
iniread var_temp,setup.ini,regedit,wallpaper
RegWrite, REG_SZ, HKEY_USERS, .DEFAULT\Control Panel\Desktop, Wallpaper, %var_temp%
if not (var_temp = "")
	RegWrite, REG_SZ, HKEY_USERS, .DEFAULT\Control Panel\Desktop, TileWallpaper,1

