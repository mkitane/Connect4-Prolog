:-use_module(finJeu).

% ---------------- Test finColonne ----------------

%true 
test1 :- checkFinColonne(1,5,[[a,a,a,a] [] [] [] [] []]).
%false
test2 :- checkFinColonne(1,5,[[a,b,a,a] [] [] [] [] []]).

% ---------------- Test finLigne ----------------

%true
test3 :- checkFinLigne(4,1,[[a,a,a,a] [a] [a] [a] [] []]).
%false
test4 :- checkFinLigne(4,1,[[a,a,a,a] [a] [b] [a] [] []]).

% ---------------- Test finDiagonale1 ----------------

%true
test5 :- checkFinDiagonale1(1,4,[[a,a,a,a] [a,a,a] [a,a] [a] [] []]).
%false
test6 :- checkFinDiagonale1(1,4,[[a,a,b,a] [a,a,a] [a,a] [a] [] []]).

% ---------------- Test finDiagonale2 ----------------

%true
test5 :- checkFinDiagonale2(4,4,[[a] [a,a] [a,a,a] [a,a,a,a] [] []]).
%false
test6 :- checkFinDiagonale2(1,4,[[a,a,b,a] [a,a,a] [a,a] [a] [] []]).

% ---------------- Test finJeu ----------------

test10 :- checkFinJeu(1,5,[[a,a,a,a] [] [] [] [] []]).
test11 :- checkFinJeu(1,1,[[a] [] [] [] [] []]).

