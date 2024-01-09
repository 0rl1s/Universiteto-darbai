/*
    Autorius: Lukas Orliukas
    Kursas: programu sistemos 4 kursas
    Grupe: 3 grupe
    Uzduoties variantai: 8, 16, 31, 32

    ?- brolis_ir_sesuo(rimas,vida).
    true.
    ?- brolis_ir_sesuo(vida,rimas).
    false.

    ?- anukas(lukas,antanijus).
    true.
    ?- anukas(akvile,antanijus).
    false.
    ?- anukas(lukas,stefanija).
    true.

    ?- vpjz(tomas).
    true.
    ?- vpjz(rimas).
    false.

    ?- sv_suk(lukas).
    false.
    ?- sv_suk(antanas).
    true.
    ?- sv_suk(lina).
    true.

*/
asmuo(brone, moteris, 83, miegojimas).
asmuo(antanijus, vyras, 85, vaiksciojimas).
asmuo(stefanija, moteris, 89, siuvimas).
asmuo(petras, vyras, 90, siuvimas).
asmuo(romas, vyras, 55, zvejyba).
asmuo(vida, moteris, 52, televizija).
asmuo(rimas, vyras, 55, zvejyba).
asmuo(antanas, vyras, 50, staliavimas).
asmuo(lina, moteris, 50, grybavimas).
asmuo(zose, moteris, 66, siuvimas).
asmuo(juozas, vyras, 69, gyvunai).
asmuo(kazys, vyras, 52, uogavimas).
asmuo(vitas, vyras, 61, grybavimas).
asmuo(katastrofa, moteris, 59, uogavimas).
asmuo(kestas, vyras, 35, darbas).
asmuo(modestas, vyras, 33, darbas).
asmuo(tomas, vyras, 30, darbas).
asmuo(lukas, vyras, 22, vairavimas).
asmuo(akvile, moteris, 18, skaitymas).
asmuo(ilona, moteris, 44, skaitymas).
asmuo(robert, vyras, 53, automobiliai).
asmuo(valdas, vyras, 35, rasymas).
asmuo(galia, moteris, 38, muzika).
asmuo(igor, vyras, 40, muzika).
asmuo(sofija, moteris, 17, skaitymas).
asmuo(gabrielius, vyras, 13, maistas).
asmuo(dimitrij, vyras, 28, kompiuteriai).

mama(brone, vida).
mama(brone, rimas).
mama(brone, antanas).
mama(stefanija, lina).
mama(stefanija, zose).
mama(stefanija, kazys).
mama(stefanija, vitas).
mama(vida, kestas).
mama(vida, modestas).
mama(vida, tomas).
mama(lina, lukas).
mama(lina, akvile).
mama(zose, ilona).
mama(katastrofa, valdas).
mama(katastrofa, galia).
mama(ilona, sofija).
mama(ilona, gabrielius).
mama(galia, dimitrij).

pora(antanijus, brone).
pora(petras, stefanija).
pora(romas, vida).
pora(antanas, lina).
pora(juozas, zose).
pora(vitas, katastrofa).
pora(robert, ilona).
pora(igor, galia).

tevas(Tevas, Vaikas) :- mama(Tevas, Vaikas).
tevas(Tevas, Vaikas) :- pora(Tevas, Mama), mama(Mama, Vaikas).

brolis(Brolis, BrolisSesuo) :- mama(Mama, Brolis), mama(Mama, BrolisSesuo), asmuo(Brolis, vyras, _, _), Brolis \= BrolisSesuo.
sesuo(Sesuo, BrolisSesuo) :- mama(Mama, Sesuo), mama(Mama, BrolisSesuo), asmuo(Sesuo, moteris, _, _), Sesuo \= BrolisSesuo.

brolis_ir_sesuo(Brolis, Sesuo) :- brolis(Brolis, Sesuo), sesuo(Sesuo, Brolis).

brolisSeseuo(Asmuo1, Asmuo2) :- mama(Mama, Asmuo1), mama(Mama, Asmuo2), Asmuo1 \= Asmuo2.

anukas(Anukas, SenelisSenele) :- tevas(TarpinisTevas, Anukas), tevas(SenelisSenele, TarpinisTevas), asmuo(Anukas, vyras, _, _).

vpjz(Vyras) :- asmuo(Vyras, vyras, AsmuoAmzius, _), AsmuoAmzius > 20, AsmuoAmzius =< 30.

sv_suk(Jubiliatas) :- asmuo(Jubiliatas, _, AsmuoAmzius, _), 0 is AsmuoAmzius mod 10.