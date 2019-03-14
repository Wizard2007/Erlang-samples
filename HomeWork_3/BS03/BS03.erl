%% BS03: Разделить строку на части, с явным указанием разделителя:
%% Пример:
%% 1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
%% <<”Col1-:-Col2-:-Col3-:-Col4-:-Col5”>>
%% 2> bs03:split(BinText, "-:-").
%% [<<”Col1”>>, <<”Col2”>>, <<”Col3”>>, <<”Col4”>>, <<”Col5”>>]

-module(bs03).
-export([split/2]).

split(Bin, Divider) -> 
	%% erlang:display(Divider),
	DividerBin = list_to_binary(Divider),
	%% erlang:display(DividerBin),
	DividerSize = byte_size(DividerBin)*8,
	%% erlang:display(DividerSize),
	<<DividerInt:DividerSize>> = DividerBin,
    %% erlang:display(DividerInt),
	%% erlang:display("---------------------"),
	split(Bin,Bin, 0, DividerInt, DividerSize).

%%split(<<_:24>>, Bin, _, _, _) -> 
%%	%% erlang:display(Bin),
%%	%% erlang:display("End"),		
%% 	[ binary_part(Bin,{0,byte_size(Bin) })];
%% -- search Divider 
split(Rest, Bin, C, DividerInt, DividerSize) -> 
    <<DividerIntLocal:DividerSize,T/binary>> = Rest,
	if(DividerIntLocal == DividerInt) ->
		%% erlang:display(T),		
	    %% erlang:display("True"),
		%% erlang:display(C),
		%% erlang:display(binary_part(Bin,{0,C})),
		[ binary_part(Bin,{0,C})|split(T,T, 0, DividerInt, DividerSize)];
	true ->
		%% -- continue search divider
		%% erlang:display("False"),
		<<_:8,TRet/binary>> = Rest,
		%% erlang:display(TRet),
		%% erlang:display(binary_part(Bin,{0,C})),
		%% erlang:display(byte_size(Bin)),
		if byte_size(Bin) - 1 > 3 ->
			%% erlang:display("true"),
			split(TRet,Bin, C+1, DividerInt, DividerSize);
		true ->
		    %% erlang:display("false"),
			[ binary_part(Bin,{0,byte_size(Bin) })]
		end
		
    end.