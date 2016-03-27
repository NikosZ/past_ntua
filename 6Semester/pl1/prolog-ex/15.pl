%
dupli([],_,[]).
dupli(_,0,_).
%dupli([Y],N,[Y|Ts]):- Ks is N-1, dupli([])
dupli([Y|Ys],N,[Y|Xs]):- Ks is N-1 ,dupli([Y],Ks,K),append(K,T,Xs),dupli(Ys,N,T).
