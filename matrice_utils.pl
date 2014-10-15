:- module(matrice_utils, [addElement/2, replace/4, nthElem/3, ajoutFin/3, longueur/2, isSame/3]).


longueur([],0).
longueur([_|L],N):- longueur(L,N1), N is N1+1.   



% Fonction qui renvoie le nième élément dune liste 
% Paramètres : N index de lélement qu on veut récupérer, L liste, X élément retourné 
nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).        

ajoutFin(X,[],[X]).
ajoutFin(X,[Y|L1],[Y|L2]):- ajoutFin(X,L1,L2),longueur([Y|L1],N), N<6 .


% Compare si deux elements dune liste sont les memes. 
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).

                                                                                                                                

% Fonction qui compare si deux elements dune liste sont les memes.
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

addElement(A,I) :- p(X), nthElem(I,X,Elem), ajoutFin(A,Elem,Newcolonne), Indice is I-1, replace(X,Indice,Newcolonne,R), retract(p(_)) ,assert(p(R)), !.

