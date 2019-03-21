%% coding: latin-1
%% Пример:
%% 1> BinXML = <<”<start><item>Text1</item><item>Text2</item></start>”>>.
%% <<”<start><item>Text1</item><item>Text2</item></start>”>>
%% 2> bs04:decode_xml(BinXML).
%% {<<”start”>>, [], [
%%     {<<”item”>>, [], [<<”Text1”>>]},
%%     {<<”item”>>, [], [<<”Text2”>>]}
%% ]}

-module(bs04).

%% API exports
-export([]).

%%====================================================================
%% API functions
%%====================================================================

decode_xml(Bin) -> [].

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    decode_xml_test_()->[?_assert(
                                 decode_xml(<<"<start><item>Text1</item><item>Text2</item></start>">>) =:=
{<<”start”>>, [], [
     {<<”item”>>, [], [<<”Text1”>>]},
     {<<”item”>>, [], [<<”Text2”>>]}
]}                                     
                                 )
].
-endif.
