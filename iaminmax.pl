:- module(iaminmax, [minimax/5]).
:-use_module(matrice_utils).
				
heuristic(Plateau,Result) :- random_between(1,5000,Result), write('    //Result :'), write(Result), nl,!. 


% Mode d'emploi : Predicat iteratif qui renvoie la valeur maximale entre deux valeurs
%				  Il renvoie aussi le coup à jouer. 
maximum(X, Y, Result, BestX, X1, BestX1) :- X < Y, Result is Y,  BestX1 is X1, !.
maximum(X, Y, Result, BestX, X1, BestX1) :- Result is X, BestX1 is BestX, !. 
minimum(X, Y, Result, BestX, X1, BestX1) :- X < Y, Result is X, BestX1 is BestX, !.
minimum(X, Y, Result, BestX, X1, BestX1) :- Result is Y, BestX1 is X1,!. 


% Mode d'emploi : Predicat iteratif qui renvoie la valeur finale à jouer
%				  Au final Child est la colonne a jouer

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verifier
%	Profondeur : Profondeur dans l'arbre
%	Valeur : Meilleure Valeur Selon l'algorithme minmax
%	X : Coup à jouer correspondant à la valeur choisie

% Algorithm : 
% function minimax(node, depth, maximizingPlayer)
%     if depth = 0 or node is a terminal node
%         return the heuristic value of node
%     if maximizingPlayer
%         bestValue := -∞
%         for each child of node
%             val := minimax(child, depth - 1, FALSE)
%             bestValue := max(bestValue, val)
%         return bestValue
%     else
%         bestValue := +∞
%         for each child of node
%             val := minimax(child, depth - 1, TRUE)
%             bestValue := min(bestValue, val)
%         return bestValue

minimax(Plateau, Child, 2, Value, X) :- heuristic(Plateau, Value), X is Child.
minimax(Plateau, Child, Profondeur, Value, X) :- Child == 2, Profondeur == 1, nl, X is Child, Value is 1309409049409409, write('    //Result :'), write(Value), nl.
%minimax(_,_,_,Value) :- %Un des deux a gagné, ou plateau Full,
%						heuristic(Plateau,Value).
minimax(Plateau, Child, Profondeur, Value, X) :- 
		Max is Profondeur mod 2, 
		write('Begginning Childs Profondeur : '), write(Profondeur), nl,

		((Max = 0 ) -> BestValue is -100000 ; BestValue is 10000 ), %Max = 0, c'est max qui joue
		BestX is 0, 
		loopChild(Plateau,0,Profondeur,BestValue,ValeurARetenir, BestX, XaRetenir),
		Value is ValeurARetenir,
		X is XaRetenir,
		write('Finishing Childs Profondeur : '), write(Profondeur), write(' with Best Value '),write(ValeurARetenir), write(' And X '), write(XaRetenir), nl, !.


% Mode d'emploi : Predicat iteratif qui renvoie la valeur a retenir quand on remonte à un noeud parent(Soit le min ou le max des noeuds fils)

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verifier
%	Profondeur : Profondeur dans l'arbre
%	BestValue : Meilleure valeur heuristique a l'iteration actuelle
%	ValeurARetenir : Meilleure valeur heuristique a transmettre au noeud parent
% 	BestX : Meme fonctionnement que BestValue
%	XaRetenir : Meme fonctionnement que ValeurARetenir
loopChild(Plateau,2,Profondeur, BestValue, ValeurARetenir, BestX, XaRetenir) :- write('SauvegardeValeurARetenir'), nl,nl,ValeurARetenir is BestValue, XaRetenir is BestX, !.
loopChild(Plateau,Child,Profondeur, BestValue, ValeurARetenir, BestX, XaRetenir) :- 
		Profondeur1 is Profondeur+1,

		write('    Begginning Next Element'), nl,
		write('        Profondeur : '), write(Profondeur1), nl,
		write('        Child :'), write(Child), nl,
		write('        Adding Element'),nl,
		write('        Entering minimax'), nl, 

		%addElement(b,Child),
		minimax(Plateau, Child, Profondeur1, Value1, X1),
		%removeElement(Child),
		Max is Profondeur1 mod 2, 
		write('                             The best Value was'), write(BestValue),
		write(' With X : '), write(BestX), nl,
		((Max = 1) -> maximum(BestValue, Value1, BestValue1, BestX, Child, BestX1) ; minimum(BestValue, Value1, BestValue1, BestX, Child, BestX1)),
		Child1 is Child+1,


		write('        Sortie minimax avec Valeur : '), write(Value1), nl,
		write('        Removing Element From : '), write(Profondeur), write(' And Child : '), write(Child), nl,
		write('              The best Value for now is '), write(BestValue1),
		write(' With X : '), write(BestX1), nl,
		write('    Ending Next Element'),nl,nl,

		loopChild(Plateau,Child1,Profondeur, BestValue1, ValeurARetenir, BestX1, XaRetenir).


