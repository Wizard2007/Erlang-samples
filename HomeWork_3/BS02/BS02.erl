%% BS02: Разделить строку на слова:
%% Пример:
%% 1> BinText = <<”Text with four words”>>.
%% <<”Text with four words”>>
%% 2> bs02:words(BinText).
%% [<<”Text”>>, <<”with”>>, <<”four”>>, <<”words”>>]


-module(bs02).
-export([words/1]).

%% words(Bin) -> binary_part(Bin,{0,search(Bin,0)}).
words(Bin) -> words(Bin,Bin, 0).

words(<<>>, Bin, C) -> [ binary_part(Bin,{0,C})];
words(<<" ",Rest/binary>>, Bin, C) -> [ binary_part(Bin,{0,C})| words(Rest,Rest, 0)];
words(<<_,Rest/binary>>, Bin, C) -> words(Rest, Bin, C+1).

