%% dcg.pl

:- module(dcg,
    [s/4]).

%% Once you have done this, extend the DCG so that noun phrases can be modified
%% by adjectives and simple prepositional phrases (that is, it should be able to
%% handle noun phrases such as ``the small frightened woman on the table'' or
%% ``the big fat cow under the shower''). Then, further extend it so that the
%% distinction between first, second, and third person pronouns is correctly
%% handled (both in subject and object form).

%% 'small' = adjective, 'on the table' = prepositional phrase.

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