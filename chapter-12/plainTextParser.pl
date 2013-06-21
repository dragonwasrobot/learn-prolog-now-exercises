%% plainTextParser.pl

:- module(plainTextParser,
   [parseSentence/2]).

%% Reading arbitrary input using get_code/2 and atom_codes/2

checkCharAndReadRest(46, [], _) :- !. % dot

checkCharAndReadRest(32, [], _) :- !. % blank character

checkCharAndReadRest(10, [], _) :- !. % new line

checkCharAndReadRest(-1, [], _) :- !. % end of stream

checkCharAndReadRest(end_of_file, [], _) :- !.

checkCharAndReadRest(Char, [Char | Chars] , InStream) :-
  get_code(InStream, NextChar),
  checkCharAndReadRest(NextChar, Chars, InStream).

readWord(InStream, W) :-
  get_code(InStream, Char),
  checkCharAndReadRest(Char, Chars, InStream),
  atom_codes(W, Chars).

parseSentence(InStream, Sentence) :-
  at_end_of_stream(InStream), !.

parseSentence(InStream, [Word | Sentence]) :-
  readWord(InStream, Word), !,
  parseSentence(InStream, Sentence).

parseSentences(InStream, Sentences) :-
  at_end_of_stream(InStream), !.

parseSentences(InStream, [Sentence | Sentences]) :-
  \+ at_end_of_stream(InStream),
  parseSentence(InStream, Sentence), !,
  parseSentences(InStream, Sentences).

testParser(InputFile) :-
  open(InputFile, read, InStream), !,
  parseSentences(InStream, Sentences), !,
  print(Sentences),
  close(InStream).
