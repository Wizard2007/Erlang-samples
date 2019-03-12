%% P15 (**) Написать функцию-репликатор всех элементов входящего списка:
%% Пример:
%% 1> p15:replicate([a,b,c], 3).
%% [a,a,a,b,b,b,c,c,c]

-module(p15).
-export([replicate/2]).


replicate(L, C)-> replicate(L, C, []).

replicate([H|T], C, Acc)-> 
    replicate(T, C, replicate(H,C,Acc));
replicate([], _, Acc)-> 
    reverse(Acc);
replicate(H, 1, Acc)-> 
    [H|Acc];
replicate(H, C, Acc)-> 
    replicate(H, C - 1, [H|Acc]).

reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> 
   reverse(T,[H|Acc]);
reverse([],T) -> T.