/*���ƣ�
��ס���I�����τ�����M���x����g�[��������֡��YԴ����������ļ��A���ļ���Word��ĈDƬ
�ȣ���Ȼ���c���I���M�Џ��ơ�

ճ�N����ס���I���ţ��c���I���M��ճ�N��

���룺
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

