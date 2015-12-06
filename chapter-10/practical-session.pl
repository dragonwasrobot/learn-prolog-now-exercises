%% Chapter 10 - Practical Session

%% The purpose of this session is to help you get familiar with cuts and
%% negation as failure. First some keyboard exercises:

%% Try out all three versions of the max/3 predicate defined in the text: the
%% cut-free version, the green cut version, and the red cut version. As usual,
%% “try out” means “run traces on”, and you should make sure that you trace
%% queries in which all three arguments are instantiated to integers, and
%% queries where the third argument is given as a variable.

max(X,Y,Y) :- X  =< Y.
max(X,Y,X) :-  X > Y.

%% [trace]  ?- max(2,3,3).
%%    Call: (6) max(2, 3, 3) ?
%% ^  Call: (7) 2=<3 ?
%% ^  Exit: (7) 2=<3 ?
%%    Exit: (6) max(2, 3, 3) ?
%% true ;
%%    Redo: (6) max(2, 3, 3) ?
%%    Fail: (6) max(2, 3, 3) ?
%% false.

%% [trace]  ?- max(2,3,X).
%%    Call: (6) max(2, 3, _G348) ?
%% ^  Call: (7) 2=<3 ?
%% ^  Exit: (7) 2=<3 ?
%%    Exit: (6) max(2, 3, 3) ?
%% X = 3 ;
%%    Redo: (6) max(2, 3, _G348) ?
%% ^  Call: (7) 2>3 ?
%% ^  Fail: (7) 2>3 ?
%%    Fail: (6) max(2, 3, _G348) ?
%% false.

max(X,Y,Y) :- X  =< Y, !. % green cut
max(X,Y,X) :- X > Y.

%% [trace]  ?- max(2,3,3).
%%    Call: (7) max(2, 3, 3) ?
%% ^  Call: (8) 2=<3 ?
%% ^  Exit: (8) 2=<3 ?
%%    Exit: (7) max(2, 3, 3) ?
%% true.

%% [trace]  ?- max(2,3,X).
%%    Call: (7) max(2, 3, _G351) ?
%% ^  Call: (8) 2=<3 ?
%% ^  Exit: (8) 2=<3 ?
%%    Exit: (7) max(2, 3, 3) ?
%% X = 3.

max(X,Y,Y) :- X =< Y, !.
max(X,Y,X).

%% [trace]  ?- max(2,3,3).
%%    Call: (7) max(2, 3, 3) ?
%% ^  Call: (8) 2=<3 ?
%% ^  Exit: (8) 2=<3 ?
%%    Exit: (7) max(2, 3, 3) ?
%% true.

%% [trace]  ?- max(2,3,X).
%%    Call: (7) max(2, 3, _G351) ?
%% ^  Call: (8) 2=<3 ?
%% ^  Exit: (8) 2=<3 ?
%%    Exit: (7) max(2, 3, 3) ?
%% X = 3.

%% max3 has been simplified too much, i.e. the query below is wrong.
%% [trace]  ?- max(1,2,1).
%%    Call: (7) max(1, 2, 1) ?
%%    Exit: (7) max(1, 2, 1) ?
%% true.

%% Ok, time for a burger. Try out all the methods discussed in the text for
%% coping with Vincent’s preferences. That is, try out the program that uses a
%% cut-fail combination, the program that uses negation as failure correctly,
%% and also the program that mucks it up by using negation in the wrong place.

enjoys(vincent,X) :- big_kahuna_burger(X),!,fail.
enjoys(vincent,X) :- burger(X).

burger(X) :- big_mac(X).
burger(X) :- big_kahuna_burger(X).
burger(X) :- whopper(X).

big_mac(a).
big_kahuna_burger(b).
big_mac(c).
whopper(d).

