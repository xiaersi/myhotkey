readinifile(ByRef OutPara, filename, appname, keyname)
{
	iniread,OutPara,%filename%,%appname%,%keyname%
	if (OutPara = "" or OutPara = "error")
	{
		return false
	}
	return true
}

var_filename := "setting.ini"
if (readinifile(var_curtask, var_filename, "head", "curtask"))
{
	if ( readinifile(var_tasks, var_filename, "head", var_curtask) )
	{
		StringSplit, ProjArray, var_tasks, `,
		Loop, %ProjArray0%
		{
		    var_project := ProjArray%a_index%
;		    MsgBox, Color number %a_index% is %var_project%.

			if 	readinifile(var_srcpath, var_filename, var_project, "srcpath") 
				and readinifile(var_trapath, var_filename, var_project, "trapath") 
				and readinifile(var_ext, var_filename, var_project, "ext") 
			{
				readinifile(var_flag, var_filename, var_project, "overwrite")

				StringSplit, ExtArray, var_ext, `,

				Loop, %ExtArray0%
				{
				    this_ext := ExtArray%a_index%

					src_file := var_srcpath
					StringRight, var_lastchar, var_srcpath, 1
					if (var_lastchar != "\")
					{
						src_file = %src_file%\
					}
					src_file = %src_file%%this_ext%
					tra_file := var_trapath

					StringRight, var_lastchar, var_trapath, 1
					if (var_lastchar != "\")
					{
						tra_file = %tra_file%\
					}


					if ( var_flag = 1 or var_flag = "overwrite")
					{
;						MsgBox, this_proj=%var_project%`n this_ext=%this_ext%`ncopy(1): %src_file%`n to: %tra_file%
						FileCopy %src_file%,%tra_file%,1
						var_info = %var_info%copy(OverWrite): %src_file%  to:  %tra_file%`n
					}
					else
					{
;						MsgBox, this_proj=%var_project%`n this_ext=%this_ext%`ncopy(0): %src_file%`n to: %tra_file%
						FileCopy %src_file%,%tra_file%,0
						var_info = %var_info%copy: %src_file%  to:  %tra_file%`n
					}
				}
			}
			else
			{
				MsgBox, read Path or File Externs fail!!
			}
		}
		MsgBox %var_info%
	}
	else
	{
		MsgBox, read Projects fail!!
	}
}
else
{
 	MsgBox, read curtask fail!!
}
