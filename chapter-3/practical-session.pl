%% Chapter 3 - Practical Session

%% 1. Load descend1.pl, turn on trace, and pose the query
%% descend(martha,laura). This is the query that was discussed in the
%% notes. Step through the trace, and relate what you see on the screen to the
%% discussion in the text.

%% [trace]  ?- descend(martha, laura).
%%    Call: (6) descend(martha, laura) ?
%%    Call: (7) child(martha, laura) ? check if laura is direct child of martha
%%    Fail: (7) child(martha, laura) ?
%%    Redo: (6) descend(martha, laura) ?
%%    Call: (7) child(martha, _G385) ? Z = _G385
%%    Exit: (7) child(martha, charlotte) ? Z = charlotte
%%    Call: (7) descend(charlotte, laura) ? recursive call
%%    Call: (8) child(charlotte, laura) ?
%%    Fail: (8) child(charlotte, laura) ?
%%    Redo: (7) descend(charlotte, laura) ?
%%    Call: (8) child(charlotte, _G385) ?
%%    Exit: (8) child(charlotte, caroline) ? Z = caroline
%%    Call: (8) descend(caroline, laura) ?
%%    Call: (9) child(caroline, laura) ? laura is a child of caroline, success
%%    Exit: (9) child(caroline, laura) ?
%%    Exit: (8) descend(caroline, laura) ?
%%    Exit: (7) descend(charlotte, laura) ?
%%    Exit: (6) descend(martha, laura) ? return
%% true

%% _G385 is an anon variable which is recursively being set to and tested with
%% Martha's descendants.

%% 2. Still with trace on, pose the query descend(martha,rose) and count how
%% many steps it takes Prolog to work out the answer (that is, how many times do
%% you have to hit the return key). Now turn trace off and pose the query
%% descend(X,Y). How many answers are there?

%% 26 steps to return true and 13 to check for further answers -> false.
%% total: 39 steps, 2 answers.

%% 3. Load descend2.pl. This, remember, is the variant of descend1.pl in which
%% the order of both clauses is switched, and in addition, the order of the two
%% goals in the recursive goals is switched too. Because of this, even for such
%% simple queries as descend(martha,laura), Prolog will not terminate. Step
%% through an example, using trace, to confirm this.

%% [trace]  ?- descend(martha, laura).
%%    Call: (7) descend(martha, laura) ? creep
%%    Call: (8) descend(_G1217, laura) ? creep
%%    Call: (9) descend(_G1217, laura) ? creep
%%    Call: (10) descend(_G1217, laura) ? creep
%%    Call: (11) descend(_G1217, laura) ? creep
%%    Call: (12) descend(_G1217, laura) ? creep
%%    Call: (13) descend(_G1217, laura) ? creep
%%    Call: (14) descend(_G1217, laura) ? creep
%%    Call: (15) descend(_G1217, laura) ? creep
%%    ...

%% But wait! There are two more variants of descend1.pl that we have not considered. For a start, we could have written the recursive clause as follows:

descend(X,Y) :- child(X,Y).
descend(X,Y) :- descend(Z,Y),
               child(X,Z).

%% Let us call this variant descend3.pl. And one further possibility remains: we
%% could have written the recursive definition as follows:

descend(X,Y) :- child(X,Z), descend(Z,Y).
descend(X,Y) :- child(X,Y).

%% Let us call this variant descend4.pl.

%% Create (or download from the internet) the files descend3.pl and
%% descend4.pl. How do they compare to descend1.pl and descend2.pl? Can they
%% handle the query descend(martha,rose)? Can they handle queries involving
%% variables? How many steps do they need to find an answer? Are they slower or
%% faster than descend1.pl?

%% descend3.pl gives all true answers but runs out of local stack when
%% searching for a false descend().

%% descend4.pl only gives correct answers both when true and false.

%% The important thing to notice here is that when we have a p :- p, q
%% clause. There is a risk of getting an infinite loop for false results since
%% it will keep calling p on end.

%% descend4.pl is slower when second parameter is a child of the first, but
%% otherwise faster since it starts looking for descendants rather than
%% children. (Haven't tested but pretty sure'ish).

%% Draw the search trees for descend2.pl, descend3.pl and descend4.pl (the one
%% for descend1.pl was given in the text) and compare them. Make sure you
%% understand why the programs behave the way they do.

%% !!! NOT DONE !!! Cba to draw an ascii tree right now.

%% 5. Finally, load the file numeral1.pl. Turn on trace, and make sure that you
%% understand how Prolog handles both specific queries (such as
%% numeral(succ(succ(0)))) and queries involving variables (such as numeral(X)).

%% [trace]  ?- numeral(succ(succ(0))).
%%   Call: (6) numeral(succ(succ(0))) ?
%%   Call: (7) numeral(succ(0)) ?
%%   Call: (8) numeral(0) ?
%%   Exit: (8) numeral(0) ?
%%   Exit: (7) numeral(succ(0)) ?
%%   Exit: (6) numeral(succ(succ(0))) ?
%% true.

%% Basically it peels away each succ layer until it reaches numeral(0). and then
%% traverses back up returning true.