%% [trace]  ?- enjoys(vincent,a).
%%    Call: (7) enjoys(vincent, a) ?
%%    Call: (8) big_kahuna_burger(a) ?
%%    Fail: (8) big_kahuna_burger(a) ?
%%    Redo: (7) enjoys(vincent, a) ?
%%    Call: (8) burger(a) ?
%%    Call: (9) big_mac(a) ?
%%    Exit: (9) big_mac(a) ?
%%    Exit: (8) burger(a) ?
%%    Exit: (7) enjoys(vincent, a) ?
%% true ;
%%    Redo: (8) burger(a) ?
%%    Call: (9) big_kahuna_burger(a) ?
%%    Fail: (9) big_kahuna_burger(a) ?
%%    Redo: (8) burger(a) ?
%%    Call: (9) whopper(a) ?
%%    Fail: (9) whopper(a) ?
%%    Fail: (8) burger(a) ?
%%    Fail: (7) enjoys(vincent, a) ?
%% false.

%% [trace]  ?- enjoys(vincent,b).
%%    Call: (7) enjoys(vincent, b) ?
%%    Call: (8) big_kahuna_burger(b) ?
%%    Exit: (8) big_kahuna_burger(b) ?
%%    Call: (8) fail ?
%%    Fail: (8) fail ?
%%    Fail: (7) enjoys(vincent, b) ?
%% false.

%% [trace]  ?- enjoys(vincent,c).
%%    Call: (7) enjoys(vincent, c) ?
%%    Call: (8) big_kahuna_burger(c) ?
%%    Fail: (8) big_kahuna_burger(c) ?
%%    Redo: (7) enjoys(vincent, c) ?
%%    Call: (8) burger(c) ?
%%    Call: (9) big_mac(c) ?
%%    Exit: (9) big_mac(c) ?
%%    Exit: (8) burger(c) ?
%%    Exit: (7) enjoys(vincent, c) ?
%% true ;
%%    Redo: (8) burger(c) ?
%%    Call: (9) big_kahuna_burger(c) ?
%%    Fail: (9) big_kahuna_burger(c) ?
%%    Redo: (8) burger(c) ?
%%    Call: (9) whopper(c) ?
%%    Fail: (9) whopper(c) ?
%%    Fail: (8) burger(c) ?
%%    Fail: (7) enjoys(vincent, c) ?
%% false.

%% [trace]  ?- enjoys(vincent,d).
%%    Call: (7) enjoys(vincent, d) ?
%%    Call: (8) big_kahuna_burger(d) ?
%%    Fail: (8) big_kahuna_burger(d) ?
%%    Redo: (7) enjoys(vincent, d) ?
%%    Call: (8) burger(d) ?
%%    Call: (9) big_mac(d) ?
%%    Fail: (9) big_mac(d) ?
%%    Redo: (8) burger(d) ?
%%    Call: (9) big_kahuna_burger(d) ?
%%    Fail: (9) big_kahuna_burger(d) ?
%%    Redo: (8) burger(d) ?
%%    Call: (9) whopper(d) ?
%%    Exit: (9) whopper(d) ?
%%    Exit: (8) burger(d) ?
%%    Exit: (7) enjoys(vincent, d) ?
%% true.

burger(X) :- big_mac(X).
burger(X) :- big_kahuna_burger(X).
burger(X) :- whopper(X).

big_mac(a).
big_kahuna_burger(b).
big_mac(c).
whopper(d).

neg(Goal) :- Goal, !, fail.
neg(Goal).

enjoys(vincent,X) :-
  burger(X),
  neg(big_kahuna_burger(X)).

%% [trace]  ?- enjoys(vincent,a).
%%    Call: (7) enjoys(vincent, a) ?
%%    Call: (8) burger(a) ?
%%    Call: (9) big_mac(a) ?
%%    Exit: (9) big_mac(a) ?
%%    Exit: (8) burger(a) ?
%%    Call: (8) neg(big_kahuna_burger(a)) ?
%%    Call: (9) big_kahuna_burger(a) ?
%%    Fail: (9) big_kahuna_burger(a) ?
%%    Redo: (8) neg(big_kahuna_burger(a)) ?
%%    Exit: (8) neg(big_kahuna_burger(a)) ?
%%    Exit: (7) enjoys(vincent, a) ?
%% true ;
%%    Redo: (8) burger(a) ?
%%    Call: (9) big_kahuna_burger(a) ?
%%    Fail: (9) big_kahuna_burger(a) ?
%%    Redo: (8) burger(a) ?
%%    Call: (9) whopper(a) ?
%%    Fail: (9) whopper(a) ?
%%    Fail: (8) burger(a) ?
%%    Fail: (7) enjoys(vincent, a) ?
%% false.

