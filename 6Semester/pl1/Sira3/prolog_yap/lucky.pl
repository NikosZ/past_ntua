%
%caller func
:-use_module(library(lists)).
lucky_numbers([],[]).
lucky_numbers([0],[true]):-!.
lucky_numbers([H],[false]):-is_lucky(H),!.
lucky_numbers([H],[true]):-!.
lucky_numbers([0|T],[true|T1]):-!,lucky_numbers(T,T1).
lucky_numbers([H|T],[false|T1]):-is_lucky(H),!,lucky_numbers(T,T1).
lucky_numbers([H|T],[true|T1]):-!,lucky_numbers(T,T1).
calc(X,0,[X,0]).
calc(X,-0,[X,0]).
calc(X,0.0,[X,0.0]).
calc(X,-0.0,[X,0.0]).
calc(X,Y,[X1,X2,X3,X4]):-X1 is X+Y,X2 is X-Y,X3 is X*Y,X4 is X/Y,!.

is_lucky(X):-digits(X,D),length(D,N),!,solve(D,N).



digits(0,[]).
digits(X,[H|T]):- H is X mod 10,X1 is X // (10),digits(X1,T).

con1(X,L):-reverse(X,X1),con(X1,0,L).
con([],_,[]).
con([H|T],P,[H1|T1]):-H1 is 10*P +H,con(T,H1,T1).

newlist([],_,[]).
newlist([H|T],T1,[H2|T2]):-newls(H,T1,H2),newlist(T,T1,T2).
newls(_,[],[]).
newls(X,[H|T],[K1|T2]):- calc(X,H,K1),newls(X,T,T2).

solve(D,N):-N1 is N+1,length(L,N),!,solution(D,N1,1,L). % Warning 

solution(D,Stop,K,L):-Stop==K,!,P is K-1,nth1(P,L,El),check(El).
solution(D,Stop,K,L):-make_list(D,K,L),K1 is K+1,solution(D,Stop,K1,L).

make_list([H],1,[[H]|L]).
make_list([H|T],1,[[H]|L]).
make_list(D,K,L):-length(ConL,K),prefix(ConL,D),con1(ConL,Alln),!,K1 is K-1,another_make_list(Alln,K1,L,El),flatten(El,Element),nth1(K,L,Element).
another_make_list([],_,_,[]).
another_make_list([H],0,_,[H]).
another_make_list([H|T],Num,L,[H1|T1]):-nth1(Num,L,L1),newls(H,L1,H1),Num1 is Num -1,another_make_list(T,Num1,L,T1),!.

check([X|T]):-X1 is X,X1==100.
check([X|T]):-check(T).
