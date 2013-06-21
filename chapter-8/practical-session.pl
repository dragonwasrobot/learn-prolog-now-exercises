%% Chapter 8 - Practical Session

%% First some keyboard exercises:

%% 1. Trace some examples using the DCG which uses extra arguments to handle the
%% subject/object distinct, the DCG which produces parses, and the DCG which
%% uses extra tests to separate lexicon and rules. Make sure you fully
%% understand the way all three DCGs work.

%% [trace]  ?- s([the,woman,shoots,him],[]).
%%    Call: (7) s([the, woman, shoots, him], []) ?
%%    Call: (8) np(subject, [the, woman, shoots, him], _G403) ?
%%    Call: (9) det([the, woman, shoots, him], _G402) ?
%%    Exit: (9) det([the, woman, shoots, him], [woman, shoots, him]) ?
%%    Call: (9) n([woman, shoots, him], _G402) ?
%%    Exit: (9) n([woman, shoots, him], [shoots, him]) ?
%%    Exit: (8) np(subject, [the, woman, shoots, him], [shoots, him]) ?
%%    Call: (8) vp([shoots, him], []) ?
%%    Call: (9) v([shoots, him], _G402) ?
%%    Exit: (9) v([shoots, him], [him]) ?
%%    Call: (9) np(object, [him], []) ?
%%    Call: (10) det([him], _G402) ?
%%    Fail: (10) det([him], _G402) ?
%%    Redo: (9) np(object, [him], []) ?
%%    Call: (10) pro(object, [him], []) ?
%%    Exit: (10) pro(object, [him], []) ?
%%    Exit: (9) np(object, [him], []) ?
%%    Exit: (8) vp([shoots, him], []) ?
%%    Exit: (7) s([the, woman, shoots, him], []) ?
%% true

%% ?- s(T,[a,woman,shoots],[]).

%% [trace]  ?- s(T,[a,woman,shoots],[]).
%%    Call: (7) s(_G346, [a, woman, shoots], []) ?
%%    Call: (8) np(_G405, [a, woman, shoots], _G414) ?
%%    Call: (9) det(_G408, [a, woman, shoots], _G417) ?
%%    Exit: (9) det(det(a), [a, woman, shoots], [woman, shoots]) ?
%%    Call: (9) n(_G409, [woman, shoots], _G419) ?
%%    Exit: (9) n(n(woman), [woman, shoots], [shoots]) ?
%%    Exit: (8) np(np(det(a), n(woman)), [a, woman, shoots], [shoots]) ?
%%    Call: (8) vp(_G406, [shoots], []) ?
%%    Call: (9) v(_G415, [shoots], _G424) ?
%%    Exit: (9) v(v(shoots), [shoots], []) ?
%%    Call: (9) np(_G416, [], []) ?
%%    Call: (10) det(_G420, [], _G429) ?
%%    Fail: (10) det(_G420, [], _G429) ?
%%    Fail: (9) np(_G416, [], []) ?
%%    Redo: (8) vp(_G406, [shoots], []) ?
%%    Call: (9) v(_G415, [shoots], []) ?
%%    Exit: (9) v(v(shoots), [shoots], []) ?
%%    Exit: (8) vp(vp(v(shoots)), [shoots], []) ?
%%    Exit: (7) s(s(np(det(a), n(woman)), vp(v(shoots))), [a, woman, shoots], []) ?
%% T = s(np(det(a), n(woman)), vp(v(shoots)))

%% [trace]  ?- det([the],[]).
%%    Call: (7) det([the], []) ?
%%    Call: (8) lex(the, det) ?
%%    Exit: (8) lex(the, det) ?
%%    Call: (8) []=[] ?
%%    Exit: (8) []=[] ?
%%    Exit: (7) det([the], []) ?
%% true.

%% [trace]  ?- v([the],[]).
%%    Call: (7) v([the], []) ?
%%    Call: (8) lex(the, v) ?
%%    Fail: (8) lex(the, v) ?
%%    Fail: (7) v([the], []) ?
%% false.

%% 2. Carry out traces on the DCG for a^n b^n c^n that was given in the text
%% (that is, the DCG that gave the Count variable the values 0, succ(0),
%% succ(succ(0)), and so on). Try cases where the three blocks of as, bs, and cs
%% are indeed of the same length as well as queries where this is not the case.

%% [trace]  ?- s(Count,L,[]).
%%    Call: (7) s(_G674, _G675, []) ?
%%    Call: (8) ablock(_G674, _G675, _G745) ?
%%    Exit: (8) ablock(0, _G675, _G675) ?
%%    Call: (8) bblock(0, _G675, _G745) ?
%%    Exit: (8) bblock(0, _G675, _G675) ?
%%    Call: (8) cblock(0, _G675, []) ?
%%    Exit: (8) cblock(0, [], []) ?
%%    Exit: (7) s(0, [], []) ?
%% Count = 0,
%% L = [] ;
%%    Redo: (8) ablock(_G674, _G675, _G745) ?
%%    Call: (9) ablock(_G739, _G742, _G750) ?
%%    Exit: (9) ablock(0, _G742, _G742) ?
%%    Exit: (8) ablock(succ(0), [a|_G742], _G742) ?
%%    Call: (8) bblock(succ(0), _G742, _G750) ?
%%    Call: (9) bblock(0, _G745, _G753) ?
%%    Exit: (9) bblock(0, _G745, _G745) ?
%%    Exit: (8) bblock(succ(0), [b|_G745], _G745) ?
%%    Call: (8) cblock(succ(0), _G745, []) ?
%%    Call: (9) cblock(0, _G748, []) ?
%%    Exit: (9) cblock(0, [], []) ?
%%    Exit: (8) cblock(succ(0), [c], []) ?
%%    Exit: (7) s(succ(0), [a, b, c], []) ?
%% Count = succ(0),
%% L = [a, b, c] ;

