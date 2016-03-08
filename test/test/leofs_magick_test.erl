%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 29. 二月 2016 上午11:49
%%%-------------------------------------------------------------------
-module(leofs_magick_test).

-compile(export_all).

start() -> t().

t() ->
    {ok, S} = file:read_file("./img/1.jpg"),
    [I1, I2, I3] = leofs_magick:convert(S),
    file:write_file("./img_to/output_1", I1),
    file:write_file("./img_to/output_2", I2),
    file:write_file("./img_to/output_3", I3).


test() ->
    {ok, S} = file:read_file("./img/1.jpg"),
    T1 = erlang:timestamp(),

    test(S),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format("cost ms_time:~p~n", [DiffTime]).


test(ImgBin) ->
    Fun = fun(_I) ->
%%        [I1, I2, I3] = leofs_magick:convert(ImgBin),
%%        file:write_file("./output_1", I1),
%%        file:write_file("./output_2", I2),
%%        file:write_file("./output_3", I3),
        leofs_magick:convert(ImgBin),
        ok
          end,
    lists_spawn({0, 1}, 1000, Fun).

lists_spawn({_MaxNum, _MaxNum}, _SpawnNum, _Fun) -> ok;

lists_spawn({Num, MaxNum}, SpawnNum, Fun) ->
    Ref = erlang:make_ref(),
    Pid = self(),

    [
        receive
            {Ref, Res} -> Res;
            _ -> ok
        end || _ <-
        [spawn(
            fun() ->
                Res = Fun(I),
                Pid ! {Ref, Res}
            end) || I <- lists:seq(1, SpawnNum)]
    ],

    lists_spawn({Num + 1, MaxNum}, SpawnNum, Fun).