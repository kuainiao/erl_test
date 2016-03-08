%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 25. 十一月 2015 上午10:06
%%%-------------------------------------------------------------------
-module(rpc_test).

-export([init/0, lookup/1, rpc/0]).
init() ->
    mnesia_test:init().


lookup(Key) ->
    ets:lookup(file_attr, Key).


%% 38s
rpc() ->
    Time = os:system_time(),
    rpc(0),
    io:format("start:~p~nstop:~p~n", [Time, os:system_time()]).

rpc(1000000) -> ok;
rpc(N) ->
    case N rem 100000 of
        0 -> io:format("loading...~p%", [N])
    end,

    rpc:call( 'node@127.0.0.1', rpc_test, lookup, [N] ),
    rpc(N+1).

send() ->
    send(0).

send(1000000) -> ok;
send(N) ->
    N.