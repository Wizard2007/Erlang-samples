%% 1. Написать библиотеку для кеширования:
%% ok = my_cache:create().                %% Создание кеш-таблицы
%% ok = my_cache:insert(Key, Value, 600). %% Ключ, Значение, Время жизни записи
%% {ok, Value} = my_cache:lookup(Key).    %% Получить значение по ключу, функция должна доставать только НЕ устаревшие данные
%% ok = my_cache:delete_obsolete().       %% Очистка утстаревших данных

-module(my_cache).

%% API exports
-export([create/0,insert/3, lookup/1 %%, delete_obsolete/0
        ]).

-record(my_cache_item,{value, expired_at}).

%%====================================================================
%% API functions
%%====================================================================

create() -> 
    TableInfo = ets:info(my_cache),
    if 
        TableInfo == undefined ->
        ets:new(my_cache, [public,named_table])
    end,
    ok.

insert(Key, Value, TimeOut) ->
    NowInSeconds = calendar:datetime_to_gregorian_seconds(calendar:universal_time()) + TimeOut,
    Item = #my_cache_item{value = Value, expired_at = calendar:gregorian_seconds_to_datetime(NowInSeconds)},
    ets:insert(my_cache, {Key, Item}),
    ok.

lookup(Key) ->
    CurrentItem = ets:lookup(my_cache, Key),
    if 
        CurrentItem =:= [] ->
            {ok, []};
        true ->     
            [{_, Item}] = CurrentItem,
            CurrentDate = calendar:universal_time(),
            if 
                Item#my_cache_item.expired_at >= CurrentDate  -> 
                    {ok, Item};
                true ->
                    {ok, []}
            end
    end.

    
%% delete_obsolete() -> ets:match_delete(my_cache, ets:fun2ms(fun({Value, ExpiredAt}) when ExpiredAt =< calendar:universal_time() -> B end)),ok.       
%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    words_test_()->[?_assert(create() =:= ok),
                    ?_assert(ets:info(my_cache) /= undefined),
                    ?_assert(insert(key1,1,600) =:= ok),
                    ?_assert(lookup(key2) =:= {ok, []}),
                    ?_assert(lookup(key1) =:= {ok, #my_cache_item{value = 1, expired_at = calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(calendar:universal_time()) + 600)}})
                   ].
-endif.