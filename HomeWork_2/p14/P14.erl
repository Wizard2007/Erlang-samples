%% P14 (*) Написать дубликатор всех элементов входящего списка:
%% Пример:
%% 1> p14:duplicate([a,b,c,c,d]).
%% [a,a,b,b,c,c,c,c,d,d]

-module(p14).
-export([duplicate/1]).

duplicate([H])-> [H,H];
duplicate([H|T])-> [H,H|duplicate(T)].

reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> 
   reverse(T,[H|Acc]);
reverse([],T) -> T.
