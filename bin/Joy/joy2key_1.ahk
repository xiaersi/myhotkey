#Persistent  ; Keep this script running until the user explicitly exits it.
SetTimer, WatchAxis, 5
return

WatchAxis:
GetKeyState, JoyX, JoyX  ; Get position of X axis.
GetKeyState, JoyY, JoyY  ; Get position of Y axis.
KeyToHoldDownPrev = %KeyToHoldDown%  ; Prev now holds the key that was down before (if any).

if JoyX > 70
    KeyToHoldDown = d	; Right
else if JoyX < 30
    KeyToHoldDown = a	; Left
else if JoyY > 70
    KeyToHoldDown = s 	;Down
else if JoyY < 30
    KeyToHoldDown = w 	;Up
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



Joy1::
Send {u down}  ; Hold down the left-arrow key.
KeyWait Joy1  ; Wait for the user to release the joystick button.
Send {u up}  ; Release the left-arrow key.
return

joy6::
Send {u down}  ; Hold down the left-arrow key.
KeyWait Joy6  ; Wait for the user to release the joystick button.
Send {u up}  ; Release the left-arrow key.
return

Joy2::
Send {i down}  ; Hold down the left-arrow key.
KeyWait Joy2  ; Wait for the user to release the joystick button.
Send {i up}  ; Release the left-arrow key.
return

joy8::
Send {i down}  ; Hold down the left-arrow key.
KeyWait Joy8  ; Wait for the user to release the joystick button.
Send {i up}  ; Release the left-arrow key.
return