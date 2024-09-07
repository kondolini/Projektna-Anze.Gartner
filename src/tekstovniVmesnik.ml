open Avtomat
open Printf

type stanje_vmesnika =
  | SeznamMoznosti
  | BranjeNiza of int  
  | RezultatSpremenjenegaNiza

type model = {
  trenutno_stanje : stanje_vmesnika;
}

type msg =
  | VnesiNiz of string
  | SpremeniNiz of string
  | ZamenjajVmesnik of stanje_vmesnika

let rec preveri_vnos_stevke niz =
  let dolzina = String.length niz in
  let rec aux i =
    if i >= dolzina then true
    else
      let znak = String.get niz i in
      if znak >= '0' && znak <= '9' then aux (i + 1)
      else false
  in
  aux 0

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

let obdelaj_niz model niz =
  match model.trenutno_stanje with
  | BranjeNiza 3 ->
      let slovar = ustvari_slovar () in
      let nov_niz = spremeni_stevilo niz slovar in
      Printf.printf "Spremenjeni niz: %s\n" nov_niz;
      ZamenjajVmesnik RezultatSpremenjenegaNiza
  | _ -> ZamenjajVmesnik SeznamMoznosti

let update model = function
  | VnesiNiz str -> (
    match model.trenutno_stanje with
    | BranjeNiza _ ->
      obdelaj_niz model str;
      { model with trenutno_stanje = RezultatSpremenjenegaNiza }
    | _ -> model
  )
  | ZamenjajVmesnik stanje ->
      { model with trenutno_stanje = stanje }

let rec izpisi_moznosti () =
  print_endline "Izberi 1 ali 2:";
  print_endline "1) Spremeni niz s slovarjem stevk";
  print_endline "2) Izhod";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik (BranjeNiza 3)
  | "2" -> print_endline "Nasvidenje!"; exit 0
  | _ ->
      print_endline "Napacen vnos! Izberi 1 ali 2.";
      izpisi_moznosti ()

let rec beri_niz model =
  print_string "Vnesi celostevilski niz: ";
  let niz = read_line () in
  if preveri_vnos_stevke niz then
    VnesiNiz niz
  else (
    print_endline "Napacen vnos! Vnesi celostevilski niz (samo stevilke).";
    beri_niz model
  )

let view model =
  match model.trenutno_stanje with
  | SeznamMoznosti -> izpisi_moznosti ()
  | BranjeNiza _ -> beri_niz model
  | RezultatSpremenjenegaNiza -> ZamenjajVmesnik SeznamMoznosti

let rec loop model =
  let msg = view model in
  let model' = update model msg in
  loop model'


let _ = 
  print_endline "Dobrodosli v preverjevalniku nizov!";
  loop { trenutno_stanje = SeznamMoznosti }
