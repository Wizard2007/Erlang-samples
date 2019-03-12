%% P12 (**) Написать декодер для модифицированого алгоритма RLE:
%% Пример:
%% 1> p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

-module(p12).
-export([decode_modified/1]).

decode_modified(L)-> decode_modified(L,[]).


decode_modified([{C,H}|T], Acc) -> decode_modified(T, decode_modified(H, C, Acc));
decode_modified([H|T], Acc) -> decode_modified(T, decode_modified(H, 1, Acc));
decode_modified([], Acc) -> reverse(Acc).

decode_modified(H, 1, Acc)-> 
    erlang:display(H),
    erlang:display(Acc),
    erlang:display("--- 1 ---"),
    [H|Acc];
decode_modified(H, I, Acc)-> 
    erlang:display(H),
    erlang:display(I),
    erlang:display(Acc),    
    erlang:display("--- I ---"),
    decode_modified(H, I - 1, [H|Acc]).

reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> 
   reverse(T,[H|Acc]);
reverse([],T) -> T.
