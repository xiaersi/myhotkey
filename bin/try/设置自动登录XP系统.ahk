	var_RootKey = HKEY_LOCAL_MACHINE
	var_SubKey = SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

	RegWrite, REG_SZ, %var_RootKey%, %var_SubKey%, AutoAdminLogon, 1

	InputBox, var_username , 用户名, 请输入默认用户名, , , , , , , , Administrator
	RegWrite, REG_SZ, %var_RootKey%, %var_SubKey%, DefaultUserName, %var_username%

	InputBox, var_password , 密码, 请输入密码
	RegWrite, REG_SZ, %var_RootKey%, %var_SubKey%, DefaultPassword, %var_password%

