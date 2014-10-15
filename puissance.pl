:- use_module(iarandom).
:- use_module(matrice_utils).
:- use_module(finJeu).

bonjour(mehdi).
bonjour(karim).
bonjour(mimiettrititi).


%Rule to Print the Matrix
print_column([]).
print_column([H|T]) :- H = a, ansi_format([bold, fg(red)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
print_column([H|T]) :- H = b, ansi_format([bold, fg(green)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
print_column([H|T]) :- H \= a, H \= b, ansi_format([bold, fg(green)], ' ', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.

print_matrix([]).
print_matrix([H|T]) :- print_column(H), nl, print_matrix(T).

							

:- dynamic p/1.
p([[],[],[],[],[],[],[]]).


puissance :- bonjour(brahim).
puissance :-
	p(X),
	write(X), nl,
	write('>>'),
	read(I),
	addElement(a,I),
	iarandom(X),
	write(X),nl,
	puissance.









