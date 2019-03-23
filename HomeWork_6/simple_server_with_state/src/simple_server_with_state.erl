-module(simple_server_with_state).

%% API exports
-export([start/0, loop/1]).

%%====================================================================
%% API functions
%%====================================================================

start() ->
    InitialState = [],
    spawn(?MODULE, loop, [InitialState]).

loop(State) ->
    receive 
        {add, Item} -> io:format("~p adds to its state ~p~n", [self(), Item]),
                       NewState = [Item|State],
                       loop(NewState);
        {remove, Item} -> NewState = case lists:member(Item, State) of
                                         true -> lists:delete(Item, State);
                                         false -> io:format("I have no ~p~n", [Item]),
                                                  State
                                     end,
                          loop(NewState);
        show_items -> io:format("my  items is ~p~n",[State]),
                      loop(State);
        stop -> io:format("~p stops now ~n", [self()]);
        _Any -> loop(State)
    end.

%%====================================================================
%% Internal functions
%%====================================================================
