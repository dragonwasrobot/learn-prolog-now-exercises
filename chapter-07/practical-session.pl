%% Chapter 7 - Practical Session

%% First some keyboard exercises:

%% First, type in or download the simple append based recognizer discussed in
%% the text, and then run some traces. As you will see, we were not exaggerating
%% when we said that the performance of the append based grammar was very
%% poor. Even for such simple sentences as The woman shot a man you will see
%% that the trace is very long, and very difficult to follow.

s(Z) :- append(X,Y,Z), np(X), vp(Y).

np(Z) :- append(X,Y,Z), det(X), n(Y).

vp(Z) :-  append(X,Y,Z), v(X), np(Y).
vp(Z) :-  v(Z).

det([the]).
det([a]).

n([woman]).
n([man]).

v([shoots]).

%% [trace]  ?- s([the,woman,shoots,a,man]).
%%   Call: (6) s([the, woman, shoots, a, man]) ?
%%   Call: (7) lists:append(_G652, _G653, [the, woman, shoots, a, man]) ?
%%   Exit: (7) lists:append([], [the, woman, shoots, a, man], [the, woman, shoots, a, man]) ?
%%    Call: (7) np([]) ?
%%    Call: (8) lists:append(_G652, _G653, []) ?
%%    Exit: (8) lists:append([], [], []) ?
%%    Call: (8) det([]) ?
%%    Fail: (8) det([]) ?
%%    Fail: (8) lists:append(_G652, _G653, []) ?
%%    Fail: (7) np([]) ?
%%    Exit: (7) lists:append([the], [woman, shoots, a, man], [the, woman, shoots, a, man]) ?
%%    Call: (7) np([the]) ?
%%    Call: (8) lists:append(_G655, _G656, [the]) ?
%%    Exit: (8) lists:append([], [the], [the]) ?
%%    Call: (8) det([]) ?
%%    Fail: (8) det([]) ?
%%    Exit: (8) lists:append([the], [], [the]) ?
%%    Call: (8) det([the]) ?
%%    Exit: (8) det([the]) ?
%%    Call: (8) n([]) ?
%%    Fail: (8) n([]) ?
%%    Redo: (8) det([the]) ?
%%    Fail: (8) det([the]) ?
%%    Redo: (8) lists:append([the|_G649], _G659, [the]) ?
%%    Fail: (8) lists:append(_G655, _G656, [the]) ?
%%    Fail: (7) np([the]) ?
%%    Redo: (7) lists:append([the|_G646], _G656, [the, woman, shoots, a, man]) ?
%%    Exit: (7) lists:append([the, woman], [shoots, a, man], [the, woman, shoots, a, man]) ?
%%    Call: (7) np([the, woman]) ?
%%    Call: (8) lists:append(_G658, _G659, [the, woman]) ?
%%    Exit: (8) lists:append([], [the, woman], [the, woman]) ?
%%    Call: (8) det([]) ?
%%    Fail: (8) det([]) ?
%%    Exit: (8) lists:append([the], [woman], [the, woman]) ?
%%    Call: (8) det([the]) ?
%%    Exit: (8) det([the]) ?
%%    Call: (8) n([woman]) ?
%%    Exit: (8) n([woman]) ?
%%    Exit: (7) np([the, woman]) ?
%%    Call: (7) vp([shoots, a, man]) ?
%%    Call: (8) lists:append(_G661, _G662, [shoots, a, man]) ?
%%    Exit: (8) lists:append([], [shoots, a, man], [shoots, a, man]) ?
%%    Call: (8) v([]) ?
%%    Fail: (8) v([]) ?
%%    Exit: (8) lists:append([shoots], [a, man], [shoots, a, man]) ?
%%    Call: (8) v([shoots]) ?
%%    Exit: (8) v([shoots]) ?
%%    Call: (8) np([a, man]) ?
%%    Call: (9) lists:append(_G664, _G665, [a, man]) ?
%%    Exit: (9) lists:append([], [a, man], [a, man]) ?
%%    Call: (9) det([]) ?
%%    Fail: (9) det([]) ?
%%    Exit: (9) lists:append([a], [man], [a, man]) ?
%%    Call: (9) det([a]) ?
%%    Exit: (9) det([a]) ?
%%    Call: (9) n([man]) ?
%%    Exit: (9) n([man]) ?
%%    Exit: (8) np([a, man]) ?
%%    Exit: (7) vp([shoots, a, man]) ?
%%    Exit: (6) s([the, woman, shoots, a, man]) ?
%% true

%% Next, type in or download our second recognizer, the one based on difference
%% lists, and run more traces. As you will see, there is a dramatic gain in
%% efficiency. Moreover, even if you find the idea of difference lists a bit
%% hard to follow, you will see that the traces are very simple to understand,
%% especially when compared with the monsters produced by the append based
%% implementation!

s(X,Z) :- np(X,Y), vp(Y,Z).

np(X,Z) :- det(X,Y), n(Y,Z).

vp(X,Z) :-  v(X,Y), np(Y,Z).

vp(X,Z) :-  v(X,Z).

det([the|W],W).
det([a|W],W).

n([woman|W],W).
n([man|W],W).

v([shoots|W],W).

