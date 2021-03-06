:- module(iaminmax, [iaminmax/2, minmax/5]).
:-use_module(matrice_utils).
:-use_module(finJeu).
:-use_module(iaglouton).

% Mode d'emploi : Predicat iteratif qui renvoie la valeur maximale entre deux valeurs
%				  Il renvoie aussi le coup à jouer. 
maximum(X, Y, Result, _, X1, BestX1) :- X < Y, Result is Y,  BestX1 is X1, !.
maximum(X, _, Result, BestX, _, BestX1) :- Result is X, BestX1 is BestX, !. 
minimum(X, Y, Result, BestX, _, BestX1) :- X < Y, Result is X, BestX1 is BestX, !.
minimum(_, Y, Result, _, X1, BestX1) :- Result is Y, BestX1 is X1,!. 


% Mode d'emploi : Predicat iteratif qui renvoie la valeur finale à jouer
%				  Au final Child est la colonne a jouer

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verifier
%	Profondeur : Profondeur dans l'arbre
%	Valeur : Meilleure Valeur Selon l'algorithme minmax
%	X : Coup à jouer correspondant à la valeur choisie

% Algorithm : 
% function minmax(node, depth, maximizingPlayer)
%     if depth = 0 or node is a terminal node
%         return the heuristic value of node
%     if maximizingPlayer
%         bestValue := -∞
%         for each child of node
%             val := minmax(child, depth - 1, FALSE)
%             bestValue := max(bestValue, val)
%         return bestValue
%     else
%         bestValue := +∞
%         for each child of node
%             val := minmax(child, depth - 1, TRUE)
%             bestValue := min(bestValue, val)
%         return bestValue

minmax(Plateau,Child,Profondeur,Value, X) :-  Profondeur \= 0, Xc is Child +1 ,  nth1(Xc,Plateau, Column), column_is_full(Column), X is Child, Value is 0,!.
minmax(Plateau,Child,_,Value, X) :- Xc is Child +1 , iaWon(Plateau,Xc), Value is 100000, X is Child,!.
minmax(Plateau,Child,_,Value, X) :- Xc is Child +1 ,playerWon(Plateau,Xc), Value is -100000, X is Child,!.
minmax(Plateau,Child,_,Value, X) :- all_full(Plateau), Value is 0, X is Child,!.
minmax(Plateau, Child, 3, Value, X) :-  Xc is Child+1, heuristique(Plateau,Xc, Value), 
										%write('   		//Result'), write(Value), nl,nl,
										X is Child,!.

minmax(Plateau, _, Profondeur, Value, X) :- 
		Max is Profondeur mod 2, 
		%write('Begginning Childs Profondeur : '), write(Profondeur), nl,

		((Max = 0 ) -> BestValue is -100000 ; BestValue is 100000 ), %Max = 0, c'est max qui joue
		BestX is 0, 
		loopChild(Plateau,0,Profondeur,BestValue,ValeurARetenir, BestX, XaRetenir),
		Value is ValeurARetenir,
		X is XaRetenir,
		%write('Finishing Childs Profondeur : '), write(Profondeur), write(' with Best Value '),write(ValeurARetenir), write(' And X '), write(XaRetenir), nl,
		!.


% Mode d'emploi : Predicat iteratif qui renvoie la valeur a retenir quand on remonte à un noeud parent(Soit le min ou le max des noeuds fils)

% Paramètres : 
% 	Plateau : La grille de jeu
%	Child : Numero du fils à verifier
%	Profondeur : Profondeur dans l'arbre
%	BestValue : Meilleure valeur heuristique a l'iteration actuelle
%	ValeurARetenir : Meilleure valeur heuristique a transmettre au noeud parent
% 	BestX : Meme fonctionnement que BestValue
%	XaRetenir : Meme fonctionnement que ValeurARetenir

%Si la colonne est full pour ce fils, on passe au suivant
loopChild(_,7,_, BestValue, ValeurARetenir, BestX, XaRetenir) :- ValeurARetenir is BestValue, XaRetenir is BestX, !.
loopChild(Plateau,Child,Profondeur, BestValue, ValeurARetenir, BestX, XaRetenir) :- Xc is Child+1 , nth1(Xc,Plateau, Column), column_is_full(Column), 
																		loopChild(Plateau,Xc,Profondeur, BestValue, ValeurARetenir, BestX, XaRetenir),!.
loopChild(Plateau,Child,Profondeur, BestValue, ValeurARetenir, BestX, XaRetenir) :- 
		Profondeur1 is Profondeur+1,
		Max is Profondeur1 mod 2, 
		ChildElement is Child +1 ,  %Solve indice problems
		((Max = 1) -> addElementToMatrix(b,ChildElement,Plateau, Plateau1) ; addElementToMatrix(a,ChildElement,Plateau, Plateau1) ),

		%write('    Begginning Next Element'), nl,
		%write('        Profondeur : '), write(Profondeur1), nl,
		%write('        Child :'), write(ChildCol), nl,
		%write('        Adding Element'),nl,
		%write('        Entering minmax'), nl, 
		%write(Plateau1),nl,
		
		minmax(Plateau1, Child, Profondeur1, Value1, _),
		retractElementFromMatrix(ChildElement,Plateau1,Plateau2),


		%write('                             The best Value was'), write(BestValue),
		%write(' With X : '), write(BestX), nl,
		((Max = 1) -> maximum(BestValue, Value1, BestValue1, BestX, Child, BestX1) ; minimum(BestValue, Value1, BestValue1, BestX, Child, BestX1)),
		Child1 is Child+1,


		%write('        Sortie minmax avec Valeur : '), write(Value1), nl,
		%write('        Removing Element From : '), write(Profondeur), write(' And Child : '), write(Child1), nl,
		%write('              The best Value for now is '), write(BestValue1),
		%write(' With X : '), write(BestX1), nl,
		%write('    Ending Next Element'),nl,nl,

		loopChild(Plateau2,Child1,Profondeur, BestValue1, ValeurARetenir, BestX1, XaRetenir),!.
		
%Introduction de Xrand pour indices
iaminmax(Plateau, XRand) :- minmax(Plateau,0,0,_,Xc), XRand is Xc +1,  !.