

%
:- use_module(library(charsio)).
:- use_module(library(assoc)).
:- use_module(library(lists)).
:- use_module(library(nb)).
:- use_module(library(tries)).

search(G,G,_Q,_T,L,LS):-s(X),!,getSol(X,G,L,LS).
	%getSol(G,L,LS).
search(S,G,Q,T,L,LS):-next_moves(S,Q,T,L,L2),nb_queue_dequeue(Q,NS),search(NS,G,Q,T,L2,LS).

list_to_Q([],_).
list_to_Q([H|T],Q):-nb_queue_enqueue(Q,H),list_to_Q(T,Q).

trie_f(_,[],_,[],L,L).
trie_f(S,[[H,H2]|T],Tr,[H|T2],L,L3):- \+ trie_check_entry(Tr,H,_),!,trie_put_entry(Tr,H,_),hash_f(H,L6),put_assoc(L6,L,par(H2,S),L2),trie_f(S,T,Tr,T2,L2,L3).
trie_f(S,[_|T],Tr,T2,L,L3):- trie_f(S,T,Tr,T2,L,L3).

%list_to_Q(A,Q,Qnew):-append(Q,A,Qnew). %queue(Q),append(Q,A,Qnew),retract(queue(_)),assertz(queue(Qnew)).
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
%diapragmateysi(S,L):- format_to_chars(S,'',Cur22),isfinal(Goal1),list_to_num(Goal1,Goal),list_to_num(Cur22,Cur),assert(queue([])),hash_f(Cur,CurH),list_to_assoc([CurH-parrents(CurH,0)],L1),search(Cur,Goal,L1,L4,AAAAA,0),!,hash_f(Goal,GK),getSolution(GK,CurH,PP,L4),reverse(PP,AS),atomic_list_concat(AS,AL),atom_codes(AL,L),!.

diapragmateysi(S,L):-format_to_chars(S,'',Cur1),isfinal(Goal1),list_to_num(Cur1,Cur),list_to_num(Goal1,Goal),nb_queue(Q),trie_open(T),assert(s(Cur)),hash_f(Cur,Hash),list_to_assoc([Hash-par(0,Cur)],L1),!,search(Cur,Goal,Q,T,L1,LL),!, %
%,write("A"),getSol(Cur,LL,L).
reverse(LL,Sol2),atomic_list_concat(Sol2,L42),atom_codes(L42,L),!.


