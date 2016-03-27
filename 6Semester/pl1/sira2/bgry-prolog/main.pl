%

bfs() :- queue_pop(X,T,Prev),(solution(X) -> true;moves(X,L), \+ member(L,Visited),queue_add(L,T,New) ).

queue_add(H,[],[H]).
queue_add(H,[K|T],[K|B]):- queue_add(H,T,B).
queue_pop(H,T,[H|T]).

moves (H,[X1,X2,X3,X4]):- move1(H,X1);move2(H,X2);move3(H,X3);move4(H,X4).
move1 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11] ,[a2,a1,a5,a0,a4,a3,a6,a7,a8,a9,a10,a11,c]).
move2 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,c],[a0,a3,a2,a6,a1,a5,a4,a7,a8,a9,a10,a11,c]).
move3 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,c] ,[a0,a1,a2,a3,a4,a7,a6,a10,a5,a9,a8,a11,c]).
move4 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,c],[a0,a1,a2,a3,a4,a5,a8,a7,a11,a6,a10,a9,c]).
