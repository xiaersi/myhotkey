#Persistent  ; Keep this script running until the user explicitly exits it.
SetTimer, WatchAxis2, 5
return

WatchAxis2:
GetKeyState, JoyX, 2JoyX  ; Get position of X axis.
GetKeyState, JoyY, 2JoyY  ; Get position of Y axis.
KeyToHoldDownPrev = %KeyToHoldDown%  ; Prev now holds the key that was down before (if any).

if JoyX > 70
    KeyToHoldDown = Right
else if JoyX < 30
    KeyToHoldDown = Left
else if JoyY > 70
    KeyToHoldDown = Down
else if JoyY < 30
    KeyToHoldDown = Up
else
    KeyToHoldDown =

if KeyToHoldDown = %KeyToHoldDownPrev%  ; The correct key is already down (or no key is needed).
    return  ; Do nothing.

; Otherwise, release the previous key and press down the new key:
SetKeyDelay -1  ; Avoid delays between keystrokes.
if KeyToHoldDownPrev   ; There is a previous key to release.
    Send, {%KeyToHoldDownPrev% up}  ; Release it.
if KeyToHoldDown   ; There is a key to press down.
    Send, {%KeyToHoldDown% down}  ; Press it down.
return



2Joy1::
Send {numpad4 down}  ; Hold down the left-arrow key.
KeyWait 2Joy1  ; Wait for the user to release the joystick button.
Send {numpad4 up}  ; Release the left-arrow key.
return


2joy6::
Send {numpad4 down}  ; Hold down the left-arrow key.
KeyWait 2Joy6  ; Wait for the user to release the joystick button.
Send {numpad4 up}  ; Release the left-arrow key.
return

2Joy2::
Send {numpad5 down}  ; Hold down the left-arrow key.
KeyWait 2Joy2  ; Wait for the user to release the joystick button.
Send {numpad5 up}  ; Release the left-arrow key.
return


2joy8::
Send {numpad5 down}  ; Hold down the left-arrow key.
KeyWait 2Joy8  ; Wait for the user to release the joystick button.
Send {numpad5 up}  ; Release the left-arrow key.
return