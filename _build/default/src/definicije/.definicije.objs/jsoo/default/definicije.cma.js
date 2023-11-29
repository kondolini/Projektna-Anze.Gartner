// Generated by js_of_ocaml
//# buildInfo:effects=false, kind=cma, use-js-string=true, version=5.4.0

//# unitInfo: Provides: Definicije
(function
  (globalThis){
   "use strict";
   var runtime = globalThis.jsoo_runtime, Definicije = [0];
   runtime.caml_register_global(0, Definicije, "Definicije");
   return;
  }
  (globalThis));

//# unitInfo: Provides: Definicije__Stanje
(function(globalThis){
   "use strict";
   var runtime = globalThis.jsoo_runtime;
   function iz_niza(oznaka){return [0, oznaka];}
   function v_niz(param){var oznaka = param[1]; return oznaka;}
   var Definicije_Stanje = [0, iz_niza, v_niz];
   runtime.caml_register_global(0, Definicije_Stanje, "Definicije__Stanje");
   return;
  }
  (globalThis));

//# unitInfo: Provides: Definicije__Avtomat
//# unitInfo: Requires: Definicije__Stanje, Stdlib__List, Stdlib__Seq, Stdlib__String
(function
  (globalThis){
   "use strict";
   var runtime = globalThis.jsoo_runtime;
   function caml_call1(f, a0){
    return (f.l >= 0 ? f.l : f.l = f.length) == 1
            ? f(a0)
            : runtime.caml_call_gen(f, [a0]);
   }
   function caml_call2(f, a0, a1){
    return (f.l >= 0 ? f.l : f.l = f.length) == 2
            ? f(a0, a1)
            : runtime.caml_call_gen(f, [a0, a1]);
   }
   var
    global_data = runtime.caml_get_global_data(),
    Stdlib_String = global_data.Stdlib__String,
    Stdlib_Seq = global_data.Stdlib__Seq,
    Stdlib_List = global_data.Stdlib__List,
    Definicije_Stanje = global_data.Definicije__Stanje,
    cst_q0 = "q0",
    cst_q1 = "q1",
    cst_q2 = "q2";
   function prazen_avtomat(zacetno_stanje){
    return [0, [0, zacetno_stanje, 0], zacetno_stanje, 0, 0];
   }
   function dodaj_nesprejemno_stanje(stanje, avtomat){
    return [0, [0, stanje, avtomat[1]], avtomat[2], avtomat[3], avtomat[4]];
   }
   function dodaj_sprejemno_stanje(stanje, avtomat){
    return [0,
            [0, stanje, avtomat[1]],
            avtomat[2],
            [0, stanje, avtomat[3]],
            avtomat[4]];
   }
   function dodaj_prehod(stanje1, znak, stanje2, avtomat){
    return [0,
            avtomat[1],
            avtomat[2],
            avtomat[3],
            [0, [0, stanje1, znak, stanje2], avtomat[4]]];
   }
   function prehodna_funkcija(avtomat, stanje, znak){
    var _b_ = avtomat[4];
    function _c_(param){
     var
      znak$0 = param[2],
      stanje1 = param[1],
      _d_ = runtime.caml_equal(stanje1, stanje),
      _e_ = _d_ ? znak === znak$0 ? 1 : 0 : _d_;
     return _e_;
    }
    var match = caml_call2(Stdlib_List[39], _c_, _b_);
    if(! match) return 0;
    var stanje2 = match[1][3];
    return [0, stanje2];
   }
   function zacetno_stanje(avtomat){return avtomat[2];}
   function seznam_stanj(avtomat){return avtomat[1];}
   function seznam_prehodov(avtomat){return avtomat[4];}
   function je_sprejemno_stanje(avtomat, stanje){
    return caml_call2(Stdlib_List[36], stanje, avtomat[3]);
   }
   var
    q0 = caml_call1(Definicije_Stanje[1], cst_q0),
    q1 = caml_call1(Definicije_Stanje[1], cst_q1),
    q2 = caml_call1(Definicije_Stanje[1], cst_q2),
    enke_1mod3 =
      dodaj_prehod
       (q2,
        49,
        q0,
        dodaj_prehod
         (q1,
          49,
          q2,
          dodaj_prehod
           (q0,
            49,
            q1,
            dodaj_prehod
             (q2,
              48,
              q2,
              dodaj_prehod
               (q1,
                48,
                q1,
                dodaj_prehod
                 (q0,
                  48,
                  q0,
                  dodaj_nesprejemno_stanje
                   (q2, dodaj_sprejemno_stanje(q1, prazen_avtomat(q0)))))))));
   function preberi_niz(avtomat, q, niz){
    function aux(acc, znak){
     if(! acc) return 0;
     var q = acc[1];
     return prehodna_funkcija(avtomat, q, znak);
    }
    var _a_ = caml_call1(Stdlib_String[39], niz);
    return caml_call1(caml_call2(Stdlib_Seq[5], aux, [0, q]), _a_);
   }
   var
    Definicije_Avtomat =
      [0,
       prazen_avtomat,
       dodaj_nesprejemno_stanje,
       dodaj_sprejemno_stanje,
       dodaj_prehod,
       prehodna_funkcija,
       zacetno_stanje,
       seznam_stanj,
       seznam_prehodov,
       je_sprejemno_stanje,
       enke_1mod3,
       preberi_niz];
   runtime.caml_register_global(7, Definicije_Avtomat, "Definicije__Avtomat");
   return;
  }
  (globalThis));

