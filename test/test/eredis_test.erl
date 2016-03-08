%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 07. 十二月 2015 上午9:52
%%%-------------------------------------------------------------------
-module(eredis_test).

-compile(export_all).

test() ->
    eredis_pool:start(),
    lists_spawn(1, 0).


-define( PROCESS_NUM, 1 ).
lists_spawn(Num, Time) when Num >= 2 -> Time;
lists_spawn(Num, Time) ->
    List = lists:seq((Num-1)*?PROCESS_NUM+1, Num*?PROCESS_NUM),
    Ref = erlang:make_ref(),
    Pid = self(),
    StartTime = os:system_time(),
    [
        receive
            {Ref, Res} -> Res;
            _ -> ok
        end || _ <-
        [spawn(
            fun() ->
                Res = do_redis(Num1),
                Pid ! {Ref, Res}
            end) || Num1 <- List]
    ],
    EndTime = os:system_time(),
    lists_spawn(Num+1, (EndTime - StartTime) + Time).

do_redis(Num) ->
    Res = eredis_pool:q({global, pool}, ["DEL", Num]),
    io:format( "del redis:~p~n", [ Res ] ).



