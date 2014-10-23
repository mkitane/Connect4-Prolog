:-use_module(matrice_utils).
:-use_module(iaglouton).

:-begin_tests(matrice_utils).

% ---------------- Test get_column(M,I,C) :- nth1(I,M, C). ----------------

test(t1) :- get_column([[a,a,a,a,a,a],[],[],[],[],[]],1,C),C =[a,a,a,a,a,a].
test(te1,[fail]):- get_column([[a,a,a,a,a,a],[],[],[],[b,b,b,b],[]],1,C),C =[b,b,b,b].


% ---------------- Test column_is_full(C) :- longueur(C,Length_c), Length_c > 5.

test(t2) :- column_is_full([1,1,1,1,1,1]).
test(te2,[fail]) :- column_is_full([1,1,1,1]).

% ----------------  all_full([]).

test(t3) :- all_full([[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

test(te3,[fail]) :- all_full([[1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

test(tee3,[fail]) :- all_full([[1,1,1,1,1,1],[1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1],[1,1,1,1,1,1],[1]]).

test(tee3,[fail]) :- all_full([[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1]]).

test(tee3,[fail]) :- all_full([[1],[1,1,1,1,1,1],[1],[,1,1,1,1],[1,1,1,1],[1,1],[1,1]]).


% -- test si le nombre saisie est entre 1 est 7 

test(t4):- is_outbound(10).

test(tee4,[fail]):- is_outbound(2).

% ----- test longueur 

test(t5) :- longueur([a,a,a,a],F),F = 4.
test(tee5) :- longueur([a,a,a,a,a,a,a,a,a,a],F),F = 10.


% -- test nthElem , retourne  le nième élément dune liste 

test(t6) :- nthElem(2,[1,2,3,4],X),X = 2.

test(tee6,[fail]) :- nthElem(4,[1,2,3,4],X),X = 5.

% -- test isSamee
test(t7) :- isSame(1,2,[0,0]).
test(t7,[fail]) :- isSame(1,2,[0,1]).

% test replacee

test(t8) :- replace([[4,5,6],[8,10,11]],0,[1,2,3],L),L = [[1,2,3],[8,10,11]].
test(te8,fail) :- replace([[4,5,6],[8,10,11]],1,[1,2,3],L),L = [[1,2,3],[8,10,11]].

test(teee8) :- replace([[4,5],[8,10,11]],0,[1,5,6],L),L = [[1,5,6],[8,10,11]].

test(tee8) :- replace([[4,5,6],[8,10,11]],1,[1,2,3],L),L = [[4,5,6],[1,2,3]].

% test getElemFromGrid and get_points_for_pawn

test(t9) :- getElemFromGrid(1,1,[[a],[],[],[],[],[],[]], Pion), get_points_for_pawn(Pion, Points).
test(t10) :- getElemFromGrid(1,1,[[b],[],[],[],[],[],[]], Pion), get_points_for_pawn(Pion, Points).
test(t11) :- getElemFromGrid(1,1,[[],[],[],[],[],[],[]], Pion), get_points_for_pawn(Pion, Points).

:-end_tests(matrice_utils).