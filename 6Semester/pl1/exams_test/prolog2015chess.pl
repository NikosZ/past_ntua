%
jump(N,X/Y,Z/T):- Z is X+2,T is Y +1 ,Z<N,T<N.
jump(N,X/Y,Z/T):- Z is X+2,T is Y -1 ,Z>0,T>0,Z<N ,T<N.
jump(N,X/Y,Z/T):-Z is X-2,T is Y +1 ,Z>0, Z<N ,T<N.
jump(N,X/Y,Z/T):-Z is X-2,T is Y -1 ,Z>0,T>0, Z<N ,T<N .
jump(N,X/Y,T/Z):- Z is X+2,T is Y +1,Z<N ,T<N .
jump(N,X/Y,T/Z):-Z is X+2,T is Y -1 , Z>0,T>0,Z<N ,T<N .
jump(N,X/Y,T/Z):-Z is X-2,T is Y +1 ,Z>0, Z<N ,T<N .
jump(N,X/Y,T/Z):-Z is X-2,T is Y -1,Z>0,T>0, Z<N ,T<N.
knightpath(_,[]).
knightpath(N,[X/Y]) :- X<N,Y<N.
knightpath(N,[X/Y,Z/T|Xs]) :- X<N,Y<N,jump(N,X/Y,Z/T),knightpath(N,[Z/T|Xs]),\+ member(X/Y,Xs).

%last question
?- length(Xs,3),knightpath(9,[2/1|Xs]),append(_,[_/8],Xs).

