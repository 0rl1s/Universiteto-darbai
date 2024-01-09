/*
    Autorius: Lukas Orliukas
    Kursas: programu sistemos 4 kursas
    Grupe: 3 grupe
    Uzduoties variantas: 4
*/

/*
    ?- can_chain([(2,1),(2,3),(1,3)]).
    true.
    ?- print_saved_chain.
    2:1,1:3,3:2,

    ?- can_chain([(1,2),(4,1),(2,3)]).
    false.

    ?- can_chain([(0,0),(0,1),(1,1),(0,2),(1,2),(2,2),(0,3),(1,3),(2,3),(3,3),(0,4),(1,4),(2,4),(3,4),(4,4)]). 
    true.
    ?- print_saved_chain.
    0:0,0:1,1:1,1:2,2:0,0:3,3:1,1:4,4:2,2:2,2:3,3:3,3:4,4:4,4:0,
*/


can_chain([]).
can_chain([(X, Y) | Rest]) :- once(can_chain(X, Y, Rest, [(X, Y)])).
can_chain(X, X, [], Chain) :- save_chain(Chain).
can_chain(Start, Next, Pieces, Chain) :- select(Piece, Pieces, Remaining), ((Next, Y) = Piece; (Y, Next) = Piece), can_chain(Start, Y, Remaining, [(Next, Y) | Chain]).

save_chain(Chain) :- retractall(saved_chain(_)), asserta(saved_chain(Chain)).

print_saved_chain :- saved_chain(Chain), reverse(Chain, ReversedChain), print_chain_format(ReversedChain).

print_chain_format([]).
print_chain_format([(X, Y) | Rest]) :- format("~w:~w,", [X, Y]), print_chain_format(Rest).





