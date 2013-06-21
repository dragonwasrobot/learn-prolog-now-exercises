%% Chapter 4 - Exercises

% Exercise 4.1
%% How does Prolog respond to the following queries?

%% [a,b,c,d] = [a,[b,c,d]]. -> false
%% [a,b,c,d] = [a|[b,c,d]]. -> true
%% [a,b,c,d] = [a,b,[c,d]]. -> false
%% [a,b,c,d] = [a,b|[c,d]]. -> true
%% [a,b,c,d] = [a,b,c,[d]]. -> false
%% [a,b,c,d] = [a,b,c|[d]]. -> true
%% [a,b,c,d] = [a,b,c,d,[]]. -> false
%% [a,b,c,d] = [a,b,c,d|[]]. -> true
%% [] = _. -> true
%% [] = [_]. -> false
%% [] = [_|[]]. -> false

%% Exercise 4.2
%% Suppose we are given a knowledge base with the following facts:

tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine).

%% Write a predicate listtran(G,E) which translates a list of German number
%% words to the corresponding list of English number words. For example:

%% listtran([eins,neun,zwei],X).
%% should give:
%% X = [one,nine,two].

%% Your program should also work in the other direction. For example, if you
%% give it the query

%% listtran(X,[one,seven,six,two]).
%% it should return:
%% X = [eins,sieben,sechs,zwei].

%% Hint: to answer this question, first ask yourself `How do I translate the
%% empty list of number words?'. That's the base case. For non-empty lists,
%% first translate the head of the list, then use recursion to translate the
%% tail.

listtran([], []).
listtran([Hg | Tg], [He | Te]) :-
  tran(Hg, He),
  listtran(Tg, Te).

%% Exercise 4.3

%% Write a predicate twice(In,Out) whose left argument is a list, and whose
%% right argument is a list consisting of every element in the left list written
%% twice. For example, the query
%% twice([a,4,buggle],X).
%% should return
%% X = [a,a,4,4,buggle,buggle]).
%% And the query
%% twice([1,2,1,1],X).
%% should return
%% X = [1,1,2,2,1,1,1,1].

%% Hint: to answer this question, first ask yourself
%% `What should happen when the first argument is the empty list?'. That's the
%% base case. For non-empty lists, think about what you should do with the head,
%% and use recursion to handle the tail.

twice([],[]).
twice([Ha | Ta], [Ha, Ha | Tb]) :- twice(Ta, Tb).

%% Exercise 4.4
%% Draw the search trees for the following three queries:
%% ?- member(a,[c,b,a,y]).
%% ?- member(x,[a,b,c]).
%% ?- member(X,[a,b,c]).

%% Can't be arsed to draw search tree in ascii.
