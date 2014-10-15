:- module(finJeu, [checkFinColonne/3,checkColonne/3]).
:-use_module(matrice_utils).



% Fonction pour savoir si les 4 sur la meme colonne ont la meme couleur 
checkColonne(C,Y,4).
checkColonne(C,Y,S) :- 
					Ya is Y-S,
					matrice_utils:isSame(Ya,Y,C),
					Sa is S+1, 
					Sa=<4, write('Sa :'), write(Sa), write(' Ya :'), write(Ya), nl, nl,
					checkColonne(C,Y,Sa), !.
checkFinColonne(X,Y,L) :- S is 1, nth1(X,L,C), checkColonne(C,Y,S).

