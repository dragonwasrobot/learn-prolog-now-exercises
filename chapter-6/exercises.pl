%% Chapter 6 - Exercises

%% Exercise 6.1

%% Let's call a list doubled if it is made of two consecutive blocks of elements
%% that are exactly the same. For example, [a,b,c,a,b,c] is doubled (it's made
%% up of [a,b,c]followed by [a,b,c]) and so is [foo,gubble,foo,gubble]. On the
%% other hand, [foo,gubble,foo] is not doubled. Write a predicate doubled(List)
%% which succeeds when List is a doubled list.

%% Helper functions

%% equal
%% base case
equal([],[]).

%% inductive case
equal([H1|T1], [H1|T2]) :- equal(T1,T2).

%% prefix
prefix(P,L) :- append(P,_,L).

%% suffix
suffix(S,L) :- append(_,S,L).

%% split

%% accSplit([Head|Tail], Prefix, Suffix).
%% It is quite inefficient since it has to compute all lengths and for recursion
%% and also check if the two lists are prefix/suffix.
%% recursion.

%% base case
split([],[],[]).

%% inductive case
split(List, Prefix, Suffix) :-
  prefix(Prefix,List),
  suffix(Suffix,List),
  length(List, LLength),
  length(Prefix, PLength),
  length(Suffix, SLength),
  PLength is SLength,
  LLength is PLength + SLength.

%% Actual function

%% doubled
doubled(List) :-
  split(List,X,Y),
  equal(X,Y).

%% Exercise 6.2

%% A palindrome is a word or phrase that spells the same forwards and
%% backwards. For example, `rotator', `eve', and `nurses run' are all
%% palindromes. Write a predicate palindrome(List), which checks whether List is
%% a palindrome. For example, to the queries

%% ?- palindrome([r,o,t,a,t,o,r]).
%% and
%% ?- palindrome([n,u,r,s,e,s,r,u,n]).
%% Prolog should respond `yes', but to the query
%% ?- palindrome([n,o,t,h,i,s]).
%% Prolog should respond `no'.

%% Helper functions

%% equal
%% base case
equal([],[]).
%% inductive case
equal([H1|T1], [H1|T2]) :- equal(T1,T2).

%% reverse
%% base case
accRev([],A,A).
%% inductive case
accRev([H|T],A,R) :- accRev(T,[H|A],R).
%% main
rev(L,R) :- accRev(L,[],R).

%% Actual function

%% palindrome
%% main
palindrome(List) :-
  rev(List, RevList),
  equal(List, RevList).

%% Exercise 6.3

%% 1. Write a predicate second(X,List) which checks whether X is the second
%% element of List.

second(X, [Y, X | List]).

%% 2. Write a predicate swap12(List1,List2) which checks whether List1 is
%% identical to List2, except that the first two elements are exchanged.

%% Helper function

%% equal
%% base case
equal([],[]).
%% inductive case
equal([H1|T1], [H1|T2]) :- equal(T1,T2).

%% Actual function
swap12([],[]).
swap12([X, Y | List1], [Y, X | List2]) :-
  equal(T1,T2).

%% 3. Write a predicate final(X,List) which checks whether X is the last element
%% of List.

%% Helper function

%% reverse
%% base case
accRev([],A,A).
%% inductive case
accRev([H|T],A,R) :- accRev(T,[H|A],R).
%% main
rev(L,R) :- accRev(L,[],R).

%% Actual function
final([],[]).
final(X,List) :-
  rev(List, [X|_]).

%% 4. Write a predicate toptail(InList,Outlist) which says `no' if inlist is a
%% list containing fewer than 2 elements, and which deletes the first and the
%% last elements of Inlist and returns the result as Outlist, when Inlist is a
%% list containing at least 2 elements. For example:

%% toptail([a],T).
%% no

%% toptail([a,b],T).
%% T=[]

%% toptail([a,b,c],T).
%% T=[b]

%% Hint: here's where append comes in useful.

%% Helper function

%% reverse
%% base case
accRev([],A,A).
%% inductive case
accRev([H|T],A,R) :- accRev(T,[H|A],R).
%% main
rev(L,R) :- accRev(L,[],R).

%% Actual function

%% toptail(InList, Outlist)
toptail(Inlist,Outlist) :-
  length(Inlist, InlistLength),
  InlistLength >= 2,
  chopOffEnds(Inlist,Outlist).

chopOffEnds([_|T],Outlist) :-
  rev(T, [_|RevOutlist]),
  rev(RevOutlist,Outlist).

%% 5. Write a predicate swapfl(List1,List2) which checks whether List1 is
%% identical to List2, except that the first and last elements are
%% exchanged. Hint: here's where append comes in useful again.

%% Helper function

%% equal
%% base case
equal([],[]).
%% inductive case
equal([H1|T1], [H1|T2]) :- equal(T1,T2).

%% reverse
%% base case
accRev([],A,A).
%% inductive case
accRev([H|T],A,R) :- accRev(T,[H|A],R).
%% main
rev(L,R) :- accRev(L,[],R).

chopOffEnds([_|T],Outlist) :-
  rev(T, [_|RevOutlist]),
  rev(RevOutlist,Outlist).

%% Actual function

%% swapfl(List1, List2)
swapfl(List1,List2) :-
  compareFirstLast(List1,List2),
  compareFirstLast(List2,List1),
  chopOffEnds(List1, Outlist1),
  chopOffEnds(List2, Outlist2),
  equal(Outlist1,Outlist2).

compareFirstLast([H|T1],L2) :- rev(L2, [H|_]).

%% Exercise 6.4

%% And here is an exercise for those of you who, like me, like logic puzzles.

%% There is a street with three neighboring houses that all have a different
%% color. They are red, blue, and green. People of different nationalities live
%% in the different houses and they all have a different pet. Here are some more
%% facts about them:

%% The Englishman lives in the red house.
%% The jaguar is the pet of the Spanish family.
%% The Japanese lives to the right of the snail keeper.
%% The snail keeper lives to the left of the blue house.
%% Who keeps the zebra?

%% Define a predicate zebra/1 that tells you the nationality of the owner of the
%% zebra.

%% Hint: Think of a representation for the houses and the street. Code the four
%% constraints in Prolog. member and sublist might be useful predicates.

%% I believe this is the correct answer:
%% (green, Japanese, zebra) | (red, English, snail) | (blue, Spanish, jaguar)

prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).
sublist(SubL,L) :- suffix(S,L), prefix(SubL,S).

house(blue,japanese,Xc).
house(red,english,snail).
house(Za,spanish,jaguar).

street(house(LCol,LNat,LPet),
       house(MCol,MNat,MPet),
       house(RCol,RNat,RPet)) :-
  sublist([LCol,MCol,RCol],[green,red,blue]),
  sublist([LNat,MNat,RNat],[japanese,english,spanish]),
  sublist([LPet,MPet,RPet],[zebra,snail,jaguar]).

%% Not quite as beautiful as I had hoped, since I had to derive the whole
%% english is snailkeeper and japanese living the blue house rather than
%% specifying it as is. Also the riddle seems to be too simple compared to the
%% "original" Einstein's Puzzle.