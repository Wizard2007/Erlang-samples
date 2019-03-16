%% coding: latin-1
%% P11 (**) ???????????? ?????? ? ?????????????? ???????????????? ????????? RLE:
%% ??????:
%% 1> p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},b,{2,c},{2,a},d,{4,e}]

-module(p11).

%% API exports
-export([encode_modified/1]).

%%====================================================================
%% API functions
%%====================================================================

encode_modified(L) -> encode_modified(L, 0).

encode_modified([H,H|T], C) -> encode_modified([H|T], C + 1);
encode_modified([], _) -> [];
encode_modified([H|T], 0) -> [H | encode_modified(T,0)];
encode_modified([H|T], C) -> [{C + 1, H} | encode_modified(T,0)].

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    encode_modified_test_()->[?_assert(encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e])=:=[{4,a},b,{2,c},{2,a},d,{4,e}])].
-endif.
