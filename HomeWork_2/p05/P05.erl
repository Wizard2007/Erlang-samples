%% P05 (*) Перевернуть список:
%% Пример:
%% 1> p05:reverse([1,2,3]).
%% [3,2,1]

-module(p05).
-export([reverse/1]).

reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> 
   reverse(T,[H|Acc]);
reverse([],T) -> T.