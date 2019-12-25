

SetingReg(var_valuename)
{
	iniread var_temp,setup.ini,regedit,%var_valuename%
	if (var_temp="") {
		tooltip %var_valuename%不存在，没有设置成功
		sleep 1000
		tooltip
		return
	}
	RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders,%var_valuename%,%var_temp%
}

;var_RootKey = HKEY_CURRENT_USER
;var_SubKey =  Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders

;;设置 我的文档
SetingReg("Personal")

;;设置收藏夹
SetingReg("Favorites")

;;设置Cookies
SetingReg("Cookies")

;;设置Desktop
SetingReg("Desktop")


;;设置 我的图片收藏
SetingReg("My Pictures")

;;设置 发送到
SetingReg("SendTo")

;;设置 启动项
SetingReg("Startup")

;;设置 我的音乐
SetingReg("My Music")
SetingReg("My Video")

;;设置 应用程序数据目录
SetingReg("AppData")

;;设置 历史记录目录
SetingReg("History")

;;设置 开始菜单
;SetingReg("Start Menu")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 设置 系统启动时背景画面
iniread var_temp,setup.ini,regedit,wallpaper
RegWrite, REG_SZ, HKEY_USERS, .DEFAULT\Control Panel\Desktop, Wallpaper, %var_temp%
if not (var_temp = "")
	RegWrite, REG_SZ, HKEY_USERS, .DEFAULT\Control Panel\Desktop, TileWallpaper,1

