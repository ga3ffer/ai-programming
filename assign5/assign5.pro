
% -*- Mode: Prolog;   -*-
% Kevin Barroga, 2014 Nov 17
% ICS361, Assignment #5
% File: assign5.pro

% recursive Prolog program LISTLENGTH the counts the number of items in a list
listlength([],0).
listlength([_|Tail], L) :-
    listlength(Tail, L1),
    L is L1 + 1.

% -----------------------------------------------------------------------------

% Tail Recursive Factorial program valid for input N >= 0
% This program rejects negative and non-integer numbers
myfac(N,Fact) :-
    (float(N) -> fail;
    \+between(0,inf,N) -> fail ;
    fact_iter(N,1,Fact)).

% Give result when N gets to 0
fact_iter(0, SoFar, SoFar) :- !. 
% N > 0
fact_iter(N, SoFar, Ans) :-
    N1 is N - 1,
    SoFar1 is N * SoFar,
    fact_iter(N1, SoFar1, Ans).

% -----------------------------------------------------------------------------

% Colored Ball problems

% program that produces solutions to a row of colored balls given some rules.

% to run, type > go<number>
% ex.            go6.

% select an element for use in permutation test
%
% If the element is the head of the list, then it is in the list, and the tail is left
selectE(Element, [Element|Tail], Tail).        
% If the two lists have the same head, check for more elements in the rest of the lists
selectE(Element, [Head|Tail1], [Head|Tail2]) :-
        selectE(Element, Tail1, Tail2).

% generate permutations
%
% The empty list is a permutation of itself
permutationQ([],[]).
% List1 is a permutation of List2 if each element occurs in both lists 
%    the same number of times
permutationQ(List, [Head|Tail]) :- selectE(Head, List, Rest),
                                  permutationQ(Rest, Tail).

% Situation #1 (15 p) 
% You have six colored balls: 2 green, 2 blue and 2 yellow 
% Constraints:
%   No balls of the same color may be adjacent to one another.
go1 :- setof(t,permutationQ([green,blue,yellow,green,blue,yellow],[A,B,C,D,E,F]),_),
    A\==B,
    B\==C,
    C\==D,
    D\==E,
    E\==F,
% print any solution you find 
    printout1([A,B,C,D,E,F]).

% print solutions
printout1([A,B,C,D,E,F]) :- 
    nl,
    write('The order of balls from left to right is: '), nl,
    write(A), write(' '),
    write(B), write(' '),
    write(C), write(' '),
    write(D), write(' '),
    write(E), write(' '),
    write(F), write(' '),nl.


% Situation #2 (15 p) 
% You have six colored balls: 4 black, 1 red and 1 blue.
% Constraints:
%   There are no more than 2 black balls in a row.
go2 :- setof(t,permutationQ([black,black,black,black,red,blue],[A,B,C,D,E,F]),_), 
    ((A==red -> D==blue);
    (A==blue -> D==red);
    (B==red -> E==blue); 
    (B==blue -> E==red); 
    ((C==red -> F==blue); (C==red -> D==blue));
    ((C==blue -> F==red); (C==blue -> D==red)); 
    (D==red -> C==blue); 
    (D==blue -> C==red)),
% print any solution you find 
    printout2([A,B,C,D,E,F]).

% print solutions
printout2([A,B,C,D,E,F]) :- 
    nl,
    write('The order of balls from left to right is: '), nl,
    write(A), write(' '),
    write(B), write(' '),
    write(C), write(' '),
    write(D), write(' '),
    write(E), write(' '),
    write(F), write(' '),nl.


% Situation #3 (30 p) 
% You have eight colored balls: 1 black, 2 white, 2 red and 3 green.
% Constraints:
%   The balls in positions 2 and 3 are not green.
%   The balls in positions 4 and 8 are the same color.
%   The balls in positions 1 and 7 are of different colors.
%   There is a green ball to the left of every red ball.
%   A white ball is neither first nor last.
%   The balls in positions 6 and 7 are not red.
go3 :- setof(t,permutationQ([black,white,white,red,red,green,green,green],[A,B,C,D,E,F,G,H]),_),
% The colors in positions 2 and 3 are not green. 
    \+ B=green,
    \+ C=green,
% The colors in positions 5 and 6 are not green because the colors in positions 6 and 7 are not red. 
    \+ E=green,
    \+ F=green,
% Since red can't be in position 8, green can't be in position 7.
    \+ G=green,
% The colors in positions 4 and 8 are the same color. 
    D=H,
% The colors in positions 1 and 8 are of different colors. 
    \+ A=G,
% The color in positions 6 and 7 are not red. 
    \+ F=red,
    \+ G=red,
% Red can't be in position 1 because there isn't any other position on the left for the green.
    \+ A=red,
% The colors in positions 3 and 4 are not red because the colors in positions 2 and 3 are not green. 
    \+ C=red,
    \+ D=red,
% Whites are neither in position 1 nor 8. 
    \+ A=white,
    \+ H=white,
% White is not in position 4 because white can't be in position 8.
    \+ D=white,
% print any solution you find    
    printout3([A,B,C,D,E,F,G,H]).

% print solutions
printout3([A,B,C,D,E,F,G,H]) :-
    nl,
    write('The order of balls from left to right is: '), nl,
    write(A), write(' '),
    write(B), write(' '),
    write(C), write(' '),
    write(D), write(' '),
    write(E), write(' '),
    write(F), write(' '),
    write(G), write(' '),
    write(H), write(' '),nl.

% -----------------------------------------------------------------------------

% Extra credit - Write a functor named split3(N,L) that takes two parameters: 
% N, a positive integer, and L, a list of positive integers. 
% You may assume that the list L is flat, i.e., it does not contain sublists. 
% The functor split3 returns true if the list L can be partitioned into three 
% sublists (with elements in the same oder), such that the sum of the integers 
% in each subset is less than or equal to N. Otherwise, it returns false.

% sum of list tail function
sumAcc([], Acc, Acc).
sumAcc([H|T], Acc, X) :- 
    Aux is Acc + H, sumAcc(T, Aux, X).

sum(L, S) :- 
    sumAcc(L, 0, S).

% finds all subsets of list
subSet([], []).
subSet([H|T], [H|R]) :- 
    subSet(T, R).

subSet([_|T], R) :- 
    subSet(T, R).

% calculates the sum of all subsets
intSum(L, N, S) :- 
    subSet(L, S), sum(S, N).

split3(0,List).
split3(N,List) :- 
    intSum(List, N, S).