open Printf
open Random
open Avtomat


let obdelaj_niz (model: model) : msg =
let prvo_stevilo = model.prvo_stevilo in
let drugo_stevilo = model.drugo_stevilo in
match prvo_stevilo, drugo_stevilo with
| Some prvo, Some drugo ->
    let slovar = ustvari_slovar () in
    Printf.printf "Prvo število: %d, Drugo število: %d\n" prvo drugo;
    let spremenjeno_stevilo = spremeni_stevilo (string_of_int prvo) slovar in
    primerjaj_stevili (string_of_int prvo) (string_of_int drugo) spremenjeno_stevilo  model.trak
| _ ->
    print_endline "Napaka! Eno ali obe števili nista bili pravilno vneseni.";
    ZamenjajVmesnik SeznamMoznosti


let generiraj_nakljucno_stevilo () =
  Random.int 100000000

let rec beri_niz model =
  match model.trenutno_stanje with
  | BranjeObehStevil -> 
      print_string "Vnesi obe števili, ločeni z vejico (prvo, drugo): ";
      let input = read_line () in
      match input with 
      | "" -> 
          print_endline "Napaka! Ponovi vajo!"; 
          ZamenjajVmesnik BranjeObehStevil  (* Return a valid message to retry *)
      | _ -> 
          let stevilke = String.split_on_char ',' input in
          (match stevilke with
          | [prvo; drugo] ->
              (* Try to convert both inputs to integers *)
              let prvo_stevilo = 
                try Some (int_of_string (String.trim prvo)) 
                with Failure _ -> print_endline "Napaka pri pretvorbi prvega števila!"; None
              in
              let drugo_stevilo = 
                try Some (int_of_string (String.trim drugo)) 
                with Failure _ -> print_endline "Napaka pri pretvorbi drugega števila!"; None
              in
              (* If both conversions succeeded, proceed, else retry *)
              (match prvo_stevilo, drugo_stevilo with
              | Some prvo, Some drugo ->
                  print_string "Vnesi mesta za preverjanje na traku, ločena z vejico: ";
                  let trak_input = read_line () in
                  let trak = List.map int_of_string (String.split_on_char ',' trak_input) in
                  if List.for_all (fun pos -> pos > 0 && pos <= min (String.length (string_of_int prvo)) (String.length (string_of_int drugo))) trak then
                    VnesiObeStevili (prvo, drugo, trak)
                  else (
                    print_endline "Napaka! Nekatera mesta na traku so izven dolžine števil.";
                    ZamenjajVmesnik BranjeObehStevil  (* Retry if track is invalid *)
                  )
              | _ -> 
                  print_endline "Napaka! Eni ali obe števili nista pravilno vneseni.";
                  ZamenjajVmesnik BranjeObehStevil  (* Retry if number conversion failed *)
              )
          | _ -> 
              print_endline "Napaka! Vnesi dve števili ločeni z vejico.";
              ZamenjajVmesnik BranjeObehStevil)  (* Retry if the input doesn't match the expected format *)



let update model = function
| VnesiObeStevili (prvo, drugo, trak) -> 
    let model' = { model with prvo_stevilo = Some prvo; drugo_stevilo = Some drugo; trak = trak } in
    obdelaj_niz model'
| ZamenjajVmesnik stanje ->
    ZamenjajVmesnik stanje
| IzberiNacinVnosa "manual" ->
    ZamenjajVmesnik BranjeObehStevil
| IzberiNacinVnosa "random" ->
    let random_stevilo = generiraj_nakljucno_stevilo () in
    print_endline ("Generirano naključno število: " ^ string_of_int random_stevilo);
    ZamenjajVmesnik SeznamMoznosti
| IzberiNacinVnosa "" -> 
    print_endline "Napaka: Prazno ime načina vnosa.";
    ZamenjajVmesnik SeznamMoznosti  (* Handle empty input case *)
| GenerirajInPrikaziNakljucnoStevilo ->
    let nakljucno_stevilo = generiraj_nakljucno_stevilo () in
    print_endline ("Naključno število: " ^ string_of_int nakljucno_stevilo);
    ZamenjajVmesnik SeznamMoznosti
| None -> None
| _ -> 
    print_endline "Neznano sporočilo!";  (* Handle any other unmatched cases *)
    ZamenjajVmesnik SeznamMoznosti

  


let rec izpisi_moznosti () =
  print_endline "Izberi možnost:";
  print_endline "1) Spremeni in preveri števili";
  print_endline "2) Generiraj naključno število";
  print_endline "3) Izhod";
  print_string "> ";
  match read_line () with
  | "1" -> IzberiNacinVnosa "manual"
  | "2" -> IzberiNacinVnosa "random"
  | "3" -> print_endline "Nasvidenje, lepo se imejte in veliko se smejte :)!"; exit 0
  | _ -> 
      print_endline "Napacen vnos! Izberi 1, 2 ali 3.";
      izpisi_moznosti ()


let view model =
match model.trenutno_stanje with
| SeznamMoznosti -> izpisi_moznosti ()
| IzbiraNacinaVnosa -> izpisi_moznosti ()
| BranjeObehStevil -> beri_niz model  
| RezultatSpremenjenegaNiza -> 
    print_endline "Postopek je zaključen."; 
    ZamenjajVmesnik SeznamMoznosti
| _ -> None


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
  loop { trenutno_stanje = SeznamMoznosti; prvo_stevilo = None; drugo_stevilo = None; trak = []  }
