%% Chapter 7 - Exercises

%% Exercise 7.1
%% Suppose we are working with the following DCG:

s --> foo,bar,wiggle.
foo --> [choo].
foo --> foo,foo.
bar --> mar,zar.
mar --> me,my.
me --> [i].
my --> [am].
zar --> blar,car.
blar --> [a].
car --> [train].
wiggle --> [toot].
wiggle --> wiggle,wiggle.
%% Write down the ordinary Prolog rules that correspond to these DCG rules.

%% s --> foo bar wiggle
%% foo --> choo
%% foo --> foo foo
%% bar --> mar zar
%% mar --> me my
%% me --> i
%% my --> am
%% zar --> blar car
%% blar --> a
%% car --> train
%% wiggle --> toot
%% wiggle --> wiggle wiggle

%% What are the first three responses that Prolog gives to the query s(X,[])?
%% ?- s(X,[]).
%% X = [choo, i, am, a, train, toot] ;
%% X = [choo, i, am, a, train, toot, toot] ;
%% X = [choo, i, am, a, train, toot, toot, toot] ;
%% ...

%% Exercise 7.2

%% The formal language a^n b^n - {\epsilon} consists of all the strings in a^n
%% b^n except the empty string. Write a DCG that generates this language.

%% nonterminals
s --> l,r.
s --> l,s,r.

%% terminals
l --> [a].
r --> [b].

%% Exercise 7.3

%% Let a^n b^(2n) be the formal language which contains all strings of the
%% following form: an unbroken block of as of length n followed by an unbroken
%% block of bs of length 2n, and nothing else. For example, abb, aabbbb, and
%% aaabbbbbb belong to a^n b^(2n), and so does the empty string. Write a DCG
%% that generates this language.

%% nonterminals
s --> [].
s --> l,r,r.
s --> l,s,r,r.

%% terminals
l --> [a].
r --> [b].