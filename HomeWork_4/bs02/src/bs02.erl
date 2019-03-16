%% coding: latin-1
%% BS02: ????????? ?????? ?? ?????:
%% ??????:
%% 1> BinText = <<"Text with four words">>.
%% <<"Text with four words">>
%% 2> bs02:words(BinText).
%% [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]


-module(bs02).

%% API exports
-export([words/1]).

%%====================================================================
%% API functions
%%====================================================================

words(Bin) -> words(Bin,Bin, 0).

words(<<>>, Bin, C) -> [ binary_part(Bin,{0,C})];
words(<<" ",Rest/binary>>, Bin, C) -> [ binary_part(Bin,{0,C})| words(Rest,Rest, 0)];
words(<<_,Rest/binary>>, Bin, C) -> words(Rest, Bin, C+1).

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    words_test_()->[?_assert(words(<<"Text with four words">>)=:=[<<"Text">>, <<"with">>, <<"four">>, <<"words">>])].
-endif.
