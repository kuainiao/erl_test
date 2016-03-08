%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 24. 二月 2016 上午10:00
%%%-------------------------------------------------------------------
-module(magick_test).

-compile(export_all).

test() ->
    {ok, S} = file:read_file("./1.jpg"),
    T1 = erlang:timestamp(),
%%    test(0, S),
    test(S),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format("111:~p~n", [DiffTime]).


test(1000, _ImgBin) -> ok;

test(N, ImgBin) ->
    leofs_magick:convert(ImgBin),
    test(N + 1, ImgBin).

test(ImgBin) ->
    Fun = fun(_I) ->
        leofs_magick:convert(ImgBin),
%%        file:write_file("./1", Img1),
%%        file:write_file("./2", Img2),
%%        file:write_file("./3", Img3),
%%        file:write_file("./4", Img4),
        ok
          end,
    lists_spawn({0, 10}, 100, Fun).

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
            end) || I <- lists:seq(0, SpawnNum)]
    ],

    lists_spawn({Num + 1, MaxNum}, SpawnNum, Fun).
