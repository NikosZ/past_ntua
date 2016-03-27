%
:-use_module(library(nb_set)).
%:-use_module(library(charsio)).
danger(A,X):- read_and_return(A,N,M),predsort(cmp,M,L1),!,list_of_sets(L1,L),!,empty_nb_set(Vis),solve([],L,0,X,Vis).

cmp(<,A,B):-length(A,N1),length(B,N2),(N1<N2;N1==N2).
cmp(>,A,B):-length(A,N1),length(B,N2),N1>N2.
list_to_set([],_).
list_to_set([X|T],S):- add_nb_set(X,S),list_to_set(T,S).

list_of_sets([],[]).
list_of_sets([X|T],[S|T1]):-empty_nb_set(S),list_to_set(X,S),list_of_sets(T,T1).




solve([],[H|TT],Size,Res,Visited):-next_moves([],Q,Size,H,K,Bool,Temp,Visited,[H|TT]),!,Sizen is Size + K-1,((Bool,Res=Temp) ; solve(Q,TT,Sizen,Res,Visited)).
solve([H|T],Lset,Size,Res,Visited):-next_moves(H,T,Size,Lset,K,Bool,Temp,Visited,Lset),!,Sizen is Size + K-1,((Bool==true,Res=Temp) ; solve(T,Lset,Sizen,Res,Visited)).



next_moves([],Q,Size,S1,Iter,Bool,Temp,Visited,Allset):-write(5), ( (insertToQ(Size,State,S1,Q,Moves,Temp,0,Iter,Visited,),!, (check_solution(Moves,Allset,Temp),Bool=true );(Bool=false) )).
next_moves(State,Q,Size,[S1|T1],Iter,Bool,Temp,Visited,Allset):- ((check(State,S1),next_moves(State,Q,Size,T1,Iter,Bool,Temp,Visited,Allset)) ; (insertToQ(Size,State,S1,Q,Moves,Temp,0,Iter,Visited), (check_solution(Moves,Allset,Temp),Bool=true );(Bool=false) )).

check([H|T],S):- add_nb_set(H,S,false);check(T,S).

insertToQ(A,State,Set,Q,Moves,Temp,A,Iter,Visited):-nb_set_to_list(Set,L),state_moves(State,Set,Visited,Moves),in(Moves,Q),length(Moves,N2),Iter is A +N2,!.
insertToQ(A,State,Set,[H|T],Bool,Temp,B,Iter,Visited):-B1 is B+1,insertToQ(A,State,Set,T,Bool,Temp,B1,Iter,Visited).

in([],_).
in([A|T],[A|T1]):-in(T,T1).
state_moves(_St,[],_V,[]).
state_moves(St,Set,V,[H1|T1]):-gen_nb_set(Set,H),append(St,[H],HK),((add_nb_set(HK,V,false),add_nb_set(HK,V,true),HK=H1,!,state_moves(St,T,V,T1)); state_moves(St,T,V,[H1|T1])).

check_all_sets(_,[]).
check_all_sets(H,[S|S2]):- \+check(H,S),check_all_sets(H,S2).
check_solution([H|T],Set,Sol):-(check_all_sets(H,Set),H=Sol,!);check_solution(T,Set,Sol).  

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
