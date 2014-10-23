:- module(iadefensive, [iadefensive/3]).

:-use_module(matrice_utils).
:-use_module(iarandom).




iadefensive(M,Xh,Xpos) :- 
nth1(Xpos,M, Colonne),  %Get Column and check size
longueur(Colonne, N),
get_consecutive_neighbors_column(Xpos,N,M,0, Cpt),
Cpt=2,
Xh is Xpos,
N=<5,!.

iadefensive(M,Xh,Xpos) :- 
nth1(Xpos,M, Colonne),  %Get Column and check size
longueur(Colonne, N),
get_consecutive_neighbors_ligne(Xpos,N,M,Cpt),
Xpos>=2,	Cpt=1,
Xh is Xpos-1,
N=<5,!.

iadefensive(M,Xh,Xpos) :- 
			nth1(Xpos,M, Colonne),  %Get Column and check size
			longueur(Colonne, N),
			get_consecutive_neighbors_ligne(Xpos,N,M,Cpt),
			Xpos<7,	
			Xh is Xpos+ (Cpt//3),
			N=<5,!.
			
iadefensive(M,Xh,Xpos) :- 
			nth1(Xpos,M, Colonne),  %Get Column and check size
			longueur(Colonne, N),
			get_consecutive_neighbors_ligne(Xpos,N,M,Cpt),
			Xpos=7,	
			Xh is Xpos-3,
			N=<5,!.

iadefensive(M,Xh,Xpos) :- iarandom(M,Xh),!.