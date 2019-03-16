%% coding: latin-1
%% P03 (*) ????? N-? ??????? ??????:
%% ??????:
%% 1> p03:element_at([a,b,c,d,e,f], 4).
%% d
%% 2> p03:element_at([a,b,c,d,e,f], 10).
%% undefined


-module(p03).

%% API exports
-export([element_at/2]).

%%====================================================================
%% API functions
%%====================================================================

element_at([H|_], 1) -> H;
element_at([_|T], I) -> element_at(T,I-1);
element_at([], _) -> undefined.

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    element_at_test_()->[
        ?_assert(element_at([a,b,c,d,e,f], 4)=:=d),
        ?_assert(element_at([a,b,c,d,e,f], 10)=:=undefined)].
-endif.
