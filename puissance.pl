bonjour(mehdi).
bonjour(karim).


longueur([],0).
longueur([_|L],N):- longueur(L,N1), N is N1+1.   



% Fonction qui renvoie le nième élément dune liste 
% Paramètres : N index de lélement qu on veut récupérer, L liste, X élément retourné 
nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).        



% Compare si deux elements dune liste sont les memes. 
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).


% Savoir si les 4 sur la meme colonne ont la meme couleur 
checkFinColonne(L) :- longueur(L,Nx), Nx>=4, Ny is Nx-1, Nz is Nx-2, Nw is Nx-3,  isSame(Nx,Ny,L), isSame(Nx,Nz,L), isSame(Nx,Nw,L).

checkFinJeu(L) :- checkFinColonne(L).


%Rule to Print the Matrix

print_column([]).
print_column([H|T]) :- H = a, ansi_format([bold, fg(red)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
print_column([H|T]) :- H = b, ansi_format([bold, fg(green)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
print_column([H|T]) :- H \= a, H \= b, ansi_format([bold, fg(green)], ' ', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.


print_matrix([]).
print_matrix([H|T]) :- print_column(H), nl, print_matrix(T).



puissance(Tab) :- bonjour(brahim).
puissance(Tab) :-
	write('>>'),
	read(X),
	longueur(Tab,Nx), Nx=<5,
	add(X,Tab,Result),
	not(checkFinJeu(Tab)),
	write(Result),nl,
	puissance(Result).