%% [trace]  ?- s([the,woman,shoots,a,man],[]).
%%    Call: (7) s([the, woman, shoots, a, man], []) ?
%%    Call: (8) np([the, woman, shoots, a, man], _G441) ?
%%    Call: (9) det([the, woman, shoots, a, man], _G441) ?
%%    Exit: (9) det([the, woman, shoots, a, man], [woman, shoots, a, man]) ?
%%    Call: (9) n([woman, shoots, a, man], _G441) ?
%%    Exit: (9) n([woman, shoots, a, man], [shoots, a, man]) ?
%%    Exit: (8) np([the, woman, shoots, a, man], [shoots, a, man]) ?
%%    Call: (8) vp([shoots, a, man], []) ?
%%    Call: (9) v([shoots, a, man], _G441) ?
%%    Exit: (9) v([shoots, a, man], [a, man]) ?
%%    Call: (9) np([a, man], []) ?
%%    Call: (10) det([a, man], _G441) ?
%%    Exit: (10) det([a, man], [man]) ?
%%    Call: (10) n([man], []) ?
%%    Exit: (10) n([man], []) ?
%%    Exit: (9) np([a, man], []) ?
%%    Exit: (8) vp([shoots, a, man], []) ?
%%    Exit: (7) s([the, woman, shoots, a, man], []) ?
%% true

%% Next, type in or download the DCG discussed in the text. Type listing so that
%% you can see what Prolog translates the rules to. How does your system
%% translate rules of the form Det --> [the]? That is, does it translate them to
%% rules like det([the|X],X), or does is make use of rules containing the
%% 'C'predicate?

s --> np,vp.
np --> det,n.
vp --> v,np.
vp --> v.
det --> [the].
det --> [a].
n --> [woman].
n --> [man].
v --> [shoots].

%% ?- listing.

%% s(A, C) :-
%%  np(A, B),
%%  vp(B, C).

%% np(A, C) :-
%%  det(A, B),
%%  n(B, C).

%% vp(A, C) :-
%%  v(A, B),
%%  np(B, C).

%% vp(A, B) :-
%%  v(A, B).

%% det([the|A], A).
%% det([a|A], A).

%% n([woman|A], A).
%% n([man|A], A).

%% v([shoots|A], A).
%% true.

%% translates it to det([the|A], X).

%% Now run some traces. Apart from variable names, the traces you observe here
%% should be very similar to the traces you observed when running the difference
%% list recognizer. In fact, you will only observe any real differences if your
%% version of Prolog uses a 'C' based translation.

%% [trace]  ?- s([the,woman,shoots,a,man],[]).
%%    Call: (7) s([the, woman, shoots, a, man], []) ?
%%    Call: (8) np([the, woman, shoots, a, man], _G441) ?
%%    Call: (9) det([the, woman, shoots, a, man], _G441) ?
%%    Exit: (9) det([the, woman, shoots, a, man], [woman, shoots, a, man]) ?
%%    Call: (9) n([woman, shoots, a, man], _G441) ?
%%    Exit: (9) n([woman, shoots, a, man], [shoots, a, man]) ?
%%    Exit: (8) np([the, woman, shoots, a, man], [shoots, a, man]) ?
%%    Call: (8) vp([shoots, a, man], []) ?
%%    Call: (9) v([shoots, a, man], _G441) ?
%%    Exit: (9) v([shoots, a, man], [a, man]) ?
%%    Call: (9) np([a, man], []) ?
%%    Call: (10) det([a, man], _G441) ?
%%    Exit: (10) det([a, man], [man]) ?
%%    Call: (10) n([man], []) ?
%%    Exit: (10) n([man], []) ?
%%    Exit: (9) np([a, man], []) ?
%%    Exit: (8) vp([shoots, a, man], []) ?
%%    Exit: (7) s([the, woman, shoots, a, man], []) ?
%% true

%% And now it's time to write some DCGs:

%% 1. The formal language aEven is very simple: it consists of all strings
%% containing an even number of as, and nothing else. Note that the empty string
%% belongs to aEven. Write a DCG that generates aEven.

s --> [].
s --> [a],s,[a].

%% 2. The formal language a^n b^(2m) c^(2m) d^n consists of all strings of the
%% following form: an unbroken block of as followed by an unbroken block of bs
%% followed by an unbroken block of cs followed by an unbroken block of ds, such
%% that the a and d blocks are exactly the same length, and the c and d blocks
%% are also exactly the same length and furthermore consist of an even number of
%% cs and ds respectively. For example, \epsilon, abbccd, and aaabbbbccccddd all
%% belong to a^n b^(2m) c^(2m) d^n. Write a DCG that generates this language.

s --> t.
s --> [a],s,[d].

t --> [].
t --> [b,b],t,[c,c].

%% 3. The language that logicians call `propositional logic over the
%% propositional symbols p, q, and r' can be defined by the following context
%% free grammar:

%% prop -> p
%% prop -> q
%% prop -> r
%% prop -> not prop
%% prop -> (prop and prop)
%% prop -> (prop or prop)
%% prop -> (prop implies prop)

%% Write a DCG that generates this language. Actually, because we don't know
%% about Prolog operators yet, you will have to make a few rather clumsy looking
%% compromises. For example, instead of getting it to recognize

%% not(p implies q)

%% you will have to get it recognize things like

%% [not, '(', p, implies, q, ')']

%% instead. But we will learn later how to make the output nicer, so write the
%% DCG that accepts a clumsy looking version of this language.

prop --> [p].
prop --> [q].
prop --> [r].

prop --> [not], prop.
prop --> ['('],prop, conj, prop,[')'].

conj --> [and].
conj --> [or].
conj --> [implies].