%% [trace]  ?- enjoys(vincent,b).
%%    Call: (7) enjoys(vincent, b) ?
%%    Call: (8) burger(b) ?
%%    Call: (9) big_mac(b) ?
%%    Fail: (9) big_mac(b) ?
%%    Redo: (8) burger(b) ?
%%    Call: (9) big_kahuna_burger(b) ?
%%    Exit: (9) big_kahuna_burger(b) ?
%%    Exit: (8) burger(b) ?
%%    Call: (8) neg(big_kahuna_burger(b)) ?
%%    Call: (9) big_kahuna_burger(b) ?
%%    Exit: (9) big_kahuna_burger(b) ?
%%    Call: (9) fail ?
%%    Fail: (9) fail ?
%%    Fail: (8) neg(big_kahuna_burger(b)) ?
%%    Redo: (8) burger(b) ?
%%    Call: (9) whopper(b) ?
%%    Fail: (9) whopper(b) ?
%%    Fail: (8) burger(b) ?
%%    Fail: (7) enjoys(vincent, b) ?
%% false.

%% [trace]  ?- enjoys(vincent,c).
%%    Call: (7) enjoys(vincent, c) ?
%%    Call: (8) burger(c) ?
%%    Call: (9) big_mac(c) ?
%%    Exit: (9) big_mac(c) ?
%%    Exit: (8) burger(c) ?
%%    Call: (8) neg(big_kahuna_burger(c)) ?
%%    Call: (9) big_kahuna_burger(c) ?
%%    Fail: (9) big_kahuna_burger(c) ?
%%    Redo: (8) neg(big_kahuna_burger(c)) ?
%%    Exit: (8) neg(big_kahuna_burger(c)) ?
%%    Exit: (7) enjoys(vincent, c) ?
%% true ;
%%    Redo: (8) burger(c) ?
%%    Call: (9) big_kahuna_burger(c) ?
%%    Fail: (9) big_kahuna_burger(c) ?
%%    Redo: (8) burger(c) ?
%%    Call: (9) whopper(c) ?
%%    Fail: (9) whopper(c) ?
%%    Fail: (8) burger(c) ?
%%    Fail: (7) enjoys(vincent, c) ?
%% false.

%% [trace]  ?- enjoys(vincent,d).
%%    Call: (7) enjoys(vincent, d) ?
%%    Call: (8) burger(d) ?
%%    Call: (9) big_mac(d) ?
%%    Fail: (9) big_mac(d) ?
%%    Redo: (8) burger(d) ?
%%    Call: (9) big_kahuna_burger(d) ?
%%    Fail: (9) big_kahuna_burger(d) ?
%%    Redo: (8) burger(d) ?
%%    Call: (9) whopper(d) ?
%%    Exit: (9) whopper(d) ?
%%    Exit: (8) burger(d) ?
%%    Call: (8) neg(big_kahuna_burger(d)) ?
%%    Call: (9) big_kahuna_burger(d) ?
%%    Fail: (9) big_kahuna_burger(d) ?
%%    Redo: (8) neg(big_kahuna_burger(d)) ?
%%    Exit: (8) neg(big_kahuna_burger(d)) ?
%%    Exit: (7) enjoys(vincent, d) ?
%% true.

burger(X) :- big_mac(X).
burger(X) :- big_kahuna_burger(X).
burger(X) :- whopper(X).

big_mac(a).
big_kahuna_burger(b).
big_mac(c).
whopper(d).

enjoys(vincent,X) :-
  burger(X),
  \+  big_kahuna_burger(X).

