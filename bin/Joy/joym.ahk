; Using a Joystick as a Mouse
; http://www.autohotkey.com
; This script converts a joystick into a three-button mouse.  It allows each
; button to drag just like a mouse button and it uses virtually no CPU time.
; Also, it will move the cursor faster depending on how far you push the joystick
; from center. You can personalize various settings at the top of the script.

; Increase the following value to make the mouse cursor move faster:
JoyMultiplier = 0.30

; Decrease the following value to require less joystick displacement-from-center
; to start moving the mouse.  However, you may need to calibrate your joystick
; -- ensuring it's properly centered -- to avoid cursor drift. A perfectly tight
; and centered joystick could use a value of 1:
JoyThreshold = 2

; Change the following to true to invert the Y-axis, which causes the mouse to
; move vertically in the direction opposite the stick:
InvertYAxis := false

; Change these values to use joystick button numbers other than 1, 2, and 3 for
; the left, right, and middle mouse buttons.  Available numbers are 1 through 32.
; Use the Joystick Test Script to find out your joystick's numbers more easily.
ButtonLeft = 6
ButtonRight = 8
ButtonMiddle = 7
EnterKey = 9
LeftKey = 4
RightKey = 2
UpKey = 1
DownKey = 3
SelectKey = 5
; If your joystick has a POV control, you can use it as a mouse wheel.  The
; following value is the number of milliseconds between turns of the wheel.
; Decrease it to have the wheel turn faster:
WheelDelay = 250

; If your system has more than one joystick, increase this value to use a joystick
; other than the first:
JoystickNumber = 2

; END OF CONFIG SECTION -- Don't change anything below this point unless you want
; to alter the basic nature of the script.

#SingleInstance


JoystickPrefix = %JoystickNumber%Joy
Hotkey, %JoystickPrefix%%ButtonLeft%, ButtonLeftClick
Hotkey, %JoystickPrefix%%ButtonRight%, ButtonRightClick
Hotkey, %JoystickPrefix%%ButtonMiddle%, ButtonMiddleClick
Hotkey, %JoystickPrefix%%UpKey%, ButtonUp
Hotkey, %JoystickPrefix%%DownKey%, ButtonDown
Hotkey, %JoystickPrefix%%LeftKey%, ButtonLeft
Hotkey, %JoystickPrefix%%RightKey%, ButtonRight


; Calculate the axis displacements that are needed to start moving the cursor:
JoyThresholdUpper := 50 + JoyThreshold
JoyThresholdLower := 50 - JoyThreshold
if InvertYAxis
	YAxisMultiplier = -1
else
	YAxisMultiplier = 1

SetTimer, WatchJoystick, 10  ; Monitor the movement of the joystick.

GetKeyState, JoyInfo, %JoystickNumber%JoyInfo
IfInString, JoyInfo, P  ; Joystick has POV control, so use it as a mouse wheel.
	SetTimer, MouseWheel, %WheelDelay%

return  ; End of auto-execute section.


; The subroutines below do not use KeyWait because that would sometimes trap the
; WatchJoystick quasi-thread beneath the wait-for-button-up thread, which would
; effectively prevent mouse-dragging with the joystick.

ButtonLeftClick:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{	; shift + 
		Send {shift down}{lbutton down}  ; Hold down the left-arrow key.
		KeyWait %JoystickPrefix%%SelectKey%  ; Wait for the user to release the joystick button.
		Send {lbutton up}{shift up}  ; Release the left-arrow key.
	}
	else 
	{
		SetMouseDelay, -1  ; Makes movement smoother.
		MouseClick, left,,, 1, 0, D  ; Hold down the left mouse button.
		SetTimer, WaitForLeftButtonUp, 10
	}
	return

ButtonRightClick:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{
;		send {pgdn}
		send !{tab}
	}
	else 
	{
		SetMouseDelay, -1  ; Makes movement smoother.
		MouseClick, right,,, 1, 0, D  ; Hold down the right mouse button.
		SetTimer, WaitForRightButtonUp, 10
	}
	return

ButtonMiddleClick:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{
		WinGetClass var_class,A
		if var_class = MozillaUIWindowClass 
			send ^w	; firefox关闭当前标签
		else if var_class = IEFrame 
			send ^w	; IE关闭当前标签
		else if var_class = Container
			send ^w	; 世界之窗3关闭当前标签
		else 
		{
			send {enter}
		}	
	}
	else 
	{
		SetMouseDelay, -1  ; Makes movement smoother.
		MouseClick, middle,,, 1, 0, D  ; Hold down the right mouse button.
		SetTimer, WaitForMiddleButtonUp, 10
	}
	return

