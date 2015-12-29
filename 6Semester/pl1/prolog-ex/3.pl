%
reverse(X,[]).
reverse(X,[H|T]):-reverse([X|T],T).
