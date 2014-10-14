bonjour(mehdi).
bonjour(karim).


longueur([],0).
longueur([_|L],N):- longueur(L,N1), N is N1+1.   




add(X,[],[X]).
add(X,[A|L],[A|L1]):- add(X,L,L1).



% Fonction qui renvoie le nième élément dune liste 
% Paramètres : N index de lélement qu on veut récupérer, L liste, X élément retourné 
nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).        



% Compare si deux elements dune liste sont les memes. 
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).


% Savoir si les 4 sur la meme colonne ont la meme couleur 
checkFinColonne(L) :- longueur(L,Nx), Nx>=4, Ny is Nx-1, Nz is Nx-2, Nw is Nx-3,  isSame(Nx,Ny,L), isSame(Nx,Nz,L), isSame(Nx,Nw,L).

checkFinJeu(L) :- checkFinColonne(L).



puissance(Tab) :- bonjour(brahim).
puissance(Tab) :-
	write('>>'),
	read(X),
	longueur(Tab,Nx), Nx=<5,
	add(X,Tab,Result),
	not(checkFinJeu(Tab)),
	write(Result),nl,
	puissance(Result).









