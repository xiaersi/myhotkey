;
  ; AutoHotkey Version: 1.0.48.05
  ; Language:       English
  ; Platform:       Win9x/NT
  ; Author:         Yonken
  ;
  ; Script Function:
  ;   To enumerate the files of specified folder(s), filter out specified type(s), list and
  ; update the result in real time as the search pattern changed.
  ;   Use at your own risk.
  ;
 
  #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
  SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
  SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
  SetBatchLines, -1   ; Never sleep
 
  WM_NOTIFY               := 0x004E
  LVN_FIRST               := -100
 
  LVN_GETDISPINFOA        := (LVN_FIRST-50)   ; For ANSI version
  LVN_GETDISPINFOW        := (LVN_FIRST-77)   ; For unicode version
  LVN_GETDISPINFO         := LVN_GETDISPINFOW
 
  LVM_FIRST               := 0x1000
  LVM_SETITEMCOUNT        := (LVM_FIRST + 47)
  LVM_REDRAWITEMS         := (LVM_FIRST + 21)
 
  LVS_OWNERDATA           := 0x1000
 
  LPSTR_TEXTCALLBACKA     := -1
 
  sizeofNMHDR             := 12
  sizeofLVITEM            := 40
 
  LVSICF_NOINVALIDATEALL  := 0x00000001
 
  LVIF_TEXT               := 0x0001
  LVIF_IMAGE              := 0x0002
  LVIF_STATE              := 0x0008
 
  CP_ACP                  := 0           ; default to ANSI code page
 
  pRtlFillMemory          := GetProcAddressInModule("RtlFillMemory")
  pWideCharToMultiByte    := GetProcAddressInModule("WideCharToMultiByte")
  pMultiByteToWideChar    := GetProcAddressInModule("MultiByteToWideChar")
  pStrCpy                 := GetProcAddressInModule("strcpy", "msvcrt")
 
  g_strAppName            := "Smart Open File"
  g_strVersion            := "2010.5.10"
  g_strTitle              := g_strAppName A_Space g_strVersion
  g_hMainWnd              := 0
 
  g_nFilesCount           := 0
  g_nMatchCount           := 0
  g_MatchIndices          = -1
 
 
  ; Allow the user to maximize or drag-resize the window:
  Gui +Resize
 
  ; Create some buttons:
  Gui, Add, Button, Default vBtnLoadFolder gButtonLoadFolder, &Load a folder
 
  ; Create the ListView with two columns, Name and Size:
  Gui, Add, ListView, Grid xm r20 w700 vMyListView Hwndg_hMyListView +%LVS_OWNERDATA%, Name|In Folder|Modified|Size (KB)|Type
 
  ; Create an ImageList so that the ListView can display some icons:
  ImageListID1 := IL_Create(10)
  ImageListID2 := IL_Create(10, 10, true)  ; A list of large icons to go with the small ones.
 
  ; Attach the ImageLists to the ListView so that it can later display the icons:
  LV_SetImageList(ImageListID1)
  LV_SetImageList(ImageListID2)
 
  ListView_SetItemCount(g_hMyListView, g_nMatchCount)
 
  Gui, Add, Edit, vEditSearchString gOnChangeSearchString,
 
  Gui, Show, , %g_strTitle% [0 of 0]
 
  OnMessage(WM_NOTIFY, "OnNotify")
 
  Gui, +LastFound
  WinSet, ReDraw      ; Invalidate the list-view
 
  g_hMainWnd := WinExist()
 
  return
 
  GuiEscape:
      GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
      ExitApp
  Return
 
  GuiSize:  ; Expand or shrink the ListView in response to the user's resizing of the window.
      if A_EventInfo = 1  ; The window has been minimized.  No action needed.
          return
      ; Otherwise, the window has been resized or maximized. Resize the ListView to match.
      GuiControl, Move, MyListView, % "W" . (A_GuiWidth - 20) . " H" . (A_GuiHeight - 70)
      GuiControl, Move, EditSearchString, % "W" . (A_GuiWidth - 20) . " Y" . (A_GuiHeight - 30)
  return
 
  ButtonLoadFolder:
      Gui +OwnDialogs  ; Forces user to dismiss the following dialog before using main window.
      FileSelectFolder, Folder,, 3, Select a folder to read:
      if not Folder  ; The user canceled the dialog.
          return
         
      g_nMatchCount := 0
      WinSetTitle, , , %g_strTitle% [%g_nMatchCount% of %g_nFilesCount%]
 
      GuiControl, Disable, BtnLoadFolder
      SetTimer, FileLoadProgressTimer, 100
     
      g_arrResult := ; Free the memory
      g_nFilesCount := LoadFolder(Folder, "g_arrResult")
     
      Gosub, OnChangeSearchString
     
      Gui +LastFound
      GuiControl, Enable, BtnLoadFolder
      SetTimer, FileLoadProgressTimer, Off
  return
 
  OnChangeSearchString:
      GuiControl, -Redraw, MyListView  ; Improve performance by disabling redrawing during load.
      nMatchCount := g_nFilesCount
      bNeedSetFocus := false
      If (g_nFilesCount > 0)
     {
          GuiControlGet, strSearchPattern, , EditSearchString
         
          strSearchPattern := RegExReplace(strSearchPattern, "S)[\s]+", "|")  ; Replace multiple whitespaces with a single character
          if(strSearchPattern = "" || strSearchPattern = "|")
          {
              ; Nothing is entered, select the first one
              g_MatchIndices = -1
              bNeedSetFocus := true
          }
          Else
         {
              If ( SubStr(strSearchPattern, StrLen(strSearchPattern)) == "|")
                  strSearchPattern := SubStr(strSearchPattern, 1, StrLen(strSearchPattern)-1)
              StringSplit, arrSearchPatterns, strSearchPattern, |
             
              g_MatchIndices =
              VarSetCapacity(g_MatchIndices, g_nFilesCount * 4)
             
              nMatchCount := 0
 
              Loop, %g_nFilesCount%
             {
                  strName := g_arrResult%A_Index%_NameAnsi
                  strFolder := g_arrResult%A_Index%_FolderAnsi
                  bMatch := true
                  Loop %arrSearchPatterns0%
                 {
                      if ( !IsMatch(strName, strFolder, arrSearchPatterns%A_Index%) )
                     {
                          bMatch := false
                          Break
                      }
                  }
                  if (bMatch)
                 {
                      NumPut(A_Index, g_MatchIndices, nMatchCount * 4)
                      ++nMatchCount
                  }
              }
          }
      }
      Else
     {
          g_MatchIndices = -1
      }
      g_nMatchCount := nMatchCount
      ListView_SetItemCount(g_hMyListView, g_nMatchCount)
      ListView_RedrawItems(g_hMyListView, 0, -1)
      ;ToolTip, Done searching %strSearchPattern%
     
      LV_ModifyCol()  ; Auto-size each column to fit its contents.
      GuiControl, +Redraw, MyListView  ; Re-enable redrawing (it was disabled above).
     
      If (bNeedSetFocus)
     {
          GuiControl, Focus, SysListView321,
          Send, {Home}
          GuiControl, Focus, EditSearchString,
      }
 
      WinSetTitle, , , %g_strTitle% [%g_nMatchCount% of %g_nFilesCount%]
  Return
 
  IsMatch(ByRef strFileName, ByRef strFolder, strSubPattern)
 {
      chChar1         := SubStr(strSubPattern, 1, 1)
      chChar2         := SubStr(strSubPattern, 2, 1)
      bIsExclude      := chChar1 == "-" || chChar2 == "-"
      bIsInFolder     := chChar1 == "\" || chChar2 == "\"
     
      strSubPattern := RegExReplace(strSubPattern, "S)^[-\\]+")
      If (strSubPattern = "")
          return true
     /*
      StringReplace, strSubPattern, strSubPattern, -
      StringReplace, strSubPattern, strSubPattern, \
      */
      strSearchText   := bIsInFolder ? strFolder : strFileName
      bMatch          := InStr(strSearchText, strSubPattern)
      if (bIsExclude)
          bMatch := !bMatch
 
      return bMatch
  }
 
  FileLoadProgressTimer:
      Gui +LastFound
      WinSetTitle, , , %g_strTitle% [%g_nMatchCount% of %g_nFilesCount%]
  Return
 
 /*
  typedef struct tagNMHDR
  {
      HWND  hwndFrom;
      UINT  idFrom;
      UINT  code;         // NM_ code
  }   NMHDR;
 
   NMHDR *pnm
  */
  OnNotify(idCtrl, pnmh)
 {
      global g_hMyListView, LVN_GETDISPINFO
      hwndFrom := DecodeInteger( "uint4", pnmh, 0 )
      if ( hwndFrom == g_hMyListView )
     {
          idFrom := DecodeInteger( "uint4", pnmh, 4)
          code := DecodeInteger( "uint4", pnmh, 8)
          nCode := code > 0x7FFFFFFF ? -(~code) - 1 : code
          if ( nCode == LVN_GETDISPINFO )
         {
              OnGetDispInfo(pnmh)
          }
      }
  }
 
 /*
  NMLVDISPINFO* pnmv
 
  typedef struct tagNMLVDISPINFO {
      NMHDR hdr;
      LVITEM item;
  } NMLVDISPINFO;
 
  typedef struct _LVITEM {
      UINT mask;     0
      int iItem;     4
      int iSubItem;  8
      UINT state;    12
      UINT stateMask; 16
      LPTSTR pszText; 20
      int cchTextMax; 24
      int iImage;     28
      LPARAM lParam;
  #if (_WIN32_IE >= 0x0300)
      int iIndent;
  #endif
  #if (_WIN32_WINNT >= 0x560)
      int iGroupId;
      UINT cColumns; // tile view columns
      PUINT puColumns;
  #endif
  #if (_WIN32_WINNT >= 0x0600)
      int* piColFmt;
      int iGroup;
  #endif
  } LVITEM, *LPLVITEM;
 
  */
  OnGetDispInfo(pnmv)
 {
      global
      iItemOffset     := sizeofNMHDR + 4
      iItem           := DecodeInteger( "uint4", pnmv, iItemOffset)
     
      if (iItem < 0 || iItem > g_nMatchCount)
          return  ; requesting invalid item
     
      maskOffset      := sizeofNMHDR + 0
      mask            := DecodeInteger( "uint4", pnmv, maskOffset)
     
      if (mask & LVIF_TEXT)
     {
          iSubItemOffset  := sizeofNMHDR + 8
          iSubItem        := DecodeInteger( "uint4", pnmv, iSubItemOffset)
         
          pszTextOffset   := sizeofNMHDR + 20
          pszText         := DecodeInteger( "uint4", pnmv, pszTextOffset)
         
          If (g_MatchIndices = -1)
              nIndex := iItem + 1
          else
              nIndex := NumGet(g_MatchIndices, iItem * 4)
             
          ;ToolTip, Row %iItem% Index in list %nIndex%
         
          pstrText := 0
          if (0 == iSubItem)
              pstrText := &g_arrResult%nIndex%_Name
          Else if (1 == iSubItem)
              pstrText := &g_arrResult%nIndex%_Folder
          Else if (2 == iSubItem)
              pstrText := &g_arrResult%nIndex%_Modified
          Else if (3 == iSubItem)
              pstrText := &g_arrResult%nIndex%_SizeKB
          Else if (4 == iSubItem)
              pstrText := &g_arrResult%nIndex%_Ext
          EncodeInteger( pstrText, 4, pnmv, pszTextOffset )
      }
      if (mask & LVIF_STATE)
     {
          stateOffset := sizeofNMHDR + 12
          EncodeInteger( 0, 4, pnmv, stateOffset )
      }
      if (mask & LVIF_IMAGE)
	  {
          iImageOffset := sizeofNMHDR + 28
          EncodeInteger( -1, 4, pnmv, iImageOffset )
      }
  }
 
  LoadFolder(ByRef strFolder, arrResultName, ByRef strExtInclude = "", ByRef strExtExclude = "", bRecursive = true)
 {
      global  ; This is important for creating/accessing array
      nTotalFiles := 0
      nIndex := g_nFilesCount+1
     
      ; Check if the last character of the folder name is a backslash, which happens for root
      ; directories such as C:\. If it is, remove it to prevent a double-backslash later on.
      StringRight, LastChar, strFolder, 1
      if LastChar = \
          StringTrimRight, strFolder, strFolder, 1  ; Remove the trailing backslash.
 
      ; Ensure the variable has enough capacity to hold the longest file path. This is done
      ; because ExtractAssociatedIconA() needs to be able to store a new filename in it.
      VarSetCapacity(Filename, 260)
      sfi_size = 352
      VarSetCapacity(sfi, sfi_size)
 
      ; Gather a list of file names from the folder
      Loop %strFolder%\*.*, 0, %bRecursive%
     {
          ;MsgBox %A_LoopFileName%
         
          ; filter out
          If (strExtExclude != "")
         {
             if A_LoopFileExt in %strExtExclude%
             {
                 Continue
             }
         }
         If (strExtInclude != "")
         {
             if A_LoopFileExt not in %strExtInclude%
             {
                  Continue
              }
          }
         
          ; Name|In Folder|Modified|Size (KB)|Type
          FormatTime, FileTimeModified, %A_LoopFileTimeModified% LSys R D1    ;, MM/dd/yyyy HH:mm
         
          ToWideChar(A_LoopFileName, %arrResultName%%nIndex%_Name)
          ToWideChar(A_LoopFileExt, %arrResultName%%nIndex%_Ext)
          ToWideChar(A_LoopFileDir, %arrResultName%%nIndex%_Folder)
          ToWideChar(FileTimeModified, %arrResultName%%nIndex%_Modified)
          ToWideChar(A_LoopFileSizeKB, %arrResultName%%nIndex%_SizeKB)
         
          ; We need this for pattern matching
          %arrResultName%%nIndex%_NameAnsi := A_LoopFileName
          %arrResultName%%nIndex%_FolderAnsi := A_LoopFileDir
         
          ++nIndex
          ++nTotalFiles
          ++g_nFilesCount
      }
      return nTotalFiles
  }
 
  #IfWinActive ahk_class AutoHotkeyGUI
  ~Up::
  ~+Up::
      IfWinNotActive, ahk_id %g_hMainWnd%,
     {
          Send, {Up}
          Return
      }
     
      GuiControl, Focus, SysListView321,
      ;ControlSend, SysListView321, {Up}, %g_hMainWnd%
  Return
 
  ~Down::
  ~+Down::
      IfWinNotActive, ahk_id %g_hMainWnd%,
     {
          Send, {Down}
          Return
      }
     
      GuiControl, Focus, SysListView321,
      ;ControlSend, SysListView321, {Down}, %g_hMainWnd%
  Return
  #IfWinActive
 
  ;;;;;;;;;;;;;;;;;;; Helper Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
  ListView_RedrawItems(hwndLV, iFirst, iLast)
 {
     global LVM_REDRAWITEMS
     SendMessage, LVM_REDRAWITEMS, iFirst, iLast, , ahk_id %hwndLV%
     return %ErrorLevel%
 }

 ListView_SetItemCount(hwndLV, cItems)
 {
     global LVM_SETITEMCOUNT, LVSICF_NOINVALIDATEALL
     SendMessage, LVM_SETITEMCOUNT, cItems, LVSICF_NOINVALIDATEALL, , ahk_id %hwndLV%
     return %ErrorLevel%
 }

 TransformWideCharToMultiByte(pWideChar, nWideCharNumber)
 {
     Global CP_ACP
     nRequiredSize := WideCharToMultiByte(CP_ACP, 0, pWideChar, nWideCharNumber, 0, 0, 0, 0)
     if(nRequiredSize > 0)
     {
          VarSetCapacity( pMultiByteBuffer, nRequiredSize, 0 )
          nBytesWritten := WideCharToMultiByte(CP_ACP, 0, pWideChar, nWideCharNumber, &pMultiByteBuffer, nRequiredSize, 0, 0)
          return pMultiByteBuffer
      }
      return 0
  }
 
  TransformMultiByteToWideChar(pMultiByte, ByRef pWideCharBuffer)
 {
     Global CP_ACP
     nRequiredSize := MultiByteToWideChar(CP_ACP, 0, pMultiByte, -1, 0, 0)
     if(nRequiredSize > 0)
     {
         VarSetCapacity( pWideCharBuffer, nRequiredSize<<1, 0 )
         nBytesWritten := MultiByteToWideChar(CP_ACP, 0, pMultiByte, -1, &pWideCharBuffer, nRequiredSize)
         return nBytesWritten
     }
     return -1
 }

 ToWideChar(strAnsiText, ByRef strUnicodeText)
 {
     nStrLen := StrLen(strAnsiText)
     VarSetCapacity(strUnicodeText, (nStrLen+1)*2, 0)
     TransformMultiByteToWideChar(&strAnsiText, strUnicodeText)
     Return strUnicodeText
 }

 WideCharToMultiByte(CodePage, dwFlags, lpWideCharStr, cchWideChar, lpMultiByteStr, cbMultiByte, lpDefaultChar, lpUsedDefaultChar)
 {
     global pWideCharToMultiByte
     return DllCall(pWideCharToMultiByte, "UInt", CodePage, "UInt", dwFlags, "UInt", lpWideCharStr, "Int", cchWideChar, "UInt", lpMultiByteStr, "Int", cbMultiByte, "UInt", lpDefaultChar, "UInt", lpUsedDefaultChar)
 }

 MultiByteToWideChar(CodePage, dwFlags, lpMultiByteStr, cbMultiByte, lpWideCharStr, cchWideChar)
 {
     global pMultiByteToWideChar
     return DllCall(pMultiByteToWideChar, "UInt", CodePage, "UInt", dwFlags, "UInt", lpMultiByteStr, "Int", cbMultiByte, "UInt", lpWideCharStr, "Int", cchWideChar)
 }

 DecodeInteger( p_type, p_address, p_offset, p_hex=true )
 {
   old_FormatInteger := A_FormatInteger
   ifEqual, p_hex, 1, SetFormat, Integer, hex
   else, SetFormat, Integer, dec
   StringRight, size, p_type, 1
   loop, %size%
       value += *( ( p_address+p_offset )+( A_Index-1 ) ) << ( 8*( A_Index-1 ) )
   if ( size <= 4 and InStr( p_type, "u" ) != 1 and *( p_address+p_offset+( size-1 ) ) & 0x80 )
       value := -( ( ~value+1 ) & ( ( 2**( 8*size ) )-1 ) )
   SetFormat, Integer, %old_FormatInteger%
   return, value
 }

 EncodeInteger( p_value, p_size, p_address, p_offset )
 {
     global pRtlFillMemory
     loop, %p_size%
         DllCall( pRtlFillMemory, "uint", p_address+p_offset+A_Index-1, "uint", 1, "uchar", p_value >> ( 8*( A_Index-1 ) ) )
 }

 GetProcAddressInModule(strFuncName, strModuleName = "kernel32")
 {
     return DllCall("GetProcAddress", uint, DllCall("GetModuleHandle", str, strModuleName), str, strFuncName)
 }