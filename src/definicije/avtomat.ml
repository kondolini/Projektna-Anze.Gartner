type stanje = int
type simbol = char
type premik = L | R

type pravilo = stanje * simbol * simbol * stanje * premik

type trak = simbol list * simbol * simbol list

type turingov_stroj = {
  pravila : pravilo list;
  zacetno_stanje : stanje;
  prazna : simbol;
  koncna_stanja : stanje list;
}

let rec najdi_pravilo pravila stanje simbol =
  match pravila with
  | [] -> None
  | (s, sim, sim', s', premik) :: ostalo ->
      if s = stanje && sim = simbol then
        Some (sim', s', premik)
      else
        najdi_pravilo ostalo stanje simbol

let rec izvedi_pravilo stroj trak stanje =
  match trak with
  | (levo, sim, desno) ->
      match najdi_pravilo stroj.pravila stanje sim with
      | None -> (levo, sim, desno)
      | Some (sim', stanje', premik) ->
          match premik with
          | L ->
              (match levo with
               | [] -> ([stroj.prazna], sim', desno)
               | glava :: rep -> (rep, sim', glava :: desno))
          | R ->
              (match desno with
               | [] -> (sim' :: levo, stroj.prazna, [])
               | glava :: rep -> (sim' :: levo, glava, rep)) 
let trak_to_string trak =
  let (levi, trenutni, desni) = trak in
  let levi_string = String.concat "" (List.map (String.make 1) (List.rev levi)) in
  let desni_string = String.concat "" (List.map (String.make 1) desni) in
  levi_string ^ String.make 1 trenutni ^ desni_string

let rec zazeni_in_izpisi stroj trak stanje preveri =
  if List.mem stanje stroj.koncna_stanja then
    trak
  else if List.mem (stanje, trak) preveri then 
    failwith (Printf.printf "Turingov stroj se je zataknil v neskončni zanki. Stanje: %d, Trak: %s\n" stanje (trak_to_string trak);
              failwith "Končano")
  else
    let novi_trak = izvedi_pravilo stroj trak stanje in
    zazeni_in_izpisi stroj novi_trak (match novi_trak with (_, _, _) -> stanje) ((stanje,trak) :: preveri)

let simuliraj_z_izpisom stroj vnos =
  let zacetni_trak = ([], stroj.prazna, List.of_seq (String.to_seq vnos)) in
  let koncni_trak = zazeni_in_izpisi stroj zacetni_trak stroj.zacetno_stanje [] in
  let (levi, trenutni, desni) = koncni_trak in
  let trak_niz = String.concat "" (List.map (String.make 1) (List.rev levi)) ^ String.make 1 trenutni ^ String.concat "" (List.map (String.make 1) desni) in
  trak_niz

let pravila = [
  (0, '1', '1', 0, R);
  (0, ' ', ' ', 1, R);
  (1, '1', ' ', 1, R);
  (1, ' ', ' ', 2, L);
  (2, '1', '1', 2, L);
  (2, ' ', '1', 0, R);
]

let tm = {
  pravila = pravila;
  zacetno_stanje = 0;
  prazna = ' ';
  koncna_stanja = [2];
}

let rezultat = simuliraj_z_izpisom tm "111"
