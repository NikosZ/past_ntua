%

bfs() :- queue_pop(X,T,L),(solution(X) -> true; ).

queue_add(H,[],[_|H]).
queue_add(H,[K|T],[K|B]):- queue_add(H,T,B).
queue_pop(H,T,[H|T]).

moves (H,X):- move1(H,X);move2(H,X);move3(H,X);move4(H,X).
move1 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11] ,[a2,a1,a5,a0,a4,a3,a6,a7,a8,a9,a10,a11,c]).
move2 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,c],[a0,a3,a2,a6,a1,a5,a4,a7,a8,a9,a10,a11,c]).
move3 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,c] ,[a0,a1,a2,a3,a4,a7,a6,a10,a5,a9,a8,a11,c]).
move4 ([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,c],[a0,a1,a2,a3,a4,a5,a8,a7,a11,a6,a10,a9,c]).
