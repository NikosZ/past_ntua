%
flatten([],[]).
flatten([A],[A]):- \+islist(A).
flatten([H|T],L):-islist(H),length(H,0),flatten(T,L).
flatten([H|T],L):-islist(H),flatten(H,L1),flatten(T,L2),append(L1,L2,L).
flatten([H|T],L):-  \+islist(H),flatten(T,L2),append([H],L2,L).
islist([_|_]).
islist([]).

match([],[]).
match([],[?]).
match([A],[?]).
match([A],[A]).
match([A],[+]).
match([H|T],[H|L]):- match(T,L).
match([H|T],[+|L]):- match(T,L).
match([H|T],[+|L]):- match(T,[+|L]).
match([H|T],[?|L]):- match(T,L).
match([H|T],[?|L]):- match([H|T],L).
