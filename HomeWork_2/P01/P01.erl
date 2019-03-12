%% P01 (*) Найти последний элемент списка:
%% Пример:
%% 1> p01:last([a,b,c,d,e,f]).
%% f

-module(p01).
-export([last/1]).

last([H]) -> H;
last([_|T]) -> last(T).
