/**
 *@file    �Զ����븴��.ahk
 *@author  teshorse
 *@date    2011.11.03
 *@brief   ����ѡ�����ļ����Զ�������Ƶ�Ŀ��λ��
 *
 *- 1����Ahk�ļ����Զ������EXE�����ƶ���Ŀ��λ�������Ŀ¼��
 *- 2����AHK�ļ����Ƶ�Ŀ��λ�������Ŀ¼��
 *- 3�������Ahk�ļ����Ҵ���ͬ����ico�ļ������ڱ���Ahk�ļ�ʱ��ʹ�ø�ico�ļ���Ϊͼ�ꡣ
 */


#NoTrayIcon
change_icon()

TreeRoot = .
TreeViewWidth := 380

;; ��������ļ��б�
g_ListFile = CompilerList.txt

;; ���ر����ļ��б���ļ�����
g_LoadConten =
FileRead, g_LoadConten, %g_ListFile%

;; ׼�����Ҽ��˵�
g_MenuItem0 = &C ���븴��
g_MenuItem1 = &1 �����²�����Ahk�ļ�
g_MenuItem2 = &2 �����²�ѡ���ӽڵ�
g_MenuItem3 = &3 ��������ѡ������ڵ�
g_MenuItem9 = &9 ����AHK�ļ�

Menu, RightMenu, Add, %g_MenuItem0% , ���������ѡ�нڵ㡿
Menu, RightMenu, Add, %g_MenuItem9% , ���Զ������AHK�ļ���
Menu, RightMenu, Add,
Menu, RightMenu, Add, %g_MenuItem1% , �������²�����Ahk�ļ���
Menu, RightMenu, Add, %g_MenuItem2% , �������²�ѡ���ӽڵ㡿
Menu, RightMenu, Add, %g_MenuItem3% , ����������ѡ������ڵ㡿

; Allow the user to maximize or drag-resize the window:
Gui +Resize

; Create an ImageList and put some standard system icons into it:
ImageListID := IL_Create(7)
Loop 5  ; Below omits the DLL's path so that it works on Windows 9x too:
    IL_Add(ImageListID, "shell32.dll", A_Index)

IL_Add(ImageListID, "shell32.dll", 131 )	 ;; icon6 pic
IL_Add(ImageListID, a_AhkPath, 2)		 ;; icon7 ahk file
IL_Add(ImageListID, "shell32.dll", 71)		 ;; icon8 notepad file
IL_Add(ImageListID, "shell32.dll", 70)		 ;; icon9 ini file
IL_Add(ImageListID, "shell32.dll", 24)		 ;; icon10 icon file



; Create a TreeView and a ListView side-by-side to behave like Windows Explorer:
Gui, Add, Text, x5 y15 w50 h20 , Ŀ���ַ
Gui, Add, Edit, x56 y12 w330 h22 v_OutPut, OutPut
Gui, Add, Button, x388 y10 w30 h25 g������Ŀ��·����, >>
Gui, Add, Button, x430 y10 w80 h25 g�������б�ť��, ��  ��
Gui, Add, Button, x520 y10 w80 h25 g���������ɡ�, ��  ��

Gui, Add, TreeView, vMyTree Checked AltSubmit r20 x6 y40 w610 h380 gMyTree ImageList%ImageListID%


; Create a Status Bar to give info about the number of files and their total size:
Gui, Add, StatusBar
SB_SetParts(60, 85)  ; Create three parts in the bar (the third part fills all the remaining width).

; Add folders and their subfolders to the tree. Display the status in case loading takes a long time:
;SplashTextOn, 200, 25, TreeView and StatusBar Example, Loading the tree...
InitFolderTree()
;SplashTextOff

; Display the window and return. The OS will notify the script whenever the user performs an eligible action:
Gui, Show,  h448 w634, ���ñ����б�  ; Display the source directory (TreeRoot) in the title bar.
return

