%% BS03: –азделить строку на части, с €вным указанием разделител€:
%% ѕример:
%% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
%% <<ФCol1-:-Col2-:-Col3-:-Col4-:-Col5Ф>>
%% 2> bs03:split(BinText, "-:-").
%% [<<ФCol1Ф>>, <<ФCol2Ф>>, <<ФCol3Ф>>, <<ФCol4Ф>>, <<ФCol5Ф>>]

-module(bs03).

%% API exports
-export([split/2]).

%%====================================================================
%% API functions
%%====================================================================

split(Bin, Divider) ->
	DividerBin = list_to_binary(Divider),
	DividerSize = byte_size(DividerBin)*8,
	<<DividerInt:DividerSize>> = DividerBin,
	split(Bin,Bin, 0, DividerInt, DividerSize).

split(Rest, Bin, C, DividerInt, DividerSize) ->
    <<DividerIntLocal:DividerSize,T/binary>> = Rest,
	if(DividerIntLocal == DividerInt) ->
		[ binary_part(Bin,{0,C})|split(T,T, 0, DividerInt, DividerSize)];
	true ->
		<<_:8,TRet/binary>> = Rest,
		if byte_size(Bin) - 1 > 3 ->
			split(TRet,Bin, C+1, DividerInt, DividerSize);
		true ->
			[ binary_part(Bin,{0,byte_size(Bin) })]
		end

    end.

%%====================================================================
%% Internal functions
%%====================================================================
