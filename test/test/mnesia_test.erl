%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 18. 十一月 2015 上午9:44
%%%-------------------------------------------------------------------
-module(mnesia_test).

-compile( export_all ).

-record(file_attr, {
    file,
    attr_create_times
}).

-record(file_bag, {
    date,
    file
}).

init() ->
    application:set_env(mnesia, dc_dump_limit, 40),
    application:set_env(mnesia, dump_log_write_threshold, 100000),
    mnesia:stop(),
    mnesia:delete_schema([node()]),
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table(file_attr, [{disc_only_copies, [node()]}, {attributes, record_info(fields, file_attr)}]),
    mnesia:create_table(file_bag, [{disc_only_copies, [node()]}, {type, bag}, {attributes, record_info(fields, file_bag)}]),
    T1 = erlang:timestamp(),
    insert(),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format("cost ms_time:~p~n", [DiffTime]).

insert() ->
%%    Fun = fun(BagId) ->
%%        Start = (BagId - 1) * 100000 + 1,
%%        [mnesia:dirty_write(file_attr, #file_attr{file = I, attr_create_times = BagId}) || I <- lists:seq(Start, Start + 100000)]
%%          end,
%%    lists:map(Fun, lists:seq(1, 20)),
%%    Fun2 = fun(BagId) ->
%%        Start = (BagId - 1) * 100000 + 1,
%%        [mnesia:dirty_write(file_bag, #file_bag{date = BagId, file = I}) || I <- lists:seq(Start, Start + 100000)]
%%           end,
%%    lists:map(Fun2, lists:seq(1, 20)).

    Fun = fun(I, Num) ->
        NewI = Num*100+I,
        mnesia:dirty_write(file_attr, #file_attr{file = NewI, attr_create_times = NewI})
          end,
    lists_spawn({0, 1000}, 100, Fun).


%% 数据库两张表 每张100w数据， 数据库文件大小file_attr.DAT 108MB
%% 循环1000次，每次1000并发读
%% 1000 1000 -> 3.153014 3.213719 %只select一个key
%% 1000 1000 -> 17.208135 %selelct 1-1000 key
%% 1000 1000 -> 71.017049 %select 1-100w key
select() ->
    Fun = fun(_I, _Num) ->
%%        mnesia:dirty_read(file_attr, 1)
%%        NewI = _Num*1000+_I,
        dets:lookup(file_attr, 100000)
          end,
    T1 = erlang:timestamp(),
    lists_spawn({0, 1000}, 1000, Fun),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format("cost ms_time:~p~n", [DiffTime]).

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
                Res = Fun(I, Num),
                Pid ! {Ref, Res}
            end) || I <- lists:seq(1, SpawnNum)]
    ],

    lists_spawn({Num + 1, MaxNum}, SpawnNum, Fun).



%%
%%foldl() ->
%%    io:format( "start:~p~n", [ erlang:system_time() ] ),
%%
%%    update_attr(100000),
%%    io:format( "stop :~p~n", [ erlang:system_time() ] ).


%%update_attr(200000) -> ok;
%%update_attr(N) ->
%%    %update(N),
%%    update_bag(N),
%%    update_attr(N+1).
%%
%%% 1.492832831
%%update(N) ->
%%    dets:insert(file_attr, #file_attr{file=N, attr_create_times=21}).
%%
%%%69.078583856
%%update_bag(N) ->
%%    case dets:lookup(file_attr, N) of
%%        [] -> ok;
%%        [#file_attr{attr_create_times = Time}] ->
%%            dets:delete_object(file_bag, #file_bag{date=Time, file = N}),
%%            NowDate = erlang:date(),
%%            dets:insert(file_bag, #file_bag{date=NowDate, file = N})
%%
%%    end,
%%    dets:insert(file_attr, #file_attr{file=N, attr_create_times=21}).


