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
    <<DividerBinLocal:DividerSize/binary,T/binary>> = Rest,
	if(DividerBinLocal == DividerBin) ->
        <<W:C/binary, _/binary>> = Bin,       
		[W|split(T,T, 0, DividerBin, DividerSize)];
	true ->
		<<_:1/binary,TRest/binary>> = Rest,
		if byte_size(Bin) - 1 > 3 ->
			split(TRest,Bin, C+1, DividerBin, DividerSize);
		true ->
            [Bin]			
		end

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
