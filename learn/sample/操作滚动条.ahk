#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
;---------------------------------------------------------------------------------------------------------------

;This creates a GUI main window a vertical scrollbar
Gui, +0x200000             ; 0x200000 = WS_VSCROLL

;This creates an Edit control with its own vertical scrollbar (with initial state affected by its choice of contents)
Gui, Add, Edit, VScroll h100 yp+20, 1`n2`n3`n4`n5`n6`n7`n8`n9`n10`n11`n12`n

;Provide a button to get the scrollbar's state - you can't properly set a control-based scrollbar's state using
;   SetScrollInfo.
Gui, Add, Button, gButtonQueryScrollbar xp+60 yp, Get Scrollbar`nState

Gui, Show, w300 h200


;Get main window's handle
Process, Exist
nThisScriptPID := ErrorLevel
WinGet, hMainGUIHwnd, ID, ahk_pid %nThisScriptPID%

;Get handle of Edit control
ControlGet, hEditControlHwnd, Hwnd, , Edit1, Copy of New AutoHotkey Script.ahk

;A user-choice for which window handle to use (Edit control's scrollbar or main window's scrollbar)
hHwnd := hMainGUIHwnd
;hHwnd := hEditControlHwnd

;Allocate and initialize SCROLLINFO structure
Gosub, CreateScrollInfo

;Initialize the scrollbar's state:  nMin, nMax, nPage, nPos
bSuccess := SetScrollBar(hHwnd, 0, 100, 10, 48)

;Set up message handler for scrollbar events
OnMessage(0x115, "DoVScroll")      ; WM_VSCROLL = 0x115

return

;---------------------------------------------------------------------------------------------------------------
CreateScrollInfo:
   ;Re-use this SCROLLINFO structure for get/set of scrollbar state

   VarSetCapacity(SCROLLBAR_INFO, 28, 0)   ;Allocate SCROLLBAR_INFO structure and zero it
   NumPut(28, &SCROLLBAR_INFO)         ;Initialize its count-bytes parameter
   NumPut(0x17, &SCROLLBAR_INFO + 4)      ;Initialize the mask for what properties to get or set, SIF_ALL = 0x17
return
;---------------------------------------------------------------------------------------------------------------
/*
---------------------------------------------------------------------------------------------------------------
The WM_VSCROLL message is sent to a window when a scroll event occurs in the window's standard vertical scroll
   bar. This message is also sent to the owner of a vertical scroll bar control when a scroll event occurs in
   the control. 

wParam
   The high-order word specifies the current position of the scroll box if the low-order word is
      SB_THUMBPOSITION or SB_THUMBTRACK; otherwise, this word is not used.
   The low-order word specifies a scroll bar value that indicates the user's scrolling request. This parameter
      can be one of the following values:

  SB_BOTTOM = 7
    Scrolls to the lower right.
  SB_ENDSCROLL = 8
    Ends scroll.
  SB_LINEDOWN = 1
    Scrolls one line down.
  SB_LINEUP = 0
    Scrolls one line up.
  SB_PAGEDOWN = 3
    Scrolls one page down.
  SB_PAGEUP = 2
    Scrolls one page up.
  SB_THUMBPOSITION = 4
    The user has dragged the scroll box (thumb) and released the mouse button. The high-order word indicates
       the position of the scroll box at the end of the drag operation.
  SB_THUMBTRACK = 5
    The user is dragging the scroll box. This message is sent repeatedly until the user releases the mouse
       button. The high-order word indicates the position that the scroll box has been dragged to.
  SB_TOP = 6
    Scrolls to the upper left.

lParam
   If the message is sent by a scroll bar, this parameter is the handle to the scroll bar control. If the
      message is not sent by a scroll bar, this parameter is NULL. 

Return Value
   If an application processes this message, it should return zero.
---------------------------------------------------------------------------------------------------------------
*/
;---------------------------------------------------------------------------------------------------------------
DoVScroll(wParam, lParam, msg, hwnd)         ;Window message handler for WM_VSCROLL
{
   global hHwnd      ;Only handle messages for the window we want to scroll
   if (hwnd != hHwnd)
      return

   wParamWordLow := Mod(wParam, 0x10000)
   wParamWordHigh := (wParam - wParamWordLow) / 0x10000

   if (wParamWordLow = 5 or wParamWordLow = 8)      ;SB_THUMBTRACK or SB_ENDSCROLL
      return 0

   QueryScrollBar(hwnd, nMin, nMax, nPage, nPos, nTrackPos)

   if (wParamWordLow = 7)            ;SB_BOTTOM
      MsgBox, SB_BOTTOM
   else if (wParamWordLow = 6)            ;SB_TOP
      MsgBox, SB_TOP
   else if (wParamWordLow = 1)            ;SB_LINEDOWN
      SetScrollBar(hwnd, nMin, nMax, nPage, nPos+1)
   else if (wParamWordLow = 0)            ;SB_LINEUP
      SetScrollBar(hwnd, nMin, nMax, nPage, nPos-1)
   else if (wParamWordLow = 3)            ;SB_PAGEDOWN
      SetScrollBar(hwnd, nMin, nMax, nPage, nPos+nPage)
   else if (wParamWordLow = 2)            ;SB_PAGEUP
      SetScrollBar(hwnd, nMin, nMax, nPage, nPos-nPage)
   else if (wParamWordLow = 4)            ;SB_THUMBPOSITION
      SetScrollBar(hwnd, nMin, nMax, nPage, wParamWordHigh)

   return 0
}
;---------------------------------------------------------------------------------------------------------------
ButtonQueryScrollbar:
	hHwnd := hEditControlHwnd
   QueryScrollBar(hHwnd, nMin, nMax, nPage, nPos, nTrackPos)
   MsgBox, nMin:%nMin%, nMax:%nMax%, nPage:%nPage%, nPos:%nPos%
return
;---------------------------------------------------------------------------------------------------------------
QueryScrollBar(hwnd, ByRef nMin, ByRef nMax, ByRef nPage, ByRef nPos, ByRef nTrackPos)
{
   ;Win32 API:   BOOL GetScrollInfo( HWND hwnd, int fnBar, LPSCROLLINFO lpsi )

   global SCROLLBAR_INFO

   bSuccess := DllCall("GetScrollInfo", UInt, hwnd, Int, 1, UInt, &SCROLLBAR_INFO)   ;SB_VERT = 1
   if (!bSuccess)
      return false

   nMin := NumGet(&SCROLLBAR_INFO, 8)
   nMax := NumGet(&SCROLLBAR_INFO, 12)
   nPage := NumGet(&SCROLLBAR_INFO, 16)
   nPos := NumGet(&SCROLLBAR_INFO, 20)
   nTrackPos := NumGet(&SCROLLBAR_INFO, 24)

   return true
}
;---------------------------------------------------------------------------------------------------------------
SetScrollBar(hwnd, nMin, nMax, nPage, nPos)
{
   ;Win32 API:   int SetScrollInfo( HWND hwnd, int fnBar, LPCSCROLLINFO lpsi, BOOL fRedraw )

   global SCROLLBAR_INFO
   NumPut(nMin, &SCROLLBAR_INFO + 8)      ;Min
   NumPut(nMax, &SCROLLBAR_INFO + 12)      ;Max
   NumPut(nPage, &SCROLLBAR_INFO + 16)      ;Page
   NumPut(nPos, &SCROLLBAR_INFO + 20)      ;Pos
   iReturnPos := DllCall("SetScrollInfo", UInt, hwnd, Int, 1, UInt, &SCROLLBAR_INFO, Int, true)   ;SB_VERT = 1
   return (iReturnPos == nPos)
}
;---------------------------------------------------------------------------------------------------------------
GuiClose:
   ExitApp
return
;---------------------------------------------------------------------------------------------------------------

