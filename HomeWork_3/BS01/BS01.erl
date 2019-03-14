%% https://www.tutorialspoint.com/erlang/erlang_binary_part.htm
%% BS01: Извлечь из строки первое слово:
%% Пример:
%% 1> BinText = <<"Some text">>.
%% <<”Some Text”>>
%% 2> bs01:first_word(BinText).
%% <<”Some”>>

-module(bs01).
-export([first_word/1]).

-module(bs01).
-export([first_word/1]).

first_word(Bin) ->  binary_part(Bin,{0,search(Bin,0)}).

search(<<" ", _/binary>>, C) ->  C;
search(<<_, Rest/binary>>, C) -> search(Rest, C + 1).
