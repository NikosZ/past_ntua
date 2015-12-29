


%
%queue([]).
search(Goal,Goal,A,A,_,_).
search(State,Goal,List,L3,[H|T],N):- next_moves(State,M_C,List,L2),!,list_to_Q(M_C,[H|T],N,NK),N1 is N-1+NK,!,search(H,Goal,L2,L3,T,N1).

list_to_Q([],_,_,0).
list_to_Q([A,B,C,D],[A,B,C,D|_],0,4).
list_to_Q([A,B,C],[A,B,C|_],0,3).
list_to_Q([A,B],[A,B|_],0,2).
list_to_Q([A],[A|_],0,1).
list_to_Q(A,[H|T],N,NK):-N1 is N-1,list_to_Q(A,T,N1,NK). %queue(Q),append(Q,A,Qnew),retract(queue(_)),assertz(queue(Qnew)).
addQ(A,Q,R):-append(Q,[A],R).
popQ(H):-queue([H|T]),retract(queue(_)),assertz(queue(T)).
next_moves(State,M,L1,L2):- moves(State,K),hash_f(State,Hash),!,addParrents(Hash,K,M,L1,L2).
%time for hashing
list_to_num([],[]).
list_to_num([98|T],[0|T1]):-list_to_num(T,T1).
list_to_num([103|T],[1|T1]):-list_to_num(T,T1).
list_to_num([71|T],[2|T1]):-list_to_num(T,T1).
list_to_num([114|T],[3|T1]):-list_to_num(T,T1).
list_to_num([121|T],[4|T1]):-list_to_num(T,T1).
%hash_f
hash_f([],0).
hash_f([X|T],X2):-hash_f(T,X1),!,X2 is X+X1*5.
addParrents(_,[],[],A,A).
addParrents(S,[[X,H]|T],[X|T2],List,L3):- hash_f(X,Hash),\+get_assoc(Hash,List,_),!,put_assoc(Hash,List,parrents(S,H),List2),addParrents(S,T,T2,List2,L3).
%addParrents(S,[[X,_H]|T],T2):-hash_f(X,Hash),parrents(_,Hash,_),addParrents(S,T,T2).
addParrents(S,[[X,_H]|T],T2,L,L2):-addParrents(S,T,T2,L,L2).
getSolution(Goal,Goal,[],L).
getSolution(Goal,G,[H|T],L):-get_assoc(Goal,L,parrents(Next,H)),getSolution(Next,G,T,L).
diapragmateysi(S,L):- string_to_list(S,Cur22),isfinal(Goal1),list_to_num(Goal1,Goal),list_to_num(Cur22,Cur),assert(queue([])),hash_f(Cur,CurH),list_to_assoc([CurH-parrents(CurH,0)],L1),search(Cur,Goal,L1,L4,QKKT,0),!,hash_f(Goal,GK),getSolution(GK,CurH,PP,L4),reverse(PP,AS),atomic_list_concat(AS,AA),string_codes(L,AA),!.
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4),!.
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
