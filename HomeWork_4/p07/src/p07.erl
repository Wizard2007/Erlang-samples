%% coding: latin-1
%% P07 (**) ????????? ????????? ? ????????? ????????:
%% ??????:
%% 1> p07:flatten([a,[],[b,[c,d],e]]).
%% [a,b,c,d,e]


-module(p07).

%% API exports
-export([flatten/1]).

%%====================================================================
%% API functions
%%====================================================================

flatten(L) -> flatten(L,[]).

flatten([H|T], Acc) -> flatten(H, flatten(T,Acc));
flatten([], T) -> T;
flatten(H,Acc) -> [H|Acc].

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    flatten_test_()->[?_assert(flatten([a,[],[b,[c,d],e]])=:=[a,b,c,d,e])].
-endif.