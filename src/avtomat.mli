(* avtomat.mli *)

type stanje_vmesnika =
  | SeznamMoznosti
  | IzbiraNacinaVnosa
  | IzbiraNacinaVnosaDrugo
  | BranjeObehStevil
  | BranjeDrugegaStevila
  | RezultatSpremenjenegaNiza

type model = {
  trenutno_stanje : stanje_vmesnika;
  prvo_stevilo : int option;
  drugo_stevilo : int option;
}

type msg =
  | VnesiObeStevili of int * int
  | VnesiDrugoStevilo of int
  | ZamenjajVmesnik of stanje_vmesnika
  | IzberiNacinVnosa of string
  | IzberiNacinVnosaDrugo of string
  | GenerirajInPrikaziNakljucnoStevilo

val spremeni_stevilo : string -> (int, int) Hashtbl.t -> string
val primerjaj_stevili : string -> string -> unit
val ustvari_slovar : unit -> (int, int) Hashtbl.t
val obdelaj_niz : int -> int -> msg
val generiraj_nakljucno_stevilo : unit -> int
