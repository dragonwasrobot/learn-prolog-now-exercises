%% Chapter 12 - Practical Session

%% TODO: The DCG still doesn't work properly, so it should be fixed after Step
%% 7.

%% Step 1
%% Take the DCG that you built in the practical session of Chapter 8 and turn
%% it into a module, exporting the predicate s/3 , that is, the predicate that
%% lets you parse sentences and returns the parse tree as its first argument.

%% Done

%% Step 2
%% In the practical session of Chapter 9 , you had to write a program for
%% pretty printing parse trees onto the screen. Turn that into a module as
%% well.

%% Done

%% Step 3
%% Now modify the program so that it prints the tree not to the screen but to a
%% given stream. That means that the predicate pptree should now be a two-place
%% predicate taking the Prolog representation of a parse tree and a stream as
%% arguments.

%% Done
%% pptree(Term, Stream).

%% Step 4
%% Import both modules into a file and define a two-place predicate test which
%% takes a list representing a sentence (such as [a,woman,shoots]), parses it,
%% and writes the result to the file specified by the second argument of test.
%% Check that everything is working as it should.

:- use_module(prettyPrinter). % prints the tree structure of Terms.
:- use_module(dcg). % parses sentences according to its DCG.
:- use_module(plainTextParser). % parses english plain text into word lists.

test(Sentence) :-
  s(_, Term, Sentence, []),
  pptree(Term, _).

%% Step 5
%% Finally, modify test/2, so that it takes a filename instead of a sentence as
%% its first argument, reads in the sentences given in the file one by one,
%% parses them, and writes the sentence as well as the parsing result into the
%% output file. For example, if your input file looked like this:

%% [the,cow,under,the,table,shoots].
%% [a,dead,woman,likes,he].

%% the output file should look something like this:
%% [the,  cow,  under,  the,  table,  shoots]
%% s(
%%   np(
%%      det(the)
%%      nbar(
%%       n(cow))
%%      pp(
%%         prep(under)
%%         np(
%%        det(the)
%%        nbar(
%%             n(table)))))
%%   vp(
%%      v(shoots)))

%% [a,  dead,  woman,  likes,  he]
%% no

test(InputFile, OutputFile) :-
  open(InputFile, read, InStream), !,
  open(OutputFile, write, OutStream), !,
  process_sentences(InStream, OutStream), !,
  close(InStream), !,
  close(OutStream), !.

process_sentences(InStream, OutStream) :-
  at_end_of_stream(InStream), !.

process_sentences(InStream, OutStream) :-
  \+ at_end_of_stream(InStream),
  read(InStream, Sentence),
  process_sentence(Sentence, OutStream),
  process_sentences(InStream, OutStream).

process_sentence(Sentence, OutStream) :-
  s(_, Term, Sentence, []), !,
  write(OutStream, Sentence), write(OutStream, '.'), nl(OutStream),
  print(Term), nl, nl, !,
  pptree(Term, OutStream), !,
  nl(OutStream).

process_sentence(Sentence, OutStream) :-
  write(OutStream, Sentence), write(OutStream, '.'), nl(OutStream), !,
  write(OutStream, 'no'), nl(OutStream),
  nl(OutStream).

%% Done

%% Step 6
%% Now (if you are in for some real Prolog hacking) try to write a module that
%% reads in sentences terminated by a full stop or a line break from a file, so
%% that you can give your testsuite as

%% the cow under the table shoots.
%% a dead woman likes he.

%% instead of
%% [the,cow,under,the,table,shoots].
%% [a,dead,woman,likes,he].

%% TODO

%% Step 7
%% Make the testsuite environment more sophisticated, by adding information to
%% the input file about the expected output (in this case, whether the sentences
%% has a parse or not). Then modify the program so that it checks whether the
%% expected output matches the obtained output.

%% TODO
