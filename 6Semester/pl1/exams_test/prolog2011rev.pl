%
same_leaves([],[]).
same_leaves(A,B):- concat_ls(A,A1),concat_ls(B,B1),same_list(B1,A1).
same_list([],[]).
same_list([A|Xs],[A|Ys]):- same_list(Xs,Ys).

concat_ls([],[]).
concat_ls([[X]|Xs],[Y|YS]):-append([X],Xs,Ts),concat_ls(Ts,[Y|YS]).
concat_ls([X|Xs],[X|YS]):-concat_ls(Xs,YS).
