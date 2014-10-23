:- module(finJeu, [checkFinJeu/2, checkFinColonne/3, checkFinLigne/3, checkFinDiagonale1/3, checkFinDiagonale2/3, iaWon/2, playerWon/2]).
:-use_module(matrice_utils).



% On vérifie si 4 pions sur la meme colonne ont la meme couleur

% Ce predicat est vrai lorsque S = 4 (4 pions consécutifs de même couleur)
checkColonne(_,_,4).

% Mode d'emploi : Predicat iteratif qui verifie les pions 2 à 2 à partir du dernier pion joué
% Paramètres : 
% 	C : la colonne sur laquelle le dernier pion a été joué
%	Y : L'indice dans le repere (X,Y) de la grille de jeu du dernier pion joué
%	S : La somme des pions consécutifs ayant la même couleur que le dernier pion joué
checkColonne(C,Y,S) :- 
					Ya is Y-S,
					matrice_utils:isSame(Ya,Y,C),
					Sa is S+1, 
					Sa=<4,
					checkColonne(C,Y,Sa), !.
					
% Mode d'emploi : checkFinColonne compte le nombre de pions consécutifs (S) de même couleur
% 	que le dernier pion joué (d'indice Y). Si la somme est <= 4, le predicat est vrai.
% Paramètres :
% 	(X,Y) : Coordonnées du dernier pion joué dans la grille du jeu
%	L : matrice (grille du jeu)
checkFinColonne(X,Y,L) :- S is 1, nth1(X,L,C), checkColonne(C,Y,S).


%  -----------------------------------------------------------------------------------------------
% On vérifie si les 4 sur la meme ligne ont la meme couleur

% Mode d'emploi : Predicat iteratif qui verifie les pions 2 à 2 à partir du dernier pion joué
%		en allant à gauche et met a jour la variable Compteur qui contient le nb de pions
% 		consécutifs de même couleur
% Paramètres : 
% 		(X,Y) : Coordonnées du dernier pion joué dans la grille du jeu
%		M : La grille de jeu
% 		S : Initialisation de la somme de pions de même couleur consécutifs (= 0)
% 		Compteur : Nombre de pions de même couleur consécutifs (sera maj par le predicat)
checkFinLigneBefore(X,Y,M,S, Compteur) :- 
					Xb is X-1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Y,Lb,Couleur),
					Sa is S + 1, 
					checkFinLigneBefore(Xb,Y,M,Sa, Compteur), !.
checkFinLigneBefore(_,_,_,S, Compteur) :- Compteur is S, !.

% Mode d'emploi : Même fonctionnement que checkFinLigneBefore, en avançant vers la droite
checkFinLigneAfter(X,Y,M,S, Compteur) :- 
					Xb is X+1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Y,Lb,Couleur),
					Sa is S + 1, 
					checkFinLigneAfter(Xb,Y,M,Sa, Compteur), !.
checkFinLigneAfter(_,_,_,S, Compteur) :- Compteur is S, !.


% Description : Fonction pour savoir si 4 pions sur la meme lignes ont la meme couleur
% Mode d'emploi : checkFinLigne compte le nombre de pions consécutifs (S) de même couleur
% 		que le dernier pion joué (de coordonnées (X,Y)). Si la somme est <= 4, le predicat est vrai.
% Paramètres :
% 		(X,Y) : Coordonnées du dernier pion joué dans la grille du jeu
%		L : matrice (grille du jeu)
checkFinLigne(X,Y,L) :- 
					get_consecutive_neighbors_ligne(X,Y,L,Total),
					write('Total Ligne:'), write(Total), nl,
					Total >=4, !.
					
				
%  -----------------------------------------------------------------------------------------------						
% Fonction pour savoir si les 4 sur la meme diagonale ont la meme couleur
% Mode d'emploi : Même fonctionnement que les prédicats précédents en vérifiant diagonalement
checkFinDiagonaleBefore1(X,Y,M,S, Compteur) :- 
					Xb is X-1, Yb is Y+1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleBefore1(Xb,Yb,M,Sa, Compteur), !.
checkFinDiagonaleBefore1(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonaleAfter1(X,Y,M,S, Compteur) :- 
					Xb is X+1, Yb is Y-1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleAfter1(Xb,Yb,M,Sa, Compteur), !.
checkFinDiagonaleAfter1(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonale1(X,Y,L) :- 
					checkFinDiagonaleBefore1(X,Y,L,0,Sb), checkFinDiagonaleAfter1(X,Y,L,0,Sa),	
					Total is Sa+Sb+1,
					write('Total Diagonale:'), write(Total), nl,
					Total >=4, !.
	
		
%  -----------------------------------------------------------------------------------------------
			
checkFinDiagonaleBefore2(X,Y,M,S, Compteur) :- 
					Xb is X-1, Yb is Y-1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleBefore2(Xb,Yb,M,Sa, Compteur), !.
checkFinDiagonaleBefore2(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonaleAfter2(X,Y,M,S, Compteur) :- 
					Xb is X+1, Yb is Y+1,
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


%  -----------------------------------------------------------------------------------------------
% Description : Predicat qui vérifie pour une grille de jeu donnée (L) et la position d'un pion
% 		donné (X) si le jeu est terminé
checkFinJeu(X,L) :-
					nth1(X,L,Column),
					matrice_utils:longueur(Column,Y),
					(checkFinColonne(X,Y,L);checkFinLigne(X,Y,L);checkFinDiagonale1(X,Y,L);checkFinDiagonale2(X,Y,L)).

iaWon(M,X) :- nth1(X,M,Column),longueur(Column,Y), getElemFromGrid(X,Y,M,Pion), nonvar(Pion), Pion == b, checkFinJeu(X,M),!.
playerWon(M,X) :- nth1(X,M,Column), longueur(Column,Y),getElemFromGrid(X,Y,M,Pion), nonvar(Pion), Pion == a, checkFinJeu(X,M),!. 
