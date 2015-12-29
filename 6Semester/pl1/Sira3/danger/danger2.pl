
%
:-use_module(library(nb_set)).
%:-use_module(library(charsio)).
danger(A,X):- read_and_return(A,N,M),predsort(cmp,M,L1),!,list_of_sets(L1,L2),!,solve(L2,X,0).

list_to_set([],_).
list_to_set([X|T],S):- add_nb_set(X,S),list_to_set(T,S).

list_of_sets([],[]).
list_of_sets([X|T],[S|T1]):-empty_nb_set(S),list_to_set(X,S),list_of_sets(T,T1).
cmp(<,A,B):- length(A,N1),length(B,N2),(N1<N2 ; N1==N2).
cmp(>,A,B):- length(A,N1),length(B,N2),N1>N2.


solve(Sets,Sol,N):-N1 is N+1,length(Sol2,N1),!,((findasol(Sol2,Sets),Sol=Sol2 ); solve(Sets,Sol,N1)).

has_element(_,[]).
has_element(Set,[H|T]):- \+add_nb_set(H,Set,false),has_element(Set,T).
findasol([],[]).
findasol(S1,[H|T]):-(\+has_element(H,S1),findasol(S1,T));(member(K,S1),gen_nb_set(H,K),findasol(S1,T)).
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
