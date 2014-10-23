:- use_module(iarandom).
:- use_module(matrice_utils).
:- use_module(finJeu).
:- use_module(iadefensive).
:- use_module(iadefatak).
:- use_module(iaminmax).


%Predicat pour dessiner soit le pion du joueur a en rouge, soit celui du joueur b en vert ou un espace si la case est vide
print_element(H) :- H = a, ansi_format([bold, fg(red)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []).
print_element(H) :- H = b, ansi_format([bold, fg(green)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []).
print_element(H) :- H \= a, H \= b, ansi_format([bold, fg(green)], ' ', []),  ansi_format([bold, fg(blue)], ' | ', []).

%Predicat qui permet de dessiner une ligne
print_line(_,8,_).
print_line(M,X,Y) :-  nth1(X,M,Column), nth1(Y,Column,Elem), print_element(Elem), Xa is X+1, print_line(M,Xa,Y), !. 
print_line(M,X,Y) :-  print_element(c) , Xa is X+1, print_line(M,Xa,Y), !. 

%Predicat qui permet de dessiner toutes les colonnes. Il dessine les lignes une par une et redessine par recursion
print_column(_,_,0).
print_column(M,X,Y) :- print_line(M,X,Y), nl, Ya is Y - 1 , print_column(M,X,Ya), !.

%Predicat qui gere le dessin du tableau
print_matrix(M) :- X is 1, Y is 6, print_column(M,X,Y). 



% print_column([]).
% print_column([H|T]) :- H = a, ansi_format([bold, fg(red)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
% print_column([H|T]) :- H = b, ansi_format([bold, fg(green)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.
% print_column([H|T]) :- H \= a, H \= b, ansi_format([bold, fg(green)], ' ', []),  ansi_format([bold, fg(blue)], ' | ', []), print_column(T), !.

% print_matrix([]).
% print_matrix([H|T]) :- print_column(H), nl, print_matrix(T).

							

:- dynamic p/1.
p([[],[],[],[],[],[],[]]).
:- dynamic x/1.
x(1). %Permet d'utiliser la position dans laquelle le joueur a jouer globalement.

% Lancement du jeu
% Si Full on sarrete
puissance :- p(Plateau), 
			 all_full(Plateau), 
			 write('Its a draw'), 
			 !.

puissance :- p(Plateau),
			 write('>>'), 
			 read(I),
			 retract(x(_)),
			 assert(x(I)),
			 ( is_outbound(I) -> write('>>Please a number between 1 and 7'), nl, puissance ;

			 	get_column(Plateau,I,C), 
			 	( column_is_full(C) ->  write('>>Column Is Full Try Another One'), nl, puissance ;
			 						addElement(a,I), 
			 						p(PlateauDeux), checkFinJeu(I,PlateauDeux),
			 						write('You Won'),nl, print_matrix(PlateauDeux)
			 	)
			 )
			 ,!.

puissance :- p(Plateau), 
			 all_full(Plateau), 
			 write('Its a draw'),nl, print_matrix(Plateau),
			 !.

puissance :- p(Plateau), x(Xplayed),
			 %iadefensive(Plateau,XRandom,Xplayed),
			 % iarandom(Plateau,XRandom), 
			 iadefatak(Plateau,XRandom,Xplayed),
			 addElement(b,XRandom), 
			 p(PlateauDeux), checkFinJeu(XRandom,PlateauDeux),
			 write('IA Won'),nl, print_matrix(PlateauDeux),!.

puissance :- p(Plateau),print_matrix(Plateau),
			 puissance.








