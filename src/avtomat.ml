open Random

type stanje_vmesnika =
  | SeznamMoznosti
  | IzbiraNacinaVnosa
  | IzbiraNacinaVnosaDrugo
  | BranjeObehStevil
  | RezultatSpremenjenegaNiza

type msg =
  | VnesiObeStevili of int * int * int list
  | VnesiDrugoStevilo of int * int list
  | ZamenjajVmesnik of stanje_vmesnika
  | IzberiNacinVnosa of string
  | IzberiNacinVnosaDrugo of string
  | GenerirajInPrikaziNakljucnoStevilo
  | None


type model = {
  trenutno_stanje : stanje_vmesnika;
  prvo_stevilo : int option;
  drugo_stevilo : int option;
  trak : int list;
  }
  

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

let primerjaj_stevili (prvo: string) (drugo: string) (spremenjeno_prvo: string) (trak: int list) : msg =
  let rec check_positions positions =
    match positions with
    | [] -> true
    | pos :: rest ->
        if pos <= String.length spremenjeno_prvo && pos <= String.length drugo then
          if String.get spremenjeno_prvo (pos - 1) = String.get drugo (pos - 1) then
            check_positions rest
          else
            false
        else (
          print_endline ("Napaka: Števka na mestu " ^ string_of_int pos ^ " je izven dolžine števila.");
          false
        )
  in
  if check_positions trak then
    begin
      Printf.printf "Spremenjeno število: %s, Drugo število: %s\n" spremenjeno_prvo drugo;
      Printf.printf "Števili se ujemata na mestih podanih v traku: %s\n" 
        (String.concat ", " (List.map string_of_int trak));
      ZamenjajVmesnik RezultatSpremenjenegaNiza
    end
  else
    begin
      Printf.printf "Spremenjeno število: %s, Drugo število: %s\n" spremenjeno_prvo drugo;
      Printf.printf "Števili se ne ujemata na mestih podanih v traku: %s\n" 
        (String.concat ", " (List.map string_of_int trak));
      ZamenjajVmesnik RezultatSpremenjenegaNiza
    end




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

let generiraj_nakljucno_stevilo () =
  Random.int 100000000


let obdelaj_niz (model: model) : msg =
  let prvo_stevilo = model.prvo_stevilo in
  let drugo_stevilo = model.drugo_stevilo in
  match prvo_stevilo, drugo_stevilo with
  | Some prvo, Some drugo ->
      let slovar = ustvari_slovar () in
      Printf.printf "Prvo število: %d, Drugo število: %d\n" prvo drugo;
      let spremenjeno_stevilo = spremeni_stevilo (string_of_int prvo) slovar in
      primerjaj_stevili (string_of_int prvo) (string_of_int drugo) spremenjeno_stevilo model.trak
  | _ ->
      print_endline "Napaka! Eno ali obe števili nista bili pravilno vneseni.";
      ZamenjajVmesnik SeznamMoznosti

