:- module(iadefatak, [iadefatak/3]).

:-use_module(matrice_utils).
:-use_module(iarandom).
:-use_module(finJeu).

%--------------------------------------------------------------------------------------------------------

%attaque

%--------------------------------------------------------------------------------------------------------


% Mode d'emploi : Predicat iteratif qui renvoie la position d'une colonne si les 3 derniers elements de cette colonne sont de la 
%				meme couleur que les elements de l'ia. (permet à l'ia de gagner)

% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : Colonne a veifiée

canwin(_,_,8).
canwin(M,Xgagnant,X):-  
                nth1(X,M, Colonne),longueur(Colonne, Y), Y<6,
                nth1(Y,Colonne,Color),
                Color == b, 
                get_consecutive_neighbors_column(X,Y,M,0, Compteur),
                Compteur == 2,
                Xgagnant is X,!.
canwin(M,Xgagnant,X) :- Xsuivant is X+1, canwin(M,Xgagnant,Xsuivant),!.




% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située a gauche des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'ia. (permet a l'ia de gagner).

% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canwin1g(_,_,8).
canwin1g(M,Xgagnant,X):-  
                nth1(X,M, Colonne),longueur(Colonne, Y),
                nth1(Y,Colonne,Color),
                Color == b, 
                get_consecutive_neighbors_ligne(X,Y,M, Compteur),
                Compteur == 3,Xv is X-1, nth1(Xv,M,Possibilite),longueur(Possibilite,Ypossibilite),
                Yz is Ypossibilite+1, Yz == Y,
                Xgagnant is X-1, !.
canwin1g(M,Xgagnant,X) :- Xsuivant is X+1, canwin1g(M,Xgagnant,Xsuivant),!.
%Test : iadefatak:canwin1g([[a],[a,b],[a,b],[a,b],[],[],[]],Xgagnant, 1), Should return 1



% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située a droite des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'ia. (permet a l'ia de gagner).
% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canwin1d(_,_,5).
canwin1d(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),
				Compteur == 3,Xv is X+3, nth1(Xv,M,Possibilite),longueur(Possibilite,Yp),
				Yz is Yp+1, Yz == Y,
				Xgagnant is X+3, !.
canwin1d(M,Xgagnant,X) :- Xsuivant is X+1, canwin1d(M,Xgagnant,Xsuivant),!.




% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située au milieu des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'ia. (permet a l'ia de gagner).
% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canwin1m1(_,_,5).
canwin1m1(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),

				Compteur == 2,
				Xv is X+3, nth1(Xv,M,Col1), longueur(Col1,Y1), nth1(Y1,Col1,Color1),
				Color1==b,
				
				Xz is X+2, nth1(Xz,M,Possibilite),longueur(Possibilite,Yp),
				Yz is Yp+1, Yz == Y,
				Xgagnant is X+2, !.
canwin1m1(M,Xgagnant,X) :- Xsuivant is X+1, canwin1m1(M,Xgagnant,Xsuivant),!.


% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située au milieu des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'ia. (permet a l'ia de gagner).
% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canwin1m2(_,_,8).
canwin1m2(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),
				Compteur == 2,Xv is X-2,nth1(Xv,M,Col1),longueur(Col1,Y1),nth1(Y1,Col1,Color1),
				Color1==b,
				Xz is X-1,nth1(Xz,M,Possibilite),longueur(Possibilite,Yp),
				Yz is Yp+1, Yz == Y,
				Xgagnant is X-1, !.
canwin1m2(M,Xgagnant,X) :- Xsuivant is X+1, canwin1m2(M,Xgagnant,Xsuivant),!.



                         

%--------------------------------------------------------------------------------------------------------

%defend

%--------------------------------------------------------------------------------------------------------








% Mode d'emploi : Predicat iteratif qui renvoie la position d'une colonne si les 3 derniers elements de cette colonne ne sont pas  
%				de la meme couleur que les elements de l'ia. (permet à l'ia d'empecher l'adversaire de gagner)

% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : Colonne a veifiée

canblock(_,_,8).
canblock(M,Xgagnant,X):-  
                        nth1(X,M, Colonne),longueur(Colonne, Y), Y<6,
                        nth1(Y,Colonne,Color),
                        Color == a, 
                        get_consecutive_neighbors_column(X,Y,M,0, Compteur),
                        Compteur == 2,
                        Xgagnant is X,!.
canblock(M,Xgagnant,X) :- Xsuivant is X+1, canblock(M,Xgagnant,Xsuivant),!.

%test : iadefatak:canwin([[b,a,b],[],[],[],[b,b,b],[],[]],Xgagnant, 1).
%test2: iadefatak:canwin([[b,b,b],[],[],[],[b,b,b],[],[]],Xgagnant, 1).
%test3: should fail iadefatak:canwin([[b,b],[],[],[],[b,b],[],[]],Xgagnant, 1).






% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située a gauche des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'adversaire de l'ia. (permet a l'ia de bloquer l'adversaire).

% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canblock1g(_,_,8).
canblock1g(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == a, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),
				Compteur == 3,Xv is X-1, nth1(Xv,M,Possibilite),longueur(Possibilite,Yp),
				Yp+1==Y,
				Xgagnant is X-1, !.
canblock1g(M,Xgagnant,X) :- Xsuivant is X+1, canblock1g(M,Xgagnant,Xsuivant),!.




% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située a droite des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'adversaire de l'ia. (permet a l'ia de bloquer l'adversaire).% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canblock1d(_,_,8).
canblock1d(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == b, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),
				Compteur == 3,Xv is X+3,Xv<8, nth1(Xv,M,Possibilite),longueur(Possibilite,Yp),
				Yp==Y-1,
				Xgagnant is X+3, !.
canblock1d(M,Xgagnant,X) :- Xsuivant is X+1, canblock1d(M,Xgagnant,Xsuivant),!.




% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située au milieu des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'adversaire. (permet a l'ia de bloquer adversaire).
% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canblock1m1(_,_,5).
canblock1m1(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == a, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),
				Compteur == 2,Xv is X+3,nth1(Xv,M,Col1),longueur(Col1,Y1),nth1(Y1,Col1,Color1),
				Color1==a,
				Xz is X+2,nth1(Xz,M,Possibilite),longueur(Possibilite,Yp),
				Yz is Yp+1, Yz==Y,
				Xgagnant is X+2, !.
canblock1m1(M,Xgagnant,X) :- Xsuivant is X+1, canblock1m1(M,Xgagnant,Xsuivant),!.


% Mode d'emploi : Predicat iteratif qui renvoie la position de la colonne située au des 3 elements voisins d'une ligne de  
%				la meme couleur que les elements de l'adversaire. (permet a l'ia de bloquer l'adversaire).
% Paramètres : 
% 	M : La grille de jeu
%	Xgagnant : colonne permettant de gagner
%	X : colonne à verifier
canblock1m2(_,_,8).
canblock1m2(M,Xgagnant,X):-  
				nth1(X,M, Colonne),longueur(Colonne, Y),
				nth1(Y,Colonne,Color),
				Color == a, 
				get_consecutive_neighbors_ligne(X,Y,M, Compteur),
				Compteur == 2,Xv is X-2, nth1(Xv,M,Col1),longueur(Col1,Y1),nth1(Y1,Col1,Color1),
				Color1==a,
				Xz is X-1, nth1(Xz,M,Possibilite),longueur(Possibilite,Yp),
				Yz is Yp+1, Yz==Y,
				Xgagnant is X-1, !.
canblock1m2(M,Xgagnant,X) :- Xsuivant is X+1, canblock1m2(M,Xgagnant,Xsuivant),!.



 % Fonction pour savoir si les 3 sur la meme diagonale ont la meme couleur
 % Mode d'emploi : Même fonctionnement que les prédicats précédents en vérifiant diagonalement


canblockdiag1(M,Xgagnant,X) :-nth1(X,M,Colonne),longueur(Colonne,Y),     
                              checkFinDiagonaleBefore1(X,Y,M,0,Sb), 
                              Total is Sb,                              
                              Total ==2,Xv is X+1,nth1(Xv,M,C1),
                              longueur(C1,Y1),Y>1,
                              Y2 is Y1+2, Y==Y2,
                              Xgagnant is Xv,!.

canblockdiag2(M,Xgagnant,X) :-nth1(X,M,Colonne),longueur(Colonne,Y),     
                              checkFinDiagonaleAfter1(X,Y,M,0,Sb), 
                              Total is Sb,Y<6,                           
                              Total ==2,Xv is X-1,nth1(Xv,M,C1),
                              longueur(C1,Y1),
                              Y1==Y,
                              Xgagnant is Xv,!. 


canblockdiag3(M,Xgagnant,X) :-nth1(X,M,Colonne),longueur(Colonne,Y),     
                              checkFinDiagonaleBefore2(X,Y,M,0,Sb), 
                              Total is Sb,                              
                              Total ==2,Xv is X+1,nth1(Xv,M,C1),Y<6,
                              longueur(C1,Y1),
                              Y==Y1,
                              Xgagnant is Xv,!.

canblockdiag4(M,Xgagnant,X) :-nth1(X,M,Colonne),longueur(Colonne,Y),     
                              checkFinDiagonaleAfter2(X,Y,M,0,Sb), 
                              Total is Sb,                              
                              Total ==2,Xv is X-1,nth1(Xv,M,C1),Y>1,
                              longueur(C1,Y1),
                              Y2 is Y1+2, Y2 == Y,
                              Xgagnant is Xv,!.


