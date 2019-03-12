%% P10 (**) Закодировать список с использованием алгоритма RLE:
%% Пример:
%% 1> p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]

-module(p10).
-export([encode/1]).

encode(L) -> encode(L, 0).

encode([H,H|T], C) ->
    erlang:display(C),
    encode([H|T], C + 1);
encode([], _) -> 
    [];
encode([H|T], C) -> 
    erlang:display(C),
    erlang:display("--- add ---"),
    [{C + 1, H} | encode(T,0)].