%% P02 (*) Найти два последних элемента списка:
%% Пример:
%% 1> p02:but_last([a,b,c,d,e,f]).
%% [e,f]


-module(p02).
-export([but_last/1]).

but_last([_,_] = L) -> 
    L;
but_last([_|T]) ->    
    but_last(T).