%% [trace]  ?- enjoys(vincent,a).
%%    Call: (7) enjoys(vincent, a) ?
%%    Call: (8) burger(a) ?
%%    Call: (9) big_mac(a) ?
%%    Exit: (9) big_mac(a) ?
%%    Exit: (8) burger(a) ?
%%    Call: (8) big_kahuna_burger(a) ?
%%    Fail: (8) big_kahuna_burger(a) ?
%%    Exit: (7) enjoys(vincent, a) ?
%% true ;
%%    Redo: (8) burger(a) ?
%%    Call: (9) big_kahuna_burger(a) ?
%%    Fail: (9) big_kahuna_burger(a) ?
%%    Redo: (8) burger(a) ?
%%    Call: (9) whopper(a) ?
%%    Fail: (9) whopper(a) ?
%%    Fail: (8) burger(a) ?
%%    Fail: (7) enjoys(vincent, a) ?
%% false.

%% [trace]  ?- enjoys(vincent,b).
%%    Call: (7) enjoys(vincent, b) ?
%%    Call: (8) burger(b) ?
%%    Call: (9) big_mac(b) ?
%%    Fail: (9) big_mac(b) ?
%%    Redo: (8) burger(b) ?
%%    Call: (9) big_kahuna_burger(b) ?
%%    Exit: (9) big_kahuna_burger(b) ?
%%    Exit: (8) burger(b) ?
%%    Call: (8) big_kahuna_burger(b) ?
%%    Exit: (8) big_kahuna_burger(b) ?
%%    Redo: (8) burger(b) ?
%%    Call: (9) whopper(b) ?
%%    Fail: (9) whopper(b) ?
%%    Fail: (8) burger(b) ?
%%    Fail: (7) enjoys(vincent, b) ?
%% false.

%% [trace]  ?- enjoys(vincent,c).
%%    Call: (7) enjoys(vincent, c) ?
%%    Call: (8) burger(c) ?
%%    Call: (9) big_mac(c) ?
%%    Exit: (9) big_mac(c) ?
%%    Exit: (8) burger(c) ?
%%    Call: (8) big_kahuna_burger(c) ?
%%    Fail: (8) big_kahuna_burger(c) ?
%%    Exit: (7) enjoys(vincent, c) ?
%% true ;
%%    Redo: (8) burger(c) ?
%%    Call: (9) big_kahuna_burger(c) ?
%%    Fail: (9) big_kahuna_burger(c) ?
%%    Redo: (8) burger(c) ?
%%    Call: (9) whopper(c) ?
%%    Fail: (9) whopper(c) ?
%%    Fail: (8) burger(c) ?
%%    Fail: (7) enjoys(vincent, c) ?
%% false.

%% [trace]  ?- enjoys(vincent,d).
%%    Call: (7) enjoys(vincent, d) ?
%%    Call: (8) burger(d) ?
%%    Call: (9) big_mac(d) ?
%%    Fail: (9) big_mac(d) ?
%%    Redo: (8) burger(d) ?
%%    Call: (9) big_kahuna_burger(d) ?
%%    Fail: (9) big_kahuna_burger(d) ?
%%    Redo: (8) burger(d) ?
%%    Call: (9) whopper(d) ?
%%    Exit: (9) whopper(d) ?
%%    Exit: (8) burger(d) ?
%%    Call: (8) big_kahuna_burger(d) ?
%%    Fail: (8) big_kahuna_burger(d) ?
%%    Exit: (7) enjoys(vincent, d) ?
%% true.

%%
burger(X) :- big_mac(X).
burger(X) :- big_kahuna_burger(X).
burger(X) :- whopper(X).

big_mac(a).
big_kahuna_burger(b).
big_mac(c).
whopper(d).

enjoys(vincent, X) :- \+ big_kahuna_burger(X), burger(X).

%% [trace]  ?- enjoys(vincent,a).
%%    Call: (7) enjoys(vincent, a) ?
%%    Call: (8) big_kahuna_burger(a) ?
%%    Fail: (8) big_kahuna_burger(a) ?
%%    Call: (8) burger(a) ?
%%    Call: (9) big_mac(a) ?
%%    Exit: (9) big_mac(a) ?
%%    Exit: (8) burger(a) ?
%%    Exit: (7) enjoys(vincent, a) ?
%% true ;
%%    Redo: (8) burger(a) ?
%%    Call: (9) big_kahuna_burger(a) ?
%%    Fail: (9) big_kahuna_burger(a) ?
%%    Redo: (8) burger(a) ?
%%    Call: (9) whopper(a) ?
%%    Fail: (9) whopper(a) ?
%%    Fail: (8) burger(a) ?
%%    Fail: (7) enjoys(vincent, a) ?
%% false.

