type stanje = 
  | Zacetno 
  | Prehodno 
  | Stevilsko 
  | Napaka

let prehod trenutno_stanje znak = 
  match trenutno_stanje, znak with
  | Zacetno, ('+' | '-') -> Prehodno  
  | Zacetno, '0'..'9' -> Stevilsko    
  | Prehodno, '0'..'9' -> Stevilsko   
  | Stevilsko, '0'..'9' -> Stevilsko  
  | _ -> Napaka                      

let spremeni_stevilo niz slovar =
  let dolzina = String.length niz in
  let buffer = Buffer.create dolzina in
  for i = 0 to dolzina - 1 do
    let znak = String.get niz i in
    let stevka = Char.code znak - Char.code '0' in  
    let nova_stevka = Hashtbl.find slovar stevka in  
    Buffer.add_char buffer (Char.chr (nova_stevka + Char.code '0'))  
  done;
  Buffer.contents buffer

let primerjaj_stevili prvo drugo =
  if prvo = drugo then
    Printf.printf "Spremenjeno prvo število \"%s\" je enako drugemu številu \"%s\".\n" prvo drugo
  else
    Printf.printf "Spremenjeno prvo število \"%s\" NI enako drugemu številu \"%s\".\n" prvo drugo
