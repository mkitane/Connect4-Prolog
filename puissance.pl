bonjour(mehdi).
bonjour(karim).
bonjout(yassine).

% Fonction qui renvoie la longueur d'une liste
% Paramètres : L,N integer
longueur([],0).
longueur([_|L],N):- longueur(L,N1), N is N1+1.   

% Fonction qui renvoie le nième élément dune liste 
% Paramètres : N index de lélement qu on veut récupérer, L liste, X élément retourné 
nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).        

% Fonction qui ajoute en fin de liste
% Paramètres : X, L1(cible) , L2 (Result)
ajoutFin(X,[],[X]).
ajoutFin(X,[Y|L1],[Y|L2]):- ajoutFin(X,L1,L2),longueur([Y|L1],N), N<6 .

% Fonction qui compare si deux elements dune liste sont les memes.
% Paramètres : X(cible), Y(cible) , L (pool)
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).


% Fonction pour savoir si les 4 sur la meme colonne ont la meme couleur 
checkFinColonne(L) :- longueur(L,Nx), Nx>=4, Ny is Nx-1, Nz is Nx-2, Nw is Nx-3,  isSame(Nx,Ny,L), isSame(Nx,Nz,L), isSame(Nx,Nw,L).

checkFinJeu(L) :- checkFinColonne(L).




%Rule to Print the Matrix
print_column([]).
print_column([H|T]) :- H = a, ansi_format([bold, fg(red)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
print_column([H|T]) :- H = b, ansi_format([bold, fg(green)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
print_column([H|T]) :- H \= a, H \= b, ansi_format([bold, fg(green)], ' ', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.

print_matrix([]).
print_matrix([H|T]) :- print_column(H), nl, print_matrix(T).

% Fonction qui compare si deux elements dune liste sont les memes.
% Paramètres : R(int colonne cible), NEW(data) , Mat(cible), Upd(Result)
% replace(R, NEW, Mat, Upd):- nth1(R, Mat, X), 
                         %   select(X, Mat, RestRows),   % get the row and the rest
                         %   select(NEW, Upd, RestRows),   % insert updated row in rest, get Upd 
                         %   nth1(R, Upd, NEW).
replace(1,NEW,[L1,L2,L3,L4,L5,L6,L7],[NEW,L2,L3,L4,L5,L6,L7]).
replace(2,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,NEW,L3,L4,L5,L6,L7]).
replace(3,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,NEW,L4,L5,L6,L7]).
replace(4,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,NEW,L5,L6,L7]).
replace(5,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,L4,NEW,L6,L7]).
replace(6,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,L4,L5,NEW,L7]).
replace(7,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,L4,L5,L6,NEW]).
							
							
% Fonction pour ajouter un jeton au plateau.
% Paramètres : X(type), I(Pos)							
addElement(X,I):- p(L),nthElem(I,L,Extr),ajoutFin(X,Extr,NEW),replace(I,NEW,L,R),retract(p(_)),assert(p(R)),!.

:- dynamic p/1.
p([[],[],[],[],[],[],[]]).

puissance :-
	p(X),
	write(X), nl,
	write('>>'),
	read(I),
	addElement(a,I),
	write(X),nl,
	puissance.









