	var_RootKey = HKEY_CURRENT_USER
	var_SubKey = Software\Microsoft\Windows\CurrentVersion\Policies\Explorer
/*
	var_hide_A = 01000000
	var_hide_B = 02000000
	var_hide_C = 04000000
	var_hide_D = 08000000
	var_hide_E = 10000000
	var_hide_F = 20000000
	var_hide_G = 40000000
	var_hide_H = 80000000
*/
	; Òþ²ØFGÅÌ
	RegWrite, REG_BINARY, %var_RootKey%, %var_SubKey%, NoDrives, 60000000

