%% coding: latin-1
%% P12 (**) ???????? ??????? ??? ???????????????? ????????? RLE:
%% ??????:
%% 1> p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

-module(p12).

%% API exports
-export([decode_modified/1]).

%%====================================================================
%% API functions
%%====================================================================

decode_modified(L)-> decode_modified(L,[]).

decode_modified([{C,H}|T], Acc) -> decode_modified(T, decode_modified(H, C, Acc));
decode_modified([H|T], Acc) -> decode_modified(T, decode_modified(H, 1, Acc));
decode_modified([], Acc) -> reverse(Acc).

decode_modified(H, 1, Acc)-> [H|Acc];
decode_modified(H, I, Acc)-> decode_modified(H, I - 1, [H|Acc]).

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
    decode_modified_test_()->[?_assert(decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}])=:=[a,a,a,a,b,c,c,a,a,d,e,e,e,e])].
-endif.
