:- module(iaminmax, [minimax/4, loopChild/4]).
:-use_module(matrice_utils).
				
heuristic(Plateau,Result) :- random_between(1,5000,Result), write('    //Result :'), write(Result), nl,!. 

maximum(X,Y,Result) :- X < Y, Result is Y, !.
maximum(X,Y,Result) :- Result is X,!. 
minimum(X,Y,Result) :- X < Y, Result is X, !.
minimum(X,Y,Result) :- Result is Y,!. 


% Mode d'emploi : Predicat iteratif qui renvoie la valeur finale à jouer
%				  Au final Child est la colonne a jouer

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verifier
%	Profondeur : Profondeur dans l'arbre
%	Valeur : Meilleure Valeur Selon l'algorithme minmax

minimax(Plateau, Child, 2, Value) :- heuristic(Plateau, Value).
%minimax(_,_,_,Value) :- %Un des deux a gagné, ou plateau Full,
%						heuristic(Plateau,Value).
minimax(Plateau, Child, Profondeur, Value) :- 
		Max is Profondeur mod 2, 
		write('Begginning Childs Profondeur : '), write(Profondeur), nl,

		((Max = 0 ) -> BestValue is -100000 ; BestValue is 10000 ), %Max = 0, c'est max qui joue
		loopChild(Plateau,0,Profondeur,BestValue,ValeurARetenir),
		Value is ValeurARetenir,
		write('Finishing Childs Profondeur : '), write(Profondeur), write(' with Best Value '),write(ValeurARetenir), nl, !.


% Mode d'emploi : Predicat iteratif qui renvoie la valeur a retenir quand on remonte à un noeud parent(Soit le min ou le max des noeuds fils)

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verifier
%	Profondeur : Profondeur dans l'arbre
%	BestValue : Meilleure valeur heuristique a l'iteration actuelle
%	ValeurARetenir : Meilleure valeur heuristique a transmettre au noeud parent
loopChild(Plateau,2,Profondeur, BestValue, ValeurARetenir) :- write('SauvegardeValeurARetenir'), nl,nl,ValeurARetenir is BestValue,!.
loopChild(Plateau,Child,Profondeur, BestValue, ValeurARetenir) :- 
		Profondeur1 is Profondeur+1,

		write('    Begginning Next Element'), nl,
		write('        Profondeur : '), write(Profondeur1), nl,
		write('        Child :'), write(Child), nl,
		write('        Adding Element'),nl,
		write('        Entering minimax'), nl, 

		%addElement(b,Child),
		minimax(Plateau, Child, Profondeur1, Value1),
		%removeElement(Child),
		Max is Profondeur1 mod 2, 
		((Max = 1) -> maximum(BestValue, Value1, BestValue1) ; minimum(BestValue, Value1, BestValue1)),
		Child1 is Child+1,


		write('        Sortie minimax avec Valeur : '), write(Value1), nl,
		write('        Removing Element From : '), write(Profondeur), write(' And Child : '), write(Child), nl,
		write('              The best Value for now is '), write(BestValue1),nl,nl,
		write('    Ending Next Element'),nl,

		loopChild(Plateau,Child1,Profondeur, BestValue1, ValeurARetenir).


