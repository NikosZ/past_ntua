
%
%queue([]).
search(State,Goal):-hash_f(State,Hash),parrents2(_,Hash,_).
search(State,Goal):-hash_f(Goal,Hash),parrents(_,Hash,_).
search(State,Goal):- next_moves(State,M_C),list_to_Q(M_C),next_moves2(Goal,M_C2),list_to_Q2(M_C2),popQ(State2),popQ2(Goal2),search(State2,Goal2).



list_to_Q(A):-queue(Q),append(Q,A,Qnew),retract(queue(Q)), assert(queue(Qnew)).
list_to_Q2(A):-queue2(Q),append(Q,A,Qnew),retract(queue2(Q)), assert(queue2(Qnew)).
addQ(A,Q,R):-append(Q,[A],R).
do_visited([],_).
do_visited([H|T],[H|P]):- \+visited(H) ,addVisited(H),do_visited(T,P).
do_visited([H|T],P):-visited(H) ,do_visited(T,P).
popQ(H):- queue([H|Q]),retract(queue([H|Q])),assert(queue(Q)).
popQ2(H):- queue2([H|Q]),retract(queue2([H|Q])),assert(queue2(Q)).
addVisited(A):- assert(visited(A)).
next_moves(State,M):- moves(State,K),hash_f(State,Hash),addParrents(Hash,K,M).
next_moves2(State,M):- moves2(State,K),hash_f(State,Hash),addParrents2(Hash,K,M).
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
addParrents2(_,[],[]).
addParrents2(S,[[X,H]|T],[X|T2]):- hash_f(X,Hash),\+parrents2(_,Hash,_),assert(parrents2(S,Hash,H)),addParrents2(S,T,T2).
addParrents2(S,[[X,_H]|T],T2):-addParrents2(S,T,T2).
addParrents(_,[],[]).
addParrents(S,[[X,H]|T],[X|T2]):- hash_f(X,Hash),\+parrents(_,Hash,_),assert(parrents(S,Hash,H)),addParrents(S,T,T2).
%addParrents(S,[[X,_H]|T],T2):-hash_f(X,Hash),parrents(_,Hash,_),addParrents(S,T,T2).
addParrents(S,[[X,_H]|T],T2):-addParrents(S,T,T2).
getSolution(Goal,[]):-parrents(Goal,Goal,_).
getSolution(Goal,[H|T]):-parrents(Next,Goal,H),getSolution(Next,T).
diapragmateysi(S,L):- string_to_list(S,Cur22),isfinal(Goal1),list_to_num(Goal1,Goal),list_to_num(Cur22,Cur),assert(queue([])),assert(queue2([])),hash_f(Cur,CurH),assert(parrents(CurH,CurH,0)),hash_f(Goal,GK),assert(parrents2(GK,GK,2)),search(Cur,Goal),getSolution(GK,PP),reverse(PP,AS),atomic_list_concat(AS,AA),string_codes(L,AA),!.
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4).
moves2(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(X1,H),move2(X2,H),move3(X3,H),move4(X4,H).
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
