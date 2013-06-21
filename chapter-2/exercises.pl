%% Chapter 2 - Exercises

%% author: Peter Urbak
%% version: 2012-10-04

%% Exercise 2.1

%% Which of the following pairs of terms unify? Where relevant,
%% give the variable instantiations that lead to successful unification.

%%  1. bread = bread -> true
%%  2. 'Bread' = bread -> false
%%  3. 'bread' = bread -> true
%%  4. Bread = bread -> Bread = bread.
%%  5. bread = sausage -> false
%%  6. food(bread) = bread -> false
%%  7. food(bread) = X -> X = food(bread).
%%  8. food(X) = food(bread) -> X = bread.
%%  9. food(bread, X) = food(Y, sausage) -> X = sausage, Y = bread.
%% 10. food(bread, X, beer) = food(Y, sausage, X) -> false
%% 11. food(bread, X, beer) = food(Y, kahuna_burger) -> false
%% 12. food(X) = X -> X = food(X).
%% 13. meal(food(bread), drink(beer)) = meal(X,Y) ->
%%     X = food(bread), Y = drink(beer).
%% 14. meal(food(bread), X) = meal(X, drink(beer)) -> false

%% Exercise 2.2

%% We are working with the following knowledge base:

house_elf(dobby).
witch(hermione).
witch('McGonagall').
witch(rita_skeeter).
magic(X) :- house_elf(X).
magic(X) :- wizard(X).
magic(X) :- witch(X).

%% Which of the following queries are satisfied? Where relevant, give all the
%% variable instantiations that lead to success.

%% 1. ?- magic(house_elf). -> false
%% 2. ?- wizard(harry). -> false
%% 3. ?- magic(wizard). -> false
%% 4. ?- magic('McGonagall'). -> true
%% 5. ?- magic(Hermione). ->
%%    Hermione = dobby;
%%    Hermione = hermione;
%%    Hermione = %% 'McGonagall';
%%    Hermione = rita_skeeter.

%% Draw the search tree for the fifth query magic(Hermione).

%% (picture).

%% Exercise 2.3 Here is a tiny lexicon and mini grammar with only one rule which
%% defines a sentence as consisting of five words: an article, a noun, a verb,
%% and again an article and a noun.

word(article,a).
word(article,every).
word(noun,criminal).
word(noun,'big kahuna burger').
word(verb,eats).
word(verb,likes).

sentence(Word1,Word2,Word3,Word4,Word5) :-
  word(article,Word1),
  word(noun,Word2),
  word(verb,Word3),
  word(article,Word4),
  word(noun,Word5).

%% What query do you have to pose in order to find out which sentences the
%% grammar can generate? List all sentences that this grammar can generate in
%% the order Prolog will generate them. Make sure that you understand why Prolog
%% generates them in this order.

%% ?- sentence(A, B, C, D, E). -> generates all possibilities:
%% e.g. the following is the first possibility since it uses all the first
%% examples of article, noun, verb listed.
%% A = a,
%% B = criminal,
%% C = eats,
%% D = a,
%% E = criminal ;

%% Exercise 2.4
%% Here are six English words:
%% abalone, abandon, anagram, connect, elegant, enhance.
%% They are to be arranged in a crossword puzzle like fashion in the grid given
%% below.
%%     V1V2V3
%%     _ _ _
%% H1 _______
%%     _ _ _
%% H2 _______
%%     _ _ _
%% H3 _______
%%     _ _ _


%% The following knowledge base represents a lexicon containing these words.
word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(enhance,e,n,h,a,n,c,e).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).

%% Write a predicate crosswd/6 that tells us how to fill the grid, i.e. the
%% first three arguments should be the vertical words from left to right and the
%% following three arguments the horizontal words from top to bottom.

crossword(V1,V2,V3,H1,H2,H3) :-
  %% Make the word intersect at the right places.
  %% Use _ where we don't give a fuck about variable name.
  word(H1,_,H12V12,_,H14V22,_,H16V32,_),
  word(H2,_,H22V14,_,H24V24,_,H26V34,_),
  word(H3,_,H32V16,_,H34V26,_,H36V36,_),

  word(V1,_,H12V12,_,H22V14,_,H32V16,_),
  word(V2,_,H14V22,_,H24V24,_,H34V26,_),
  word(V3,_,H16V32,_,H26V34,_,H36V36,_)
.

%% ?- crosswd(H1,H2,H3,V1,V2,V3). ->
%% H1 = abandon, H2 = elegant, H3 = enhance, V1 = abalone, V2 = anagram,
%% V3 = connect ;
%% H1 = abalone, H2 = anagram, H3 = connect, V1 = abandon, V2 = elegant,
%% V3 = enhance ;
%% false.