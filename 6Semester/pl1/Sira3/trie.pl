
%
%queue([]).
search(Goal,Goal,_).
search(State,Goal,T,Q):- next_moves(State,M_C,T,T1),list_to_Q(Q,M_C,Q1),popQ(Q1,State2,Q2),search(State2,Goal,T1,Q2).
to_tree([],[],A,A).
to_tree([[X,H]|T],[[X,H]|T2],Root,Tree3):- \+ find(X,Root),insert(X,Root,Tree2),to_tree(T,T2,Tree2,Tree3).
to_tree([_|T],T2,A,B):- to_tree(T,T2,A,B).


list_to_Q(Q,A,Qnew):-append(Q,A,Qnew).
addQ(A,Q,R):-append(Q,[A],R).
do_visited([],_).
do_visited([H|T],[H|P]):- \+visited(H) ,addVisited(H),do_visited(T,P).
do_visited([H|T],P):-visited(H) ,do_visited(T,P).
popQ([H|T],H,T).
addVisited(A):- assert(visited(A)).
next_moves(State,M,T1,T2):- moves(State,K),to_tree(K,M1,T1,T2),addParrents(State,M1,M).
addParrents(_,[],[]).
addParrents(S,[[X,H]|T],[X|T2]):- assertz(parrents(X,S,H)),addParrents(S,T,T2).
%addParrents(S,[[X,_H]|T],T2):-hash_f(X,Hash),parrents(_,Hash,_),addParrents(S,T,T2).
getSolution(Goal,[]):-parrents(Goal,Goal,_).
getSolution(Goal,[H|T]):-parrents(Goal,Next,H),getSolution(Next,T).
diapragmateysi(S,L):- string_to_list(S,Cur),isfinal(Goal),assert(the_tree(tree(nill,[]))),assert(queue([])),assert(parrents(Cur,Cur,0)),search(Cur,Goal,tree(nill,[]),[]),write("A"),getSolution(Goal,PP),reverse(PP,AS),atomic_list_concat(AS,AA),string_codes(L,AA),!.
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4).
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).

find([A],tree(A,_)).
find([A,B|H],tree(nill,Kids)):- next_tree(A,Kids,Tree),find([A,B|H],Tree).
find([A,B|H],tree(A,Kids)):- next_tree(B,Kids,Tree),find([B|H],Tree).
next_tree(B,[tree(B,Kids)|T],tree(B,Kids)).
next_tree(B,[_|T],A):-next_tree(B,T,A).
next2(H,[tree(H,A)],[tree(H,A2)],tree(H,A),tree(H,A2)).
next2(H,[tree(H,A)|T],[tree(H,A2)|T],tree(H,A),tree(H,A2)).
next2(H,[A|T1],[A|T2],C,D):-next2(H,T1,T2,C,D).
insert([H|T],tree(A,Kids),tree(A,Kids2)):-next2(H,Kids,Kids2,A1,A2),insert(T,A1,A2).
insert([H|T],tree(A,Kids),tree(A,Kids2)):-const(T,K),append([tree(H,K)],Kids,Kids2).
const([],[]).
const([H|T],[tree(H,Kids)]):-const(T,Kids).


