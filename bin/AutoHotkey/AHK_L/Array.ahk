CreateArray(ByRef Array,Length,ArrayType="Char",Value="-")
{
	local ELength
	If (ArrayType="Char")
		ELength := 1
	Else If (ArrayType="UInt")
		ELength := 4
	If (Value="-")
	{
		VarSetCapacity(Array,Length * ELength,0)
	}
	Else
	{
		VarSetCapacity(Array,Length * Elength,0)
		Loop,Parse,Value,%A_Space%
		{
			If (A_Index>Length)
				Break
			NumPut(A_LoopField,&Array,(A_Index-1) * ELength,ArrayType)
		}
	}
	Return
}

GetArrayNum(ByRef Array,ArrayType="Char",OffSet=0,GetType="Num")
{
	local RetValue,ELength
	If (ArrayType="Char")
		ELength := 1
	Else If (ArrayType="UInt")
		ELength := 4
	RetValue := NumGet(&Array,OffSet * ELength,ArrayType)
	If (ArrayType="Char" And GetType="Char")
		RetValue := Chr(RetValue)
	Return,RetValue
}

ModifyArray(ByRef Array,NewLength,ArrayType="Char")
{
	local TempArray,OldEELength,ELength
	If (ArrayType="Char")
		ELength := 1
	Else If (ArrayType="UInt")
		ELength := 4
	OldEELength := VarSetCapacity(Array)
	VarSetCapacity(TempArray,NewLength * ELength,0)
	If (OldEELength<(NewLength * ELength))
		DllCall("RtlMoveMemory","UInt",&TempArray,"UInt",&Array,"UInt",OldEELength)
	Else
		DllCall("RtlMoveMemory","UInt",&TempArray,"UInt",&Array,"UInt",NewLength * ELength)
	Array=
	VarSetCapacity(Array,NewLength * ELength,0)
	DllCall("RtlMoveMemory","UInt",&Array,"UInt",&TempArray,"UInt",VarSetCapacity(Array))
	Return
}

SetArrayNum(ByRef Array,ArrayType="Char",OffSet=0,NewValue=0)
{
	local ELength
	If (ArrayType="Char")
		ELength := 1
	Else If (ArrayType="UInt")
		ELength := 4
	If (OffSet * ELength + ELength>VarSetCapacity(Array))
		Return,-1
	Numput(NewValue,&Array,OffSet * ELength,ArrayType)
	Return
}

DeleteArrayNum(ByRef Array,ArrayType="Char",OffSet=0,Length=0)
{
	local TempArray,ELength,OldEELength
	If (Length=0)
		Return
	If (ArrayType="Char")
		ELength := 1
	Else If (ArrayType="UInt")
		ELength := 4
	OldEELength := VarSetCapacity(Array)
	VarSetCapacity(TempArray,OldEELength)
	DllCall("RtlMoveMemory","UInt",&TempArray,"UInt",&Array,"UInt",OldEELength)
	VarSetCapacity(Array,OldEELength - ELength * Length)
	If (OffSet>0)
		DllCall("RtlMoveMemory","UInt",&Array,"UInt",&TempArray,"UInt",OffSet * ELength)
	DllCall("RtlMoveMemory","UInt",ELength * OffSet + &Array,"UInt",ELength * (OffSet + Length) + &TempArray,"UInt",VarSetCapacity(Array) - OffSet * ELength)
	Return
}