//# unitInfo: Provides: Definicije__Trak
//# unitInfo: Requires: Stdlib__String
(function
  (globalThis){
   "use strict";
   var
    runtime = globalThis.jsoo_runtime,
    caml_ml_string_length = runtime.caml_ml_string_length;
   function caml_call3(f, a0, a1, a2){
    return (f.l >= 0 ? f.l : f.l = f.length) == 3
            ? f(a0, a1, a2)
            : runtime.caml_call_gen(f, [a0, a1, a2]);
   }
   var
    global_data = runtime.caml_get_global_data(),
    cst = "",
    Stdlib_String = global_data.Stdlib__String;
   function trenutni_znak(trak){
    return runtime.caml_string_get(trak[1], trak[2]);
   }
   function je_na_koncu(trak){
    return caml_ml_string_length(trak[1]) === trak[2] ? 1 : 0;
   }
   function premakni_naprej(trak){return [0, trak[1], trak[2] + 1 | 0];}
   function iz_niza(niz){return [0, niz, 0];}
   var prazen = iz_niza(cst);
   function v_niz(trak){return trak[1];}
   function prebrani(trak){
    return caml_call3(Stdlib_String[15], trak[1], 0, trak[2]);
   }
   function neprebrani(trak){
    return caml_call3
            (Stdlib_String[15],
             trak[1],
             trak[2],
             caml_ml_string_length(trak[1]) - trak[2] | 0);
   }
   var
    Definicije_Trak =
      [0,
       prazen,
       trenutni_znak,
       je_na_koncu,
       premakni_naprej,
       iz_niza,
       v_niz,
       prebrani,
       neprebrani];
   runtime.caml_register_global(2, Definicije_Trak, "Definicije__Trak");
   return;
  }
  (globalThis));

