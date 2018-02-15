%% Chapter 4 - Practical Session

%% First, systematically carry out a number of traces on a2b/2 to make sure you
%% fully understand how it works. In particular:

%% 1. Trace some examples, not involving variables, that succeed. E.g., trace
%% the query a2b([a,a,a,a],[b,b,b,b]) and relate the output to the discussion in
%% the text.

%% [trace]  ?- a2b([a,a,a,a],[b,b,b,b]).
%%   Call: (7) a2b([a, a, a, a], [b, b, b, b]) ?
%%   Call: (8) a2b([a, a, a], [b, b, b]) ?
%%   Call: (9) a2b([a, a], [b, b]) ?
%%   Call: (10) a2b([a], [b]) ?
%%   Call: (11) a2b([], []) ?
%%   Exit: (11) a2b([], []) ?
%%   Exit: (10) a2b([a], [b]) ?
%%   Exit: (9) a2b([a, a], [b, b]) ?
%%   Exit: (8) a2b([a, a, a], [b, b, b]) ?
%%   Exit: (7) a2b([a, a, a, a], [b, b, b, b]) ?
%% true.

%% 2. Trace some simple examples that fail. Try examples involving lists of
%% different lengths (such as a2b([a,a,a,a],[b,b,b])) and examples involving
%% symbols other than a and b (such as a2b([a,c,a,a],[b,b,5,4])).

%% [trace]  ?- a2b([a,a,a,a],[b,b,b]).
%%   Call: (7) a2b([a, a, a, a], [b, b, b]) ?
%%   Call: (8) a2b([a, a, a], [b, b]) ?
%%   Call: (9) a2b([a, a], [b]) ?
%%   Call: (10) a2b([a], []) ?
%%   Fail: (10) a2b([a], []) ?
%%   Fail: (9) a2b([a, a], [b]) ?
%%   Fail: (8) a2b([a, a, a], [b, b]) ?
%%   Fail: (7) a2b([a, a, a, a], [b, b, b]) ?
%% false.

%% [trace]  ?- a2b([a,c,a,a],[b,b,5,4]).
%%   Call: (7) a2b([a, c, a, a], [b, b, 5, 4]) ?
%%   Call: (8) a2b([c, a, a], [b, 5, 4]) ?
%%   Fail: (8) a2b([c, a, a], [b, 5, 4]) ?
%%   Fail: (7) a2b([a, c, a, a], [b, b, 5, 4]) ?
%% false.

%% 3. Trace some examples involving variables. For example, try tracing
%% a2b([a,a,a,a],X) and a2b(X,[b,b,b,b]).

%% [trace]  ?- a2b([a,a,a,a],X).
%%   Call: (7) a2b([a, a, a, a], _G692) ?
%%   Call: (8) a2b([a, a, a], _G773) ?
%%   Call: (9) a2b([a, a], _G776) ?
%%   Call: (10) a2b([a], _G779) ?
%%   Call: (11) a2b([], _G782) ?
%%   Exit: (11) a2b([], []) ?
%%   Exit: (10) a2b([a], [b]) ?
%%   Exit: (9) a2b([a, a], [b, b]) ?
%%   Exit: (8) a2b([a, a, a], [b, b, b]) ?
%%   Exit: (7) a2b([a, a, a, a], [b, b, b, b]) ?
%% X = [b, b, b, b].

%% [trace]  ?- a2b(X,[b,b,b,b]).
%%   Call: (7) a2b(_G691, [b, b, b, b]) ?
%%   Redo: (7) a2b(_G691, [b, b, b, b]) ?
%%   Call: (8) a2b(_G773, [b, b, b]) ?
%%   Redo: (8) a2b(_G773, [b, b, b]) ?
%%   Call: (9) a2b(_G776, [b, b]) ?
%%   Redo: (9) a2b(_G776, [b, b]) ?
%%   Call: (10) a2b(_G779, [b]) ?
%%   Redo: (10) a2b(_G779, [b]) ?
%%   Call: (11) a2b(_G782, []) ?
%%   Exit: (11) a2b([], []) ?
%%   Exit: (10) a2b([a], [b]) ?
%%   Exit: (9) a2b([a, a], [b, b]) ?
%%   Exit: (8) a2b([a, a, a], [b, b, b]) ?
%%   Exit: (7) a2b([a, a, a, a], [b, b, b, b]) ?
%% X = [a, a, a, a]