%--------------------------------------------------------------------------------------------------------



%--------------------------------------------------------------------------------------------------------



%gagne colonne
iadefatak(M,Xh,_) :- 
                canwin(M,Xgagnant,1),
                %write('Can win launched'), write(Xgagnant),nl,
                nonvar(Xgagnant), 
                Xh is Xgagnant,
                %write('Non Randomize'),nl,
                !.

%gagne ligne gauche
iadefatak(M,Xh,_) :- 
				canwin1g(M,Xgagnant,2),
				%write('Can win1g launched'), write(Xgagnant),nl,
				nonvar(Xgagnant), 
				Xh is Xgagnant,
				%write('Non Randomize'),nl,
				!.      
				
%gagne ligne droite				          
iadefatak(M,Xh,_) :- 
				canwin1d(M,Xgagnant,1),
				%write('Can win1d launched'), write(Xgagnant),nl,
				nonvar(Xgagnant), 
				Xh is Xgagnant,
				%write('Non Randomize'),nl,
				!.
				
%gagne ligne milieu				          
 iadefatak(M,Xh,_) :- 
                         canwin1m1(M,Xgagnant,1),
                         %write('Can win1m1 launched'), write(Xgagnant),nl,
                         nonvar(Xgagnant), 
                         Xh is Xgagnant,
                         %write('Non Randomize'),nl,
                         !.	
 
 %gagne ligne milieu				          
 iadefatak(M,Xh,_) :- 
                         canwin1m2(M,Xgagnant,3),
                         %write('Can win1m2 launched'), write(Xgagnant),nl,
                         nonvar(Xgagnant), 
                         Xh is Xgagnant,
                         %write('Non Randomize'),nl,
                         !.				
 
%bloque colonne adversaire				          				                          
iadefatak(M,Xh,_) :- 
                        canblock(M,Xgagnant,1),
                        %write('Can block launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !.      

%bloque ligne adversaire	a gauche			          				                          
iadefatak(M,Xh,_) :- 
                        canblock1g(M,Xgagnant,2),
                        %write('Can block1g launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !.   

%bloque ligne adversaire	a droite		          				                          
iadefatak(M,Xh,_) :- 
                        canblock1d(M,Xgagnant,1),
                        %write('Can block1d launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !. 
                        
%bloque ligne milieu				          
 iadefatak(M,Xh,_) :- 
                         canblock1m1(M,Xgagnant,1),
                         %write('Can block1m1 launched'), write(Xgagnant),nl,
                         nonvar(Xgagnant), 
                         Xh is Xgagnant,
                         %write('Non Randomize'),nl,
                         !.	
                         
                         
 %bloque ligne milieu				          
 iadefatak(M,Xh,_) :- 
                         canblock1m2(M,Xgagnant,3),
                         %write('Can block1m2 launched'), write(Xgagnant),nl,
                         nonvar(Xgagnant), 
                         Xh is Xgagnant,
                         %write('Non Randomize'),nl,
                         !.		
                         			
                                                             
%bloque diagonale				          
iadefatak(M,Xh,Xpos) :- 
                        canblockdiag1(M,Xgagnant,Xpos),
                        %write('Can blockdiag1 launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !.	
                        
%bloque diagonale				          
iadefatak(M,Xh,Xpos) :- 
                        canblockdiag2(M,Xgagnant,Xpos),
                        %write('Can blockdiag2 launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !.	

%bloque diagonale				          
iadefatak(M,Xh,Xpos) :- 
                        canblockdiag3(M,Xgagnant,Xpos),
                        %write('Can blockdiag3 launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !.	

%bloque diagonale				          
iadefatak(M,Xh,Xpos) :- 
                        canblockdiag4(M,Xgagnant,Xpos),
                        %write('Can blockdiag4 launched'), write(Xgagnant),nl,
                        nonvar(Xgagnant), 
                        Xh is Xgagnant,
                        %write('Non Randomize'),nl,
                        !.	                                                                       
                                                 
                 
%joue a gauche ou a droite de la derniere position
iadefatak(M,Xh,Xpos) :- nth1(Xpos,M,C),longueur(C,Y),Xpos<7,
						Xv is Xpos+1,nth1(Xv,M,C1),
						longueur(C1,Y1),Y2 is Y1+1,Y2==Y,
						Xh=Xv,!.

		          				                            
iadefatak(M,Xh,Xpos) :- nth1(Xpos,M,C),longueur(C,Y),Xpos>1,
                        Xv is Xpos-1,nth1(Xv,M,C1),
                        longueur(C1,Y1),Y2 is Y1+1,Y2==Y,
                        Xh=Xv,!.


                        
iadefatak(M,Xh,_) :- iarandom(M,Xh),!.
                        
                        
