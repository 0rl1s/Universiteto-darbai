/*
    Autorius: Lukas Orliukas
    Kursas: programu sistemos 4 kursas
    Grupe: 3 grupe
    Uzduoties variantai: 1.3, 6.2

    galima nuvaziuoti is miesto X i miesta Y nevaziuojant per miesta M.
    ?- keliasNevaziuojant(vilnius, lazdijai, alytus).
    false.
    ?- keliasNevaziuojant(vilnius, lazdijai, druskininkai).
    true 

    ?- skirtumas(ss(ss(ss(nul))), ss(ss(nul)), Skirt).
    Skirt = ss(nul) .
    ?- skirtumas(ss(nul), ss(ss(nul)), Skirt).
    Skirt = nul .
    ?- skirtumas(ss(nul), nul, Skirt).
    Skirt = ss(nul) .
    ?- skirtumas(nul, ss(ss(nul)), Skirt).
    Skirt = nul .

*/

kelias(vilnius, utena, 97).
kelias(vilnius, panevezys, 137).
kelias(vilnius, kaunas, 103).
kelias(panevezys, utena, 103).
kelias(kaunas, siauliai, 175).
kelias(kaunas, marijampole, 62).
kelias(kaunas, alytus, 71).
kelias(alytus, varena, 48).
kelias(alytus, druskininkai, 59).
kelias(alytus, lazdijai, 45).
kelias(druskininkai, lazdijai, 48).


keliasNevaziuojantVidinis(X, Y, M, _) :- kelias(X, Y, _), X \== M, Y \== M.
keliasNevaziuojantVidinis(X, Y, M, Pravaziuota) :- kelias(X, T, _), X \== M, T \== M, \+ member(T, Pravaziuota), keliasNevaziuojantVidinis(T, Y, M, [X | Pravaziuota]).

keliasNevaziuojant(X, Y, M) :- (kelias(X, Y, _) ; (X \== M, Y \== M, keliasNevaziuojantVidinis(X, Y, M, []))).

/* darau su ss, nes naudojant tiesiog s tekstas po jos keiciasi i komentara (arba kazka panasaus) */

skirtumas(nul, _, nul).
skirtumas(X, nul, X).
skirtumas(ss(X), ss(Y), Z) :- skirtumas(X, Y, Z).


