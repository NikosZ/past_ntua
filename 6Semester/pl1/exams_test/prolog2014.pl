%
lensort(X,Y):- mkpair(X,Y1),keysort(Y1,Y2),getkeys(Y2,K),solution(Y2,K,Y3),mkpair(Y,Y3).

getkeys([],[]).
getkeys([X-_|XS],[X|T]):-getkeys(XS,T).
mkpair([],[]).
mkpair([X|XS],[N-X|NS]):- length(X,N),mkpair(XS,NS).
solution([],[]).
solution(,[]).

selectkey(_,)
selectkey(K,[X-T|XS],L):-K==X,
