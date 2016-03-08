%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 01. 十二月 2015 上午11:38
%%%-------------------------------------------------------------------
-module(leofs_test).

-compile(export_all).

-define(URL, "http://192.168.1.16/").
-define(MAX_NUMBER, 1).

%erl -setcookie 669ceba8de9704653d40f55ae763098d -name observer@192.168.1.101
% special_info:31a8c2c6334a00acb93cad0f3fb3db8f
% curl -H "special-info:31a8c2c6334a00acb93cad0f3fb3db8f" -o text.txt http://192.168.1.16:8080/efe9ae79ae552113503a9f67e56477c5
test() ->
    inets:start(),
    eredis_pool:start(), 
    % Nums = lists:seq(1, ?MAX_NUMBER),
    % FunRedis = fun(Num) ->
    %     eredis_pool:q({global, pool}, ["SET", Num, "bar"])
    %            end,
    % lists:map(FunRedis, Nums),
    Time = lists_spawn(1, 0, os:system_time()),
    io:format("diff time:~p~n", [Time]).



%% 100 -> 629.722209437 808.473307317
%% 200 -> 1720.285410536


%% start table_size 14957
%% 
-define(PROCESS_NUM, 1).
lists_spawn(Num, Time, _Now) when Num >= 2 -> Time;
lists_spawn(Num, Time, Now) ->
    erl_file:log("/home/yujian/project/test/log/num.txt", "num:~p~n", [ Num ], write),
    Str = "this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         this is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\nthis is test\n
         test stability 2",
    %Str = "this is test add 1",
    Fun = fun(I1) ->
        lists:flatten([integer_to_list(I1 * 1000000), Str, Str, Str, Str, Str, Str, Str, Str, Str,
            Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str,
            Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str,
            Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str,
            Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str, Str,
            Str])
          end,

    List = [{?URL ++ test_test:md5(Fun(I)), integer_to_list(I), Fun(I)} || I <- lists:seq((Num - 1) * ?PROCESS_NUM + 1, Num * ?PROCESS_NUM)],
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
                Res = httpc(Url, IStr, Content),
                Pid ! {Ref, Res}
            end) || {Url, IStr, Content} <- List]
    ],
    EndTime = os:system_time(),
    SleepTime = (600000000 - (EndTime - Now)) div 1000000,
    io:format( "time:~p~n", [[SleepTime, EndTime, Now]] ),
    if
        SleepTime > 0 -> timer:sleep(SleepTime);
        true -> ok
    end,
    lists_spawn(Num + 1, (EndTime - StartTime) + Time, os:system_time()).

httpc(Url, Num, Content) ->
    case httpc:request(post, {Url, [{"token", Num}], [], Content}, [{timeout, 3000}], []) of
        {ok, Info} ->
            io:format( "info:~p~n", [Info] ),
            ok;
        {error, Other} ->
            erl_file:log("error:~p~n", [ Other ], append),
            io:format("error:~p~n", [Other])
    end.
