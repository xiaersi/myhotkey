	o := ComObjCreate("MSXML2.DOMdocument.6.0")
	o.async := false

;	o.selectSingleNode("/compactdiscs/compactdisc[artist=""Frank Sinatra""]/title").text
	o.selectSingleNode("/date[value=""2012-10-10""]/user").text := 338343

	msgbox % o.selectSingleNode("/date[value=""2012-10-10""]/user").text
