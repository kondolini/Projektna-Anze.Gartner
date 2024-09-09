type stanje_vmesnika =
  | SeznamMoznosti
  | IzbiraNacinaVnosa
  | IzbiraNacinaVnosaDrugo
  | BranjeObehStevil
  | BranjeDrugegaStevila
  | RezultatSpremenjenegaNiza

type msg =
  | VnesiObeStevili of int * int
  | VnesiDrugoStevilo of int
  | ZamenjajVmesnik of stanje_vmesnika
  | IzberiNacinVnosa of string
  | IzberiNacinVnosaDrugo of string
  | GenerirajInPrikaziNakljucnoStevilo

type stanje = 
  | Zacetno 
  | Prehodno 
  | Stevilsko 
  | Napaka

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

let ustvari_slovar () =
  let slovar = Hashtbl.create 10 in
  for i = 0 to 9 do
    let vrednost = 
      let rec get_valid_digit () =
        Printf.printf "Vnesi novo vrednost za stevko %d (0-9): " i;
        let input = read_line () in
        if String.length input = 1 && input.[0] >= '0' && input.[0] <= '9' then
          int_of_string input
        else (
          Printf.printf "Napaka: '%s' ni veljavna števka. Poskusi znova.\n" input;
          get_valid_digit ()
        )
      in
      get_valid_digit ()
    in
    Hashtbl.add slovar i vrednost
  done;
  slovar

let obdelaj_niz prvo_stevilo drugo_stevilo =
  let slovar = ustvari_slovar () in
  Printf.printf "Prvo število: %d, Drugo število: %d\n" prvo_stevilo drugo_stevilo;
  let spremenjeno_stevilo = spremeni_stevilo (string_of_int prvo_stevilo) slovar in
  primerjaj_stevili spremenjeno_stevilo (string_of_int drugo_stevilo);
  ZamenjajVmesnik RezultatSpremenjenegaNiza

let generiraj_nakljucno_stevilo () =
  Random.int 100000000
