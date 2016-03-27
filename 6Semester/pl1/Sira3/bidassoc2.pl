


%
%queue([]).
search(Goal,_,A,A,_,_,_,_B,B,Goal):-hash_f(Goal,H),!,get_assoc(H,B,_).
search(_,Goal,A,A,_,_,_,_B,B,Goal):-hash_f(Goal,H),!,get_assoc(H,A,_).
search(State,Goal,List,L3,[H|T],N,[H2|T2],N2,List2,L5,TT):- next_moves(State,M_C,List,L2),!,list_to_Q(M_C,[H|T],N,NK),N1 is N-1+NK,!,rev_next_moves(Goal,M_C2,List2,L6),list_to_Q(M_C2,[H2|T2],N2,NK2),N3 is N2-1+NK2,write(N2),nl,search(H,H2,L2,L3,T,N1,T2,N3,L6,L5,TT).

list_to_Q([],_,_,0).
list_to_Q([A,B,C,D],[A,B,C,D|_],0,4).
list_to_Q([A,B,C],[A,B,C|_],0,3).
list_to_Q([A,B],[A,B|_],0,2).
list_to_Q([A],[A|_],0,1).
list_to_Q(A,[H|T],N,NK):-N1 is N-1,list_to_Q(A,T,N1,NK). %queue(Q),append(Q,A,Qnew),retract(queue(_)),assertz(queue(Qnew)).
addQ(A,Q,R):-append(Q,[A],R).
popQ(H):-queue([H|T]),retract(queue(_)),assertz(queue(T)).
next_moves(State,M,L1,L2):- moves(State,K),hash_f(State,Hash),!,addParrents(Hash,K,M,L1,L2).
rev_next_moves(State,M,L1,L2):- rev_moves(State,K),hash_f(State,Hash),!,addParrents2(Hash,K,M,L1,L2).
%time for hashing
list_to_num([],[]).
list_to_num([98|T],[0|T1]):-list_to_num(T,T1).
list_to_num([103|T],[1|T1]):-list_to_num(T,T1).
list_to_num([71|T],[2|T1]):-list_to_num(T,T1).
list_to_num([114|T],[3|T1]):-list_to_num(T,T1).
list_to_num([121|T],[4|T1]):-list_to_num(T,T1).
addParrents2(_,[],[],A,A).
addParrents2(S,[[X,H]|T],[X|T2],List,L3):- hash_f(X,Hash),\+get_assoc(Hash,List,_),!,put_assoc(Hash,List,parrents2(S,H),List2),addParrents2(S,T,T2,List2,L3).
%addParrents(S,[[X,_H]|T],T2):-hash_f(X,Hash),parrents(_,Hash,_),addParrents(S,T,T2).
addParrents2(S,[[X,_H]|T],T2,L,L2):-addParrents2(S,T,T2,L,L2).
%hash_f
hash_f([],0).
hash_f([X|T],X2):-hash_f(T,X1),!,X2 is X+X1*5.
addParrents(_,[],[],A,A).
addParrents(S,[[X,H]|T],[X|T2],List,L3):- hash_f(X,Hash),\+get_assoc(Hash,List,_),!,put_assoc(Hash,List,parrents(S,H),List2),addParrents(S,T,T2,List2,L3).
%addParrents(S,[[X,_H]|T],T2):-hash_f(X,Hash),parrents(_,Hash,_),addParrents(S,T,T2).
addParrents(S,[[X,_H]|T],T2,L,L2):-addParrents(S,T,T2,L,L2).
getSolution(Goal,Goal,[],L).
getSolution(Goal,G,[H|T],L):-get_assoc(Goal,L,parrents(Next,H)),getSolution(Next,G,T,L).
getSolution2(Goal,Goal,[],L).
getSolution2(Goal,G,[H|T],L):-get_assoc(Goal,L,parrents2(Next,H)),getSolution(Next,G,T,L).
diapragmateysi(S,L):- string_to_list(S,Cur22),isfinal(Goal1),list_to_num(Goal1,Goal),list_to_num(Cur22,Cur),assert(queue([])),hash_f(Cur,CurH),list_to_assoc([CurH-parrents(CurH,0)],L1),
%bid records 
%search(State,Goal,List,L3,[H|T],N,[H2|T2],N2,List2,L5):- next_moves(State,M_C,List,L2),!,list_to_Q(M_C,[H|T],N,NK),N1 is N-1+NK,!,rev_next_moves(Goal,M_C2,List2,L6),list_to_Q(M_C2,[H2|T2],N2,NK2),N3 is N2-1+NK2,search(H,H2,L2,L3,T,N1,T2,N3,L6,L5).
hash_f(Goal,GK),list_to_assoc([GK-parrents2(GK,0)],L2),!,
search(Cur,Goal,L1,L4,QKKT,0,BBBB,0,L2,L12,TT),!,hash_f(TT,TTf),getSolution(TTf,CurH,PP1,L4),getSolution2(TTf,GK,PP2m,L12),reverse(PP1,PP2),append(PP2,PP2m,AS),atomic_list_concat(AS,AA),string_codes(L,AA),!.
isfinal([98, 103, 98, 71, 103, 71, 71, 114, 71, 121, 114, 121]).
isfinal2(K):- string_to_list("bgbGgGGrGyry",K).
moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4),!.
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
rev_moves(H,[[X1,1],[X2,2],[X3,3],[X4,4]]):- move1(X1,H),move2(X2,H),move3(X3,H),move4(X4,H),!.
