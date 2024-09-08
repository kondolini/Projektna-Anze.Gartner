open Printf
open Avtomat
open Random

type stanje_vmesnika =
  | SeznamMoznosti
  | IzbiraNacinaVnosa
  | IzbiraNacinaVnosaDrugo
  | BranjeNiza of int  (* 1 for first number, 2 for second number *)
  | RezultatSpremenjenegaNiza
  | PreverjanjeStevil

type model = {
  trenutno_stanje : stanje_vmesnika;
  prvo_stevilo : int option;
  drugo_stevilo : int option;
}

type msg =
  | VnesiNiz of int
  | PreveriStevili of string * string
  | ZamenjajVmesnik of stanje_vmesnika
  | IzberiNacinVnosa of string
  | IzberiNacinVnosaDrugo of string


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

let rec beri_niz model =
  match model.trenutno_stanje with
  | BranjeNiza 1 -> (
      print_string "Vnesi prvo število: ";
      let prvo_stevilo = int_of_string (read_line ()) in
      ZamenjajVmesnik IzbiraNacinaVnosaDrugo
  )
  | BranjeNiza 2 -> (
      print_string "Vnesi drugo število: ";
      let drugo_stevilo = int_of_string (read_line ()) in
      match model.prvo_stevilo with
      | Some prvo_stevilo -> obdelaj_niz prvo_stevilo drugo_stevilo
      | None ->
          print_endline "Napaka! Najprej vnesi prvo število.";
          ZamenjajVmesnik SeznamMoznosti
  )
  | _ -> failwith "Neveljavno stanje"

let update model = function
  | IzberiNacinVnosa "manual" -> 
      ZamenjajVmesnik (BranjeNiza 1)
  
  | IzberiNacinVnosa "random" ->
      let random_number = generiraj_nakljucno_stevilo () in
      Printf.printf "Generirano nakljucno število: %d\n" random_number;
      let model' = { model with prvo_stevilo = Some random_number } in
      ZamenjajVmesnik (IzbiraNacinaVnosaDrugo)

  | IzberiNacinVnosaDrugo "manual" -> (
      match model.prvo_stevilo with
      | Some prvo_stevilo -> 
          print_string "Vnesi drugo število: ";
          let drugo_stevilo = int_of_string (read_line ()) in
          obdelaj_niz prvo_stevilo drugo_stevilo
      | None -> 
          print_endline "Napaka! Najprej vnesi prvo število.";
          ZamenjajVmesnik SeznamMoznosti
  )
  
  | IzberiNacinVnosaDrugo "random" -> (
      match model.prvo_stevilo with
      | Some prvo_stevilo ->
          let random_number = generiraj_nakljucno_stevilo () in
          Printf.printf "Generirano nakljucno število: %d\n" random_number;
          obdelaj_niz prvo_stevilo random_number
      | None -> 
          print_endline "Napaka! Najprej vnesi prvo število.";
          ZamenjajVmesnik SeznamMoznosti
  )

  | ZamenjajVmesnik stanje ->
      ZamenjajVmesnik stanje

let rec izpisi_moznosti () =
  print_endline "Izberi možnost:";
  print_endline "1) Spremeni in preveri števili";
  print_endline "2) Izhod";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik IzbiraNacinaVnosa
  | "2" -> exit 0
  | _ -> 
      print_endline "Napacen vnos! Izberi 1 ali 2.";
      izpisi_moznosti ()

let rec izberi_nacin_vnosa () =
  print_endline "Izberi nacin vnosa števila:";
  print_endline "1) Ročni vnos";
  print_endline "2) Generiraj nakljucno število";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik (BranjeNiza 1)
  | "2" -> IzberiNacinVnosa "random"
  | _ -> 
      print_endline "Napacen vnos! Izberi 1 ali 2.";
      izberi_nacin_vnosa ()

let rec izberi_nacin_vnosa_drugo () =
  print_endline "Izberi nacin vnosa drugega števila:";
  print_endline "1) Ročni vnos";
  print_endline "2) Generiraj nakljucno število";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik (BranjeNiza 2)
  | "2" -> IzberiNacinVnosaDrugo "random"
  | _ -> 
      print_endline "Napacen vnos! Izberi 1 ali 2.";
      izberi_nacin_vnosa_drugo ()

let view model =
  match model.trenutno_stanje with
  | SeznamMoznosti -> izpisi_moznosti ()
  | IzbiraNacinaVnosa -> izberi_nacin_vnosa ()
  | IzbiraNacinaVnosaDrugo -> izberi_nacin_vnosa_drugo ()
  | BranjeNiza 1 -> beri_niz model
  | BranjeNiza 2 -> beri_niz model
  | RezultatSpremenjenegaNiza -> ZamenjajVmesnik SeznamMoznosti

let rec loop model =
  let msg = view model in
  let model' = match update model msg with
    | ZamenjajVmesnik stanje -> { model with trenutno_stanje = stanje }
    | _ -> model
  in
  loop model'

let _ = 
  Random.self_init (); 
  print_endline "Dobrodosli v avtomatu!";
  loop { trenutno_stanje = SeznamMoznosti; prvo_stevilo = None; drugo_stevilo = None }
