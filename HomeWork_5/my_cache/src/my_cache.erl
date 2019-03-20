%% 1. Написать библиотеку для кеширования:
%% ok = my_cache:create().                %% Создание кеш-таблицы
%% ok = my_cache:insert(Key, Value, 600). %% Ключ, Значение, Время жизни записи
%% {ok, Value} = my_cache:lookup(Key).    %% Получить значение по ключу, функция должна доставать только НЕ устаревшие данные
%% ok = my_cache:delete_obsolete().       %% Очистка утстаревших данных

-module(my_cache).

%% API exports
-export([create/0,insert_/3, lookup/1]).

-record(my_cache_item,{value, expired_at}).

%%====================================================================
%% API functions
%%====================================================================

create() -> 
    ets:new(my_cache, [public,named_table]),
    ok.

insert_(Key, Value, TimeOut) ->
    erlang:display("info"),
    
    NowInSeconds = calendar:datetime_to_gregorian_seconds(calendar:local_time()) + TimeOut,
    Item = #my_cache_item{value = Value, expired_at = calendar:gregorian_seconds_to_datetime(NowInSeconds)},
    erlang:display(Item),
    erlang:display("insert"),
    ets:insert(my_cache, {Key, Item}),
    ok.

lookup(Key) ->
    [{_, Value}] = ets:lookup(my_cache, Key),
    {ok, Value}.

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.