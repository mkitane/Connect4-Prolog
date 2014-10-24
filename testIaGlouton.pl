:-use_module(iaglouton).

:-begin_tests(iaglouton).

test(t1, [ true(X =@= 2)]) :- iaglouton([[b],[a,b],[b,b],[a,a,b],[a,b],[],[b]],1,0,1,Total,X).

:-end_tests(iaglouton).