%% Now for some programming. We suggest two exercises.

%% First, bring together all the things we have learned about DCGs for English
%% into one DCG. In particular, today we say how to use extra arguments to deal
%% with the subject/object distinction, and in the exercises you were asked to
%% use additional arguments to deal with the singular/plural distinction. Write
%% a DCG which handles both. Moreover, write the DCG in such a way that it will
%% produce parse trees, and makes use of a separate lexicon.

s(Number, s(Number, NP, VP)) --> np(Number, NP), vp(Number, VP).

np(Number, np(Number, DET, N)) --> det(Number, DET), n(Number, N).

vp(Number, vp(Number, V, NP)) --> v(Number, V), np(_, NP).
vp(Number, vp(Number, V)) --> v(Number, V).

det(Number, det(Number, Word)) --> [Word], {lex(Word, Number, det)}.

n(Number, n(Number, Word)) --> [Word], {lex(Word, Number, n)}.

v(Number, v(Number, Word)) --> [Word], {lex(Word, Number, v)}.

%% Lexicon
lex(the, _, det).
lex(a, singular, det).

lex(woman, singular, n).
lex(man, singular, n).
lex(men, plural, n).

lex(shoots, singular, v).
lex(shoot, plural, v).

%% Test output

%% s(P,T,[the,men,shoot,a,woman],[]).
%% P = plural,
%%  T =
%%  s(plural,
%%    np(plural,
%%       det(plural, the),
%%       n(plural, men)),
%%    vp(plural,
%%       v(plural, shoot),
%%       np(singular,
%%   det(singular, a),
%%   n(singular, woman))))

%% s(P,T,L,[]).
%% T =
%% s(singular,
%%   np(singular,
%%      det(singular, the),
%%      n(singular, woman)),
%%   vp(singular,
%%      v(singular, shoots),
%%      np(singular,
%%  det(singular, the),
%%  n(singular, woman))))

%% That is pretty cool.

%% Once you have done this, extend the DCG so that noun phrases can be modified
%% by adjectives and simple prepositional phrases (that is, it should be able to
%% handle noun phrases such as ``the small frightened woman on the table'' or
%% ``the big fat cow under the shower''). Then, further extend it so that the
%% distinction between first, second, and third person pronouns is correctly
%% handled (both in subject and object form).

%% small = adjective, on the table = prepositional phrase.

s(Number, s(Number, NP, VP)) --> np(Number, NP), vp(Number, VP).
s(Number, s(Number, NP, PP)) --> np(Number, NP), pp(PP).

np(Number, np(Number, DET, AP, N)) --> det(Number, DET), ap(AP), n(Number, N).
np(Number, np(Number, DET, N)) --> det(Number, DET), n(Number, N).

vp(Number, vp(Number, V, PP, NP)) --> v(Number, V), pp(PP).
vp(Number, vp(Number, V)) --> v(Number, V).

det(Number, det(Number, Word)) --> [Word], {lex(Word, Number, det)}.

ap(ap(ADJ1,ADJ2)) --> adj(size, ADJ1), adj(propadj, ADJ2).
ap(ap(ADJ)) --> adj(size, ADJ).
ap(ap(ADJ)) --> adj(propadj, ADJ).

pp(pp(PRE, NP)) --> pre(PRE), np(_, NP).

pre(pre(Word)) --> [Word], {lex(Word, prepos)}.

n(Number, n(Number, Word)) --> [Word], {lex(Word, Number, n)}.

v(Number, v(Number, Word)) --> [Word], {lex(Word, Number, v)}.

adj(Type, adj(Type, Word)) --> [Word], {lex(Word, Type, adj)}.

%% Lexicon
lex(the, _, det).
lex(a, singular, det).

lex(woman, singular, n).
lex(man, singular, n).
lex(men, plural, n).
lex(cow, singular, n).
lex(table, singular, n).
lex(shower, singular, n).

lex(shoots, singular, v).
lex(shoot, plural, v).

lex(small, size, adj).
lex(big, size, adj).
lex(frightened, propadj, adj).
lex(fat, propadj, adj).

lex(under, prepos).
lex(on, prepos).

%% ?- s(P,T,[the,small,frightened,woman,on,the,table],[]).
%% P = singular,
%% T = s(singular,
%%       np(singular,
%%      det(singular,
%%          the),
%%      ap(adj(size,
%%       small),
%%         adj(propadj,
%%       frightened)),
%%      n(singular,
%%        woman)),
%%       pp(pre(on),
%%      np(singular,
%%         det(singular,
%%       the),
%%         n(singular, table))))

%% Note: couldn't be arsed to complete the whole implementation, i.e. the
%% first/second/third person aspects, but it should be (almost) trivial to do.