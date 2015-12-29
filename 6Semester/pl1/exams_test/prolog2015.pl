%
next([],[]).
next([X],[1,X]).
next([X,Y|Xs],[1,X|Ys]):- next([Y|Xs],Ys).
next([X,X|Xs],[Y1,X|Ys]):-Y1>0,Y2 is Y1-1,next([X|Xs],[Y2,X|Ys]).
