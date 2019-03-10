%% P02 (*) Найти два последних элемента списка:
%% Пример:
%% 1> p02:but_last([a,b,c,d,e,f]).
%% [e,f]


-module(p02).
-export([but_last/1]).

but_last([H|[H1|[H2|T]]]) ->
    %%erlang:display("Start"),
    but_last_ex(H1,H2,T);
but_last([H1|[]]) -> undefined;
but_last([H|[H1|[]]]) ->
    %%erlang:display("match #1 "),
    [H,H1];
but_last([]) -> undefined.

but_last_ex(H,H1,[H2|T]) ->
    but_last_ex(H1,H2,T);
but_last_ex(H,H1,[]) ->
    %%erlang:display("Finish"),
    [H,H1].
