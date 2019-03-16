p11
=====

An OTP library

%% P11 (**) Закодировать список с использованием модифицированого алгоритма RLE:
%% Пример:
%% 1> p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
%% [{4,a},b,{2,c},{2,a},d,{4,e}]

Build
-----

    $ rebar3 compile
