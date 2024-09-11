open Printf
open Random
open Avtomat


let generiraj_nakljucno_stevilo () =
  Random.int 100000000

let rec beri_niz model =
  match model.trenutno_stanje with
  | BranjeObehStevil -> 
      print_string "Vnesi obe števili, ločeni z vejico (prvo, drugo): ";
      let input = read_line () in
      let stevilke = String.split_on_char ',' input in
      (match stevilke with
      | [prvo; drugo] ->
          let prvo_stevilo = int_of_string (String.trim prvo) in
          let drugo_stevilo = int_of_string (String.trim drugo) in
          VnesiObeStevili (prvo_stevilo, drugo_stevilo)
      | _ ->
          print_endline "Napaka! Vnesi dve števili ločeni z vejico.";
          beri_niz model)
  | BranjeDrugegaStevila -> 
      print_string "Vnesi drugo število: ";
      let drugo_stevilo = int_of_string (read_line ()) in
      VnesiDrugoStevilo drugo_stevilo
  | _ -> failwith "Neveljavno stanje"

let update model = function
  | IzberiNacinVnosa "manual" -> 
      ZamenjajVmesnik BranjeObehStevil
  
  | IzberiNacinVnosa "random" ->
      let random_number = generiraj_nakljucno_stevilo () in
      Printf.printf "Generirano naključno število: %d\n" random_number;
      ZamenjajVmesnik SeznamMoznosti
  
  | IzberiNacinVnosa "print" ->
      let random_number = generiraj_nakljucno_stevilo () in
      Printf.printf "Generirano naključno število: %d\n" random_number;
      ZamenjajVmesnik SeznamMoznosti

  | VnesiObeStevili (prvo, drugo) -> 
      obdelaj_niz prvo drugo

  | VnesiDrugoStevilo drugo_stevilo -> 
      (match model.prvo_stevilo with
      | Some prvo_stevilo -> obdelaj_niz prvo_stevilo drugo_stevilo
      | None ->
          print_endline "Napaka! Najprej vnesi prvo število.";
          ZamenjajVmesnik SeznamMoznosti)

  | ZamenjajVmesnik stanje ->
      ZamenjajVmesnik stanje
  | _ -> None

let rec izpisi_moznosti () =
  print_endline "Izberi možnost:";
  print_endline "1) Spremeni in preveri števili";
  print_endline "2) Generiraj naključno število";
  print_endline "3) Izhod";
  print_string "> ";
  match read_line () with
  | "1" -> IzberiNacinVnosa "manual"
  | "2" -> IzberiNacinVnosa "print"
  | "3" -> print_endline "Nasvidenje, lepo se imejte in veliko se smejte :)!"; exit 0
  | _ -> 
      print_endline "Napacen vnos! Izberi 1, 2 ali 3.";
      izpisi_moznosti ()

let rec izberi_nacin_vnosa () =
  print_endline "Izberi nacin vnosa števila:";
  print_endline "1) Ročni vnos";
  print_endline "2) Generiraj naključno število";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik BranjeObehStevil
  | "2" -> IzberiNacinVnosa "print"
  | _ -> 
      print_endline "Napacen vnos! Izberi 1 ali 2.";
      izberi_nacin_vnosa ()

let view model =
  match model.trenutno_stanje with
  | SeznamMoznosti -> izpisi_moznosti ()
  | IzbiraNacinaVnosa -> izberi_nacin_vnosa ()
  | BranjeObehStevil -> beri_niz model
  | BranjeDrugegaStevila -> beri_niz model
  | RezultatSpremenjenegaNiza -> 
      print_endline "Postopek je zaključen."; 
      ZamenjajVmesnik SeznamMoznosti
  |_ -> None

let rec loop model =
  let msg = view model in
  let model' = match update model msg with
    | ZamenjajVmesnik stanje -> { model with trenutno_stanje = stanje }
    | _ -> model
  in
  loop model'

let _ = 
  Random.self_init (); 
  print_endline "Dobrodošli v avtomatu!";
  loop { trenutno_stanje = SeznamMoznosti; prvo_stevilo = None; drugo_stevilo = None }
