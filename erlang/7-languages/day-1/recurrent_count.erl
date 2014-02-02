-module(recurrent_count).
-export([count/1]).

internal_count(Total, Total) -> io:format("~b\n", [Total]);
internal_count(Current, Total) ->
    io:format("~b\n", [Current]),
    internal_count(Current + 1, Total).

count(N) -> internal_count(1, N).
