:- module(finJeu, [checkFinColonne/3,checkColonne/3, checkFinJeu/2]).
:-use_module(matrice_utils).



% Fonction pour savoir si les 4 sur la meme colonne ont la meme couleur 
checkColonne(C,Y,4).
checkColonne(C,Y,S) :- 
					Ya is Y-S,
					matrice_utils:isSame(Ya,Y,C),
					Sa is S+1, 
					Sa=<4,
					checkColonne(C,Y,Sa), !.
checkFinColonne(X,Y,L) :- S is 1, nth1(X,L,C), checkColonne(C,Y,S).


% Fonction pour savoir si les 4 sur la meme ligne ont la meme couleur
checkFinLigneBefore(X,Y,L,Sa) :- 
					Xb is X-1,
					nth1(X,L,La), nth1(Y,La,Va),
					nth1(Xb,L,Lb), nth1(Y,Lb,Vb),
					Va == Vb,
					S is Sa+1,
					checkFinLigneBefore(Xb,Y,L,S), !.
					
checkFinLigneAfter(X,Y,L,Sb) :- 
					Xb is X+1,
					nth1(X,L,La), nth1(Y,La,Va),
					nth1(Xb,L,Lb), nth1(Y,Lb,Vb),
					Va == Vb,
					S is Sb+1,
					checkFinLigneAfter(Xb,Y,L,Sb), !.

checkFinLigne(X,Y,L) :- 
					S is 1,
					checkFinLigneBefore(X,Y,L,Sa),
					checkFinLigneAfter(X,Y,L,Sa), St is Sa+Sb,
					St = 4, !.



checkFinJeu(X,L) :-
					nth1(X,L,Column),
					matrice_utils:longueur(Column,Y),
					checkFinColonne(X,Y,L),
					checkFinLigne(X,Y,L).
