:-use_module(matrice_utils).

:-begin_tests(matrice_utils).

% ---------------- Test get_column(M,I,C) :- nth1(I,M, C). ----------------

test(t1) :- get_column([[a,a,a,a,a,a],[],[],[],[],[]],1,C),C =[a,a,a,a,a,a].


% ---------------- Test column_is_full(C) :- longueur(C,Length_c), Length_c > 5.

test(t2) :- column_is_full([1,1,1,1,1,1]).

% ----------------  all_full([]).

test(t3) :- all_full([[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,1]]).

% -- test si le nombre saisie est entre 1 est 7 

test(t4):- is_outbound(10).

% ----- test longueur 

test(t5) :- longueur([a,a,a,a],F),F = 4.

% -- test nthElem , retourne  le nième élément dune liste 

test(t6) :- nthElem(2,[1,2,3,4],X),X = 2.

test(t7) :- isSame(1,2,[0,0]).

test(t8) :- replace([[4,5,6],[8,10,11]],0,[1,2,3],L),L = [[1,2,3],[8,10,11]].


:-end_tests(matrice_utils).