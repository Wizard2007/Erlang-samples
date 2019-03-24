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

-record(state, {}).


%% API exports
-export([start_link/0,init/1]).

%%====================================================================
%% API functions
%%====================================================================

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    {ok, #state{}}.

%%====================================================================
%% Internal functions
%%====================================================================
