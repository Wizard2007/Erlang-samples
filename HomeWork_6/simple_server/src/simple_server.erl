-module(simple_server).

%% API exports
-export([start/0]).

start() ->
    io:format("start ~p~n", [self()]),
    spawn(fun loop/0).

loop() ->
    io:format("~p enter loop ~n", [self()]),
    receive
        stop -> io:format("~p stops now ~n", [self()]);
        Msg -> io:format("~p receive ~p~n",[self(), Msg]),
               loop()
    end.

%%====================================================================
%% API functions
%%====================================================================


%%====================================================================
%% Internal functions
%%====================================================================
