%
diapragmateysi(S,L):- string_to_list(S,Cur),solution(Cur,L,1).
solution(Cur,K,N):- (length(K,N),solve(Cur,N,K,P));(writeln(N),Ns is N+1 , solution(Cur,K,Ns)).
solve(Cur,N,K,Prev):-isfinal(Cur,K); (moves(Cur,L),nth1(J,L,Next),append([J],K1,K),solve(Next,N,K1,Pe) ) .
isfinal(['G','g','b','r','g','b','y','G','G','y','G','r'],_).
moves(H,[X1,X2,X3,X4]):- move1(H,X1),move2(H,X2),move3(H,X3),move4(H,X4).
move1([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],L):-append([],L,[A2,A1,A5,A0,A4,A3,A6,A7,A8,A9,A10,A11]).
move2([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A3,A2,A6,A1,A5,A4,A7,A8,A9,A10,A11]).
move3([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11] ,[A0,A1,A2,A3,A4,A7,A6,A10,A5,A9,A8,A11]).
move4([A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11],[A0,A1,A2,A3,A4,A5,A8,A7,A11,A6,A10,A9]).
