%% Вот пример того, как можно проитерировать по бинарю. Функция отбрасывает все пробелы в начале строки.

-module(bin_utils).
-export([skip_spaces/1]).

skip_spaces(<<" ", Rest/binary>>) ->
    skip_spaces(Rest);
skip_spaces(Bin) ->
    Bin.