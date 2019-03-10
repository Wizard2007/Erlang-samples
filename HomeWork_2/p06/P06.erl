%% P06 (*) Определить, является ли список палиндромом:
%% Пример:
%% 1> p06:is_palindrome([1,2,3,2,1]).
%% true


-module(p06).
-export([is_palindrome/1]).

is_palindrome([H|T]) ->
    %%erlang:display("Start"),
    %%erlang:display(H),
    %%erlang:display(T),
    is_palindromeEx(T, [H]);
is_palindrome([]) -> true.

is_palindromeEx([H|T],R) ->
    erlang:display(H),
    erlang:display(T),
    erlang:display(R),
    erlang:display("------------"),
    if 
        [H|T] == R -> true;
        true ->
        if
            R == T -> true;
            true -> is_palindromeEx(T, [H|R])
        end
    end;
is_palindromeEx([],_) ->
    %%erlang:display("Finish"),
    false.
