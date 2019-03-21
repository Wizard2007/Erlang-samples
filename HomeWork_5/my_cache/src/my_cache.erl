%% 1. Написать библиотеку для кеширования:
%% ok = my_cache:create().                %% Создание кеш-таблицы
%% ok = my_cache:insert(Key, Value, 600). %% Ключ, Значение, Время жизни записи
%% {ok, Value} = my_cache:lookup(Key).    %% Получить значение по ключу, функция должна доставать только НЕ устаревшие данные
%% ok = my_cache:delete_obsolete().       %% Очистка утстаревших данных

-module(my_cache).

%% API exports
-export([create/0,insert/3, lookup/1, delete_obsolete/0]).

-record(my_cache_item,{value, expired_at}).

%%====================================================================
%% API functions
%%====================================================================

create() -> 
    ets:new(my_cache, [public,named_table]),
    ok.

insert(Key, Value, TimeOut) ->
    NowInSeconds = calendar:datetime_to_gregorian_seconds(calendar:universal_time()) + TimeOut,
    Item = #my_cache_item{value = Value, expired_at = calendar:gregorian_seconds_to_datetime(NowInSeconds)},
    ets:insert(my_cache, {Key, Item}),
    ok.

lookup(Key) ->
    [{_, Item}] = ets:lookup(my_cache, Key),
    CurrentTime = calendar:universal_time(),
    if 
        Item#my_cache_item.expired_at >= CurrentTime  -> 
            {ok, Item};
        true ->
            {ok, undefin
    end.
    
delete_obsolete() -> ets:match_delete(my_cache, ets:fun2ms(fun({Value, ExpiredAt}) when ExpiredAt =< calendar:universal_time() -> B end)).
    ok.       
%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.