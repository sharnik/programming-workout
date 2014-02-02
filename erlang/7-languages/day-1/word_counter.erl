-module(word_counter).
-export([count/1]).

count([]) -> 0;
count([32]) -> 0;
count([_ | []]) -> 1;
% 32 is ASCII code for ' '
count([32 | Tail]) -> 1 + count(Tail);
count([_ | Tail]) -> count(Tail).
