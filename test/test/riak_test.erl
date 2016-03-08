%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%%-------------------------------------------------------------------
-module(riak_test).

-export([test/0]).

-define(PROCESS_NUM, 10000).
-define(TEST_MAX_NUMBER, 100001).
-define(MAX_POOL_NUM, 32).
test() ->
    T1 = erlang:system_time(),
    FunPool = fun(_I) ->
        {ok, Pid} = riakc_pb_socket:start_link("127.0.0.1", 8087),
        Pid
    end,
    PidPollList = lists:map(FunPool, lists:seq(1, ?MAX_POOL_NUM)),

    test(PidPollList, 1),
    T2 = erlang:system_time() - T1,
    io:format("cost time:~p....one opearator cost time:~p~n", [T2, (T2/1000000000)]).

test(_PidPollList, ?TEST_MAX_NUMBER) -> ok;
%% test(PidPool, Num) ->
%%     case Num rem ?PROCESS_NUM of
%%         0 ->
%%             List = lists:seq(Num, Num + ?PROCESS_NUM - 1),
%%             Ref = erlang:make_ref(),
%%             Pid = self(),
%%             [receive {Ref, Res} -> Res; _ -> ok end || _ <- [spawn(fun() -> Res = insert(PidPool, INum),
%%                 Pid ! {Ref, Res} end) || INum <- List]];
%%         _ ->
%%             ok
%%     end,
%%     test(PidPool, Num + 1).

test(PidPoolList, Num) ->
    PoolIndex =
        case Num rem ?MAX_POOL_NUM of
            0 -> ?MAX_POOL_NUM;
            Index -> Index
        end,
    PidPool = lists:nth(PoolIndex, PidPoolList),
    delete(PidPool, Num),
    % insert(PidPool, Num),

    test(PidPoolList, Num + 1).

%% 10000 -> 8.6s
%% 100000 -> 336s

insert(PidPool, Num) ->
    Value = erlang:make_tuple(15, Num),
    Bucket = Key = Num,
    Obj = riakc_obj:new(integer_to_binary(Bucket), integer_to_binary(Key), Value),
    riakc_pb_socket:put(PidPool, Obj).

%% 10000 -> 40s
%% 100000 -> 109s
%% 1000000 -> 979s
delete(PidPool, Num) ->
    riakc_pb_socket:delete(PidPool, integer_to_binary(Num), integer_to_binary(Num)).


select(_PidPool, _Key) ->
    ok.