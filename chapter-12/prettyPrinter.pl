%% prettyPrinter.pl

:- module(prettyPrinter,
   [pptree/2]).

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
printterm(Term, Indent, Stream) :-
  termtype(Term, simple_term),
  tab(Stream, Indent), write(Stream, Term).

%% complex term containing only simple terms; indent and print the
%% term and its arguments.
%% Example: likes(mia, vincent).
printterm(Term, Indent, Stream) :-
  termtype(Term, complex_term),
  Term =.. [TermName | TermArguments],
  checkSimpleTypes(TermArguments),
  tab(Stream, Indent), write(Stream, Term).

checkSimpleTypes([]).

checkSimpleTypes([Head | Tail]) :-
  termtype(Head, simple_term),
  checkSimpleTypes(Tail).

%% complex term containing other complex terms; indent and print the term, then
%% call printterm on all its arguments.
printterm(Term, Indent, Stream) :-
  termtype(Term, complex_term),
  Term =.. [TermName | TermArguments],
  tab(Stream, Indent), write(Stream, TermName), write(Stream, '('),
  nl(Stream),
  NewIndent is Indent + 2,
  iterateArguments(TermArguments, NewIndent, Stream),
  write(Stream, ')').

iterateArguments([], _, _).

iterateArguments([Head | Tail], Indent, Stream) :-
  Tail == [],
  printterm(Head, Indent, Stream).

iterateArguments([Head | Tail], Indent, Stream) :-
  printterm(Head, Indent, Stream), nl(Stream),
  iterateArguments(Tail, Indent, Stream).

%% Main
%% pptree(Term, Stream) :-
%%  open('treeOutput.txt', write, Stream),
%%  printterm(Term, 0, Stream),
%%  close(Stream).

pptree(Term, OutStream) :-
  printterm(Term, 0, OutStream), !,
  nl(OutStream).

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

%% TODO: If possible, try to see if you can generate actual syntax
%% using dot files.
