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

first_word(<<" ", Bin/binary>>) -> first_word(Bin); 

first_word(Bin) ->
    case binary:match(Bin, <<" ">>) of
        {Pos, _} -> <<W:Pos/binary, _/binary>> = Bin, 
                    W;
        nomatch -> Bin
    end.

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
