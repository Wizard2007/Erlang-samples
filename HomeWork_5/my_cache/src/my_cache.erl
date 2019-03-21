%% 1. Написать библиотеку для кеширования:
%% ok = my_cache:create().                %% Создание кеш-таблицы
%% ok = my_cache:insert(Key, Value, 600). %% Ключ, Значение, Время жизни записи
%% {ok, Value} = my_cache:lookup(Key).    %% Получить значение по ключу, функция должна доставать только НЕ устаревшие данные
%% ok = my_cache:delete_obsolete().       %% Очистка утстаревших данных
-include_lib("stdlib/include/ms_transform.hrl").
-module(my_cache).

%% API exports
-export([create/0,
         insert/3, 
         lookup/1, 
         delete_obsolete/0
        ]).

-record(my_cache_item,{value, expired_at}).

%%====================================================================
%% API functions
%%====================================================================

create() -> 
    TableInfo = ets:info(my_cache),
    if 
        TableInfo == undefined ->
            ets:new(my_cache, [public,named_table]);
        true -> ok
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

    
delete_obsolete() -> 
    CurrentTime = calendar:universal_time(),
    Expr = ets:fun2ms(
                      fun({Key, Item}) when Item#my_cache_item.expired_at < CurrentTime -> {Key, Item} end
                     ),
    ets:match_delete(my_cache, Expr),
    ok.

%%Item#my_cache_item.expired_at

%%====================================================================
%% Internal functions
%%====================================================================

addSeconds(Date, TimeOut) -> calendar:gregorian_seconds_to_datetime(calendar:datetime_to_gregorian_seconds(Date) + TimeOut).

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    my_cache_test_()->[?_assert(create() =:= ok),
                    ?_assert(ets:info(my_cache) /= undefined),
                    ?_assert(insert(key1,1,600) =:= ok),                    
                    ?_assert(lookup(key1) =:= {ok, #my_cache_item{value = 1, expired_at = addSeconds(calendar:universal_time(),600)}}),
                    ?_assert(lookup(key2) =:= {ok, []}),
                    ?_assert(delete_obsolete() =:= ok)
                   ].
    my_cache_test_integrated_()->
        
        CurrentTime = calendar:universal_time(),
        create(),
        insert(key1, 1, 0),
        insert(key2, 2, 0),
        insert(key3, 3, 60),
        insert(key4, 4, 60),
        delete_obsolete(),
        ?_assert(lookup(key1) =:= undefined),
        ?_assert(lookup(key2) =:= undefined),
        ?_assert(lookup(key3) =:= {ok, #my_cache_item{value = 3, expired_at = addSeconds(calendar:universal_time(),60)}}),
        ?_assert(lookup(key4) =:= {ok, #my_cache_item{value = 4, expired_at = addSeconds(calendar:universal_time(),60)}}).        
-endif.

%% http://erlang.org/pipermail/erlang-questions/2015-August/085570.html