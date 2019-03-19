%% coding: latin-1
%% BS03: ????????? ?????? ?? ?????, ? ????? ????????? ???????????:
%% ??????:
%% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
%% <<”Col1-:-Col2-:-Col3-:-Col4-:-Col5”>>
%% 2> bs03:split(BinText, "-:-").
%% [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]

-module(bs03).

%% API exports
-export([split/2]).

%%====================================================================
%% API functions
%%====================================================================

split(Bin, Divider) ->
	DividerBin = list_to_binary(Divider),
	DividerSize = byte_size(DividerBin),
	split(Bin,Bin, 0, DividerBin, DividerSize).

split(Rest, Bin, C, DividerBin, DividerSize) ->
    case Rest of
        <<DividerBin:DividerSize/binary,T/binary>> ->            
            erlang:display("case 1"),
            <<W:C/binary, _/binary>> = Bin,
            erlang:display(W),
            erlang:display(T),
            [W|split(T,T, 0, DividerBin, DividerSize)];
        <<_:DividerSize/binary>> -> 
            [Bin];
        _ -> 
            <<_:1/binary,TRest/binary>> = Rest,
            split(TRest,Bin, C+1, DividerBin, DividerSize)
    end.

%%====================================================================
%% Internal functions
%%====================================================================

%%====================================================================
%% Unit tests
%%====================================================================

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
    split_test_()->[?_assert(split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>,"-:-")=:=[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>])].
-endif.
