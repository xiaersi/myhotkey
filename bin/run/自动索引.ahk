

g_TaskStep := 0                         ;; »ŒŒÒ≤Ω÷Ë
g_inifile = launchy.ini
g_SecKeys =
;; g_icon_section

read_seckeys( g_SecKeys, g_inifile, "file" )

if g_SecKeys <>
{
	Loop parse, g_SecKeys, `n
	{
		if a_LoopField =
			Continue
		Key := a_LoopField
		Value := read_ini( g_inifile, "file", Key, "" )
		
	;	msgbox a_LoopField[%a_LoopField%]
		
		if Value =
			Continue
			
		IfNotInString Value, |
		{
			Path := read_ini( g_inifile, "path", Key, "" )
			var_ext := get_file_ext( Value )
			var_value = %Value%|%var_ext%|%Path%
			write_ini( g_inifile, "file", Key, var_value )
			if Path <>
				del_ini( g_inifile, "path", Key, false )

			if var_ext not in bmp,jpg,gif,png,tif,exe,dll,ico,cur,cpl,scr
			{
				if g_icon_%var_ext% =
				{
					var_exe := get_open_exe( Value )
					g_icon_%var_ext% = 1
					IfExist %var_exe%
					{
						write_ini( g_inifile, "icon", var_ext, var_exe )
					}
				}
			}
		}
	}
}

#include ..\..\
#include .\inc\inifile.aik
#include .\inc\common.aik