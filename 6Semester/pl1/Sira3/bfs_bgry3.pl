

%
%queue([]).
search(Goal,Goal).
search(State,Goal):- next_moves(State,M_C),list_to_Q(M_C),popQ(State2),search(State2,Goal).



list_to_Q(A):-queue(Q),append(Q,A,Qnew),retract(queue(Q)), assert(queue(Qnew)).
addQ(A,Q,R):-append(Q,[A],R).
do_visited([],_).
do_visited([H|T],[H|P]):- \+visited(H) ,addVisited(H),do_visited(T,P).
do_visited([H|T],P):-visited(H) ,do_visited(T,P).
popQ(H):- queue([H|Q]),retract(queue([H|Q])),assert(queue(Q)).
addVisited(A):- assert(visited(A)).
next_moves(State,M):- moves(State,K),addParrents(State,K,M).
%time for hashing
list_to_num([],[]).
list_to_num([98|T],[0|T1]):-list_to_num(T,T1).
list_to_num([103|T],[1|T1]):-list_to_num(T,T1).
list_to_num([71|T],[2|T1]):-list_to_num(T,T1).
list_to_num([114|T],[3|T1]):-list_to_num(T,T1).
list_to_num([121|T],[4|T1]):-list_to_num(T,T1).
%hash_f
hash_f([],0).
hash_f([X|T],X2):-hash_f(T,X1),X2 is X+X1*5.
addParrents(_,[],[]).
addParrents(S,[[X,H]|T],[X|T2]):- \+parrents(_,X,_),assert(parrents(S,X,H)),addParrents(S,T,T2).
addParrents(S,[[_X,_H]|T],T2):-addParrents(S,T,T2).
getSolution(Goal,[]):-parrents(Goal,Goal,_).
getSolution(Goal,[H|T]):-parrents(Next,Goal,H),getSolution(Next,T).
diapragmateysi(S,L):- string_to_list(S,Cur),isfinal(Goal),assert(queue([])),assert(parrents(Cur,Cur,0)),search(Cur,Goal),getSolution(Goal,PP),reverse(PP,AS),atomic_list_concat(AS,AA),string_codes(L,AA),!.
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4).
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
