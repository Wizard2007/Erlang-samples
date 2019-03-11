%% P05 (*) Перевернуть список:
%% Пример:
%% 1> p05:reverse([1,2,3]).
%% [3,2,1]

-module(p05).
-export([reverse/1]).

reverse([H|T]) ->
    %%erlang:display("Start"),
    %%erlang:display(H),
    %%erlang:display(T),
    reverseEx(T, [H]);
reverse([]) -> [].

reverseEx([H|T], R) ->
    %%erlang:display(H),
    %%erlang:display(T),
    reverseEx(T, [H|R]);
reverseEx([], R) ->
    %%erlang:display("Finish"),
    R.
