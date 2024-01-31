-module(user_default).

-export([hex/1]).

hex(Bin) when is_binary(Bin) ->
    hex(erlang:binary_to_list(Bin));
hex(L) when is_list(L) ->
    lists:append([io_lib:format("~2.16.0b", [N]) || N <- L]).
