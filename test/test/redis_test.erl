%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 22. 三月 2016 下午5:48
%%%-------------------------------------------------------------------
-module(redis_test).

-compile(export_all).

test() ->
    eredis_pool:start(),
    T1 = timer:tc(fun() -> insert() end),
    io:format("insert cost time:~p~n", [T1]),

    T2 = timer:tc(fun() -> select() end),
    io:format("select cost time:~p~n", [T2]),

    T4 = timer:tc(fun() -> update() end),
    io:format("update cost time:~p~n", [T4]),

    T3 = timer:tc(fun() -> delete() end),
    io:format("delete cost time:~p~n", [T3]).

%% string hash order_set
insert() ->
    All = lists:seq(1, 50000),
    Column = lists:seq(1, 20),
    Fun = fun(Num) ->
%%        Pipeline = [["HMSET", Num, N, Num] || N <- Column],
%%        eredis_pool:qp({global, pool}, Pipeline)

        Data = lists:append([[N, Num] || N <- Column]),
        eredis_pool:q({global, pool}, ["HMSET", Num] ++ Data)
          end,
    lists:map(Fun, All),
    ok.

select() ->
    All = lists:seq(1, 50000),
    Column = lists:seq(1, 20),
    Fun = fun(Num) ->
        eredis_pool:q({global, pool}, ["HMGET", Num] ++ Column)
          end,
    lists:map(Fun, All),
    ok.

update() -> insert().

delete() ->
    All = lists:seq(1, 50000),
    Column = lists:seq(1, 20),
    Fun = fun(Num) ->
        eredis_pool:q({global, pool}, ["HDEL", Num] ++ Column)
          end,
    lists:map(Fun, All),
    ok.