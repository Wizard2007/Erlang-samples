%% coding: latin-1
%% P15 (**) ???????? ???????-?????????? ???? ????????? ????????? ??????:
%% ??????:
%% 1> p15:replicate([a,b,c], 3).
%% [a,a,a,b,b,b,c,c,c]

-module(p15).

%% API exports
-export([replicate/2]).

%%====================================================================
%% API functions
%%====================================================================

replicate(L, C)-> replicate(L, C, []).

replicate([H|T], C, Acc)-> replicate(T, C, replicate(H,C,Acc));
replicate([], _, Acc)-> reverse(Acc);
replicate(H, 1, Acc)-> [H|Acc];
replicate(H, C, Acc)-> replicate(H, C - 1, [H|Acc]).

reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> reverse(T,[H|Acc]);
reverse([],T) -> T.

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    replicate_test_()->[?_assert(replicate([a,b,c], 3)=:=[a,a,a,b,b,b,c,c,c])].
-endif.
