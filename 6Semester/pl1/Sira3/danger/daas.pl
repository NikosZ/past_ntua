/* from softlab predicate to read measurments from file */
read_and_return(File, N, Combos) :-
    open(File, read, Stream),
    read_line(Stream, [N, M]),
    read_segs(Stream, M, Combos),
    close(Stream).

read_segs(Stream, M, Combos) :-
    ( M > 0 ->
    Combos = [Combo|Rest],
        read_line(Stream, [K|Combo]),
    length(Combo, K), %% just an assertion for for extra safety 
        M1 is M - 1,
        read_segs(Stream, M1, Rest)
    ; M =:= 0 ->
    Combos = []
    ).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).

danger(File,S):- read_and_return(File,N,Combos), dan(Combos,N,S),!.


com(<,A,B) :- length(A,L1),length(B,L2),(L1<L2 ; L1=L2) .		/* comparison for predicate sort */
com(>,A,B) :- length(A,L1),length(B,L2),L1>L2.

thereis(H,[H|_]).
thereis(H,[X|T]) :- H>X, thereis(H,T).

answer([],[]).								/* generator of measurments */
answer([H|T],[[H|_]|L]) :- exclude(thereis(H),L,RL), answer(T,RL).
answer(L,[[_|T]|L2]) :- answer(L,[T|L2]).

update(L,[],L).								/* when measurments are found, create the list so no danger */
update(L1,[H|T],L2) :- select(H,L1,L11), update(L11,T,L2).		/* measurments exists */

min_sol(E, _, [], E).							/* finds the minimum length list */
min_sol(E, N1, [H|T], A) :- length(H,N2), (N1 < N2 -> min_sol(E, N1, T,A) ; min_sol(H, N2, T,A) ).

sortlistof([],[]).
sortlistof([H1|T1],[H2|T2]):- sort(H1,H2),sortlistof(T1,T2).

dan(L,N,A) :- 	predsort(com,L,SLL),sortlistof(SLL,SL), findall(X, answer(X, SL), [HA|TA]), length(HA,N1), 	/* the prediate */
        min_sol(HA, N1, TA, GA), numlist(1,N,MA), update(MA,GA,A).
