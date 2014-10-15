:- module(iarandom, [iarandom/1]).

:-use_module(matrice_utils).


iarandom(M) :- 
			longueur(M,Length_m),
			random_between(1,Length_m,XRand),
			nth1(XRand,M, Colonne),  %Get Column and check size
			longueur(Colonne, N),
			( N < 6 -> addElement(b,XRand) ; iarandom(M) ).


