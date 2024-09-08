type stanje = 
  | Zacetno
  | Vmesno of char list  
  | Sprejemno of char list 
  | Napaka  

val spremeni_stevilo : string -> (int, int) Hashtbl.t -> stanje
val preveri_stevili : string -> string -> (int, int) Hashtbl.t -> unit
val primerjaj_stevili : 'a -> 'a -> unit