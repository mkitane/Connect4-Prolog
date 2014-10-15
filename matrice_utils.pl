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
% Paramètres : R(int colonne cible), NEW(data) , Mat(cible), Upd(Result)
% replace(R, NEW, Mat, Upd):- nth1(R, Mat, X), 
                         %   select(X, Mat, RestRows),   % get the row and the rest
                         %   select(NEW, Upd, RestRows),   % insert updated row in rest, get Upd 
                         %   nth1(R, Upd, NEW).


% replace([_|T], 0, X, [X|T]).
% replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
% replace(L, _, _, L).
% jouer(A,I) :- p(X), nthElem(I,X,Elem), ajoutFin(A,Elem,Newcolonne), Indice is I+1,  replace(X,Indice,Newcolonne, R), retract(p(_)) ,assert(p(R)), !.


replace(1,NEW,[L1,L2,L3,L4,L5,L6,L7],[NEW,L2,L3,L4,L5,L6,L7]).
replace(2,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,NEW,L3,L4,L5,L6,L7]).
replace(3,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,NEW,L4,L5,L6,L7]).
replace(4,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,NEW,L5,L6,L7]).
replace(5,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,L4,NEW,L6,L7]).
replace(6,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,L4,L5,NEW,L7]).
replace(7,NEW,[L1,L2,L3,L4,L5,L6,L7],[L1,L2,L3,L4,L5,L6,NEW]).



addElement(X,I):- p(L),nthElem(I,L,Extr),ajoutFin(X,Extr,NEW),replace(I,NEW,L,R),retract(p(_)),assert(p(R)),!.

