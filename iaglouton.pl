:- module(iaglouton, [runiaglouton/2, iaglouton/6, get_points_for_pawn/2]).
:-use_module(matrice_utils).

		
get_points_for_pawn(Pion, Points) :- not(nonvar(Pion)), Points is 0,!.
get_points_for_pawn(a, Points) :- Points is -4,!.
get_points_for_pawn(b, Points) :- Points is 1,!.

egaliser_a_zero(Total, Final) :- Total < 0 , Final is 0, !.
egaliser_a_zero(Total, Final) :- Final is Total, !.

% --------------------- Points for line

get_points_for_line(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_line(X, Y, M, Offset, Points, Cpt) :-
				Xa is X-Offset,
				Xb is X+1-Offset,
				Xc is X+2-Offset,
				Xd is X+3-Offset,
				getElemFromGrid(Xa,Y,M,Pion1),
				getElemFromGrid(Xb,Y,M,Pion2),
				getElemFromGrid(Xc,Y,M,Pion3),
				getElemFromGrid(Xd,Y,M,Pion4),
				
				get_points_for_pawn(Pion1,Points1),
				get_points_for_pawn(Pion2,Points2),
				get_points_for_pawn(Pion3,Points3),
				get_points_for_pawn(Pion4,Points4),

				Total is Points1+Points2+Points3+Points4,
				egaliser_a_zero(Total, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_line(X, Y, M, Iteration, Pointsa,Cpt), !.
				

% ---------------------- Points for column

get_points_for_column(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_column(X, Y, M, Offset, Points, Cpt) :-
				Ya is Y-Offset,
				Yb is Y+1-Offset,
				Yc is Y+2-Offset,
				Yd is Y+3-Offset,
				getElemFromGrid(X,Ya,M,Pion1),
				getElemFromGrid(X,Yb,M,Pion2),
				getElemFromGrid(X,Yc,M,Pion3),
				getElemFromGrid(X,Yd,M,Pion4),

				get_points_for_pawn(Pion1,Points1),
				get_points_for_pawn(Pion2,Points2),
				get_points_for_pawn(Pion3,Points3),
				get_points_for_pawn(Pion4,Points4),

				Total is Points1+Points2+Points3+Points4,
				egaliser_a_zero(Total, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_column(X, Y, M, Iteration, Pointsa,Cpt), !.
				

% ---------------------- Points for diago 1

get_points_for_diago1(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_diago1(X, Y, M, Offset, Points, Cpt) :-
				Xa is X-Offset, Ya is Y-Offset,
				Xb is X+1-Offset, Yb is Y+1-Offset,
				Xc is X+2-Offset, Yc is Y+2-Offset,
				Xd is X+3-Offset, Yd is Y+3-Offset,
				getElemFromGrid(Xa,Ya,M,Pion1),
				getElemFromGrid(Xb,Yb,M,Pion2),
				getElemFromGrid(Xc,Yc,M,Pion3),
				getElemFromGrid(Xd,Yd,M,Pion4),

				get_points_for_pawn(Pion1,Points1),
				get_points_for_pawn(Pion2,Points2),
				get_points_for_pawn(Pion3,Points3),
				get_points_for_pawn(Pion4,Points4),

				Total is Points1+Points2+Points3+Points4,
				egaliser_a_zero(Total, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_diago1(X, Y, M, Iteration, Pointsa,Cpt), !.
				
% ---------------------- Points for diago 2
			
get_points_for_diago2(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_diago2(X, Y, M, Offset, Points, Cpt) :-
				Xa is X-Offset, Ya is Y-Offset,
				Xb is X+1-Offset, Yb is Y+1+Offset,
				Xc is X+2-Offset, Yc is Y+2+Offset,
				Xd is X+3-Offset, Yd is Y+3+Offset,
				getElemFromGrid(Xa,Ya,M,Pion1),
				getElemFromGrid(Xb,Yb,M,Pion2),
				getElemFromGrid(Xc,Yc,M,Pion3),
				getElemFromGrid(Xd,Yd,M,Pion4),

				get_points_for_pawn(Pion1,Points1),
				get_points_for_pawn(Pion2,Points2),
				get_points_for_pawn(Pion3,Points3),
				get_points_for_pawn(Pion4,Points4),

				Total is Points1+Points2+Points3+Points4,
				egaliser_a_zero(Total, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_diago2(X, Y, M, Iteration, Pointsa,Cpt), !.			
				

maximum(Totaltemp, Totalligne, Totalchoisi, Xtemp, Xcolonne, Xchoisi) :- Totaltemp < Totalligne, Totalchoisi is Totalligne,  Xchoisi is Xcolonne, !.
maximum(Totaltemp, Totalligne, Totalchoisi, Xtemp, Xcolonne, Xchoisi) :- Totalchoisi is Totaltemp, Xchoisi is Xtemp, !. 
% compte le nb de points pr une ligne

iaglouton(_,8,Totaltemp, Xtemp, TotalRetenu, Xretenu) :- TotalRetenu is Totaltemp, Xretenu is Xtemp, !.
iaglouton(M,Xcolonne,Totaltemp, Xtemp, TotalRetenu, Xretenu) :- 
				get_column(M,Xcolonne,C),
				not(column_is_full(C)),
				addElementToMatrix(b,Xcolonne,M,MResult1),
				write('Hey'), nl,
				nth1(Xcolonne,MResult1,Colonne),
				write('Hey'), nl,
				longueur(Colonne,Y),
				write('Hey'), nl,

				write('TotalTemporaire'), write(Totaltemp), 
				nl, write('XTemporaire'), write(Xtemp),nl,
				
				get_points_for_line(Xcolonne,Y,MResult1,0,0,Totalligne),
				get_points_for_column(Xcolonne,Y,MResult1,0,0,TotalColumn),
				get_points_for_diago1(Xcolonne,Y,MResult1,0,0,TotalDiago1),
				get_points_for_diago2(Xcolonne,Y,MResult1,0,0,TotalDiago2),
				Total is Totalligne+TotalColumn+TotalDiago1+TotalDiago2,

				write('TotalLigne'), write(Totalligne), 
				write('TotalColonne'), write(TotalColumn), 
				nl, write('XLigne'), write(Xcolonne),nl,
				
				maximum(Totaltemp, Total, TotalChoisi, Xtemp, Xcolonne, Xchoisi),
				
				write('TotalChoisi'), write(TotalChoisi), 
				nl, write('Xchoisi'), write(Xchoisi),nl,
				
				retractElementFromMatrix(Xcolonne,MResult1,MResult2),
				X2 is Xcolonne+1,
				iaglouton(MResult2,X2, TotalChoisi, Xchoisi, TotalRetenu, Xretenu), !.

iaglouton(M,Xcolonne,Totaltemp, Xtemp, TotalRetenu, Xretenu) :-
				Xnext is Xcolonne+1,
				iaglouton(M,Xnext,Totaltemp, Xtemp, TotalRetenu, Xretenu), !.
				
runiaglouton(M,X) :-
				iaglouton(M,1,0,1,Total,X).