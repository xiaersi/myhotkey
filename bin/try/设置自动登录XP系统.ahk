	var_RootKey = HKEY_LOCAL_MACHINE
	var_SubKey = SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

	RegWrite, REG_SZ, %var_RootKey%, %var_SubKey%, AutoAdminLogon, 1

	InputBox, var_username , �û���, ������Ĭ���û���, , , , , , , , Administrator
	RegWrite, REG_SZ, %var_RootKey%, %var_SubKey%, DefaultUserName, %var_username%

	InputBox, var_password , ����, ����������
	RegWrite, REG_SZ, %var_RootKey%, %var_SubKey%, DefaultPassword, %var_password%

