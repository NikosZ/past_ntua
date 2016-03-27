
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
calc(X,0.0,[X,0.0]).
calc(X,0,[X,0.0]).
calc(X,-0,[X,0.0]).
calc(X,-0.0,[X,0.0]).
calc(X,Y,[X1,X2,X3,X4]):-X1 is X+Y,X2 is X-Y,X3 is X*Y,X4 is X/Y,!.

is_lucky(X):-retractall(memoization(_,_,_)),assertz(memoization(0,0,0)),digits(X,D),reverse(D,X1),length(D,N),!,(solve(X1,N);(con5(X1,R,1,N),check([R]))).



digits(0,[]).
digits(X,[H|T]):- H is X mod 10,X1 is X // (10),digits(X1,T).

con1(X,L):-reverse(X,X1),con(X1,0,L).
con2([H|T],L,N,K):-N>1,N1 is N-1,K1 is K -1,con2(T,L,N1,K1).
con2([H|T],[H|L],N,K):-K>0,K1 is K -1,con2(T,L,N1,K1).
con2(_,[],_,_).
con3(X,Res,N,K):- con2(X,L,N,K),con6(L,0,Res).
con([],_,[]).
con([H|T],P,[H1|T1]):-H1 is 10*P +H,con(T,H1,T1).

con5(D,R,N,K):-N1 is N-1, length(D1,N1),append(D1,D2,D),Y is K-N +1,length(D3,Y),append(D3,D4,D2),con6(D3,0,R).
con6([],L,L).
con6([H|T],P,Res):- H1 is 10*P+H,con6(T,H1,Res).

newlist([],_,[]).
newlist([H|T],T1,[H2|T2]):-newls(H,T1,H2),newlist(T,T1,T2).
newls(_,[],[]).
newls(X,[H|T],[X1,X2|T2]):- calc(X,H,[X1,X2]),newls(X,T,T2).
newls(X,[H|T],[X1,X2,X3,X4|T2]):- calc(X,H,[X1,X2,X3,X4]),newls(X,T,T2).



newlist2([H|T],L2):-newls(H,L2,R),!,(check(R);(newlist2(T,L2))).

solve(D,N):-T1 is N-1,calculate_mem2(D,1,0,T1,N),!.
solve2(D,N,N):-memo(D,3,N,_),memo(D,1,N,L),!,check(L),!.
solve2(D,N,K):-D1 is K+1,memo(D,1,D1,_),!,solve2(D,N,D1).

%solve(D,N):-N1 is N+1,length(L,N),!,solution(D,N1,1,L). % Warning 

solution(D,Stop,K,L):-Stop==K,!,P is K-1,nth1(P,L,El),check(El).
solution(D,Stop,K,L):-make_list(D,K,L),K1 is K+1,solution(D,Stop,K1,L).

make_list([H],1,[[H]|L]).
make_list([H|T],1,[[H]|L]).
make_list(D,K,L):-length(ConL,K),prefix(ConL,D),con1(ConL,Alln),!,K1 is K-1,another_make_list(Alln,K1,L,El),flatten(El,Element),nth1(K,L,Element).
another_make_list([],_,_,[]).
another_make_list([H],0,_,[H]).
another_make_list([H|T],Num,L,[H1|T1]):-nth1(Num,L,L1),newls(H,L1,H1),Num1 is Num -1,another_make_list(T,Num1,L,T1),!.

check([X|T]):-(Y is abs(X-100.0),Y<0.000001);(check(T)).

check2([X|T]):-check(X).
check2([X|T]):-!,check2(T).
memo(_,N,K,L):- memoization(N,K,L),!.
memo(D,N,K,PP):-Hd is K-N, calculate_mem(D,N,0,Hd,K,L1),!,flatten(L1,L),con5(D,H,N,K),!,sort([H|L],PP),assertz(memoization(N,K,PP)),!.

memo2(D,N,K,[H|L]):-Hd is K-N, calculate_mem2(D,N,0,Hd,K).
calculate_mem(D,Start,_,_,Start,[H]):-nth1(Start,D,H),!.
calculate_mem(D,Start,K,Stop,Last,[H|L]):-K<Stop,K1 is K+1,First is Start+K,Second is First+1,!,memo(D,Start,First,L1),!,memo(D,Second,Last,L2),!,newlist(L1,L2,H),!,calculate_mem(D,Start,K1,Stop,Last,L),!.
calculate_mem(_,_,_,_,_,[]).


calculate_mem2(D,Start,K,Stop,Last):-K<Stop,K1 is K+1,First is Start+K,Second is First+1,!,memo(D,Start,First,L1),!,memo(D,Second,Last,L2),!,((newlist2(L1,L2),!);(calculate_mem2(D,Start,K1,Stop,Last))).
%write(55),!,nl,write(Start),nl,write(Last),(Start>Last;
%calculate_mem2(D,Start,K1,Stop,Last):-K1<Stop, K is K+1,!,write(777),calculate_mem2(D,Start,K,Stop,Last).
