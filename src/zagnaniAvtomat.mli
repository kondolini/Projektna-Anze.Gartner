type t

val pozeni : Trak.t -> string -> t
val avtomat : t -> Avtomat.t
val trak : t -> Trak.t
val korak_naprej : t -> t 
val je_v_sprejemnem_stanju : t -> bool
