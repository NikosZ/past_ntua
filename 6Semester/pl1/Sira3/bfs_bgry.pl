%

search(Goal,Goal,_).
search(State,Goal,Q):- next_moves(State,M_C),list_to_Q(M_C,Q,Qnew),popQ(State2,Qnew,Qnew2),search(State2,Goal,Qnew2).



list_to_Q(A,Q,L):-append(Q,A,L).
addQ(A,Q,R):-append(Q,[A],R).
do_visited([],_).
do_visited([H|T],[H|P]):- \+visited(H) ,addVisited(H),do_visited(T,P).
do_visited([H|T],P):-visited(H) ,do_visited(T,P).
popQ(H,[H|T],T).
addVisited(A):- assert(visited(A)).
next_moves(State,M):- moves(State,K),addParrents(State,K,M).

addParrents(_,[],[]).
addParrents(S,[[X,H]|T],[X|T2]):- \+parrents(_,X,_),assert(parrents(S,X,H)),addParrents(S,T,T2).
addParrents(S,[[X,_H]|T],T2):-parrents(_,X,_),addParrents(S,T,T2).
getSolution(Goal,[]):-parrents(Goal,Goal,_).
getSolution(Goal,[H|T]):-parrents(Next,Goal,H),getSolution(Next,T).
diapragmateysi(S,L):- string_to_list(S,Cur),isfinal(Goal),assert(parrents(Cur,Cur,0)),search(Cur,Goal,[]),getSolution(Goal,PP),reverse(PP,AS),atomic_list_concat(AS,AA),string_codes(L,AA),!.
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4).
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
