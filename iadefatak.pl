:- module(iadefatak, [iadefatak/3]).

:-use_module(matrice_utils).
:-use_module(iarandom).



% Mode d'emploi : Predicat iteratif qui renvoie la position d'une colonne si les 3 derniers elements de cette colonne sont de la 
%				meme couleur que les elements de l'ia. 

% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : Colonne a veifiée

canwin(M,Xg,8).
canwin(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y), Y<6,
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_column(X,Y,M,0, Compteur),
				Compteur == 3,
				Xgagnant is X, !.
canwin(M,Xgagnant,X) :- Xsuivant is X+1, canwin(M,Xgagnant,Xsuivant).


% Mode d'emploi : Predicat iteratif qui renvoie la position d'une ligne si les 3 derniers elements de cette ligne sont de la 
%				meme couleur que les elements de l'ia. 

% Paramètres : 
% 	M : La grille de jeu
%	Ygagnant : ligne permettant de gagner
%	Y : ligne a veifiée
canwin1(M,Xg,7).
canwin1(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),X>1,
				Compteur == 3,nth1(X-1,M,Possibilite),longueur(Possibilite,Yp),
				Yp=Y-1,
				Xgagnant is X-1, !.

canwin1(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),X<5,
				Compteur == 3,nth1(X+3,M,Possibilite),longueur(Possibilite,Yp),
				Yp=Y-1,
				Xgagnant is X+3, !.
canwin1(M,Xgagnant,X) :- Xsuivant is X+1, canwin(M,Xgagnant,Xsuivant).


iadefatak(M,Xh,Xbeg) :- 
 				canwin(M,Xgagnant,Xbeg),
				Xh is Xgagnant.
				
iadefatak(M,Xh,Xbeg) :- 
 				canwin1(M,Xgagnant,Xbeg),
				Xh is Xgagnant.				
				
iadefensive(M,Xh,Xpos) :- iarandom(M,Xh),!.
% % Cpt=3,
% Xh is Xpos,
% N=<5,!.
% 
% iadefatak(M,Xh,Xpos) :- 
% nth1(Xpos,M, Colonne),  %Get Column and check size
% longueur(Colonne, N),
% get_consecutive_neighbors_ligne(Xpos,N,M,Cpt),
% Xpos>=2,	Cpt=1,
% Xh is Xpos-1,
% N=<5,!.
% 
% iadefatak(M,Xh,Xpos) :- 
%             nth1(Xpos,M, Colonne),  %Get Column and check size
%             longueur(Colonne, N),
%             get_consecutive_neighbors_ligne(Xpos,N,M,Cpt),
%             Xpos<7,	
%             Xh is Xpos+ (Cpt//3),
%             N=<5,!.
% 
% iadefatak(M,Xh,Xpos) :- 
%             nth1(Xpos,M, Colonne),  %Get Column and check size
%             longueur(Colonne, N),
%             get_consecutive_neighbors_ligne(Xpos,N,M,Cpt),
%             Xpos=7,	
%             Xh is Xpos-3,
%             N=<5,!.
% 
% iadefatak(M,Xh,Xpos) :- iarandom(M,Xh),!.