//# unitInfo: Provides: Definicije__ZagnaniAvtomat
//# unitInfo: Requires: Definicije__Avtomat, Definicije__Trak
(function
  (globalThis){
   "use strict";
   var runtime = globalThis.jsoo_runtime;
   function caml_call1(f, a0){
    return (f.l >= 0 ? f.l : f.l = f.length) == 1
            ? f(a0)
            : runtime.caml_call_gen(f, [a0]);
   }
   function caml_call2(f, a0, a1){
    return (f.l >= 0 ? f.l : f.l = f.length) == 2
            ? f(a0, a1)
            : runtime.caml_call_gen(f, [a0, a1]);
   }
   function caml_call3(f, a0, a1, a2){
    return (f.l >= 0 ? f.l : f.l = f.length) == 3
            ? f(a0, a1, a2)
            : runtime.caml_call_gen(f, [a0, a1, a2]);
   }
   var
    global_data = runtime.caml_get_global_data(),
    Definicije_Avtomat = global_data.Definicije__Avtomat,
    Definicije_Trak = global_data.Definicije__Trak;
   function pozeni(avtomat, trak){
    return [0, avtomat, trak, caml_call1(Definicije_Avtomat[6], avtomat)];
   }
   function avtomat(param){var avtomat = param[1]; return avtomat;}
   function trak(param){var trak = param[2]; return trak;}
   function stanje(param){var stanje = param[3]; return stanje;}
   function korak_naprej(param){
    var stanje = param[3], trak = param[2], avtomat = param[1];
    if(caml_call1(Definicije_Trak[3], trak)) return 0;
    var
     _a_ = caml_call1(Definicije_Trak[2], trak),
     stanje$0 = caml_call3(Definicije_Avtomat[5], avtomat, stanje, _a_);
    if(! stanje$0) return 0;
    var stanje$1 = stanje$0[1];
    return [0, [0, avtomat, caml_call1(Definicije_Trak[4], trak), stanje$1]];
   }
   function je_v_sprejemnem_stanju(param){
    var stanje = param[3], avtomat = param[1];
    return caml_call2(Definicije_Avtomat[9], avtomat, stanje);
   }
   var
    Definicije_ZagnaniAvtomat =
      [0, pozeni, avtomat, trak, stanje, korak_naprej, je_v_sprejemnem_stanju];
   runtime.caml_register_global
    (2, Definicije_ZagnaniAvtomat, "Definicije__ZagnaniAvtomat");
   return;
  }
  (globalThis));

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLjAsImZpbGUiOiIuZGVmaW5pY2lqZS5vYmpzL2pzb28vZGVmYXVsdC9kZWZpbmljaWplLmNtYS5qcyIsInNvdXJjZVJvb3QiOiIiLCJuYW1lcyI6WyJpel9uaXphIiwib3puYWthIiwidl9uaXoiLCJwcmF6ZW5fYXZ0b21hdCIsInphY2V0bm9fc3RhbmplIiwiZG9kYWpfbmVzcHJlamVtbm9fc3RhbmplIiwic3RhbmplIiwiYXZ0b21hdCIsImRvZGFqX3NwcmVqZW1ub19zdGFuamUiLCJkb2Rhal9wcmVob2QiLCJzdGFuamUxIiwiem5hayIsInN0YW5qZTIiLCJwcmVob2RuYV9mdW5rY2lqYSIsInpuYWskMCIsInNlem5hbV9zdGFuaiIsInNlem5hbV9wcmVob2RvdiIsImplX3NwcmVqZW1ub19zdGFuamUiLCJxMCIsInExIiwicTIiLCJlbmtlXzFtb2QzIiwicHJlYmVyaV9uaXoiLCJxIiwibml6IiwiYXV4IiwiYWNjIiwidHJlbnV0bmlfem5hayIsInRyYWsiLCJqZV9uYV9rb25jdSIsInByZW1ha25pX25hcHJlaiIsInByYXplbiIsInByZWJyYW5pIiwibmVwcmVicmFuaSIsInBvemVuaSIsImtvcmFrX25hcHJlaiIsInN0YW5qZSQwIiwic3RhbmplJDEiLCJqZV92X3NwcmVqZW1uZW1fc3Rhbmp1Il0sInNvdXJjZXMiOlsiL3dvcmtzcGFjZV9yb290L3NyYy9kZWZpbmljaWplL3N0YW5qZS5tbCIsIi93b3Jrc3BhY2Vfcm9vdC9zcmMvZGVmaW5pY2lqZS9hdnRvbWF0Lm1sIiwiL3dvcmtzcGFjZV9yb290L3NyYy9kZWZpbmljaWplL3RyYWsubWwiLCIvd29ya3NwYWNlX3Jvb3Qvc3JjL2RlZmluaWNpamUvemFnbmFuaUF2dG9tYXQubWwiXSwibWFwcGluZ3MiOiI7Ozs7Ozs7Ozs7RTs7Ozs7OztZQUVJQSxRQUFRQyxRQUFTLFdBQVRBLFFBQW1CO1lBQzNCQyxpQkFBUUQsbUJBQVcsT0FBWEE7K0JBRFJELFNBQ0FFOzs7RTs7Ozs7Ozs7O0c7Ozs7O0c7Ozs7Ozs7Ozs7Ozs7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LFFBRUE2QixjQVdBRzs7OztFIiwic291cmNlc0NvbnRlbnQiOlsidHlwZSB0ID0geyBvem5ha2EgOiBzdHJpbmcgfVxuXG5sZXQgaXpfbml6YSBvem5ha2EgPSB7IG96bmFrYSB9XG5sZXQgdl9uaXogeyBvem5ha2EgfSA9IG96bmFrYVxuIiwidHlwZSBzdGFuamUgPSBTdGFuamUudFxuXG50eXBlIHQgPSB7XG4gIHN0YW5qYSA6IHN0YW5qZSBsaXN0O1xuICB6YWNldG5vX3N0YW5qZSA6IHN0YW5qZTtcbiAgc3ByZWplbW5hX3N0YW5qYSA6IHN0YW5qZSBsaXN0O1xuICBwcmVob2RpIDogKHN0YW5qZSAqIGNoYXIgKiBzdGFuamUpIGxpc3Q7XG59XG5cbmxldCBwcmF6ZW5fYXZ0b21hdCB6YWNldG5vX3N0YW5qZSA9XG4gIHtcbiAgICBzdGFuamEgPSBbIHphY2V0bm9fc3RhbmplIF07XG4gICAgemFjZXRub19zdGFuamU7XG4gICAgc3ByZWplbW5hX3N0YW5qYSA9IFtdO1xuICAgIHByZWhvZGkgPSBbXTtcbiAgfVxuXG5sZXQgZG9kYWpfbmVzcHJlamVtbm9fc3RhbmplIHN0YW5qZSBhdnRvbWF0ID1cbiAgeyBhdnRvbWF0IHdpdGggc3RhbmphID0gc3RhbmplIDo6IGF2dG9tYXQuc3RhbmphIH1cblxubGV0IGRvZGFqX3NwcmVqZW1ub19zdGFuamUgc3RhbmplIGF2dG9tYXQgPVxuICB7XG4gICAgYXZ0b21hdCB3aXRoXG4gICAgc3RhbmphID0gc3RhbmplIDo6IGF2dG9tYXQuc3RhbmphO1xuICAgIHNwcmVqZW1uYV9zdGFuamEgPSBzdGFuamUgOjogYXZ0b21hdC5zcHJlamVtbmFfc3RhbmphO1xuICB9XG5cbmxldCBkb2Rhal9wcmVob2Qgc3RhbmplMSB6bmFrIHN0YW5qZTIgYXZ0b21hdCA9XG4gIHsgYXZ0b21hdCB3aXRoIHByZWhvZGkgPSAoc3RhbmplMSwgem5haywgc3RhbmplMikgOjogYXZ0b21hdC5wcmVob2RpIH1cblxubGV0IHByZWhvZG5hX2Z1bmtjaWphIGF2dG9tYXQgc3RhbmplIHpuYWsgPVxuICBtYXRjaFxuICAgIExpc3QuZmluZF9vcHRcbiAgICAgIChmdW4gKHN0YW5qZTEsIHpuYWsnLCBfc3RhbmplMikgLT4gc3RhbmplMSA9IHN0YW5qZSAmJiB6bmFrID0gem5haycpXG4gICAgICBhdnRvbWF0LnByZWhvZGlcbiAgd2l0aFxuICB8IE5vbmUgLT4gTm9uZVxuICB8IFNvbWUgKF8sIF8sIHN0YW5qZTIpIC0+IFNvbWUgc3RhbmplMlxuXG5sZXQgemFjZXRub19zdGFuamUgYXZ0b21hdCA9IGF2dG9tYXQuemFjZXRub19zdGFuamVcbmxldCBzZXpuYW1fc3RhbmogYXZ0b21hdCA9IGF2dG9tYXQuc3RhbmphXG5sZXQgc2V6bmFtX3ByZWhvZG92IGF2dG9tYXQgPSBhdnRvbWF0LnByZWhvZGlcblxubGV0IGplX3NwcmVqZW1ub19zdGFuamUgYXZ0b21hdCBzdGFuamUgPVxuICBMaXN0Lm1lbSBzdGFuamUgYXZ0b21hdC5zcHJlamVtbmFfc3RhbmphXG5cbmxldCBlbmtlXzFtb2QzID1cbiAgbGV0IHEwID0gU3RhbmplLml6X25pemEgXCJxMFwiXG4gIGFuZCBxMSA9IFN0YW5qZS5pel9uaXphIFwicTFcIlxuICBhbmQgcTIgPSBTdGFuamUuaXpfbml6YSBcInEyXCIgaW5cbiAgcHJhemVuX2F2dG9tYXQgcTAgfD4gZG9kYWpfc3ByZWplbW5vX3N0YW5qZSBxMVxuICB8PiBkb2Rhal9uZXNwcmVqZW1ub19zdGFuamUgcTJcbiAgfD4gZG9kYWpfcHJlaG9kIHEwICcwJyBxMCB8PiBkb2Rhal9wcmVob2QgcTEgJzAnIHExIHw+IGRvZGFqX3ByZWhvZCBxMiAnMCcgcTJcbiAgfD4gZG9kYWpfcHJlaG9kIHEwICcxJyBxMSB8PiBkb2Rhal9wcmVob2QgcTEgJzEnIHEyIHw+IGRvZGFqX3ByZWhvZCBxMiAnMScgcTBcblxubGV0IHByZWJlcmlfbml6IGF2dG9tYXQgcSBuaXogPVxuICBsZXQgYXV4IGFjYyB6bmFrID1cbiAgICBtYXRjaCBhY2Mgd2l0aCBOb25lIC0+IE5vbmUgfCBTb21lIHEgLT4gcHJlaG9kbmFfZnVua2NpamEgYXZ0b21hdCBxIHpuYWtcbiAgaW5cbiAgbml6IHw+IFN0cmluZy50b19zZXEgfD4gU2VxLmZvbGRfbGVmdCBhdXggKFNvbWUgcSlcbiIsInR5cGUgdCA9IHsgbml6IDogc3RyaW5nOyBpbmRla3NfdHJlbnV0bmVnYV96bmFrYSA6IGludCB9XG5cbmxldCB0cmVudXRuaV96bmFrIHRyYWsgPSBTdHJpbmcuZ2V0IHRyYWsubml6IHRyYWsuaW5kZWtzX3RyZW51dG5lZ2Ffem5ha2FcbmxldCBqZV9uYV9rb25jdSB0cmFrID0gU3RyaW5nLmxlbmd0aCB0cmFrLm5peiA9IHRyYWsuaW5kZWtzX3RyZW51dG5lZ2Ffem5ha2FcblxubGV0IHByZW1ha25pX25hcHJlaiB0cmFrID1cbiAgeyB0cmFrIHdpdGggaW5kZWtzX3RyZW51dG5lZ2Ffem5ha2EgPSBzdWNjIHRyYWsuaW5kZWtzX3RyZW51dG5lZ2Ffem5ha2EgfVxuXG5sZXQgaXpfbml6YSBuaXogPSB7IG5pejsgaW5kZWtzX3RyZW51dG5lZ2Ffem5ha2EgPSAwIH1cbmxldCBwcmF6ZW4gPSBpel9uaXphIFwiXCJcbmxldCB2X25peiB0cmFrID0gdHJhay5uaXpcblxubGV0IHByZWJyYW5pIHRyYWsgPSBTdHJpbmcuc3ViIHRyYWsubml6IDAgdHJhay5pbmRla3NfdHJlbnV0bmVnYV96bmFrYVxuXG5hbmQgbmVwcmVicmFuaSB0cmFrID1cbiAgU3RyaW5nLnN1YiB0cmFrLm5peiB0cmFrLmluZGVrc190cmVudXRuZWdhX3puYWthXG4gICAgKFN0cmluZy5sZW5ndGggdHJhay5uaXogLSB0cmFrLmluZGVrc190cmVudXRuZWdhX3puYWthKVxuIiwidHlwZSB0ID0geyBhdnRvbWF0IDogQXZ0b21hdC50OyB0cmFrIDogVHJhay50OyBzdGFuamUgOiBTdGFuamUudCB9XG5cbmxldCBwb3plbmkgYXZ0b21hdCB0cmFrID1cbiAgeyBhdnRvbWF0OyB0cmFrOyBzdGFuamUgPSBBdnRvbWF0LnphY2V0bm9fc3RhbmplIGF2dG9tYXQgfVxuXG5sZXQgYXZ0b21hdCB7IGF2dG9tYXQ7IF8gfSA9IGF2dG9tYXRcbmxldCB0cmFrIHsgdHJhazsgXyB9ID0gdHJha1xubGV0IHN0YW5qZSB7IHN0YW5qZTsgXyB9ID0gc3RhbmplXG5cbmxldCBrb3Jha19uYXByZWogeyBhdnRvbWF0OyB0cmFrOyBzdGFuamUgfSA9XG4gIGlmIFRyYWsuamVfbmFfa29uY3UgdHJhayB0aGVuIE5vbmVcbiAgZWxzZVxuICAgIGxldCBzdGFuamUnID1cbiAgICAgIEF2dG9tYXQucHJlaG9kbmFfZnVua2NpamEgYXZ0b21hdCBzdGFuamUgKFRyYWsudHJlbnV0bmlfem5hayB0cmFrKVxuICAgIGluXG4gICAgbWF0Y2ggc3RhbmplJyB3aXRoXG4gICAgfCBOb25lIC0+IE5vbmVcbiAgICB8IFNvbWUgc3RhbmplJyAtPlxuICAgICAgICBTb21lIHsgYXZ0b21hdDsgdHJhayA9IFRyYWsucHJlbWFrbmlfbmFwcmVqIHRyYWs7IHN0YW5qZSA9IHN0YW5qZScgfVxuXG5sZXQgamVfdl9zcHJlamVtbmVtX3N0YW5qdSB7IGF2dG9tYXQ7IHN0YW5qZTsgXyB9ID1cbiAgQXZ0b21hdC5qZV9zcHJlamVtbm9fc3RhbmplIGF2dG9tYXQgc3RhbmplXG4iXX0=
