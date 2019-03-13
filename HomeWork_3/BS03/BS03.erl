%% BS03: Разделить строку на части, с явным указанием разделителя:
%% Пример:
%% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
%% <<”Col1-:-Col2-:-Col3-:-Col4-:-Col5”>>
%% 2> bs03:split(BinText, "-:-").
%% [<<”Col1”>>, <<”Col2”>>, <<”Col3”>>, <<”Col4”>>, <<”Col5”>>]

-module(bs03).
-export([split/2]).

split(Bin, Divider) -> split(Divider, Bin,Bin, 0).

split(_, <<>>, Bin, C) -> [ binary_part(Bin,{0,C})];
split(Divider, <<Divider,Rest/binary>>, Bin, C) -> [ binary_part(Bin,{0,C})| split(Divider, Rest,Rest, 0)];
split(Divider, <<_,Rest/binary>>, Bin, C) -> split(Divider, Rest, Bin, C+1).