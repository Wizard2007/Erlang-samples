%% P13 (**) Написать декодер для стандартного алгоритма RLE:
%% Пример:
%% 1> p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]



-module(p13).
-export([decode/1]).

decode(L)-> decode(L,[]).

decode([{C,H}|T], Acc) -> decode(T, decode(H, C, Acc));
decode([], Acc) -> reverse(Acc).

decode(H, 1, Acc)-> 
    erlang:display(H),
    erlang:display(Acc),
    erlang:display("--- 1 ---"),
    [H|Acc];
decode(H, I, Acc)-> 
    erlang:display(H),
    erlang:display(I),
    erlang:display(Acc),    
    erlang:display("--- I ---"),
    decode(H, I - 1, [H|Acc]).


reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> 
   reverse(T,[H|Acc]);
reverse([],T) -> T.
