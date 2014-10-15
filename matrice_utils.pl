:- module(matrice_utils, [addElement/2, replace/4, nthElem/3, ajoutFin/3, longueur/2, isSame/3, all_full/1, is_outbound/1, get_column/3, column_is_full/1]).

get_column(M,I,C) :- nth1(I,M, C). 
column_is_full(C) :- longueur(C,Length_c), Length_c > 5.

all_full([]).
all_full([H|T]) :- column_is_full(H), all_full(T).


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


% Compare si deux elements dune liste sont les memes. 
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).

                                                                                                                                

% Fonction qui compare si deux elements dune liste sont les memes.
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

addElement(A,I) :- p(X), nthElem(I,X,Elem), ajoutFin(A,Elem,Newcolonne), Indice is I-1, replace(X,Indice,Newcolonne,R), retract(p(_)) ,assert(p(R)), !.

