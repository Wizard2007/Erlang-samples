%% 1> p04:len([]).
%% 0
%% 2> p04:len([a,b,c,d]).
%% 4


-module(p04).
-export([len/1]).

len([H|T]) ->
    %%erlang:display("Start"),
    %%erlang:display(H),
    %%erlang:display(T),
    lenEx(T,1);
len([]) -> 0.

lenEx([H|T],I) ->
    %%erlang:display(H),
    %%erlang:display(T),
    %%erlang:display(I),
    lenEx(T, I + 1);
lenEx([], I) -> I.
