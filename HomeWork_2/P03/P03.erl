%% P03 (*) Найти N-й элемент списка:
%% Пример:
%% 1> p03:element_at([a,b,c,d,e,f], 4).
%% d
%% 2> p03:element_at([a,b,c,d,e,f], 10).
%% undefined


-module(p03).
-export([element_at/2]).

element_at([H|_], 1) -> H;
element_at([_|T], I) -> element_at(T,I-1);
element_at([], _) -> undefined.

