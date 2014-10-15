:- module(matrice_utils, [addElement/2, replace/4, nthElem/3, ajoutFin/3, longueur/2, isSame/3]).


longueur([],0).
longueur([_|L],N):- longueur(L,N1), N is N1+1.   



% Fonction qui renvoie le nième élément dune liste 
% Paramètres : N index de lélement qu on veut récupérer, L liste, X élément retourné 
nthElem(N, L, []):- longueur(L, N1), N1 < N.
nthElem(N, L, X):- nth1(N, L, X).        

ajoutFin(X,[],[X]).
ajoutFin(X,[Y|L1],[Y|L2]):- ajoutFin(X,L1,L2).




% Compare si deux elements dune liste sont les memes. 
isSame(X,Y,L) :- nth1(X,L,Z), nth1(Y,L,Z).



replace(R, NEW, Mat, Upd) :- nth1(R, Mat, X), 
                            select(X, Mat, RestRows),   % get the row and the rest
                            select(NEW, Upd, RestRows),   % insert updated row in rest, get Upd 
                            nth1(R, Upd, NEW).
                                                                                                                                

addElement(X,I):- p(L),nthElem(I,L,Extr),ajoutFin(X,Extr,NEW),replace(I,NEW,L,R),retract(p(_)),assert(p(R)),!.

