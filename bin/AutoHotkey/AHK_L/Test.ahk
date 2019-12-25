
arr := object()



ii = 1

arr[2] := 34567
arr[7,"id"] := 123
arr[7,"name"] := "aaaaaaa"
arr[67,"id"] := 222
arr[67,"name"] := "bbbb"
arr[3,"id"] := 333
arr[3,"name"] := "ccc"
arr[177, "id"] := 53
arr[177, "name"] := "cjpp"
;arr[ii, "id"] := 11111
arr[ii, "id", "a"] := 1122
arr[ii, "id", "b"] := 1133
arr[ii, "name"] := "eeeeeeeee"

var_temp := GetObjectText(arr)
msgbox var_temp %var_temp%
return

arr[8] := NewObj(100, "a1", "b2" )
msgbox,% arr.8.100.a . " " arr.8.100.b 
return

MinIndex := arr.MinIndex()
MaxIndex := arr.MaxIndex()
MaxItems := arr.GetCapacity()
ptr := arr.GetAddress(3)
Enum := arr._NewEnum()
b := arr.HasKey(4)

count := arr0
msgbox arr.count := %count%
return

idx := arr[999].MaxIndex() 
if not idx
{
	idx++
	arr[999, idx] := 333
	idx++
	arr[999, idx] := 444
	xxx := arr[999, 1] 
	yyy := arr[999, 2] 
	msgbox arr[999, 1]  = %xxx%`narr[999, 2]  = %yyy%
}

msgbox ( %MinIndex%`, %MaxIndex%`, %MaxItems%`, %b% )
return

/*

for index, element in arr
{
;	MsgBox % "Element number " . index . " is " . element.id . " = " . element.name
	var_id := arr.%index%.id
	var_name := arr.%index%.name
	msgbox,% var_id " " var_name
}
*/



test(arr)

msgbox,% arr.1.id . " " arr.1.name . " `n" . arr.1.id.a . " " . arr.1.id.b


test( o )
{
	o[1, "name"] := "fffffffff"
}


NewObj( key, v1, v2 )
{
	o_ := object()
	o_[key,"a"] := v1
	o_[key,"b"] := v2
	return o_
}



GetObjectText( byref o_, t_=0 )
{
	var_temp = 
	var_tab =
	loop %t_%
	{
		var_tab .= a_tab
	}

	for key, element in o_
	{
	;	msgbox key = %key%
		var_txt = 
		if IsObject(element)
			var_txt := GetObjectText( o_[key], t_+1 )
		else 
			var_txt := var_tab . element
		var_txt = `n%var_tab%[%key%]`n%var_tab%-----------------------------------------------------------`n%var_txt%`n

		var_ret = %var_ret%%var_txt%
	}
	return var_ret
}

