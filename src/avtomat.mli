type stanje_vmesnika =
  | SeznamMoznosti
  | IzbiraNacinaVnosa
  | BranjeObehStevil
  | RezultatSpremenjenegaNiza

  
type msg =
  | VnesiObeStevili of int * int * int list
  | ZamenjajVmesnik of stanje_vmesnika
  | IzberiNacinVnosa of string
  | GenerirajInPrikaziNakljucnoStevilo
  | None


type model = {
  trenutno_stanje : stanje_vmesnika;
  prvo_stevilo : int option;
  drugo_stevilo : int option;
  trak : int list; 
}


val spremeni_stevilo : string -> (int, int) Hashtbl.t -> string
val primerjaj_stevili : string -> string -> string -> int list -> msg
val ustvari_slovar : unit -> (int, int) Hashtbl.t
val obdelaj_niz : model -> msg
val generiraj_nakljucno_stevilo : unit -> int