InitFolderTree()
{
	AddSubFoldersToTree("Bin\", TV_Add( "Bin\", ParentItemID, "Icon4") )
	AddSubFoldersToTree("Awin\", TV_Add( "Awin\", ParentItemID, "Icon4"))
	AddSubFoldersToTree("Users\", TV_Add( "Users\", ParentItemID, "Icon4"))


    Loop *.*, 0  ; Retrieve all of Folder's sub-folders.
	{
		if  A_LoopFileExt contains ~,aik,swp
			continue

		TV_AddOneFile( A_LoopFileName, ParentItemID, A_LoopFileName, A_LoopFileExt )


	}
}

MyTree:  ; This subroutine handles user actions (such as clicking).
	ItemID := A_EventInfo
	if A_guievent = Normal
	{
		if ( GetKeyState("shift","P") = 1 )
		{
			if TV_Get(ItemID, "Checked") = ItemID
				bCheck := true
			else
				bCheck := false

			CheckOneNode( ItemID, bCheck )
		}
		TV_Modify(ItemID, "Select")
	}
	else if a_GuiEvent = RightClick
	{
		if TV_GetChild(ItemID) = 0
		{
			Menu, RightMenu, Enable,  %g_MenuItem0%
			Menu, RightMenu, Disable, %g_MenuItem1%
			Menu, RightMenu, Disable, %g_MenuItem2%
			Menu, RightMenu, Disable, %g_MenuItem3%
			TV_GetText( var_text, ItemID )
			ifInString var_text, .ahk
				Menu, RightMenu, Enable,  %g_MenuItem9%
			else 
				Menu, RightMenu, Disable,  %g_MenuItem9%
		}
		else
		{
			Menu, RightMenu, Disable, %g_MenuItem0%
			Menu, RightMenu, Disable, %g_MenuItem9%
			Menu, RightMenu, Enable,  %g_MenuItem1%
			Menu, RightMenu, Enable,  %g_MenuItem2%
			Menu, RightMenu, Enable,  %g_MenuItem3%
		}
		Menu, RightMenu, show
	}
	return


GuiSize:  ; Expand\shrink the ListView and TreeView in response to user's resizing of window.
	if A_EventInfo = 1  ; The window has been minimized.  No action needed.
		return
	; Otherwise, the window has been resized or maximized. Resize the controls to match.

	GuiControl, Move, MyTree, % "H" . (A_GuiHeight - 70) . " W" . ( A_GuiWidth - 16 )   ; -30 for StatusBar and margins.
	return

GuiClose:  ; Exit the script when the user closes the TreeView's GUI window.
ExitApp


������Ŀ��·����:
	FileSelectFolder, OutputVar, %a_ScriptDir%
	guicontrol, , _OutPut, %OutputVar%
	return


�Ʊ����б�()
{
	global g_SaveConten, g_ListFile
	g_SaveConten =
	ParentPath =
	ItemID =
	loop
	{
		ItemID := TV_GetNext(ItemID)
		if not ItemID
			break

		TV_GetText(ItemText, ItemID)
		path = %ItemText%
		DealOneNode( ItemID, path )
	}

	if g_SaveConten <>
	{
		ifExist %g_ListFile%
			filedelete  %g_ListFile%

		fileappend %g_SaveConten%, %g_ListFile%

		return true
	}

	;msgbox % g_SaveConten .
	return false
}

�������б�ť��:
	if �Ʊ����б�()
		msgbox �б��Ѿ����棡
	else
		msgbox �����б����
	return

���������ɡ�:
	gui, submit, nohide
	
	�Ʊ����б�()

	if g_SaveConten <>
	{
		Loop, parse, g_SaveConten, `n, `r
		{
			ComplieOneFile( a_LoopField )
		}
		msgbox ���븴����ɣ�
	}
	else
	{
     	msgbox û���ļ��ɱ��룡
	}
	return



���������ѡ�нڵ㡿:
	Gui, submit, nohide
	var_path := GetNodeFullPath( TV_GetSelection() )
	if var_path <>
	{
		ComplieOneFile( var_path )
		msgbox �������ѡ�нڵ�, ������ϣ�
	}
	return

�������²�����Ahk�ļ���:
	Gui, submit, nohide
	var_path := GetNodeFullPath( TV_GetSelection() )
	if var_path <>
	{
		childID := TV_GetChild( TV_GetSelection() )
		loop
		{
			if not childID
				break

			TV_GetText( var_text, childID )

			IfInString var_text, .ahk
			{
				StringRight var_ext, var_text, 4
				if var_ext = .ahk
					ComplieOneFile( var_path . var_text )
			}

			childID := TV_GetNext( childID )
		}
		msgbox �����²�����Ahk�ļ���������ϣ�
	}
	return

�������²�ѡ���ӽڵ㡿:
	Gui, submit, nohide
	var_path := GetNodeFullPath( TV_GetSelection() )
	if var_path <>
	{
		childID := TV_GetChild( TV_GetSelection() )
		loop
		{
			if not childID
				break

			if TV_Get(childID, "Checked") = childID
			{
				TV_GetText( var_text, childID )
				ComplieOneFile( var_path . var_text )
			}

			childID := TV_GetNext( childID )
		}
		msgbox �����²�ѡ���ӽڵ�, ������ϣ�
	}
	return

����������ѡ������ڵ㡿:
	Gui, submit, nohide
	itemID 	 := TV_GetSelection()
	if not itemID
		return

	var_path := GetNodeFullPath( itemID )
	if var_path <>
	{
		ComplieOneNode( itemID, var_path )
		msgbox ��������ѡ������ڵ�, ������ϣ�
	}
	return


���Զ������AHK�ļ���:
	Gui, submit, nohide
	var_path := GetNodeFullPath( TV_GetSelection() )
	if var_path <>
	{
		ComplieOneFile2( var_path )
	}	
	return


AddSubFoldersToTree(Folder, ParentItemID = 0)
{
    ; This function adds to the TreeView all subfolders in the specified folder.
    ; It also calls itself recursively to gather nested folders to any depth.
    Loop %Folder%*.*, 2  ; Retrieve all of Folder's sub-folders.
	{
	;		tooltip %A_LoopFileDir% >> %A_LoopFileName% >>  %A_LoopFileFullPath%
	 	if  A_LoopFileName not in .svn,bak
         	AddSubFoldersToTree(A_LoopFileFullPath . "\", TV_Add(A_LoopFileName . "\", ParentItemID, "Icon4"))

;		sleep 1000
	}

    Loop %Folder%\*.*, 0  ; Retrieve all of Folder's sub-folders.
	{
	;		tooltip %A_LoopFileDir% >> %A_LoopFileName% >>  %A_LoopFileFullPath%
		if  A_LoopFileExt contains ~,aik,swp
			continue

		path = %Folder%%A_LoopFileName%
		TV_AddOneFile( A_LoopFileName, ParentItemID, path, A_LoopFileExt )

	}
}

TV_AddOneFile( title_, itemid_, path_, ext_ )
{
	global g_LoadConten
	checked =
	StringReplace, needle, path_, \, \\, all
	needle = i)(?<=^|`r`n)%needle%(?=$|`r`n)
;	clipboard := needle
;	msgbox regexmatch(`n %g_LoadConten%`, `n%needle% )

	var_icon = Icon1
	if ext_ in ahk
		var_icon = Icon7
	else if ext_ in jpg,gif,png
		var_icon = Icon6
	else if ext_ in text,txt
		var_icon = Icon8
	else if ext_ in ini,cfg,dic
		var_icon = Icon9
	else if ext_ in ico
		var_icon = Icon10

	if regexmatch( g_LoadConten, needle ) > 0
	{
		checked = check
	}
	opt = %var_icon% %checked%

	TV_Add( title_, itemid_, opt )


	;; �����Ҫ��ѡ�������丸����Ƿ��Ѿ���ѡ������ѡ֮
	if checked = check
	{
		parentID := itemid_
		loop
		{
			if ( parentID && TV_Get(parentID, "Checked") != parentID )
			{
			;	msgbox TV_Modify( %parentID%, checked )
				TV_Modify( parentID, checked )  ;; ͬʱ��ѡ���׽ڵ�
				parentID := TV_GetParent( parentID )
			}
			else
			{
				break
			}
		}
	}
}


DealOneNode( ParentItemID = 0, ParentPath="" )
{
	global g_SaveConten
	ItemID := ParentItemID
	if ItemID = 0
	{
		ItemID := TV_GetNext( )
	}
	if not ItemID  ; No more items in tree.
		return

	TV_GetText(ItemText, ItemID)

	;; ���û���ӽڵ�
	if TV_GetChild(ItemID) = 0
	{
		StringRight var_lastchar, ItemText, 1
		if ( var_lastchar != "\" and TV_Get(ItemID, "Check") = ItemID )
		{
			g_SaveConten = %g_SaveConten%%ParentPath%`r`n
		}
	}
	;; ������ӽڵ�
	else
	{
		ChildID := TV_GetChild(ItemID)
		loop
		{
			if not ChildID
				break

			TV_GetText(ItemText, ChildID)
			path = %ParentPath%%ItemText%
			DealOneNode( ChildID, path )
			ChildID := TV_GetNext(ChildID)
		}
	}
}

CheckOneNode( ItemID, bCheck_ )
{
	if not ItemID
		return

	var_check = -Check
	if bCheck_
	{
		var_check = Check
	}

	parentID := ItemID
	loop
	{
		parentID := TV_GetParent( parentID )
		if not parentID
			break

		if bCheck_
		{
			TV_Modify( parentID, var_check )
		}
		else
		{
			bAllUnchecked := true
			ChildID := TV_GetNext(parentID,"Full")
			loop
			{
				if not ChildID
					break

				if TV_Get(ChildID, "Checked") = ChildID
				{
					bAllUnchecked := false
					break
				}
				ChildID := TV_GetNext(ChildID)
			}
			if bAllUnchecked
			{
				TV_Modify( parentID, var_check )
			}
		}
	}

	TV_Modify( ItemID, var_check )

	if TV_GetChild(ItemID) > 0
	{
		ChildID := TV_GetNext(ItemID,"Full")
		loop
		{
			if not ChildID
				break

			CheckOneNode( ChildID, bCheck_ )
			ChildID := TV_GetNext(ChildID)
		}
	}
}

;; ʹ�������б���AHK�ļ�
ComplieOneFile( fileName )
{
	Local OutFileName, OutDir, OutExtension, OutNameNoExt, iconFile, DestPattern, var_ahk2exe
	if ( FileExist( fileName ) and _OutPut <> "" )
	{
		SplitPath, fileName , OutFileName, OutDir, OutExtension, OutNameNoExt

		if OutDir <>
		{	
			OutDir = %OutDir%\
			FileCreateDir, %_OutPut%\%OutDir%
		}

	;	msgbox FileCreateDir`, %_OutPut%\%OutDir%

	  ;  msgbox SplitPath`, %fileName% `, %OutFileName%`, %OutDir%`, %OutExtension%
		if OutExtension <> ahk
		{
			DestPattern = %_OutPut%\%fileName%
			FileCopy, %fileName%, %DestPattern%, 1
	  ;  	msgbox FileCopy, %fileName%`, %DestPattern%`, 1
		}
		else
		{
			iconFile = %OutDir%%OutNameNoExt%.ico
		;	msgbox iconFile = %iconFile%
		 	if FileExist( iconFile )
              	iconFile =  `"%iconFile%`"
			else
			 	iconFile =  `"Users\MyHotkey2.ico`"

		;	msgbox iconFile = %iconFile%

			DestPattern = %_OutPut%\%OutDir%%OutNameNoExt%.exe

            var_ahk2exe := Ahk2exeFile()
			if var_ahk2exe <>
				run %var_ahk2exe% /in `"%fileName%`" /out `"%DestPattern%`" /icon %iconFile%
		}
	}
}

;; ʹ�ñ������AutoScriptComplie����ָ���ļ�
ComplieOneFile2( fileName )
{
	Local OutFileName, OutDir, OutExtension, OutNameNoExt, iconFile, DestPattern, var_ahk2exe, OutDriver, ahk2exe
	if ( FileExist( fileName ) and _OutPut <> "" )
	{
		SplitPath, fileName , OutFileName, OutDir, OutExtension, OutNameNoExt
		FileCreateDir, %_OutPut%\%OutDir%

	;	msgbox FileCreateDir`, %_OutPut%\%OutDir%

	  ;  msgbox SplitPath`, %fileName% `, %OutFileName%`, %OutDir%`, %OutExtension%
		if OutExtension <> ahk
		{
			DestPattern = %_OutPut%\%fileName%
			FileCopy, %fileName%, %DestPattern%, 1
	  ;  	msgbox FileCopy, %fileName%`, %DestPattern%`, 1
		}
		else
		{
			var_root := a_ScriptDir

			fileName = %var_root%\%fileName%
			iconFile = %var_root%\%OutDir%\%OutNameNoExt%.ico
		 	if FileExist( iconFile )
              	iconFile =  `"%iconFile%`"
			else
			 	iconFile = 

			DestPattern = %_OutPut%\%OutDir%\%OutNameNoExt%.exe


			;; �ж�_OutPut�Ƿ����·��
			SplitPath, _OutPut , , OutDir, , , OutDriver
			if OutDriver =
			{
				DestPattern = %var_root%\%DestPattern% ;; �����·��
			}

			SplitPath, a_ahkpath , , ahk2exe
			ahk2exe = %ahk2exe%\Compiler\Ahk2Exe.exe

			ifexist %ahk2exe%
			{
				run %ahk2exe%, , , ThisPID
				WinWait, ahk_pid %ThisPID%
				loop 10
				{
					sleep 200
				    WinGet, ThisID, ID, ahk_pid %ThisPID%
					ifwinexist ahk_id %ThisID%
					{
						winactivate 
						ControlSetText , Edit1, %fileName%, ahk_id %ThisID%
						ControlSetText , Edit2, %DestPattern%, ahk_id %ThisID%
						ControlSetText , Edit3, %iconFile%, ahk_id %ThisID%
						break
					}
				}
			}
			else
			{
				msgbox ������� Ahk2Exe.exe û�ҵ���
			}
         ;   msgbox fileName = %fileName% `niconFile = %iconFile% `nDestPattern = %DestPattern%
		}
	}
}


ComplieOneNode( ParentItemID = 0, ParentPath="" )
{
	global g_SaveConten
	ItemID := ParentItemID
	if ItemID = 0
	{
		ItemID := TV_GetNext( )
	}

	if not ItemID  ; No more items in tree.
		return

	TV_GetText(ItemText, ItemID)

	;; ���û���ӽڵ�
	if TV_GetChild(ItemID) = 0
	{
		StringRight var_lastchar, ItemText, 1
		if ( var_lastchar != "\" and TV_Get(ItemID, "Check") = ItemID )
		{
		;	msgbox ComplieOneFile( %ParentPath% )
			ComplieOneFile( ParentPath )
		}
		;Else
		;	msgbox ComplieOneNode( %ParentItemID%`, %ParentPath%`, %bFull% ) >>>> %ItemText%
	}
	;; ������ӽڵ�
	else
	{
		ChildID := TV_GetChild(ItemID)
	;	TV_GetText(ItemText, ChildID)
	;	MsgBox %ChildID% %ItemText% := TV_GetChild(%ItemID%) `n ( %ParentItemID%`, %ParentPath%`, %bFull% )
		loop
		{
			if not ChildID
			{
				break
			}
			TV_GetText(ItemText, ChildID)
			var_path = %ParentPath%%ItemText%
			ComplieOneNode( ChildID, var_path )
			;msgbox <<< ComplieOneNode( %ChildID%`, %var_path% )
			ChildID := TV_GetNext(ChildID)
		}
	}
}

Ahk2exeFile()
{
	global g_ahk2exe
	if g_ahk2exe =
	{
       	SplitPath, a_ahkPath , , OutDir,
        g_ahk2exe = %OutDir%\Compiler\Ahk2Exe.exe
	}
	return g_ahk2exe
}

GetNodeFullPath( itemID )
{
	var_path =
	loop
	{
		if not itemId
			break

		TV_GetText( var_text, ItemID)
		var_path := var_text . var_path
		ItemID := TV_GetParent( ItemID )
;		msgbox % var_text . "`n" .  var_path
	}
	return var_path
}

GetParentPath( itemID )
{
	var_path =
	loop
	{
		ItemID := TV_GetParent( ItemID )
		if not itemId
			break

		TV_GetText( var_text, ItemID)
		var_path := var_text . var_path
	}
	return var_path
}


;; ����������ͼ��
change_icon( var_icofile = "", bForce = false )
{
	;; ���ִ�еĽű���EXE�ļ���ֻ��bForce = True ʱ�Ÿ���ͼ��
	if a_IsCompiled
	{
		if not bForce
		{
			Return                                  ;; ����EXE�ļ�����û��ǿ�ƻ�ͼ��ʱ�˳�
		}
	}
	;; ���ͼ���ļ�Ϊ��, ��Ĭ�ϲ�����ű��ļ�����Ŀ¼��, ��ű�����ͬ���Ƶ�ICO�ļ�
	if var_icofile =
	{
		SplitPath, a_ScriptFullPath ,  , OutDir, , OutNameNoExt
		var_icofile = %OutDir%\%OutNameNoExt%.ico
		; msgbox var_icofile = %var_icofile%
	}
	else
	{
		SplitPath, var_icofile, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
		if OutExtension <> ico
		{
			Return                                  ;; ������ͼ�겻��ICO�ļ�, ���˳�
		}
		if Outdir =
		{
			SplitPath, a_ScriptFullPath ,  , OutDir
			var_icofile = %OutDir%\%OutNameNoExt%.ico
		}
	}
	;; ���icoͼ���ļ����ڣ���ʹ��֮
	IfExist %var_icofile%
	{
		Menu TRAY, Icon,  %var_icofile%
	}
}


