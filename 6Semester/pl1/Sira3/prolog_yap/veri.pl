%
:-use_module(library(charsio)).

isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- format_to_chars("bgbGgGGrGyry",'',K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4),!.
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).

movesp(1,N,S):-move1(N,S).
movesp(2,N,S):-move2(N,S).
movesp(3,N,S):-move3(N,S).
movesp(4,N,S):-move4(N,S).


veri(Moves,Start):-format_to_chars(Start,'',List),isfinal2(K),verif(Moves,List,K).

verif([],A,A).
verif([H|T],C,G):-movesp(H,C,Cn),verif(T,Cn,G).
