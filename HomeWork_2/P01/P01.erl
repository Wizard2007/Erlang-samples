-module(p01).
-export([last/1]).

last([H|T]) ->
    %%erlang:display("Start"),
    %%erlang:display(H),
    %%erlang:display(T),
    lastEx(H,T);
last([]) -> false.

lastEx(_,[H|T]) ->
    %%erlang:display(H_),
    %%erlang:display(T_),
    lastEx(H, T);
lastEx(H,[]) ->
    %%erlang:display("Finish"),
    H.
