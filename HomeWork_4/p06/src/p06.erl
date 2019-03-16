%% coding: latin-1
%% P06 (*) ??????????, ???????? ?? ?????? ???????????:
%% ??????:
%% 1> p06:is_palindrome([1,2,3,2,1]).
%% true

-module(p06).

%% API exports
-export([is_palindrome/1]).

%%====================================================================
%% API functions
%%====================================================================

is_palindrome(L) -> reverse(L) == L.

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
    is_palindrome_test_()->[
        ?_assert(is_palindrome([1,2,3,2,1])=:=true),
        ?_assert(is_palindrome([1,2,3,3,2,1])=:=true),
        ?_assert(is_palindrome([1,2,3,5,2,1])=:=false),
        ?_assert(is_palindrome([1,2,3,1,1])=:=false)].
-endif.
