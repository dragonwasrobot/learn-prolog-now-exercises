%% Chapter 2 - Practical Session

%% \=/2 opposite of =/2
%% ?- a \= b -> true

%% Questions:

%% a \= a. -> false

%% 'a' \= a. -> false

%% A \= a. -> false

%% f(a) \= a. -> true

%% f(a) \= A. -> false

%% f(A) \= f(a). -> false

%% g(a,B,c) \= g(A,b,C). -> false

%% g(a,b,c) \= g(A,C). -> true

%% f(X) \= X. -> false (interesting).

%% trace.

%% f(a).
%% f(b).

%% g(a).
%% g(b).

%% h(b).

%% k(X) :- f(X),g(X),h(X).

%% Trace example:
%% [trace]  ?- k(X).
%%   Call: (6) k(_G386) ?
%%   Call: (7) f(_G386) ?
%%   Exit: (7) f(a) ?
%%   Call: (7) g(a) ?
%%   Exit: (7) g(a) ?
%%   Call: (7) h(a) ?
%%   Fail: (7) h(a) ?
%%   Redo: (7) f(_G386) ?
%%   Exit: (7) f(b) ?
%%   Call: (7) g(b) ?
%%   Exit: (7) g(b) ?
%%   Call: (7) h(b) ?
%%   Exit: (7) h(b) ?
%%   Exit: (6) k(b) ?
%% X = b.

%% ?- notrace.
%% ?- nodebug.