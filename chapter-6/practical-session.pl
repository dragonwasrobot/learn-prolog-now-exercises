%% Chapter 6 - Practical Session

%% The following traces will help you get to grips with the predicates discussed
%% in the text:

%% 1. Carry out traces of append with the first two arguments instantiated, and
%% the third argument uninstantiated. For example,
%% append([a,b,c],[[],[2,3],b],X) Make sure the basic pattern is clear.

myAppend([],L,L).
myAppend([H|T], L2, [H|L3]) :- myAppend(T,L2,L3).

%% [trace]  ?- myAppend([a,b,c],[[],[2,3],b],X).
%%   Call: (6) myAppend([a, b, c], [[], [2, 3], b], _G648) ?
%%   Call: (7) myAppend([b, c], [[], [2, 3], b], _G724) ?
%%   Call: (8) myAppend([c], [[], [2, 3], b], _G727) ?
%%   Call: (9) myAppend([], [[], [2, 3], b], _G730) ?
%%   Exit: (9) myAppend([], [[], [2, 3], b], [[], [2, 3], b]) ?
%%   Exit: (8) myAppend([c], [[], [2, 3], b], [c, [], [2, 3], b]) ?
%%   Exit: (7) myAppend([b, c], [[], [2, 3], b], [b, c, [], [2, 3], b]) ?
%%   Exit: (6) myAppend([a, b, c], [[], [2, 3], b], [a, b, c, [], [2, 3], b]) ?
%% X = [a, b, c, [], [2, 3], b].

%% 2. Next, carry out traces on append as used to split up a list, that is, with
%% the first two arguments given as variables, and the last argument
%% instantiated. For example, append(L,R,[foo,wee,blup]).

%% [trace]  ?- myAppend(L,R,[foo,wee,blup]).
%%    Call: (6) myAppend(_G949, _G950, [foo, wee, blup]) ?
%%    Exit: (6) myAppend([], [foo, wee, blup], [foo, wee, blup]) ?
%% L = [],
%% R = [foo, wee, blup] ;
%%    Redo: (6) myAppend(_G949, _G950, [foo, wee, blup]) ?
%%    Call: (7) myAppend(_G1024, _G950, [wee, blup]) ?
%%    Exit: (7) myAppend([], [wee, blup], [wee, blup]) ?
%%    Exit: (6) myAppend([foo], [wee, blup], [foo, wee, blup]) ?
%% L = [foo],
%% R = [wee, blup] ;
%%    Redo: (7) myAppend(_G1024, _G950, [wee, blup]) ?
%%    Call: (8) myAppend(_G1027, _G950, [blup]) ?
%%    Exit: (8) myAppend([], [blup], [blup]) ?
%%    Exit: (7) myAppend([wee], [blup], [wee, blup]) ?
%%    Exit: (6) myAppend([foo, wee], [blup], [foo, wee, blup]) ?
%% L = [foo, wee],
%% R = [blup] ;
%%    Redo: (8) myAppend(_G1027, _G950, [blup]) ?
%%    Call: (9) myAppend(_G1030, _G950, []) ?
%%    Exit: (9) myAppend([], [], []) ?
%%    Exit: (8) myAppend([blup], [], [blup]) ?
%%    Exit: (7) myAppend([wee, blup], [], [wee, blup]) ?
%%    Exit: (6) myAppend([foo, wee, blup], [], [foo, wee, blup]) ?
%% L = [foo, wee, blup],
%% R = [] ;
%%    Redo: (9) myAppend(_G1030, _G950, []) ?
%%    Fail: (9) myAppend(_G1030, _G950, []) ?
%%    Fail: (8) myAppend(_G1027, _G950, [blup]) ?
%%    Fail: (7) myAppend(_G1024, _G950, [wee, blup]) ?
%%    Fail: (6) myAppend(_G949, _G950, [foo, wee, blup]) ?
%% false.

%% 3. Carry out some traces on prefix and suffix. Why does prefix find shorter
%% lists first, and suffix longer lists first?

%% Because it uses myAppend whose base case is myAppend([],L,L). so the easiest
%% solution to prefix is the empty list and the whole list for suffix.

%% 4. Carry out some traces on sublist. As we said in the text, via backtracking
%% this predicate generates all possible sublists, but as you'll see, it
%% generates several sublists more than once. Do you understand why?

myAppend([],L,L).
myAppend([H|T], L2, [H|L3]) :- myAppend(T,L2,L3).
prefix(P,L) :- myAppend(P,_,L).
suffix(S,L) :- myAppend(_,S,L).
sublist(SubL,L) :- suffix(S,L), prefix(SubL,S).

%% ?- sublist(S,[1,2,3,4]).
%% S = [] ;
%% S = [1] ;
%% S = [1, 2] ;
%% S = [1, 2, 3] ;
%% S = [1, 2, 3, 4] ;
%% S = [] ;
%% S = [2] ;
%% S = [2, 3] ;
%% S = [2, 3, 4] ;
%% S = [] ;
%% S = [3] ;
%% S = [3, 4] ;
%% S = [] ;
%% S = [4] ;
%% S = [] ;
%% false.

%% Because it generates all possible sublists of each sublist, making all common
%% prefixes appear more than once (i.e. the empty lists appears n times in a
%% list of n elements).

%% 5. Carry out traces on both naiverev and rev, and compare their behavior.

