%% Chapter 12 - Exercises

%% Exercise 12.1 Write code that creates hogwart.houses, a file that that looks
%% like this:

%%           gryffindor
%% hufflepuff          ravenclaw
%%             slytherin

%% You can use the built-in predicates open/3 , close/1 , tab/2 , nl/1 , and
%% write/2 .

writeHouses :-
  open('hogwarts.houses', write, Stream),
  tab(Stream, 10), write(Stream, 'gryffindor'),
  nl(Stream),
  write(Stream, 'hufflepuff'), tab(Stream, 10), write(Stream, 'ravenclaw'),
  nl(Stream),
  tab(Stream, 10), write(Stream, 'slytherin'),
  close(Stream).

%% Exercise 12.2 Write a Prolog program that reads in a plain text file word by
%% word, and asserts all read words and their frequency into the Prolog
%% database. You may use the predicate readWord/2 to read in words. Use a
%% dynamic predicate word/2 to store the words, where the first argument is a
%% word, and the second argument is the frequency of that word.

:- dynamic word/2.

addWordToDatabase(W) :-
  word(W, X),
  Y is X + 1,
  assert( word(W, Y) ), !.

addWordToDatabase(W) :-
  assert( word(W, 1) ), !.

readPlainText(X) :-
  open(X, read, Stream),
  readWords(Stream),
  close(Stream).

readWords(InStream) :-
  \+ at_end_of_stream(InStream),
  readWord(InStream, W),
  write(W), nl,
  addWordToDatabase(W),
  readWords(InStream).

readWord(InStream, W) :-
  get_code(InStream, Char),
  checkCharAndReadRest(Char, Chars, InStream),
  atom_codes(W, Chars).

checkCharAndReadRest(10, [], _) :- !.

checkCharAndReadRest(32, [], _) :- !.

checkCharAndReadRest(-1, [], _) :- !.

checkCharAndReadRest(end_of_file, [], _) :- !.

checkCharAndReadRest(Char, [Char | Chars] , InStream) :-
  get_code(InStream, NextChar),
  checkCharAndReadRest(NextChar, Chars, InStream).

%% ?- readPlainText('foo.txt').
%% foo
%% bar
%% baz
%% bozz
%% newline
%% bozz
%% bar
%% baz
%% foo
%% end
%% of
%% file
%% false.

%% partial output from ?- listing.
word(foo, 1).
word(bar, 1).
word(baz, 1).
word(bozz, 1).
word(newline, 1).
word(bozz, 2).
word(bar, 2).
word(baz, 2).
word(foo, 2).
word(end, 1).
word(of, 1).
word(file, 1).
