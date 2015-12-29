%
search(Goal,Goal,_).
search(State,Goal,Q):- next_moves(State,M),do_visited(M,M_C),list_to_Q(M_C,Q,Qnew),popQ(State2,Qnew,Qnew2),search(State2,Goal,Qnew2).



list_to_Q(A,Q,L):-append(Q,A,L).
addQ(A,Q,R):-append(Q,[A],R).
do_visited([],_).
do_visited([H|T],[H|P]):-\+visited(H) ,addVisited(H),do_visited(T,P).
do_visited([H|T],P):-visited(H) ,do_visited(T,P).
\+ popQ(_,[],[]).
popQ(H,[H|T],T).
addVisited(A):- assert(visited(A)).
addParrents().
