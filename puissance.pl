:- use_module(iarandom).
:- use_module(matrice_utils).
:- use_module(finJeu).



%Predicat pour dessiner soit le pion du joueur a en rouge, soit celui du joueur b en vert ou un espace si la case est vide
print_element(H) :- H = a, ansi_format([bold, fg(red)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []).
print_element(H) :- H = b, ansi_format([bold, fg(green)], 'o', []),  ansi_format([bold, fg(blue)], ' | ', []).
print_element(H) :- H \= a, H \= b, ansi_format([bold, fg(green)], ' ', []),  ansi_format([bold, fg(blue)], ' | ', []).

%Predicat qui permet de dessiner une ligne
print_line(M,8,Y).
print_line(M,X,Y) :-  nth1(X,M,Column), nth1(Y,Column,Elem), print_element(Elem), Xa is X+1, print_line(M,Xa,Y), !. 
print_line(M,X,Y) :-  print_element(c) , Xa is X+1, print_line(M,Xa,Y), !. 

%Predicat qui permet de dessiner toutes les colonnes. Il dessine les lignes une par une et redessine par recursion
print_column(M,X,0).
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


% Lancement du jeu
% Si Full on sarrete
puissance :- p(X), 
			 all_full(X), 
			 write('Its a draw'), 
			 !.

puissance :- p(X),
			 write('>>'), 
			 read(I),
			 ( is_outbound(I) -> write('>>Please a number between 1 and 7'), nl, puissance ;

			 	get_column(X,I,C), 
			 	( column_is_full(C) ->  write('>>Column Is Full Try Another One'), nl, puissance ;
			 						addElement(a,I), 
			 						p(Y), checkFinJeu(I,Y),
			 						write('You Won')
			 	)
			 )
			 ,!.

puissance :- p(X), 
			 all_full(X), 
			 write('Its a draw'), 
			 !.

puissance :- p(Y), iarandom(Y,XRandom), 
			 addElement(b,XRandom), 
			 p(Z), checkFinJeu(XRandom,Z),
			 write('IA Won'),!.

puissance :- p(Z),print_matrix(Z),
			 puissance.








