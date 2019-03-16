%% coding: latin-1
%% BS01: ??????? ?? ?????? ?????? ?????:
%% ??????:
%% 1> BinText = <<"Some text">>.
%% <<"Some Text">>
%% 2> bs01:first_word(BinText).
%% <<"Some">>

-module(bs01).

%% API exports
-export([first_word/1]).

%%====================================================================
%% API functions
%%====================================================================

first_word(Bin) ->  binary_part(Bin,{0,search(Bin,0)}).

search(<<" ", _/binary>>, C) ->  C;
search(<<_, Rest/binary>>, C) -> search(Rest, C + 1).

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    first_word_test_()->[
        ?_assert(first_word(<<"   Some text">>)=:=<<"Some">>),
        ?_assert(first_word(<<"Some text">>)=:=<<"Some">>),
        ?_assert(first_word(<<"Some">>)=:=<<"Some">>)].
-endif.
