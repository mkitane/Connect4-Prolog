:- module(matrice_utils, [addElement/2, replace/4, nthElem/3, ajoutFin/3, longueur/2, isSame/3, all_full/1, is_outbound/1, get_column/3, column_is_full/1, get_consecutive_neighbors_column/5, get_consecutive_neighbors_ligne_before/5, get_consecutive_neighbors_ligne_after/5, get_consecutive_neighbors_ligne/4, checkFinDiagonaleBefore1/5, checkFinDiagonaleAfter1/5,checkFinDiagonaleBefore2/5,checkFinDiagonaleAfter2/5,getElemFromGrid/4,addElementToMatrix/4,retractElementFromMatrix/3]).

get_column(M,I,C) :- nth1(I,M, C). 
column_is_full(C) :- longueur(C,Length_c), Length_c > 5.

all_full([]).
all_full([H|T]) :- column_is_full(H), all_full(T).

% Returns Elem at position (X,Y) in grid M
getElemFromGrid(X,Y,M,Elem) :- nth1(X,M,L), nth1(Y,L,Elem),!.
getElemFromGrid(_,_,_,_) :- true,!.

% Check if the number entered in parameter is a number between 1 and 7 
is_outbound(I) :- (not(number(I)) ; I<1 ; I>7),!.


longueur([],0).
longueur([_|L],N):- longueur(L,N1), N is N1+1.   



% Fonction qui renvoie le nième élément dune liste 
% Paramètres : N index de lélement qu on veut récupérer, L liste, X élément retourné 
nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).        

ajoutFin(X,[],[X]).
ajoutFin(X,[Y|L1],[Y|L2]):- ajoutFin(X,L1,L2),longueur([Y|L1],N), N<6 .

retireFin([_],[]).
retireFin([Head|L1], [Head|WithoutLast]) :- retireFin(L1, WithoutLast), !.


% Compare si deux elements dune liste sont les memes. 
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).

                                                                                                                                

% Fonction qui compare si deux elements dune liste sont les memes.
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

addElement(A,I) :- p(X), nthElem(I,X,Elem), ajoutFin(A,Elem,Newcolonne), 
				   Indice is I-1, replace(X,Indice,Newcolonne,R), retract(p(_)) ,assert(p(R)), !.

retractElement(I) :- p(X), nthElem(I,X,Elem), retireFin(Elem,Newcolonne), 
					 Indice is I-1, replace(X,Indice,Newcolonne,R), retract(p(_)), assert(p(R)), !. 


addElementToMatrix(A,I,M,MResult) :- 
				nthElem(I,M,Elem), ajoutFin(A,Elem,Newcolonne), 
				Indice is I-1, replace(M,Indice,Newcolonne,MResult), !.

retractElementFromMatrix(I,M,MResult) :-
				nthElem(I,M,Elem), retireFin(Elem,Newcolonne), 
				Indice is I-1, replace(M,Indice,Newcolonne,MResult), !.

%%Utilitaires pour avoir le nombre de voisin en lignes/colonne etc..

get_consecutive_neighbors_column(X,Y,M,S, Compteur) :- 
					Yb is Y-1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(X,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					get_consecutive_neighbors_column(X,Yb,M,Sa, Compteur), !.
get_consecutive_neighbors_column(_,_,_,S, Compteur) :- Compteur is S, !.


% Fonction pour savoir si les 4 sur la meme ligne ont la meme couleur
get_consecutive_neighbors_ligne_before(X,Y,M,S, Compteur) :- 
					Xb is X-1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Y,Lb,Couleur),
					Sa is S + 1, 
					get_consecutive_neighbors_ligne_before(Xb,Y,M,Sa, Compteur), !.
get_consecutive_neighbors_ligne_before(_,_,_,S, Compteur) :- Compteur is S, !.

get_consecutive_neighbors_ligne_after(X,Y,M,S, Compteur) :- 
					Xb is X+1, 
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Y,Lb,Couleur),
					Sa is S + 1, 
					get_consecutive_neighbors_ligne_after(Xb,Y,M,Sa, Compteur), !.
get_consecutive_neighbors_ligne_after(_,_,_,S, Compteur) :- Compteur is S, !.

get_consecutive_neighbors_ligne(X,Y,L,Total) :- 
					get_consecutive_neighbors_ligne_before(X,Y,L,0,Sb), get_consecutive_neighbors_ligne_after(X,Y,L,0,Sa),	
					Total is Sa+Sb+1, !.


					
% Fonction pour savoir si les 4 sur la meme diagonale ont la meme couleur
checkFinDiagonaleBefore1(X,Y,M,S, Compteur) :- 
					Xb is X-1, Yb is Y+1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleBefore1(Xb,Y,M,Sa, Compteur), !.
checkFinDiagonaleBefore1(_,_,_,S, Compteur) :- Compteur is S, !.

checkFinDiagonaleAfter1(X,Y,M,S, Compteur) :- 
					Xb is X+1, Yb is Y-1,
					nth1(X,M,La), nth1(Y,La,Couleur),
					nth1(Xb,M,Lb),nth1(Yb,Lb,Couleur),
					Sa is S + 1, 
					checkFinDiagonaleAfter1(Xb,Y,M,Sa, Compteur), !.
checkFinDiagonaleAfter1(_,_,_,S, Compteur) :- Compteur is S, !.

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