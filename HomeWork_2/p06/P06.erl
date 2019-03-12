%% P06 (*) Определить, является ли список палиндромом:
%% Пример:
%% 1> p06:is_palindrome([1,2,3,2,1]).
%% true

-module(p06).
-export([is_palindrome/1]).

is_palindrome(L) -> reverse(L) == L.

reverse(L) -> reverse(L,[]).

reverse([H|T],Acc) -> 
   reverse(T,[H|Acc]);
reverse([],T) -> T.

