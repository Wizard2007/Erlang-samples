%% P07 (**) Выровнять структуру с вложеными списками:
%% Пример:
%% 1> p07:flatten([a,[],[b,[c,d],e]]).
%% [a,b,c,d,e]


-module(p07).
-export([flatten/1]).

flatten(L) -> flatten(L,[]).

flatten([H|T], Acc) -> 
   flatten(H, flatten(T,Acc));
flatten([], T) -> T;
flatten(H,Acc) -> [H|Acc].
