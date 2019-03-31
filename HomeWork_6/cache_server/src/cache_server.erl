%% Написать кеширующий сервер:
%% {ok, Pid} = cache_server:start_link([{drop_interval, 3600}]).
%% ok = cache_server:insert(Key, Value, 600). %% Ключ, Значение, Время жизни записи
%% {ok, Value} = cache_server:lookup(Key).
%% DateFrom = {{2015,1,1},{00,00,00}}.
%% DateTo = {{2015,1,10},{23,59,59}}.
%% {ok, Value} = cache_server:lookup_by_date(DateFrom, DateTo).
%% Сервер должен хранить данные то количество времени которе было указано при записи.
%% Интервал очистки устаревших данных указывается при старте (drop_interval). Время
%% задается в секундах.

-module(cache_server).

-define(DBG(Str, Args), io:format(Str, Args)).

-behaviour(gen_server).
-import(calendar,[datetime_to_gregorian_seconds/1, gregorian_seconds_to_datetime/1, universal_time/0]). 

-include_lib("eunit/include/eunit.hrl").


-record(state, {drop_interval}).
-record(my_cache_item,{value, expired_at}).

%% API exports
-export([start_link/1,init/1,create/0,handle_info/2,lookup_by_date/2]).

%%====================================================================
%% API functions
%%====================================================================

start_link([{drop_interval, Seconds}]) -> gen_server:start_link({local, ?MODULE}, ?MODULE, [{drop_interval, Seconds}], []).

init([{drop_interval, Seconds}]) ->
    erlang:display(Seconds),
    erlang:send_after(Seconds, self(), trigger),
    {ok, #state{drop_interval = Seconds}}.


handle_info(trigger, State) ->
   % erlang:display("Delete"),
   delete_obsolete(),
   erlang:send_after(State#state.drop_interval, self(), trigger),
   {noreply, State}.

create() ->
    try 
        ets:new(my_cache, [public,named_table]) 
    catch 
        error:badarg -> ok
    end,
    ok.

insert(Key, Val, TimeOut) ->
    ets:insert(my_cache, {Key, #my_cache_item{value = Val, expired_at = add_seconds_to_date(universal_time(), TimeOut)}}),
    ok.

lookup(Key) ->
    CurrentDate = universal_time(),
    case ets:lookup(my_cache, Key) of
        [{_,Val}] when Val#my_cache_item.expired_at >= CurrentDate -> {ok, Val};
        _ -> undefined
    end.

lookup_by_date(DateFrom, DateTo) ->    
    ?debugFmt(" ~p ~p", [DateFrom,DateTo]),
    try
        ?debugFmt(" try", []),
        ?debugFmt(" select ~p ", [    ets:select(my_cache, 
            ets:fun2ms(
                fun({Value, Expired_at}) -> {Value, Expired_at} end)
            )]),
    ets:match(my_cache, 
            ets:fun2ms(
                fun({{Value, Expired_at}}) -> {{Value, Expired_at}} end)
            )
        
    catch
        _:_ -> undefuned
    end.

delete_obsolete() -> 
    CurrentDate = universal_time(),
    try
        ets:match_delete(my_cache, 
            ets:fun2ms(
                fun({Key, Item}) when Item#my_cache_item.expired_at < CurrentDate -> {Key, Item} end)
            )
    catch
        _:_ -> ok
    end,
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

add_seconds_to_date(Date, TimeOut) -> gregorian_seconds_to_datetime(datetime_to_gregorian_seconds(Date) + TimeOut).

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).

    my_cache_test_()->[?_assert(create() =:= ok),
                    ?_assert(ets:info(my_cache) /= undefined),
                    ?_assert(insert(key1,1,600) =:= ok),                    
                    ?_assert(lookup(key1) =:= {ok, #my_cache_item{value = 1, expired_at = add_seconds_to_date(universal_time(),600)}}),
                    ?_assert(lookup(key2) =:= undefined),
                    ?_assert(delete_obsolete() =:= ok)
                   ].

    my_cache_lookup_test_()->        
        create(),
        insert(key1, 1, 0),
        insert(key2, 2, 0),
        insert(key3, 3, 60),
        insert(key4, 4, 60),
        delete_obsolete(),
        ?_assert(lookup(key1) =:= undefined),
        ?_assert(lookup(key2) =:= undefined),
        ?_assert(lookup(key3) =:= {ok, #my_cache_item{value = 3, expired_at = add_seconds_to_date(universal_time(),60)}}),
        ?_assert(lookup(key4) =:= {ok, #my_cache_item{value = 4, expired_at = add_seconds_to_date(universal_time(),60)}}).

    my_cache_lookup_by_date_test_()-> 
        create(),
        insert(key1, 1, 0),
        insert(key2, 2, 0),
        insert(key3, 3, 60),
        insert(key4, 4, 60),        
         ?_assert(lookup_by_date(0, 0) =:= []). 
-endif.