WaitForLeftButtonUp:
	if GetKeyState(JoystickPrefix . ButtonLeft)
		return  ; The button is still, down, so keep waiting.
	; Otherwise, the button has been released.
	SetTimer, WaitForLeftButtonUp, off
	SetMouseDelay, -1  ; Makes movement smoother.
	MouseClick, left,,, 1, 0, U  ; Release the mouse button.
	return

WaitForRightButtonUp:
	if GetKeyState(JoystickPrefix . ButtonRight)
		return  ; The button is still, down, so keep waiting.
	; Otherwise, the button has been released.
	SetTimer, WaitForRightButtonUp, off
	MouseClick, right,,, 1, 0, U  ; Release the mouse button.
	return

WaitForMiddleButtonUp:
	if GetKeyState(JoystickPrefix . ButtonMiddle)
		return  ; The button is still, down, so keep waiting.
	; Otherwise, the button has been released.
	SetTimer, WaitForMiddleButtonUp, off
	MouseClick, middle,,, 1, 0, U  ; Release the mouse button.
	return

WatchJoystick:
	MouseNeedsToBeMoved := false  ; Set default.
	SetFormat, float, 03
	GetKeyState, joyx, %JoystickNumber%JoyX
	GetKeyState, joyy, %JoystickNumber%JoyY
	if joyx > %JoyThresholdUpper%
	{
		MouseNeedsToBeMoved := true
		movexcount ++
		DeltaX := joyx - JoyThresholdUpper
	}
	else if joyx < %JoyThresholdLower%
	{
		MouseNeedsToBeMoved := true
		movexcount ++
		DeltaX := joyx - JoyThresholdLower
	}
	else
	{
		DeltaX = 0
		movexcount = 0
	}
	if joyy > %JoyThresholdUpper%
	{
		MouseNeedsToBeMoved := true
		moveycount ++
		DeltaY := joyy - JoyThresholdUpper
	}
	else if joyy < %JoyThresholdLower%
	{
		MouseNeedsToBeMoved := true
		moveycount ++
		DeltaY := joyy - JoyThresholdLower
	}
	else
	{
		DeltaY = 0
		moveycount = 0
	}
;	if MouseNeedsToBeMoved and 
	if (movexcount=1 or movexcount > 9 or moveycount=1 or moveycount > 9)
	{
		SetMouseDelay, -1  ; Makes movement smoother.
		
		MouseMove, DeltaX * JoyMultiplier, DeltaY * JoyMultiplier * YAxisMultiplier, 0, R
	}
	return

MouseWheel:
	GetKeyState, JoyPOV, %JoystickNumber%JoyPOV
	if JoyPOV = -1  ; No angle.
		return
	if (JoyPOV > 31500 or JoyPOV < 4500)  ; Forward
		Send {WheelUp}
	else if JoyPOV between 13500 and 22500  ; Back
		Send {WheelDown}
	return


ButtonUp:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{
		Send {pgup down}  
		KeyWait %JoystickPrefix%%UpKey%
		Send {pgup up} 
	}
	else 
	{
		Send {up down}  
		KeyWait %JoystickPrefix%%UpKey%
		Send {up up} 
	}
	return
ButtonDown:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{
		Send {pgdn down}  
		KeyWait %JoystickPrefix%%DownKey%
		Send {pgdn up} 
	}
	else 
	{
		Send {down down}  
		KeyWait %JoystickPrefix%%DownKey%
		Send {down up} 
	}
	return
ButtonLeft:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{
		WinGetClass var_class,A
		if var_class = MozillaUIWindowClass
			send ^{pgup}	; firefox 中向左切换标签
		else if var_class = Container
			send !{up}		; 世界之窗3.0 向左切换标签
		else 
		{
			; Scroll left.
			ControlGetFocus, fcontrol, A
			Loop 10  ; <-- Increase this value to scroll faster.
			    SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINERIGHT.
		}
	}
	else 
	{
		Send {left down}  
		KeyWait %JoystickPrefix%%LeftKey%
		Send {left up} 
	}
	return
ButtonRight:
	GetKeyState, state, %JoystickPrefix%%SelectKey%
	if state = D
	{
		WinGetClass var_class,A
		if var_class = MozillaUIWindowClass
			send ^{pgdn}	; firefox 中向右切换标签
		else if var_class = Container
			send !{down}	; 世界之窗3.0 向右切换标签
		else 
		{
			; Scroll right.
			ControlGetFocus, fcontrol, A
			Loop 10  ; <-- Increase this value to scroll faster.
			    SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINELEFT.
		}
	}
	else 
	{
		Send {right down}  
		KeyWait %JoystickPrefix%%RightKey%
		Send {right up} 
	}
	return
ButtonEnter:
	send {enter}
	return
	
	
2joy9 & 2joy8::
	send {tab}
	return
	
2joy9 & 2joy7::
	send +{tab}
	return