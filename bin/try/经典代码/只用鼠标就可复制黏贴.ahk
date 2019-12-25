/*復制：
按住左鍵不放拖動鼠標進行選擇（如瀏覽器里的文字、資源管理器里的文件夾或文件、Word里的圖片
等），然后點右鍵將進行復制。

粘貼：按住右鍵不放，點左鍵將進行粘貼。

代码：
*/
#IfWinNotActive ahk_class ConsoleWindowClass
bAllowOverride := False

~LButton::   
	GetKeyState, keystate, RButton   
	If (keystate = "D")   
	{      
		SendInput {RButton Up} 
		SendInput {Escape}        
		SendInput ^v        
		bAllowOverride := True   
	}   
	Return

RButton:: 
	GetKeyState, keystate, LButton   
	If (keystate = "D")    
	{      
	SendInput {LButton Up}    
	    SendInput ^c       
	bAllowOverride := True      
	Return   
	}    
	SendInput {RButton Down}   
	Return
	
RButton Up::   
	GetKeyState, keystate, LButton    
	If (keystate = "D") 
	{     
	   Return 
	}   
	If (bAllowOverride) 
	{     
	   bAllowOverride := False     
	   Return 
	} 
	SendInput {RButton Up} 
	Return

