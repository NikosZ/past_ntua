%
:-use_module(library(nb_set)).
:-use_module(library(heaps)).
%:-use_module(library(charsio)).
test(A,X):- read_and_return(A,N,M),predsort(cmp,M,L1),!,list_of_sets(L1,X),!.

danger(A,X):- read_and_return(A,N,M),predsort(cmp,M,L1),!,list_of_sets(L1,L),!,empty_nb_set(Vis),assertz(boal(false)),nextMoves([]-L,Q,0,Size,Vis),!,solving(Q,Size,Vis),!,solu(X1),!,numlist(1,N,L2),last(X1,L2,X),!.
cmp(<,A,B):-length(A,N1),length(B,N2),(N1<N2;N1==N2).
cmp(>,A,B):-length(A,N1),length(B,N2),N1>N2.
list_to_set([],_).
list_to_set([X|T],S):- add_nb_set(X,S),list_to_set(T,S).


last([],L2,L2).
last([X|XS],L2,L3):- select(X,L2,L4),last(XS,L4,L3).

list_of_sets([],[]).
list_of_sets([X|T],[S|T1]):-empty_nb_set(S),list_to_set(X,S),list_of_sets(T,T1).


solving(Q,SizeofQ,Vis):-(boal(true),!);(getQ(Q,State,Qnew),Size1 is SizeofQ -1,nextMoves(State,Qnew,Size1,Size2,Vis),!,solving(Qnew,Size2,Vis)).


nextMoves(A-[H|T],Q,Size1,Size2,Vis):-nb_set_to_list(H,L),moves(A,L,T,NewM),insertQ(Q,NewM,Size1,0),length(NewM,N2),Size2 is Size1 + N2.

moves(_,[],_,[]).
moves(A,[H|Rest],T,[H1-P1|T1]):-append([H],A,H1),exclude(element(H1),T,P1),check(H1,P1),!,moves(A,Rest,T,T1).
check(H1,[]):-assertz(boal(true)),assertz(solu(H1)).
check(_,_).

filter([],_,[]).
filter([H-T|T2],Vis,[H1-T1|Tail]):-(\+ add_nb_set(H,Vis,false),add_nb_set(H,Vis),H1=H,T1=T,filter(T2,Vis,Tail));filter(T2,Vis,[H1-T1|Tail]).

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
