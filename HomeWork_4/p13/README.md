p13
=====

An OTP library

%% P13 (**) Написать декодер для стандартного алгоритма RLE:
%% Пример:
%% 1> p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
%% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

Build
-----

    $ rebar3 compile
