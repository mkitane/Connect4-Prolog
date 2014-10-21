:- module(finJeu, [checkFinColonne/3,checkColonne/3, checkFinJeu/2]).
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


% Fonction pour savoir si les 4 sur la meme ligne ont la meme couleur
checkFinLigneBefore(X,Y,M,S, Compteur) :- 
					Xb is X-1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Y,Lb,Couleur),
					Sa is S + 1, 
					checkFinLigneBefore(Xb,Y,M,Sa, Compteur), !.
checkFinLigneBefore(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinLigneAfter(X,Y,M,S, Compteur) :- 
					Xb is X+1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Y,Lb,Couleur),
					Sa is S + 1, 
					checkFinLigneAfter(Xb,Y,M,Sa, Compteur), !.
checkFinLigneAfter(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinLigne(X,Y,L) :- 
					checkFinLigneBefore(X,Y,L,0,Sb), checkFinLigneAfter(X,Y,L,0,Sa),	
					Total is Sa+Sb+1,
					write('Total Ligne:'), write(Total), nl,
					Total >=4, !.
					
				
				
					
% Fonction pour savoir si les 4 sur la meme diagonale ont la meme couleur
checkFinDiagonaleBefore1(X,Y,M,S, Compteur) :- 
					Xb is X-1, Yb is Y+1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleBefore1(Xb,Y,M,Sa, Compteur), !.
checkFinDiagonaleBefore1(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonaleAfter1(X,Y,M,S, Compteur) :- 
					Xb is X+1, Yb is Y-1
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleAfter1(Xb,Y,M,Sa, Compteur), !.
checkFinDiagonaleAfter1(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonale1(X,Y,L) :- 
					checkFinDiagonaleBefore1(X,Y,L,0,Sb), checkFinDiagonaleAfter1(X,Y,L,0,Sa),	
					Total is Sa+Sb+1,
					write('Total Diagonale:'), write(Total), nl,
					Total >=4, !.
					
checkFinDiagonaleBefore2(X,Y,M,S, Compteur) :- 
					Xb is X-1, Yb is Y-1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleBefore2(Xb,Yb,M,Sa, Compteur), !.
checkFinDiagonaleBefore2(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonaleAfter2(X,Y,M,S, Compteur) :- 
					Xb is X+1, Yb is Y+1
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleAfter2(Xb,Yb,M,Sa, Compteur), !.
checkFinDiagonaleAfter2(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonale2(X,Y,L) :- 
					checkFinDiagonaleBefore2(X,Y,L,0,Sb), checkFinDiagonaleAfter2(X,Y,L,0,Sa),	
					Total is Sa+Sb+1,
					write('Total Diagonale:'), write(Total), nl,
					Total >=4, !.



checkFinJeu(X,L) :-
					nth1(X,L,Column),
					matrice_utils:longueur(Column,Y),
					(checkFinColonne(X,Y,L);checkFinLigne(X,Y,L);checkFinDiagonale1(X,Y,L);checkFinDiagonale2(X,Y,L)).
