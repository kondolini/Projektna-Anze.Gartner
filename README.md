# Projektna-Anze.Gartner
# Končen avtomat več stanj
Za projektno nalogo sem sestavil preprost avtomat več stanj. Uporabnik uporablja avtomat preko tekstovnega vmesnika (glej navodila uporabe). Avtomat ima tip model in premore 4 argumente: trenutno_stanje, prvo_stevilo, drugo_stevilo in trak.
## **Trenutno_stanje**
trenutno_stanje ima tip stanje_vmesnika, ki je tip, definiran v datoteki avtomat.ml, SeznamMoznosti, IzbiraNacinaVnosa, BranjeObehStevil, RezultatSpremenjenegaNiza. Vsa ta stanja pomagajo pri spreminjanju stanj avtomata preko tekstovnega vmesnika.
## **prvo_stevilo**
Na začetku je nastavljeno na None in se posodobi, preko tekstovnega vmesnika.
## **drugo_stevilo**
Tudi ta je na začetku nastavljeno na None in se posodobi, preko tekstovnega vmesnika.
## **trak**
Trak je tipa int list in je na začetku nastavljen na []. Uporabnik ga preko tekstovnega vmesnika posodobi v poljuben int list, kjer števila v seznamu označujejo mesta, na katerih bo avtomat preverjal enakost števil.

# **Navodila za uporabo**
Uporabnik naj odpre terminalo, ter naj se premakne v mapo src, preko ukaza "cd src". Sedaj smo v mapi Projektna-Anze.Gartner-1/src. Od tu lahko z ukazom ./tekstovni_vmesnik poženemo tekstovni vmesnik. Ta nas toplo sprejme in poda 3 možnosti:
1) Spremeni in preveri števili
2) Generiraj naključno število
3) Izhod

1) Možnost je glavni program avtomata. Prosi nas za vnos dveh števil, ločeni z vejico ((Vnesi obe števili, ločeni z vejico (prvo, drugo):)). Po pravilnem vpisu obeh števil smo dolžni vpisati še trak, torej števke, kjer naj avtomat preverja enakost števil ((Vnesi mesta za preverjanje na traku, ločena z vejico: )). Ko naredimo to, nas bo avtomat vprašal za novo vrednost za števko 0. S tem mislimo, da bo prvemu številu spremenil vse števke 0 v novo števko, ki mu jo mi podamo. Enako bo avtomat zahteval za vse ostale števke 0-9. Ko to končamo, preidemo v končno stanje avtomata, ki nam izpiše, če se spremenjeno prvo število in drugo število ujemata na danih mestih traka in preidemo nazaj v SeznamMoznosti.

2) Če nimamo dovolj domišljije za število, nam lahko prijazni generator sam ponudi čisto naključno število od 1-100000000. Klic naključnega števila lahko uporabimo večkrat, število pa lahko uporabimo tako za prvo, kot za drugo število.

3) Razmislek predan bralcu.

# **Primer uporabe**
Oglejmo si primer uporabe Avtomata. Imejmo števili 12345 in 678. Preverjajmo njuno enakost na 1. in 3. števki (če bi želeli v trak vstaviti število >3, bi naleteli na napako, saj ta ne obstaja v drugem številu). Prvemu številu spremenimo 1->6 2->7 3->8 4->9 5->0. Ostalo pa pustimo pri miru. Spremenjeno prvo število bo tedaj 67890, drugo število pa 678. Števili se ujemata na 1. in 3. števki (mesta v traku) in nam zato trak vrne: Števili se ujemata na mestih podanih v traku: 1, 3

V terminali, bi to zgledalo kot:  
  
Dobrodošli v avtomatu!  
Izberi možnost:  
1) Spremeni in preveri števili  
2) Generiraj naključno število  
3) Izhod  
> 1    
Vnesi obe števili, ločeni z vejico (prvo, drugo): 12345, 678  
Vnesi mesta za preverjanje na traku, ločena z vejico: 1,3  
Vnesi novo vrednost za stevko 0 (0-9): 0    
Vnesi novo vrednost za stevko 1 (0-9): 6  
Vnesi novo vrednost za stevko 2 (0-9): 7  
Vnesi novo vrednost za stevko 3 (0-9): 8  
Vnesi novo vrednost za stevko 4 (0-9): 9  
Vnesi novo vrednost za stevko 5 (0-9): 0  
Vnesi novo vrednost za stevko 6 (0-9): 6  
Vnesi novo vrednost za stevko 7 (0-9): 7  
Vnesi novo vrednost za stevko 8 (0-9): 8   
Vnesi novo vrednost za stevko 9 (0-9): 9  
Prvo število: 12345, Drugo število: 678  
Spremenjeno število: 67890, Drugo število: 678  
Števili se ujemata na mestih podanih v traku: 1, 3  
Postopek je zaključen.  


# **Kako deluje avtomat**
Vse pomožne funkcije, ki niso neposredno povezane s tekstovnim vmesnikom so shranjene v datoteki avtomat.ml. Tam so definirane funkcije:
1) spremeni_stevilo : string -> (int, int) Hashtbl.t -> string (Preko "slovarja"(v tem primeru Hastbl.t) spremeni število glede na vrednosti)
2) primerjaj_stevili : string -> string -> string -> int list -> msg (Primerja števili na mestih, podanih v int listu)
3) ustvari_slovar : unit -> (int, int) Hashtbl.t (Preko uporabniškega inputa sestavi "slovar", ki bo uporabljen v spremeni_stevilo) 
4) obdelaj_niz : model -> msg (sprejme model (v sebi nosi trenutno_stajne, prvo_stevilo, drugo_stevilo in trak) ter vrne (primerjaj_stevili prvo_stevilo drugo_stevilo), če ni ostalih problemov)
5) generiraj_nakljucno_stevilo : unit -> int (preko knjižnice random generira naključno naravno število do 100000000)
Klic vseh teh se izvede preko tekstovnega vmesnika. Type msg je definiran, da lahko avtomat pravilno preber in uporabi input uporabnika na določenih mestih, kjer se to od uporabnika zahteva.