%% 4. Make sure you understand what happens when both arguments in the query are
%% variables. For example, carry out a trace on the query a2b(X,Y).

%% [trace]  ?- a2b(X, Y).
%%   Call: (7) a2b(_G679, _G680) ?
%%   Exit: (7) a2b([], []) ?
%% X = Y, Y = [] ;
%%   Redo: (7) a2b(_G679, _G680) ?
%%   Call: (8) a2b(_G761, _G764) ?
%%   Exit: (8) a2b([], []) ?
%%   Exit: (7) a2b([a], [b]) ?
%% X = [a],
%% Y = [b] ;
%%   Redo: (8) a2b(_G761, _G764) ?
%%   Call: (9) a2b(_G767, _G770) ?
%%   Exit: (9) a2b([], []) ?
%%   Exit: (8) a2b([a], [b]) ?
%%   Exit: (7) a2b([a, a], [b, b]) ?
%% X = [a, a],
%% Y = [b, b] ;
%%   Redo: (9) a2b(_G767, _G770) ?
%%   Call: (10) a2b(_G773, _G776) ?
%%   Exit: (10) a2b([], []) ?
%%   Exit: (9) a2b([a], [b]) ?
%%   Exit: (8) a2b([a, a], [b, b]) ?
%%   Exit: (7) a2b([a, a, a], [b, b, b]) ?
%% X = [a, a, a],
%% Y = [b, b, b]

%% 5. Carry out a series of similar traces involving member. That is, carry out
%% traces involving simple queries that succeed (such as member(a,[1,2,a,b])),
%% simple queries that fail (such as member(z,[1,2,a,b])), and queries involving
%% variables (such as member(X,[1,2,a,b])). In all cases, make sure that you
%% understand why the recursion halts.

%% [trace]  ?- myMember(a,[1,2,a,b]).
%%   Call: (6) myMember(a, [1, 2, a, b]) ?
%%   Call: (7) myMember(a, [2, a, b]) ?
%%   Call: (8) myMember(a, [a, b]) ?
%%   Exit: (8) myMember(a, [a, b]) ?
%%   Exit: (7) myMember(a, [2, a, b]) ?
%%   Exit: (6) myMember(a, [1, 2, a, b]) ?
%% true

%% [trace]  ?- myMember(z,[1,2,a,b]).
%%   Call: (6) myMember(z, [1, 2, a, b]) ?
%%   Call: (7) myMember(z, [2, a, b]) ?
%%   Call: (8) myMember(z, [a, b]) ?
%%   Call: (9) myMember(z, [b]) ?
%%   Call: (10) myMember(z, []) ?
%%   Fail: (10) myMember(z, []) ?
%%   Fail: (9) myMember(z, [b]) ?
%%   Fail: (8) myMember(z, [a, b]) ?
%%   Fail: (7) myMember(z, [2, a, b]) ?
%%   Fail: (6) myMember(z, [1, 2, a, b]) ?
%% false.

