%% Chapter 11 - Exercises

%% Exercise 11.1 Suppose we start with an empty database. We then give the
%% command:

assert(q(a,b)),  assertz(q(1,2)),  asserta(q(foo,blug)).

%% What does the database now contain?
q(foo,blug).
q(a,b).
q(1,2).

%5 We then give the command:
retract(q(1, 2)), assertz( (p(X) :- h(X)) ).

%% What does the database now contain?
q(foo,blug).
q(a,b).

:- dynamic p/1.

p(A) :- h(A).

%% We then give the command:
retractall(q(_,_)).

%% What does the database now contain?
p(A) :- h(A).

%% Exercise  11.2 Suppose we have the following database:

q(blob,blug).
q(blob,blag).
q(blob,blig).
q(blaf,blag).
q(dang,dong).
q(dang,blug).
q(flab,blob).

%% What is Prolog’s response to the queries:

%% ?- findall(X,q(blob,X),List).
%% List = [blug, blag, blig].

%% ?- findall(X,q(X,blug),List).
%% List = [blob, dang].

%% findall(X,q(X,Y),List).
%% List = [blob, blob, blob, blaf, dang, dang, flab].

%% ?- bagof(X,q(X,Y),List).
%% Y = blag,
%% List = [blob, blaf] ;
%% Y = blig,
%% List = [blob] ;
%% Y = blob,
%% List = [flab] ;
%% Y = blug,
%% List = [blob, dang] ;
%% Y = dong,
%% List = [dang].

%% ?- setof(X,Y^q(X,Y),List).
%% List = [blaf, blob, dang, flab].

%% Exercise  11.3 Write a predicate sigma/2 that takes an integer n > 0 and
%% calculates the sum of all integers from 1 to n. For example:

%% ?-  sigma(3,X).
%% X  =  6
%% yes

%% ?-  sigma(5,X).
%% X  =  15
%% yes

%% Write the predicate so that results are stored in the database (there should
%% never be more than one entry in the database for each value) and are reused
%% whenever possible. For example, suppose we make the following query:

%% ?-  sigma(2,X).
%% X  =  3
%% yes

%% ?-  listing.
%% sigmares(2,3).
%% Then, if we go on to ask

%% ?-  sigma(3,X).

%% Prolog should not calculate everything new, but should get the result for
%% sigma(2,3) from the database and only add 3 to that. It should then answer:

%% X  =  6
%% yes
%% ?-  listing.
%% sigmares(2,3).
%% sigmares(3,6).

%% base case
mySigma(0, Sum, Sum).

%% inductive case
mySigma(N, Acc, Sum) :-
  is(DecN, -(N, 1)), !,
  is(NewAcc, +(Acc, N)), !,
  mySigma(DecN, NewAcc, Sum), !.

%% main
:- dynamic sigmares/2.

sigma(N, Sum) :- sigmares(N, Sum), !.

sigma(N, Sum) :- mySigma(N, 0, Sum),
  assert( sigmares(N, Sum) ).