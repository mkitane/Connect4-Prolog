:- module(iaminmax, [minimax/4, loopChild/4]).

:-use_module(matrice_utils).
				
:- dynamic p/1.
p([[],[],[],[],[],[],[]]).


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





heuristic(Plateau,Result) :- random_between(1,5000,Result),!. 

maximum(X,Y,Result) :- X < Y, Result is Y, !.
maximum(X,Y,Result) :- Result is X,!. 
minimum(X,Y,Result) :- X < Y, Result is X, !.
minimum(X,Y,Result) :- Result is Y,!. 


% Mode d'emploi : Predicat iteratif qui renvoie la valeur finale à jouer


minimax(Plateau, Child, 2, Value) :- heuristic(Plateau, Value).
%minimax(_,_,_,Value) :- %Un des deux a gagné, ou plateau Full,
%						heuristic(Plateau,Value).


%Child is the the column played??
minimax(Plateau, Child, Profondeur, Value) :- 
		Max is Profondeur mod 2, 
		BestValue is -100000,
		write('Begginning Childs Profondeur : '), write(Profondeur), nl,
		loopChild(Plateau,0,Profondeur,BestValue,ValeurARetenir),
		Value is ValeurARetenir,
		write('Finishing Childs Profondeur : '), write(Profondeur), write(' with Best Value '),write(ValeurARetenir), nl, !.

% Mode d'emploi : Predicat iteratif qui renvoie la valeur a retenir quand on remonte à un noeud parent(Soit le min ou le max des noeuds fils)

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verfieir
%	Profondeur : Profondeur dans l'arbre
%	BestValue : Meilleure valeur heuristique a l'iteration actuelle
%	ValeurARetenir : Meilleure valeur heuristique a transmettre au noeud parent
loopChild(Plateau,2,Profondeur, BestValue, ValeurARetenir) :- write('SauvegardeValeurARetenir'), nl,nl,ValeurARetenir is BestValue,!.
loopChild(Plateau,Child,Profondeur, BestValue, ValeurARetenir) :- 
		Profondeur1 is Profondeur+1,
		%addElement(b,Child),

		write('    Begginning Next Element'), nl,
		write('        Profondeur : '), write(Profondeur1), nl,
		write('        Child :'), write(Child), nl,
		write('        Adding Element'),nl,
		write('        Entering minimax'), nl, 
		minimax(Plateau, Child, Profondeur1, Value1),
		write('        Sortie minimax avec Valeur : '), write(Value1), nl,
		write('        Removing Element From : '), write(Profondeur), write(' And Child : '), write(Child), nl,
		write('              The best Value for now is '), write(BestValue1),nl,nl,
		write('    Ending Next Element'),nl,

		%removeElement(Child),
		maximum(BestValue, Value1, BestValue1),
		Child1 is Child+1,
		loopChild(Plateau,Child1,Profondeur, BestValue1, ValeurARetenir).


