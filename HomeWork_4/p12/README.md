p12
=====

An OTP library

%% P12 (**) Написать декодер для модифицированого алгоритма RLE:
%% Пример:
%% 1> p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

Build
-----

    $ rebar3 compile
