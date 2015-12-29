%
element_at(H,[H|T],1).
element_at(X,[H|T],N):-K is N-1, element_at(X,T,K).