%% [trace]  ?- numeral(X).
%%   Call: (6) numeral(_G398) ?
%%   Exit: (6) numeral(0) ?
%% X = 0 ;
%%   Redo: (6) numeral(_G398) ?
%%   Call: (7) numeral(_G462) ?
%%   Exit: (7) numeral(0) ?
%%   Exit: (6) numeral(succ(0)) ?
%% X = succ(0) ;
%%   Redo: (7) numeral(_G462) ?
%%   Call: (8) numeral(_G464) ?
%%   Exit: (8) numeral(0) ?
%%   Exit: (7) numeral(succ(0)) ?
%%   Exit: (6) numeral(succ(succ(0))) ?
%% X = succ(succ(0)) ;
%%   Redo: (8) numeral(_G464) ?
%%   Call: (9) numeral(_G466) ?
%%   Exit: (9) numeral(0) ?
%%   Exit: (8) numeral(succ(0)) ?
%%   Exit: (7) numeral(succ(succ(0))) ?
%%   Exit: (6) numeral(succ(succ(succ(0)))) ?
%% X = succ(succ(succ(0))) .

%% Starts out returning the simplest answer which is the numeral(0) case -> X =
%% 0. It then looks to see if there are other possibilities, here we have
%% numeral(succ(X)) :- numeral(X). so it returns succ(0). and continues this way
%% enumerating succ(....succ(0)...).

%% Programming exercises.

%% 1. Imagine that the following knowledge base describes a maze. The facts
%% determine which points are connected, i.e., from which point you can get to
%% which other point in one step. Furthermore, imagine that all paths are
%% one-way streets, so that you can only walk them in one direction. So, you can
%% get from point 1 to point 2, but not the other way round.

connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

%% Write a predicate path/2 that tells you from which point in the maze you can
%% get to which other point when chaining together connections given in the
%% above knowledge base. Can you get from point 5 to point 10? Which other point
%% can you get to when starting in point 1? And which points can be reached from
%% point 13?

path(X,Y) :- connected(X,Y).
path(X,Y) :-
  connected(X,Z),
  path(Z, Y).

% path(5, 10). -> true
% path(1, X). -> 2
% path(13, X). -> 14, 9, 17, 10, 18

%% 2. We are given the following knowledge base of travel information:

byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(losAngeles,auckland).

%% Write a predicate travel/2 which determines whether it is possible to travel
%% from one place to another by `chaining together' car, train, and plane
%% journeys. For example, your program should answer `yes' to the query
%% travel(valmont,raglan).

%% Base cases
travel(X,Y) :- byCar(X,Y).
travel(X,Y) :- byPlane(X,Y).
travel(X,Y) :- byTrain(X,Y).

%% Inductive cases
travel(X,Y) :-
  byCar(X,Z),
  travel(Z,Y).
travel(X,Y) :-
  byPlane(X,Z),
  travel(Z,Y).
travel(X,Y) :-
  byTrain(X,Z),
  travel(Z,Y).

%% travel(valmont, raglan):
%% byCar(valmont, metz), byCar(valmont, saarbruecken)
%% byTrain(metz, frankfurt), byTrain(saarbruecken, frankfurt)
%% byPlane(frankfurt, bangkok)
%% byPlane(bangkok, auckland)
%% byCar(auckland, hamilton)
%% byCar(hamilton, raglan)
%% true.

%% 3. So, by using travel/2 to query the above database, you can find out that
%% it is possible to go from Vamont to Raglan. In case you are planning a
%% travel, that's already very good information, but what you would then really
%% want to know is how exactly to get from Valmont to Raglan. Write a predicate
%% travel/3 which tells you how to travel from one place to another. The program
%% should, e.g., answer `yes' to the query
%% travel(valmont,paris,go(valmont,metz,go(metz,paris))) and X =
%% go(valmont,metz,go(metz,paris,go(paris,losAngeles))) to the query
%% travel(valmont,losAngeles,X).

byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(losAngeles,auckland).

%% Base cases
travel(X,Y, go(X,Y)) :- byCar(X,Y).
travel(X,Y, go(X,Y)) :- byPlane(X,Y).
travel(X,Y, go(X,Y)) :- byTrain(X,Y).

%% Inductive cases
travel(X,Y, go(X,Z,G)) :-
  byCar(X,Z),
  travel(Z,Y,G).

travel(X,Y, go(X,Z,G)) :-
  byPlane(X,Z),
  travel(Z,Y,G).

travel(X,Y, go(X,Z,G)) :-
  byTrain(X,Z),
  travel(Z,Y,G).

%% travel(valmont,paris,go(valmont,metz,go(metz,paris))) -> true
%% travel(valmont,losAngeles,X). ->
%% X = go(valmont,metz,go(metz,paris,go(paris,losAngeles))).
%% X = go(valmont,saarbruecken,go(saarbruecken,paris,go(paris,losAngeles))).

%% 4. Extend the predicate travel/3 so that it not only tells you via which
%% other cities you have to go to get from one place to another, but also how,
%% i.e. by car, train, or plane, you get from one city to the next.

byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(losAngeles,auckland).

%% Base cases
travel(X,Y, go(byCar(X,Y))) :- byCar(X,Y).
travel(X,Y, go(byTrain(X,Y))) :- byTrain(X,Y).
travel(X,Y, go(byPlane(X,Y))) :- byPlane(X,Y).

%% Inductive cases
travel(X,Y, go(byCar(X,Z),G)) :-
  byCar(X,Z),
  travel(Z,Y,G).

travel(X,Y, go(byTrain(X,Z),G)) :-
  byTrain(X,Z),
  travel(Z,Y,G).

travel(X,Y, go(byPlane(X,Z),G)) :-
  byPlane(X,Z),
  travel(Z,Y,G).