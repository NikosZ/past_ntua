%
:-use_module(library(nb_set)).
%:-use_module(library(charsio)).

danger(A,X):- read_and_return(A,N,M),predsort(cmp,M,L1),!,list_of_sets(L1,L),!,empty_nb_set(Vis2),assertz(boal(false)),list_to_assoc([],Vis),nextMoves([]-L,Q,0,Size,Vis,Vis3,Var3),!,solving(Q,Size,Vis3,Var3),!,solu(X1),!,numlist(1,N,L2),last(X1,L2,X),!.
cmp(<,A,B):-length(A,N1),length(B,N2),(N1<N2;N1==N2).
cmp(>,A,B):-length(A,N1),length(B,N2),N1>N2.
list_to_set([],_).
list_to_set([X|T],S):- add_nb_set(X,S),list_to_set(T,S).


last([],L2,L2).
last([X|XS],L2,L3):- select(X,L2,L4),last(XS,L4,L3).

list_of_sets([],[]).
list_of_sets([X|T],[S|T1]):-empty_nb_set(S),list_to_set(X,S),list_of_sets(T,T1).


solving(Q,SizeofQ,Vis,Var):-(Var>0,!);(getQ(Q,State,Qnew),Size1 is SizeofQ -1,nextMoves(State,Qnew,Size1,Size2,Vis,Vis2,Var2),!,solving(Qnew,Size2,Vis2,Var2)).


nextMoves(A-[H|T],Q,Size1,Size2,Vis,Vis2,Var):-nb_set_to_list(H,L),moves(A,L,T,NewM,Var),filter(NewM,Vis,NewM2,Vis2),insertQ(Q,NewM2,Size1,0),length(NewM2,N2),Size2 is Size1 + N2.

moves(_,[],_,[],0).
moves(A,[H|Rest],T,[H1-P1|T1],Var1):-append([H],A,H1),exclude(element(H1),T,P1),check(H1,P1,Var),moves(A,Rest,T,T1,Var2),Var1 is Var2 + Var.
check(H1,[],1):-assertz(boal(true)),assertz(solu(H1)).
check(_,_,0).

filter([],A,[],A).
filter([H-T|T2],Vis,[H-T|Tail],Vis3):-hash_f1(H,Hash1,Hash2),((\+ exists_in_hash(Hash1,Hash2,Vis),addTo(Hash1,Hash2,Vis,Vis2),!,filter(T2,Vis2,Tail,Vis3))).
filter([H-T|T2],Vis,Tail,Vis3):-(filter(T2,Vis,Tail,Vis3)).
exists_in_hash(Hash1,Hash2,AssocL):- (get_assoc(Hash1,AssocL,Val),add_nb_set(Hash2,Val,false),!).

addTo(Hash1,Hash2,Vis,Vis2):- (get_assoc(Hash1,Vis,Val),add_nb_set(Hash2,Val),Vis2=Vis) ;(empty_nb_set(V2),add_nb_set(Hash2,V2),put_assoc(Hash1,Vis,V2,Vis2),!).

getQ([El|T],El,T).
insertQ(_,[],_,_).
insertQ([El|T1],[El|T],K,K):-insertQ(T1,T,K,K).
insertQ([_|T1],T,K,K1):-K2 is K1+1,insertQ(T1,T,K,K2).

element([X|XS],M):-add_nb_set(X,M,false);element(XS,M).

%add to Queue check if it is a solution
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
read_and_just_print_dangers(File) :-
	    open(File, read, Stream),
	        repeat,
		    read_line_to_codes(Stream, X),
		        ( X \== end_of_file -> writeln(X), fail ; close(Stream), ! ).


hash_f1(L,Hash1,Hash2):-sort(L,L1),hash_f(L1,0,Hash1,0,28,Res),hash_f(Res,0,Hash2,0,17,[]),!.
hash_f([],H1,H1,_,_,[]).
hash_f(T,H1,H1,A,A,T).
hash_f([H|Ts],H1,Hash1,B,A,T):-H2 is H1 + (2<< (H mod A)),B1 is B+1,hash_f(Ts,H2,Hash1,B1,A,T).
