%% P07 (**) Выровнять структуру с вложеными списками:
%% Пример:
%% 1> p07:flatten([a,[],[b,[c,d],e]]).
%% [a,b,c,d,e]


-module(p07).
-export([flatten/1]).

flatten([H|T]) ->
    erlang:display("# 0"),
    erlang:display(H),
    erlang:display(T),
    erlang:display("-----------"),
    flattenEx(H,T);
flatten([]) ->
    erlang:display("# 2"),
    erlang:display("-----------"),
    [].

flattenEx([H|T], TL) ->
    erlang:display(H),
    erlang:display(T),
    erlang:display(TL),
    erlang:display("# 1.1 list "),
    erlang:display("-----------"),
    flattenEx(H,[T|TL]);
flattenEx(H,[H1|T]) ->
    erlang:display(H),
    erlang:display(H1),
    erlang:display(T),
    erlang:display("# 1.2 single element "),
    erlang:display("-----------"),
    flattenEx(H1,T);
flattenEx([],T) ->
    erlang:display(T),
    erlang:display("# 1.3 empty element "),
    erlang:display("-----------"),
    flattenEx(T,[]);
flattenEx([H|T],[]) ->
    erlang:display(H),
    erlang:display(T),
    erlang:display("# 1.4 empty element "),
    flattenEx(H,T);
flattenEx(H,[]) ->
    erlang:display(H),
    erlang:display("# 1.5 empty element "),
    erlang:display("# end");
flattenEx([],[]) ->
    erlang:display("# end").
