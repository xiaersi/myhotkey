DetectHiddenWindows, on

items := 4

Gui, +Resize

Process, Exist
WinGet, hw_gui, ID, ahk_class AutoHotkeyGUI ahk_pid %ErrorLevel%

Gui, Add, ListView, x5 y5 Report, Icon|Text

h_ImageList := IL_Create( items, 2, 1 )

loop, %items%
   IL_Add( h_ImageList, "D:\Program Files\Greensoft\EmEditor\EmEditor.exe" )

loop, %items%
   LV_Add( "", "Icon" . A_Index, "Text"  . A_Index)

LV_SetImageList( h_ImageList, 1 )

; LVM_GETHEADER
SendMessage, 0x1000+31, 0, 0, SysListView321, ahk_id %hw_gui%
WinGetPos,,,, lv_header_h, ahk_id %ErrorLevel%

VarSetCapacity( rect, 16, 0 )

; LVM_GETITEMRECT
;   LVIR_BOUNDS
SendMessage, 0x1000+14, 0, &rect, SysListView321, ahk_id %hw_gui%

y1 := DecodeInteger( "int4", &rect, 4 )
y2 := DecodeInteger( "int4", &rect, 12 )

lv_row_h := y2-y1

lv_h := 2+lv_header_h+( lv_row_h*items )+2

GuiControl, Move, SysListView321, h%lv_h%

gui_h := 5+lv_h+5

Gui, Show, h%gui_h%
return

DecodeInteger( p_type, p_address, p_offset, p_hex=true )
{
   old_FormatInteger := A_FormatInteger

   if ( p_hex )
      SetFormat, Integer, hex
   else
      SetFormat, Integer, dec
      
   sign := InStr( p_type, "u", false )^1
   
   StringRight, size, p_type, 1
   
   loop, %size%
      value += ( *( ( p_address+p_offset )+( A_Index-1 ) ) << ( 8*( A_Index-1 ) ) )
      
   if ( sign and size <= 4 and *( p_address+p_offset+( size-1 ) ) & 0x80 )
      value := -( ( ~value+1 ) & ( ( 2**( 8*size ) )-1 ) )
       
   SetFormat, Integer, %old_FormatInteger%

   return, value
}