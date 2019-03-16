%% coding: latin-1
%% P13 (**) ???????? ??????? ??? ???????????? ????????? RLE:
%% ??????:
%% 1> p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

-module(p13).

%% API exports
-export([decode/1]).

%%====================================================================
%% API functions
%%====================================================================

decode(L)-> decode(L,[]).

decode([{C,H}|T], Acc) -> decode(T, decode(H, C, Acc));
decode([], Acc) -> reverse(Acc).

decode(H, 1, Acc)-> [H|Acc];
decode(H, I, Acc)-> decode(H, I - 1, [H|Acc]).

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
    decode_test_()->[?_assert(decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}])=:=[a,a,a,a,b,c,c,a,a,d,e,e,e,e])].
-endif.
