/*
    Autorius: Lukas Orliukas
    Kursas: programu sistemos 4 kursas
    Grupe: 3 grupe
    Uzduoties variantai: 1.7, 2.2, 3.6, 4.3
*/

/*
    Uzduoties variantas: 1.7
    ?- maxlyg([4,10,-2,-1,23], M).
    M = 10.
    maxlyg([1,-10,9,11,-12,3,-8], M).
    M = -8.
*/

lyginis(X) :- X mod 2 =:= 0.

maxlyg([X|T], M) :- lyginis(X), !, maxlyg(T, X, M).
maxlyg([_|T], M) :- maxlyg(T, M).
maxlyg([], M, M).
maxlyg([X|T], Didziausias, M) :- lyginis(X), !, Tarpinis is max(X, Didziausias), maxlyg(T, Tarpinis, M).
maxlyg([_|T], Didziausias, M) :- maxlyg(T, Didziausias, M).

/*
    Uzduoties variantas: 2.2
    ?- apjungti([[a,b],[c],[d,[e,f], g]], R).
    R = [a, b, c, d, [e, f], g].
    ?- apjungti([[a,b],[c],[d,[h,[e,f]], g]], R).
    R = [a, b, c, d, [h, [e, f]], g].


*/

apjungti([], []).
apjungti([[]|T], R) :- apjungti(T, R).
apjungti([[H|T]|Likes], [H|TL]) :- apjungti([T|Likes], TL).

/*
    Uzduoties variantas: 3.6
    ?- rusiuoti([1,23,5,1,2],R).
    R = [1, 1, 2, 5, 23].
    ?- rusiuoti([1,23,5,-1,2,-6,0],R).
    R = [-6, -1, 0, 1, 2, 5, 23].
    ?- rusiuoti([1,1,1,2,1,1],R).
    R = [1, 1, 1, 1, 1, 2].

*/

iterpti(Elementas, [], [Elementas]):- !.
iterpti(Elementas, [H|T], [Elementas, H|T]):- Elementas =< H, !.
iterpti(Elementas, [H|T1], [H|T2]):- iterpti(Elementas, T1, T2).

rusiuoti([], []).
rusiuoti([H|T], Surusiuotas):- rusiuoti(T, TarpinisSurusiuotas), iterpti(H, TarpinisSurusiuotas, Surusiuotas).

/*
    Uzduoties variantas: 4.3
    suma([9,4,6,1,3,4], [2,8], Sum).
    Sum = [9, 4, 6, 1, 6, 2].
    suma([9,4,6,1,3,4], [9,4,6,1,3,4], Sum).
    Sum = [1, 8, 9, 2, 2, 6, 8].
    suma([9,4,6,1,3], [9,4,6,1,3,4], Sum).
    Sum = [1, 0, 4, 0, 7, 4, 7].
    suma([9,4,6,1,3], [], Sum).
    Sum = [9, 4, 6, 1, 3].
    suma([], [9,4,6,1,3,4], Sum).
    Sum = [9, 4, 6, 1, 3, 4].

*/


apverstas(S1, S2) :- apverstas(S1, [], S2).
apverstas([], Tarpinis, Tarpinis).
apverstas([H|T], Tarpinis, Apverstas) :- apverstas(T, [H|Tarpinis], Apverstas).


suma(S1, S2, Sum) :- apverstas(S1, ApverstasS1), apverstas(S2, ApverstasS2), suma_apverstu(ApverstasS1, ApverstasS2, 0, ApverstasSum), !, apverstas(ApverstasSum, Sum).

suma_apverstu([], [], 0, []).
suma_apverstu([H1|T1], [H2|T2], Minty, [SumaH|SumaT]) :- TarpSuma is H1 + H2 + Minty, SumaH is TarpSuma mod 10, NaujasMinty is TarpSuma // 10, suma_apverstu(T1, T2, NaujasMinty, SumaT).

suma_apverstu([], [], Minty, [Minty]) :- Minty > 0, !.
suma_apverstu([H|T], [], Minty, [SumaH|SumaT]) :- TarpSuma is H + Minty, SumaH is TarpSuma mod 10, NaujasMinty is TarpSuma // 10, suma_apverstu(T, [], NaujasMinty, SumaT).
suma_apverstu([], [H|T], Minty, [SumaH|SumaT]) :- TarpSuma is H + Minty, SumaH is TarpSuma mod 10, NaujasMinty is TarpSuma // 10, suma_apverstu([], T, NaujasMinty, SumaT).




