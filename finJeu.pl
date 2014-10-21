:- module(finJeu, [checkFinJeu/2]).
:-use_module(matrice_utils).



% Fonction pour savoir si les 4 sur la meme colonne ont la meme couleur 
checkColonne(_,_,4).
checkColonne(C,Y,S) :- 
					Ya is Y-S,
					matrice_utils:isSame(Ya,Y,C),
					Sa is S+1, 
					Sa=<4,
					checkColonne(C,Y,Sa), !.
checkFinColonne(X,Y,L) :- S is 1, nth1(X,L,C), checkColonne(C,Y,S).


checkFinLigne(X,Y,L) :- 
					get_consecutive_neighbors_ligne(X,Y,L,Total),
					write('Total Ligne:'), write(Total), nl,
					Total >=4, !.
					
				
checkFinDiagonale1(X,Y,L) :- 
					checkFinDiagonaleBefore1(X,Y,L,0,Sb), checkFinDiagonaleAfter1(X,Y,L,0,Sa),	
					Total is Sa+Sb+1,
					write('Total Diagonale:'), write(Total), nl,
					Total >=4, !.
					

checkFinDiagonale2(X,Y,L) :- 
					checkFinDiagonaleBefore2(X,Y,L,0,Sb), checkFinDiagonaleAfter2(X,Y,L,0,Sa),	
					Total is Sa+Sb+1,
					write('Total Diagonale:'), write(Total), nl,
					Total >=4, !.


checkFinJeu(X,L) :-
					nth1(X,L,Column),
					matrice_utils:longueur(Column,Y),
					(checkFinColonne(X,Y,L);checkFinLigne(X,Y,L);checkFinDiagonale1(X,Y,L);checkFinDiagonale2(X,Y,L)).