myAppend([],L,L).
myAppend([H|T], L2, [H|L3]) :- myAppend(T,L2,L3).

naiverev([],[]).
naiverev([H|T],R) :-
  naiverev(T,RevT),
  myAppend(RevT,[H],R).

accRev([H|T],A,R) :- accRev(T,[H|A],R).
accRev([],A,A).

rev(L,R) :- accRev(L,[],R).

%% naive rev:
%% [trace]  ?- naiverev([1,2],R).
%%    Call: (7) naiverev([1, 2], _G344) ?
%%    Call: (8) naiverev([2], _G405) ?
%%    Call: (9) naiverev([], _G405) ?
%%    Exit: (9) naiverev([], []) ?
%%    Call: (9) myAppend([], [2], _G409) ?
%%    Exit: (9) myAppend([], [2], [2]) ?
%%    Exit: (8) naiverev([2], [2]) ?
%%    Call: (8) myAppend([2], [1], _G344) ?
%%    Call: (9) myAppend([], [1], _G407) ?
%%    Exit: (9) myAppend([], [1], [1]) ?
%%    Exit: (8) myAppend([2], [1], [2, 1]) ?
%%    Exit: (7) naiverev([1, 2], [2, 1]) ?
%% R = [2, 1].

%% rev:
%% [trace]  ?- rev([1,2],R).
%%    Call: (7) rev([1, 2], _G396) ?
%%    Call: (8) accRev([1, 2], [], _G396) ?
%%    Call: (9) accRev([2], [1], _G396) ?
%%    Call: (10) accRev([], [2, 1], _G396) ?
%%    Exit: (10) accRev([], [2, 1], [2, 1]) ?
%%    Exit: (9) accRev([2], [1], [2, 1]) ?
%%    Exit: (8) accRev([1, 2], [], [2, 1]) ?
%%    Exit: (7) rev([1, 2], [2, 1]) ?
%% R = [2, 1].

%% Now for some programming work:

%% 1. It is possible to write a one line definition of the member predicate by
%% making use of append. Do so. How does this new version of member compare in
%% efficiency with the standard one?

myAppend([],L,L).
myAppend([H|T], L2, [H|L3]) :- myAppend(T,L2,L3).

%% standard member
myMember(X, [X | T]).
myMember(X, [H | T]) :- myMember(X, T).

%% append member
myAppendMember(X, Ys) :- myAppend(_,[X|_],Ys).

%% myMember just runs through each element of the list while myAppendMember
%% tries to find list that concatenated with X gives Ys. myAppend is slower
%% since it has to do a Call/Redo while myMember only has to do a Call.

%% 2. Write a predicate set(InList,OutList) which takes as input an arbitrary
%% list, and returns a list in which each element of the input list appears only
%% once. For example, the query

%% set([2,2,foo,1,foo, [],[]],X).
%% should yield the result
%% X = [2,foo,1,[]].

%% Hint: use the member predicate to test for repetitions of items you have
%% already found.

%% Helper function (Only there to reverse list before returning).
accRev([H|T],A,R) :- accRev(T,[H|A],R).
accRev([],A,A).
rev(L,R) :- accRev(L,[],R).

%% Actual function
%% accSet(InList,AccList,Outlist).

%% base case
accSet([],L,L).
%% inductive case
accSet([X|Inlist], AccList, Outlist) :-
  not(member(X,AccList)),
  accSet(Inlist,[X|AccList],Outlist).
accSet([X|Inlist], AccList, Outlist) :-
  member(X,AccList),
  accSet(Inlist,AccList,Outlist).
%% main
set(Inlist,Outlist) :-
  rev(TempOutlist, Outlist),
  accSet(Inlist,[],TempOutlist).

%% 3. We `flatten' a list by removing all the square brackets around any lists it
%% contains as elements, and around any lists that its elements contain as
%% element, and so on for all nested lists. For example, when we flatten the
%% list
%% [a,b,[c,d],[[1,2]],foo] we get the list
%% [a,b,c,d,1,2,foo]
%% and when we flatten the list
%% [a,b,[[[[[[[c,d]]]]]]],[[1,2]],foo,[]]
%% we also get
%% [a,b,c,d,1,2,foo].

%% Write a predicate flatten(List,Flat) that holds when the first argument
%% List flattens to the second argument Flat. This exercise can be done without
%% making use of append.

% base case
accFlatten([],L,L).

%% inductive case
%% accFlatten([HList|TList], AccList, Flat) :-

%% !!! TO DO !!!

%% 4. Opposite Zip

accRev([H|T],A,R) :- accRev(T,[H|A],R).
accRev([],A,A).
rev(L,R) :- accRev(L,[],R).


zip([], [], []).
zip([HX | TX], [HY | TY], [[HX , HY] | TZ]) :-
  zip(TX, TY, TZ).

revZipSimple(X, Y, R) :-
  rev(Y, RY),
  zip(X, RY, R).

revZip([], [], []).
revZip([HX | TX], [HY | TY], [[HX , HY] | TR]) :-
  revZip(TX, TY, TR).


foo([], [], []).
foo([HX|TX], [HY, TY], [HZ, TZ]) :- foo(TX, TY, TZ).

myAppend([],L,L).
myAppend([H|T], L2, [H|L3]) :- myAppend(T,L2,L3).
