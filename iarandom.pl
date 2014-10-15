:- module(iarandom, [iarandom/2]).

:-use_module(matrice_utils).


% iarandom(M,XRand) :- 
%			longueur(M,Length_m),
%			random_between(1,Length_m,XRandom),
%			nth1(XRandom,M, Colonne),  %Get Column and check size
%			longueur(Colonne, N),
%			( N < 6 -> XRand is XRandom ; iarandom(M, XRand1), XRand is XRand1).



%Si inferieur à 5, cest bon on garde, sinon on passe au predicat suivant, qui relance.
iarandom(M,XRand) :- 			
			longueur(M,Length_m),
			random_between(1,Length_m,XRand),
			nth1(XRand,M, Colonne),  %Get Column and check size
			longueur(Colonne, N),
			N=<5,!.

iarandom(M,XRand) :- iarandom(M, XRand),!.