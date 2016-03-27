
%
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4).
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
movesr(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(X1,H),move2(X2,H),move3(X3,H),move4(X4,H).


addQ([]).
addQ([[A,B]|T]):-queue(K), ,addQ(T).
search(State,Goal):-moves(State,M_C),movesr(Goal,M_P),addQ(M_C),addQ2(M_P2),   popQ(State2),popQ(Goal2),search(State2,Goal2).

