:- module(iaglouton, [runiaglouton/2, iaglouton/6, get_points_for_pawn/2, heuristique/3]).
:-use_module(matrice_utils).
		
		
get_points_for_pawn(Pion, Points) :- not(nonvar(Pion)), Points is 0,!.
get_points_for_pawn(a, Points) :- Points is -4,!.
get_points_for_pawn(b, Points) :- Points is 1,!.

get_total_pondere(1, Total2) :- Total2 is 1, !.
get_total_pondere(2, Total2) :- Total2 is 8, !.
get_total_pondere(3, Total2) :- Total2 is 32, !.
get_total_pondere(4, Total2) :- Total2 is 1000, !.
get_total_pondere(Total1, Total2) :- Total2 is -16, !.

egaliser_a_zero(Total, Final) :- Total < 0 , Final is Total, !.
egaliser_a_zero(Total, Final) :- Final is Total, !.

% --------------------- Points for line

get_points_for_line(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_line(X, Y, M, Offset, Points, Cpt) :-
				write('HMAR'), nl,
				RectHead is X-Offset,
				RectHead > 0, RectHead < 5,
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
				get_total_pondere(Total,TotalFinal),
				write('PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE : '), write(TotalPondere),nl,
				%egaliser_a_zero(TotalPondere, TotalFinal),
				write('TotalFinal : '), write(TotalFinal),nl,
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_line(X, Y, M, Iteration, Pointsa,Cpt), !.
				
get_points_for_line(X, Y, M, Offset, Points, Cpt) :-
				Pointsa is Points,
				Iteration is Offset+1,
				get_points_for_line(X, Y, M, Iteration, Pointsa,Cpt), !.

				

% ---------------------- Points for column

get_points_for_column(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_column(X, Y, M, Offset, Points, Cpt) :-
				Ya is Y-Offset, Ya > 0, Ya < 7,
				Yb is Y+1-Offset, Yb > 0, Yb < 7,
				Yc is Y+2-Offset, Yc > 0, Yc < 7,
				Yd is Y+3-Offset, Yd > 0, Yd < 7,
				getElemFromGrid(X,Ya,M,Pion1),
				getElemFromGrid(X,Yb,M,Pion2),
				getElemFromGrid(X,Yc,M,Pion3),
				getElemFromGrid(X,Yd,M,Pion4),

				get_points_for_pawn(Pion1,Points1),
				write('PION : '), write(Xa), write(' '), write(Y), write(' '), write(Pion1), write(' points :'), write(Points1),nl,
				get_points_for_pawn(Pion2,Points2),
				write('PION : '), write(Xb), write(' '), write(Y), write(' '), write(Pion2), write(' points :'), write(Points2),nl,
				get_points_for_pawn(Pion3,Points3),
				write('PION : '), write(Xc), write(' '), write(Y), write(' '), write(Pion3), write(' points :'), write(Points3),nl,
				get_points_for_pawn(Pion4,Points4),
				write('PION : '), write(Xd), write(' '), write(Y), write(' '), write(Pion4), write(' points :'), write(Points4),nl,

				Total is Points1+Points2+Points3+Points4,
				get_total_pondere(Total,TotalFinal),
				write('PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE : '), write(TotalPondere),nl,
				%egaliser_a_zero(TotalPondere, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_column(X, Y, M, Iteration, Pointsa,Cpt), !.
				
get_points_for_column(X, Y, M, Offset, Points, Cpt) :-
				Pointsa is Points,
				Iteration is Offset+1,
				get_points_for_column(X, Y, M, Iteration, Pointsa,Cpt), !.
				

% ---------------------- Points for diago 1

get_points_for_diago1(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_diago1(X, Y, M, Offset, Points, Cpt) :-
				Xa is X-Offset, Ya is Y-Offset, Xa > 0, Xa < 8, Ya > 0, Ya < 7,
				Xb is X+1-Offset, Yb is Y+1-Offset, Xb > 0, Xb < 8, Yb > 0, Yb < 7,
				Xc is X+2-Offset, Yc is Y+2-Offset, Xc > 0, Xc < 8, Yc > 0, Yc < 7,
				Xd is X+3-Offset, Yd is Y+3-Offset, Xd > 0, Xd < 8, Yd > 0, Yd < 7,
				getElemFromGrid(Xa,Ya,M,Pion1),
				getElemFromGrid(Xb,Yb,M,Pion2),
				getElemFromGrid(Xc,Yc,M,Pion3),
				getElemFromGrid(Xd,Yd,M,Pion4),

				get_points_for_pawn(Pion1,Points1),
				get_points_for_pawn(Pion2,Points2),
				get_points_for_pawn(Pion3,Points3),
				get_points_for_pawn(Pion4,Points4),

				Total is Points1+Points2+Points3+Points4,
				get_total_pondere(Total,TotalFinal),
				write('PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE : '), write(TotalPondere),nl,
				%egaliser_a_zero(TotalPondere, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_diago1(X, Y, M, Iteration, Pointsa,Cpt), !.
				
				
get_points_for_diago1(X, Y, M, Offset, Points, Cpt) :-
				Pointsa is Points,
				Iteration is Offset+1,
				get_points_for_diago1(X, Y, M, Iteration, Pointsa,Cpt), !.
				
% ---------------------- Points for diago 2
			
get_points_for_diago2(_,_,_,4,Points, Cpt) :- Cpt is Points, !.	
get_points_for_diago2(X, Y, M, Offset, Points, Cpt) :-
				Xa is X-Offset, Ya is Y-Offset, Xa > 0, Xa < 8, Ya > 0, Ya < 7,
				Xb is X+1-Offset, Yb is Y+1+Offset, Xb > 0, Xb < 8, Yb > 0, Yb < 7,
				Xc is X+2-Offset, Yc is Y+2+Offset, Xc > 0, Xc < 8, Yc > 0, Yc < 7,
				Xd is X+3-Offset, Yd is Y+3+Offset, Xd > 0, Xd < 8, Yd > 0, Yd < 7,
				getElemFromGrid(Xa,Ya,M,Pion1),
				getElemFromGrid(Xb,Yb,M,Pion2),
				getElemFromGrid(Xc,Yc,M,Pion3),
				getElemFromGrid(Xd,Yd,M,Pion4),

				get_points_for_pawn(Pion1,Points1),
				get_points_for_pawn(Pion2,Points2),
				get_points_for_pawn(Pion3,Points3),
				get_points_for_pawn(Pion4,Points4),

				Total is Points1+Points2+Points3+Points4,
				get_total_pondere(Total,TotalFinal),
				write('PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE PONDERE : '), write(TotalPondere),nl,
				%egaliser_a_zero(TotalPondere, TotalFinal),
				Pointsa is Points + TotalFinal,
				Iteration is Offset+1,
				get_points_for_diago2(X, Y, M, Iteration, Pointsa,Cpt), !.		
				
get_points_for_diago2(X, Y, M, Offset, Points, Cpt) :-
				Pointsa is Points,
				Iteration is Offset+1,
				get_points_for_diago2(X, Y, M, Iteration, Pointsa,Cpt), !.	
				

maximum(Totaltemp, Totalligne, Totalchoisi, Xtemp, Xcolonne, Xchoisi) :- Totaltemp < Totalligne, Totalchoisi is Totalligne,  Xchoisi is Xcolonne, !.
maximum(Totaltemp, Totalligne, Totalchoisi, Xtemp, Xcolonne, Xchoisi) :- Totalchoisi is Totaltemp, Xchoisi is Xtemp, !. 
% compte le nb de points pr une ligne



% Heuristique

heuristique(M,X,Value) :-
				nth1(X,M,Colonne),
				longueur(Colonne,Y),
				write('BEGIN BEGIN BEGIN ------------------------------------ '),
				get_points_for_line(X,Y,M,0,0,Totalligne),
				write('POINTS POINTS POINTS POINTS POINTS POINTS POINTS POINTS '), write(X), write(' '), write(Y), write(' '), write(Totalligne),nl,
				get_points_for_column(X,Y,M,0,0,TotalColumn),
				write('TOTAL COLUMN :'), write(TotalColumn), nl,
				get_points_for_diago1(X,Y,M,0,0,TotalDiago1),
				write('TOTAL DIAGO 1 :'), write(TotalDiago1), nl,
				get_points_for_diago2(X,Y,M,0,0,TotalDiago2),
				write('TOTAL DIAGO 2 :'), write(TotalDiago2), nl,
				Value is Totalligne+TotalColumn+TotalDiago1+TotalDiago2.

iaglouton(_,8,Totaltemp, Xtemp, TotalRetenu, Xretenu) :- TotalRetenu is Totaltemp, Xretenu is Xtemp, !.
iaglouton(M,Xcolonne,Totaltemp, Xtemp, TotalRetenu, Xretenu) :- 
				get_column(M,Xcolonne,C),
				not(column_is_full(C)),
				addElementToMatrix(b,Xcolonne,M,MResult1),
				write('Hey'), nl,
				
				heuristique(MResult1,Xcolonne,Total),

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