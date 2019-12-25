
LV = SysListView321   ;set the controls to use
ED = Edit1
ST = Static1
FontSize = 10
g_GuiID =                               ;; 存放窗口GuiID

EnableSingleClick = 1   ;whether or not to do cell highlighting on singleclick

SysGet,SM_CXVSCROLL,2         ;get width of vertical scrollbar
LVIR_LABEL = 0x0002            ;LVM_GETSUBITEMRECT constant - get label info
LVM_GETITEMCOUNT = 4100      ;gets total number of rows
LVM_SCROLL = 4116               ;scrolls the listview
LVM_GETTOPINDEX = 4135      ;gets the first displayed row
LVM_GETCOUNTPERPAGE = 4136   ;gets number of displayed rows
LVM_GETSUBITEMRECT = 4152   ;gets cell width,height,x,y

LVS_SINGLESEL = 0x4                     ;allow one item to be selected
LVS_SHOWSELALWAYS = 0x8               ;shows selection highlighting even if no focus
LVS_EX_FULLROWSELECT = LV0x20         ;whole row selection

listOptions =
   (Join`s LTrim
      +AltSubmit
      -Checked
      +Grid
      -%LVS_EX_FULLROWSELECT%
      -%LVS_SHOWSELALWAYS%
      +%LVS_SINGLESEL%
   )

AutoTrim,Off   
DetectHiddenWindows,On
Gui,+LastFound
g_GuiID := WinExist()   ;get id for gui
GroupAdd,editKeypress,ahk_id %g_GuiID%   ;for ENTER and ESC handling
Gui, Font, s%FontSize%, Arial   ;set font for listview1,static1 and edit1
Gui, Add, ListView, r20 w525 %listOptions% v_MyListView g【点击MyListView】, Name|Modified|FullPath   ;make listview
Gui, Add, Edit, x0 y-50 vCellEdit   ;make edit control
Gui, Add, Text, x0 y-50 vCellHighlight +Border cBlue -Wrap   ;make static1 control
ControlGetPos,lx,ly,lw,lh,%LV%,ahk_id %g_GuiID%   ;get info on listview

;********just to fill the listview********
; Gather a list of file names from a folder and put them into the ListView:
Loop, %A_MyDocuments%\*.*
{   If A_Index>40
      Break
   LV_Add("", A_LoopFileName, A_LoopFileTimeModified, A_LoopFileLongPath)
}
LV_ModifyCol()   ;autosize columns

Gui, Show
Return

;TODO:
;singleclick in listview not reliable - find another way other than "Normal" maybe "C" with other condition
;can't highlight text in edit1 with mouse, just calls 【点击MyListView】
;maybe use arrow keys with a static control cell overlay to emulate cell highlighting? - partially done

【点击MyListView】:
   CoordMode,MOUSE,RELATIVE
   MouseGetPos,mx,my,oID,oCNN
   If(A_GuiEvent = "DoubleClick")
   {   Gosub doubleclick
   }
   Else If(A_GuiEvent = "Normal" )
   {   	
   		if ( DispControl == ED && mx > edX && mx < ( edx + edW ) && my > edY && my < ( edy + edH ) ) 
   		{
   			click
   		}
   		else if EnableSingleClick
   			Gosub singleclick
   }
   Else If A_GuiEvent In S,s,RightClick,ColClick,D,d,e      ;hide edit on these events
   {   
   		msgbox A_GuiEvent[%A_GuiEvent%]
   		GuiControl,Hide,%ST%   ;hide static control
       	GuiControl,Hide,%ED%   ;hide edit control
   }
   
Return

doubleclick:
   GuiControl,Hide,%ED%   ;hide edit control
   GuiControl,Hide,%ST%   ;hide static control
   DispControl := ED      ;make edit1 the default control
   spacer =
   Gosub CellInfo
   Gosub CellReSize
   Gosub CellPosition
   GuiControl,Focus,%DispControl%   ;set focus   
   SetTimer,isEditFocused,75   ;start edit focus monitor
Return

singleclick:
   GuiControl,Hide,%ED%   ;hide edit control
   GuiControl,Hide,%ST%   ;hide edit control
   DispControl := ST   ;make static1 the default control
   spacer = %A_Space%
   Gosub CellInfo
   Gosub CellReSize
   Gosub CellPosition
   GuiControl,Focus,%LV%   ;set focus   
Return

;*************************cell size and position stuff******************************
CellInfo:
   SendMessage,LVM_GETITEMCOUNT,0,0,%LV%,ahk_id %g_GuiID%
   TotalNumOfRows := ErrorLevel   ;get total number of rows
   SendMessage,LVM_GETCOUNTPERPAGE,0,0,%LV%,ahk_id %g_GuiID%
   NumOfRows := ErrorLevel   ;get number of displayed rows
   SendMessage,LVM_GETTOPINDEX,0,0,%LV%,ahk_id %g_GuiID%
   topIndex := ErrorLevel   ;get first displayed row
   
   VarSetCapacity(XYstruct, 16, 0)   ;create struct
   Loop,%NumOfRows%   ;gets the current row, and cell Y,H
   {   which := topIndex + A_Index -1   ;loop through each displayed row
      InsertInteger(LVIR_LABEL   ,XYstruct,0)   ;get label info constant
      InsertInteger(A_Index-1   ,XYstruct,4)   ;subitem index
      SendMessage,LVM_GETSUBITEMRECT,%which%,&XYstruct,%LV%,ahk_id %g_GuiID%   ;get cell coords
      RowY     := ExtractInteger(XYstruct,4,4) + ly   ;row upperleft y = itempos y + listview y
      RowY2    := ExtractInteger(XYstruct,12,4) + ly   ;row bottomright y2 = itempos y2 + listview y
      currColHeight := RowY2 - RowY ;get cell height
      If(my <= RowY + currColHeight)   ;if mouse Y pos less than row pos + height
      {   currRow    := which   +1   ;1-based current row
         currRow0   := which      ;0-based current row
         Break
      }
   }
   
   VarSetCapacity(XYstruct, 16, 0)   ;create struct
   Loop % LV_GetCount("Col")   ;gets the current column, and cell X,W
   {   InsertInteger(LVIR_LABEL   ,XYstruct,0)   ;get label info constant
      InsertInteger(A_Index-1   ,XYstruct,4)   ;subitem index
      SendMessage,LVM_GETSUBITEMRECT,%currRow0%,&XYstruct,%LV%,ahk_id %g_GuiID%   ;get cell coords
      RowX    := ExtractInteger(XYstruct,0,4) + lx   ;row upperleft x = itempos x + listview x
      RowX2    := ExtractInteger(XYstruct,8,4) + lx   ;row bottomright x2 = itempos x2 + listview x
      currColWidth := RowX2 - RowX   ;get cell width
      If(mx <= RowX + currColWidth)   ;if mouse X pos less than column pos+width
      {   currCol := A_Index   ;get current column number
         Break
      }
   }
Return

CellReSize:
   If(RowX < lx)   ;make sure the cell is in view, then get the cell x coord again if it wasn't
   {   hscrollVal := RowX - lx - 4    ;get the difference
      SendMessage,LVM_SCROLL,%hscrollVal%,0,%LV%,ahk_id %g_GuiID%   ;scroll the column into view
      VarSetCapacity(XYstruct, 16, 0)   ;recreate struct
      InsertInteger(LVIR_LABEL   ,XYstruct,0)   ;get just label coords
      InsertInteger(currCol-1      ,XYstruct,4)   ;1-based subitem index
      SendMessage,LVM_GETSUBITEMRECT,%currRow0%,&XYstruct,%LV%,ahk_id %g_GuiID%   ;get cell coords
      RowX    := ExtractInteger(XYstruct,0,4) + lx   ;row upperleft x = itempos x + listview x
   }
   
   scrollWidth := TotalNumOfRows > NumOfRows ? SM_CXVSCROLL : 0   ;0 if no vscroll, else = SM_CXVSCROLL
   If(RowX+currColWidth > lx+lw-scrollWidth)   ;if edit will be too wide, shrink it
   {   currColWidth -= ((RowX+currColWidth) - (lx+lw-scrollWidth)) + 3
   }
Return

CellPosition:
   CellX_LV := currCol                           ;get cell column
   CellY_LV := currRow                           ;get cell row
   LV_GetText(coltxt,CellY_LV,CellX_LV)         ;get the text
   edW := currColWidth                        ;get control width
   edH := currColHeight + 1                     ;get control height
   edX := RowX + 2                              ;get control x pos
   edY := RowY + 1                              ;get control y pos
   ControlMove,%DispControl%,edX,edY,edW,edH   ;move and size control
   GuiControl,,%DispControl%,%spacer%%colTxt%            ;set the text
   GuiControl,Show,%DispControl%                  ;show control
Return

CellHide:
   GuiControl,Hide,%DispControl%
   ;GuiControl,Focus,%ED%   ;set focus   
Return
;*************************end cell size and position stuff******************************

isEditFocused:
   GuiControlGet,cFoc,Focus
   If(cFoc != DispControl)
   {   SetTimer,isEditFocused,Off
      Gosub CellHide
   }
Return

guiClose:
   ExitApp
Return

#IfWinActive ahk_group editKeypress
Enter::
   GuiControlGet,fControl,Focus   ;get control with focus
   If(fControl = DispControl)   ;if Edit, save any changes
   {   Gui,Submit,NoHide
      CellX_save = Col%CellX_LV%
      LV_Modify(CellY_LV,CellX_save,CellEdit)
      Gosub CellHide
   }
Return

Esc::
   Gosub CellHide   ;cancel
Return





InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4)
; The caller must ensure that pDest has sufficient capacity.  To preserve any existing contents in pDest,
; only pSize number of bytes starting at pOffset are altered in it.
{
    Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data.
        DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF)
}

ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4)
; pSource is a string (buffer) whose memory area contains a raw/binary integer at pOffset.
; The caller should pass true for pSigned to interpret the result as signed vs. unsigned.
; pSize is the size of PSource's integer in bytes (e.g. 4 bytes for a DWORD or Int).
; pSource must be ByRef to avoid corruption during the formal-to-actual copying process
; (since pSource might contain valid data beyond its first binary zero).
{
    Loop %pSize%  ; Build the integer by adding up its bytes.
        result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1)
    if (!pIsSigned OR pSize > 4 OR result < 0x80000000)
        return result  ; Signed vs. unsigned doesn't matter in these cases.
    ; Otherwise, convert the value (now known to be 32-bit) to its signed counterpart:
    return -(0xFFFFFFFF - result + 1)
}