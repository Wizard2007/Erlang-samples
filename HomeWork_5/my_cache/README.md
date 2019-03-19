my_cache
=====

An OTP library

ok = my_cache:create().                %% Создание кеш-таблицы
ok = my_cache:insert(Key, Value, 600). %% Ключ, Значение, Время жизни записи
{ok, Value} = my_cache:lookup(Key).    %% Получить значение по ключу, функция должна доставать только НЕ устаревшие данные
ok = my_cache:delete_obsolete().       %% Очистка утстаревших данных

Build
-----

    $ rebar3 compile
