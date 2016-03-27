%
pack([],[]).
pack([X],[X]).%:- append([X],[],Y),pack([],Leet).
pack([X,X|Leet],[Y|Ys]):- append([X],L,Y),pack([X|Leet],[L|Ys]) .
pack([X,Y|Leet],[Yk|Ys]):- X\=Y, append([X],[],Yk),pack([Y|Leet],Ys).
