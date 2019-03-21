bs04
=====

An OTP library

%% Пример:
%% 1> BinXML = <<”<start><item>Text1</item><item>Text2</item></start>”>>.
%% <<”<start><item>Text1</item><item>Text2</item></start>”>>
%% 2> bs04:decode_xml(BinXML).
%% {<<”start”>>, [], [
%%     {<<”item”>>, [], [<<”Text1”>>]},
%%     {<<”item”>>, [], [<<”Text2”>>]}
%% ]}

Build
-----

    $ rebar3 compile
