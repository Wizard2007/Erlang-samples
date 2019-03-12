%% P11 (**) Закодировать список с использованием модифицированого алгоритма RLE:
%% Пример:
%% 1> p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},b,{2,c},{2,a},d,{4,e}]


-module(p11).
-export([encode_modified/1]).

encode_modified(L) -> encode_modified(L, 0).

encode_modified([H,H|T], C) ->
    encode_modified([H|T], C + 1);
encode_modified([], _) -> 
    [];
encode_modified([H|T], 0) -> 
    [H | encode_modified(T,0)];
encode_modified([H|T], C) -> 
    [{C + 1, H} | encode_modified(T,0)].