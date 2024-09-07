type stanje = 
  | Zacetno 
  | Prehodno 
  | Stevilsko 
  | Napaka

(* Funkcija za prehod med stanji glede na trenutni znak *)
let prehod trenutno_stanje znak = 
  match trenutno_stanje, znak with
  | Zacetno, ('+' | '-') -> Prehodno  (* Sprejmemo opcijski + ali - znak *)
  | Zacetno, '0'..'9' -> Stevilsko    (* ce ni predznaka, lahko takoj zacne s Stevilkami *)
  | Prehodno, '0'..'9' -> Stevilsko   (* Po predznaku mora slediti Stevilka *)
  | Stevilsko, '0'..'9' -> Stevilsko  (* ce smo Ze v Stevilcnem stanju, ostanemo v njem *)
  | _ -> Napaka                       (* ce pride kaj drugega, gremo v napako *)

(* Glavna funkcija, ki preveri, ali je dani niz veljavno Stevilo *)
let preveri_stevilo niz =
  let dolzina = String.length niz in
  let rec aux i stanje =
    if i >= dolzina then stanje = Stevilsko (* Sprejmemo le, ce je zadnje stanje Stevilsko *)
    else 
      let znak = String.get niz i in
      let novo_stanje = prehod stanje znak in
      aux (i + 1) novo_stanje
  in
  aux 0 Zacetno



let preveri_celostevilske_sekvence niz =
  let dolzina = String.length niz in
  let rec aux i je_celostevilska_sekvenca decimalno_stevilo =
    if i >= dolzina then je_celostevilska_sekvenca
    else
      let znak = String.get niz i in
      if znak >= '0' && znak <= '9' then
        aux (i + 1) true decimalno_stevilo
      else if znak = '.' && not decimalno_stevilo then
        (* Ce najdemo prvo piko, dovolimo le, ce so za njo samo nicle *)
        let rec preveri_nicle j =
          if j >= dolzina then true
          else
            let znak_za_piko = String.get niz j in
            if znak_za_piko = '0' then preveri_nicle (j + 1)
            else false
        in
        if preveri_nicle (i + 1) then aux (i + 1) true true
        else false
      else if je_celostevilska_sekvenca then
        aux (i + 1) false decimalno_stevilo
      else
        aux (i + 1) je_celostevilska_sekvenca decimalno_stevilo
  in
  aux 0 false false



let spremeni_niz niz slovar =
  let dolzina = String.length niz in
  let buffer = Buffer.create dolzina in
  for i = 0 to dolzina - 1 do
    let znak = String.get niz i in
    let stevka = Char.code znak - Char.code '0' in  (* Pretvori znak v celo stevilo *)
    let nova_stevka = Hashtbl.find slovar stevka in  (* Poišče vrednost za stevko iz slovarja *)
    Buffer.add_char buffer (Char.chr (nova_stevka + Char.code '0'))  (* Zamenja števko *)
  done;
  Buffer.contents buffer  (* Vrne nov spremenjen niz *)
