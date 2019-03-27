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
-behaviour(gen_server).

-record(state, {drop_interval}).


%% API exports
-export([start_link/0,init/1,my_api_1/1,handle_call/3,handle_info/2, create/0, handle_create/3]).

%%====================================================================
%% API functions
%%====================================================================

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    erlang:send_after(?INTERVAL, self(), trigger),
    {ok, #state{drop_interval = 5000}}.

my_api_1(A) ->
    erlang:display("my_api_1~n"),
    gen_server:call(?MODULE, {msg1, A}).

handle_info(trigger, State) ->
   delete_obsolete(),
   erlang:send_after(State#state.drop_interval, self(), trigger),
   {noreply, State}.

handle_call({msg1, A}, _From, State) -> erlang:display("test"),
    {reply, State, [A, _From]};
handle_call({create}, _From, State) -> erlang:display("create2 "),{reply, State, [ _From]}.

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
    
delete_obsolete() -> 
    CurrentDate = universal_time(),
    ets:match_delete(my_cache, 
        ets:fun2ms(
            fun({Key, Item}) when Item#my_cache_item.expired_at < CurrentDate -> {Key, Item} end)
        ),
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

add_seconds_to_date(Date, TimeOut) -> gregorian_seconds_to_datetime(datetime_to_gregorian_seconds(Date) + TimeOut).

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    my_cache_test_()->[?_assert(create() =:= ok),
                    ?_assert(ets:info(my_cache) /= undefined),
                    ?_assert(insert(key1,1,600) =:= ok),                    
                    ?_assert(lookup(key1) =:= {ok, #my_cache_item{value = 1, expired_at = add_seconds_to_date(universal_time(),600)}}),
                    ?_assert(lookup(key2) =:= undefined),
                    ?_assert(delete_obsolete() =:= ok)
                   ].

    my_cache_integrated_test_()->        
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
-endif.