%% [trace]  ?- enjoys(vincent,b).
%%    Call: (7) enjoys(vincent, b) ?
%%    Call: (8) big_kahuna_burger(b) ?
%%    Exit: (8) big_kahuna_burger(b) ?
%%    Fail: (7) enjoys(vincent, b) ?
%% false.

%% [trace]  ?- enjoys(vincent,c).
%%    Call: (6) enjoys(vincent, c) ?
%%    Call: (7) big_kahuna_burger(c) ?
%%    Fail: (7) big_kahuna_burger(c) ?
%%    Call: (7) burger(c) ?
%%    Call: (8) big_mac(c) ?
%%    Exit: (8) big_mac(c) ?
%%    Exit: (7) burger(c) ?
%%    Exit: (6) enjoys(vincent, c) ?
%% true ;
%%    Redo: (7) burger(c) ?
%%    Call: (8) big_kahuna_burger(c) ?
%%    Fail: (8) big_kahuna_burger(c) ?
%%    Redo: (7) burger(c) ?
%%    Call: (8) whopper(c) ?
%%    Fail: (8) whopper(c) ?
%%    Fail: (7) burger(c) ?
%%    Fail: (6) enjoys(vincent, c) ?
%% false.

%% [trace]  ?- enjoys(vincent,d).
%%    Call: (6) enjoys(vincent, d) ?
%%    Call: (7) big_kahuna_burger(d) ?
%%    Fail: (7) big_kahuna_burger(d) ?
%%    Call: (7) burger(d) ?
%%    Call: (8) big_mac(d) ?
%%    Fail: (8) big_mac(d) ?
%%    Redo: (7) burger(d) ?
%%    Call: (8) big_kahuna_burger(d) ?
%%    Fail: (8) big_kahuna_burger(d) ?
%%    Redo: (7) burger(d) ?
%%    Call: (8) whopper(d) ?
%%    Exit: (8) whopper(d) ?
%%    Exit: (7) burger(d) ?
%%    Exit: (6) enjoys(vincent, d) ?
%% true.

%% Now for some programming:

%% Define a predicate nuni/2 (”not unifiable”) which takes two terms as arguments
%% and succeeds if the two terms do not unify. For example:

%% nuni(foo,foo).
%% no

%% nuni(foo,blob).
%% yes

%% nuni(foo,X).
%% no

%% You should define this predicate in three different ways:

%% First (and easiest) write it with the help of = and \+.
notUnifiable(X, Y) :- \+ X = Y.

%% Second write it with the help of = , but don’t use \+.
neg(Goal)  :-  Goal,!,fail.
neg(Goal).

notUnifiable(X, Y) :- neg(X = Y).

%% Third, write it using a cut-fail combination. Don’t use = and don’t use \+.
notUnifiable(X, Y) :- X \= Y.

%% Define a predicate unifiable(List1,Term,List2) where List2 is the list of all
%% members of List1 that unify with Term. The elements of List2 should not be
%% instantiated by the unification. For example
%% unifiable([X,b,t(Y)],t(a),List]
%% should yield
%% List  =  [X,t(Y)].

%% Bit tricky:
%% if \+ H = Term succeeds we know that the H and Term can be unified so we fail
%% and go to the default to second myUnifiable and add H to List2.
%% if it fails we use a cut (i.e. it can be unified) we make a cut so that we
%% don't end up trying the second myUnifiable which would add it regardless to
%% List2 even though it can't be unified.
%% Alternative we could've used a double \+ \+ so we add H in the case where the
%% check succeeds to avoid confusion about the default case being the one that
%% adds H to List2.

myUnifiable([H | List1],Term,List2) :-
  \+ H = Term, !,
  myUnifiable(List1, Term, List2).

myUnifiable([H | List1], Term, [H | List2]) :-
  myUnifiable(List1, Term, List2).

myUnifiable([],Term,[]).
