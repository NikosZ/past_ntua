/*
 * This file contains two predicates
 *   - read_and_just_print_dangers/1
 *   - read_and_return/3
 * that illustrate reading one line at a time from a file in SWI Prolog.
 * The file has the format of input files of the 'danger' exercise.
 */

/*
 * The first predicate is not so interesting. It just shows you how you can
 * write in Prolog a predicate that contains a loop with *only* side-effects.
 * Use as:
 *
 *   ?- read_and_just_print_dangers('forbidden1.txt').
 */
read_and_just_print_dangers(File) :-
    open(File, read, Stream),
    repeat,
    read_line_to_codes(Stream, X),
    ( X \== end_of_file -> writeln(X), fail ; close(Stream), ! ).

/*
 * The second predicate reads the information of an input file and returns
 * it in the next two arguments: an integer and a list with combinations of
 * dangerous measurements represented as lists, as in the example below:
 * 
 *   ?- read_and_return('forbidden1.txt', M, Combos).
 *   M = 8,
 *   Combos = [[1, 2], [3, 2], [7], [3, 4], [5, 6, 4]].
 *
 * To read the information of each of the segments, it uses the auxiliary
 * predicate read_segs/3.
 */

read_and_return(File, N, Combos) :-
    open(File, read, Stream),
    read_line(Stream, [N, M]),
    read_segs(Stream, M, Combos),
    close(Stream).

read_segs(Stream, M, Combos) :-
    ( M > 0 ->
	Combos = [Combo|Rest],
        read_line(Stream, [K|Combo]),
	length(Combo, K), %% just an assertion for for extra safety 
        M1 is M - 1,
        read_segs(Stream, M1, Rest)
    ; M =:= 0 ->
	Combos = []
    ).

/*
 * An auxiliary predicate that reads a line and returns the list of
 * integers that the line contains.
 */
read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    atom_codes(A, Line),
    atomic_list_concat(As, ' ', A),
    maplist(atom_number, As, List).