%% [trace]  ?- myMember(X,[1,2,a,b]).
%%   Call: (6) myMember(_G935, [1, 2, a, b]) ?
%%   Exit: (6) myMember(1, [1, 2, a, b]) ?
%% X = 1 ;
%%   Redo: (6) myMember(_G935, [1, 2, a, b]) ?
%%   Call: (7) myMember(_G935, [2, a, b]) ?
%%   Exit: (7) myMember(2, [2, a, b]) ?
%%   Exit: (6) myMember(2, [1, 2, a, b]) ?
%% X = 2 ;
%%   Redo: (7) myMember(_G935, [2, a, b]) ?
%%   Call: (8) myMember(_G935, [a, b]) ?
%%   Exit: (8) myMember(a, [a, b]) ?
%%   Exit: (7) myMember(a, [2, a, b]) ?
%%   Exit: (6) myMember(a, [1, 2, a, b]) ?
%% X = a ;
%%   Redo: (8) myMember(_G935, [a, b]) ?
%%   Call: (9) myMember(_G935, [b]) ?
%%   Exit: (9) myMember(b, [b]) ?
%%   Exit: (8) myMember(b, [a, b]) ?
%%   Exit: (7) myMember(b, [2, a, b]) ?
%%   Exit: (6) myMember(b, [1, 2, a, b]) ?
%% X = b ;
%%   Redo: (9) myMember(_G935, [b]) ?
%%   Call: (10) myMember(_G935, []) ?
%%   Fail: (10) myMember(_G935, []) ?
%%   Fail: (9) myMember(_G935, [b]) ?
%%   Fail: (8) myMember(_G935, [a, b]) ?
%%   Fail: (7) myMember(_G935, [2, a, b]) ?
%%   Fail: (6) myMember(_G935, [1, 2, a, b]) ?
%% false.

%% Having done this, try the following.

%% 1. Write a 3-place predicate combine1 which takes three lists as arguments
%% and combines the elements of the first two lists into the third as follows:

%% ?- combine1([a,b,c],[1,2,3],X).
%% X = [a,1,b,2,c,3]

%% ?- combine1([foo,bar,yip,yup],[glub,glab,glib,glob],Result).
%% Result = [foo,glub,bar,glab,yip,glib,yup,glob]

combine1([],[],[]).
combine1([H1 | T1], [H2 | T2], [H1, H2 | T3]) :- combine1(T1, T2, T3).

%% 2. Now write a 3-place predicate combine2 which takes three lists as
%% arguments and combines the elements of the first two lists into the third as
%% follows:

%% ?- combine2([a,b,c],[1,2,3],X).
%% X = [[a,1],[b,2],[c,3]]

%% ?- combine2([foo,bar,yip,yup],[glub,glab,glib,glob],Result).
%% Result = [[foo,glub],[bar,glab],[yip,glib],[yup,glob]]

combine2([],[],[]).
combine2([H1 | T1], [H2 | T2], [[H1, H2] | T3]) :- combine2(T1, T2, T3).

%% 3. Finally, write a 3-place predicate combine3 which takes three lists as
%% arguments and combines the elements of the first two lists into the third as
%% follows:

%% ?- combine3([a,b,c],[1,2,3],X).
%% X = [join(a,1),join(b,2),join(c,3)]

%% ?- combine3([foo,bar,yip,yup],[glub,glab,glib,glob],R).
%% R = [join(foo,glub),join(bar,glab),join(yip,glib),join(yup,glob)]

combine3([],[],[]).
combine3([H1 | T1], [H2 | T2], [join(H1, H2) | T3]) :- combine3(T1, T2, T3).

%% Now, you should have a pretty good idea of what the basic pattern of
%% predicates for processing lists looks like. Here are a couple of list
%% processing exercises that are a bit more interesting. Hint: you can of course
%% use predicates that we defined earlier, like e.g. member/2 in your predicate
%% definition.

%% 1. Write a predicate mysubset/2 that takes two (unsorted?) lists (of
%% constants) as arguments and checks, whether the first list is a subset of the
%% second.

mysubset([],_).
mysubset([H1 | T1], T2) :-
  member(H1, T2),
  mysubset(T1, T2).

%% 2. Write a predicate mysuperset/2 that takes two (unsorted?) lists as
%% arguments and checks, whether the first list is a superset of the second.

mysuperset(_,[]).
mysuperset(T1, [H2 | T2]) :-
  member(H2, T1),
  mysuperset(T1, T2).