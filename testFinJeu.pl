:-use_module(finJeu).

:-begin_tests(finJeu).

% ---------------- Test finColonne ----------------

test(t1) :- checkFinColonne(1,4,[[a,a,a,a],[],[],[],[],[]]).
test(t2, [fail]) :- checkFinColonne(1,5,[[a,b,a,a],[],[],[],[],[]]).

% ---------------- Test finLigne ----------------

test(t3) :- checkFinLigne(4,1,[[a,a,a,a],[a],[a],[a],[],[]]).
test(t4, [fail]) :- checkFinLigne(4,1,[[a,a,a,a],[a],[b],[a],[],[]]).

% ---------------- Test finDiagonale1 ----------------

test(t5) :- checkFinDiagonale1(1,4,[[a,a,a,a],[a,a,a],[a,a],[a],[],[]]).
test(t6, [fail]) :- checkFinDiagonale1(1,4,[[a,a,a,a],[a,a,b,a],[a,a],[a],[],[]]).

% ---------------- Test finDiagonale2 ----------------


test(t7) :- checkFinDiagonale2(4,4,[[a],[a,a],[a,a,a],[a,a,a,a],[],[]]).
test(t8, [fail]) :- checkFinDiagonale2(1,4,[[a,a,b,a],[a,a,a],[a,a],[a],[],[]]).

% ---------------- Test finJeu ----------------

test(t9) :- checkFinJeu(1,[[a,a,a,a],[],[],[],[],[]]).
test(t10, [fail]) :- checkFinJeu(1,[[a],[],[],[],[],[]]).

:-end_tests(finJeu).