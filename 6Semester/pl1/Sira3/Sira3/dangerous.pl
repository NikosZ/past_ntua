%

danger(A,X):- read_and_return(A,N,M),numlist(1,N,L),solve(X,M,N,L),!.

solve(X,M,N,L):- (length(X,N),subset(L,X),not_sub(X,M));(Ns is N -1,solve(X,M,Ns,L)) .
subset([], []).
subset([E|Tail], [E|NTail]):-
  subset(Tail, NTail).
subset([_|Tail], NTail):-
  subset(Tail, NTail).
not_sub(_,[]).
not_sub(X,[M|Ms]):- \+ sub(X,M),not_sub(X,Ms).
%sub(X,M):- append(_,M,X).
sub(_,[]).
sub(X,[M|Ms]):-member(M,X),sub(X,Ms).
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
