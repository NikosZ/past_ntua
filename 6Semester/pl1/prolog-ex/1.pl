%
my_last(X,[X]).
my_last(X,[H|T]):-my_last(X,T).
