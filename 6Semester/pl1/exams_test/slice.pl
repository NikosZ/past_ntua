%
step2(A,0,[]).
step2([X|Xs],C,[X|Ys]):- C1 is C-1, step2(Xs,C1,Ys).
slice(A,0,C,RES):-step2(A,C,RES).
slice([A|Xs],N,C,Res):-N1 is N-1,C1 is C-1, slice(Xs,N1,C1,Res).
