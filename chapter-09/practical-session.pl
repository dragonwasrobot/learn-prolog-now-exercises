%% Chapter 9 - Practical Session

%% In this practical session, we want to introduce some built-in predicates for
%% printing terms onto the screen. The first predicate we want to look at is
%% display/1, which takes a term and prints it onto the screen.

%% ?- display(loves(vincent,mia)).
%% loves(vincent, mia)
%% Yes

%% ?- display('jules eats a big kahuna burger').
%% jules eats a big kahuna burger
%% Yes

%% More strictly speaking, display prints Prolog's internal representation of terms.

%% ?- display(2+3+4).
%% +(+(2, 3), 4)
%% Yes

%% In fact, this property of display makes it a very useful tool for learning
%% how operators work in Prolog. So, before going on to learn more about how to
%% write things onto the screen, try the following queries. Make sure you
%% understand why Prolog answers the way it does.

%% ?- display([a,b,c]). -> .(a,.(b,.(c,[])))
%% ?- display(3 is 4 + 5 / 3). -> is(3,+(4,/(5,3)))
%% ?- display(3 is (4 + 5) / 3). -> is(3,/(+(4,5),3))
%% ?- display((a:-b,c,d)). -> :-(a,,(b,,(c,d)))
%% ?- display(a:-b,c,d). -> undefined procedure display/3

%% So, display is nice to look at the internal representation of terms in
%% operator notation, but usually we would probably prefer to print the user
%% friendly notation instead. Especially when printing lists, it would be much
%% nicer to get [a,b,c], instead of .(a.(b.(c,[]))). This is what the built-in
%% predicate write/1 does. It takes a term and prints it to the screen in the
%% user friendly notation.

%% ?- write(2+3+4).
%% 2+3+4
%% Yes

%% ?- write(+(2,3)).
%% 2+3
%% Yes

%% ?- write([a,b,c]).
%% [a, b, c]
%% Yes

%% ?- write(.(a,.(b,[]))).
%% [a, b]
%% Yes

%% And here is what happens, when the term that is to be written contains
%% variables.

%% ?- write(X).
%% _G204
%% X = _G204
%% yes

%% ?- X = a, write(X).
%% a
%% X = a
%% Yes

%% The following example shows what happens when you put two write commands one
%% after the other.

%% ?- write(a),write(b).
%% ab
%% Yes

%% Prolog just executes one after the other without putting any space in between
%% the output of the different write commands. Of course, you can tell Prolog to
%% print spaces by telling it to write the term ' '.

%% ?- write(a),write(' '),write(b).
%% a b
%% Yes

%% And if you want more than one space, for example five blanks, you can tell
%% Prolog to write '     '.

%% ?- write(a),write('     '),write(b).
%% a     b
%% Yes

%% Another way of printing spaces is by using the predicate tab/1. tab takes a
%% number as argument and then prints as many spaces as specified by that
%% number.

%% ?- write(a),tab(5),write(b).
%% a     b
%% Yes

%% Another predicate useful for formatting is nl. nl tells Prolog to make a
%% linebreak and to go on printing on the next line.

%% ?- write(a),nl,write(b).
%% a
%% b
%% Yes

%% In the last lecture, we saw how extra arguments in DCGs can be used to build
%% a parse tree. For example, to the query s(T,[a,man,shoots,a,woman],[]) Prolog
%% would answer s(np(det(a),n(man)),vp(v(shoots),np(det(a),n(woman)))). This is
%% a representation of the parse tree. It is not a very readable representation,
%% though. Wouldn't it be nicer if Prolog printed something like

%% s(
%%   np(
%%      det(a)
%%      n(man))
%%   vp(
%%     v(shoots)
%%     np(
%%       det(a)
%%       n(woman))))

%% for example?

%% Write a predicate pptree/1 that takes a complex term representing a tree,
%% such as s(np(det(a),n(man)),vp(v(shoots),np(det(a),n(woman)))), as its
%% argument and prints a nice and readable output for this tree.

%% Helper function

%% simple terms
termtype(Term, atom) :-
  atom(Term).
termtype(Term, integer) :-
  integer(Term).
termtype(Term, number) :-
  number(Term).
termtype(Term, constant) :-
  atomic(Term).
termtype(Term, variable) :-
  var(Term).

%% complex term
termtype(Term, complex_term) :-
  nonvar(Term),
  functor(Term, _, A),
  A > 0.

%% simple term
termtype(Term, simple_term) :-
  termtype(Term, variable).
termtype(Term, simple_term) :-
  termtype(Term, constant).

%% term
termtype(Term, term) :-
  termtype(Term, simple_term).
termtype(Term, term) :-
  termtype(Term, complex_term).

%% Actual Function

%% simple term; indent and print the term with no linebreak.
%% Example: mia
printterm(Term, Indent) :-
  termtype(Term, simple_term),
  tab(Indent), write(Term).

%% complex term containing only simple terms; indent and print the
%% term and its arguments.
%% Example: likes(mia, vincent).
printterm(Term, Indent) :-
  termtype(Term, complex_term),
  Term =.. [TermName | TermArguments],
  checkSimpleTypes(TermArguments),
  tab(Indent), write(Term).

checkSimpleTypes([]).

checkSimpleTypes([Head | Tail]) :-
  termtype(Head, simple_term),
  checkSimpleTypes(Tail).

%% complex term containing other complex terms; indent and print the term, then
%% call printterm on all its arguments.
printterm(Term, Indent) :-
  termtype(Term, complex_term),
  Term =.. [TermName | TermArguments],
  not(checkSimpleTypes(TermArguments)),
  tab(Indent), write(TermName), write('('), nl,
  NewIndent is Indent + 2,
  iterateArguments(TermArguments, NewIndent),
  write(')').

iterateArguments([Head], Indent) :-
  printterm(Head, Indent).

iterateArguments([Head | Tail], Indent) :-
  Tail \= [],
  printterm(Head, Indent), nl,
  iterateArguments(Tail, Indent).

%% %% Main
pptree(Term) :-
  printterm(Term, 0).

%% ?- pptree(s(np(det(a),n(man)),vp(v(shoots),np(det(a),n(woman))))).
%% s(
%%   np(
%%     det(a)
%%     n(man))
%%   vp(
%%     v(shoots)
%%     np(
%%       det(a)
%%       n(woman))))
%% true

%% In the practical session of Chapter 7, you were asked to write a DCG
%% generating propositional logic formulas. The input you had to use was a bit
%% awkward though. The formula not(p-->q) had to be represented as [not, '(', p,
%% implies, q, ')']. Now, that you know about operators, you can do something a
%% lot nicer. Write the operator definitions for the operators not, and, or,
%% implies, so that Prolog accepts (and correctly brackets) propositional logic
%% formulas. For example:

%% ?- display(not(p implies q)).
%% not(implies(p,q)).
%% Yes

%% ?- display(not p implies q).
%% implies(not(p),q)
%% Yes

:- op(800, fy, not).
:- op(1000, xfy, implies).
:- op(1000, xfy, and).
:- op(1000, xfy, or).

%% ?- display(p implies q and not r).
%% implies(p,and(q,not(r)))
%% true.

