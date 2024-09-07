type stanje = 
  | Zacetno 
  | Prehodno 
  | Stevilsko 
  | Napaka

val spremeni_stevilo : string -> (int, int) Hashtbl.t -> string