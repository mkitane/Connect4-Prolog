:- module(iadefensive, [iadefensive/3]).

:-use_module(matrice_utils).


iadefensive(M,Xh,Xpos) :- 			
			Xh is Xpos,
			nth1(Xh,M, Colonne),  %Get Column and check size
			longueur(Colonne, N),
			N=<5,!.

iadefensive(M,Xh,Xpos) :- iadefensive(M,Xh,Xpos),!.