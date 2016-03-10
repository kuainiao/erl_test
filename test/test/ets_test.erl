%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc ets 测试 有序ordered_set 无序set,
%%%         key为字符串长度32 set:1764713us  ordered_set:2143611us 长度8 set:606130us ordered_set:983022us
%%%         key为int set:497617 ordered_set:324761
%%%         key为binary set:614133 ordered_set:352321
%%%         结论：有序的插入比无序插入要快
%%% Created : 04. 三月 2016 下午4:44
%%%-------------------------------------------------------------------
-module(ets_test).

-compile(export_all).

-define(set_test, set_test).
-define(ordered_set_test, ordered_set_test).

-record(?set_test, {
    key,
    value0 = "123"
%%    value = "this is ets test this is ets test this is ets test this is ets test",
%%    value1 = "this is ets test this is ets test this is ets test this is ets test",
%%    value2 = "this is ets test this is ets test this is ets test this is ets test",
%%    value3 = "this is ets test this is ets test this is ets test this is ets test",
%%    value4 = "this is ets test this is ets test this is ets test this is ets test",
%%    value5 = "this is ets test this is ets test this is ets test this is ets test",
%%    value6 = "this is ets test this is ets test this is ets test this is ets test",
%%    value7 = "this is ets test this is ets test this is ets test this is ets test",
%%    value8 = "this is ets test this is ets test this is ets test this is ets test"
}).

-record(?ordered_set_test, {
    key,
    value0 = "123"
}).



init() ->
    ets:new(?set_test, [set, named_table, {keypos, #?set_test.key}]),
    ets:new(?ordered_set_test, [ordered_set, named_table, {keypos, #?ordered_set_test.key}]),
    insert(500000).

insert(Num) ->
    SetRecords = records(?set_test, Num),
    OrderedSetRecords = records(?ordered_set_test, Num),

    DiffTime1 = timer:tc(fun() -> lists:foreach(fun(Record) -> ets:insert(?set_test, Record) end, SetRecords) end),
    io:format("set insert:~p us~nets info:~p~n", [DiffTime1, ets:info(?set_test)]),

    DiffTime2 = timer:tc(fun() -> lists:foreach(fun(Record) -> ets:insert(?ordered_set_test, Record) end, OrderedSetRecords) end),
    io:format("ordered_set insert:~p us~nets ifo:~p~n", [DiffTime2, ets:info(?ordered_set_test)]).


records(?set_test, Num) ->
%%    erl_util:uuid(),
%%    string:sub_string(erl_util:uuid(), 1, 10)
%%    integer_to_binary(_I)
    lists:map(fun(_I) -> #?set_test{key = string:sub_string(erl_util:uuid(), 1, 8)} end, lists:seq(1, Num));
records(?ordered_set_test, Num) ->
    lists:map(fun(_I) -> #?ordered_set_test{key = string:sub_string(erl_util:uuid(), 1, 8)} end, lists:seq(1, Num)).

%%    Fun = fun(I, Num) ->
%%        NewI = Num*100+I,
%%        ets:insert(ets_test, #ets_test{key=NewI})
%%          end,
%%    T1 = erlang:timestamp(),
%%    test_pub:lists_spawn({0, 1000}, 1000, Fun),
%%    DiffTime = timer:now_diff(erlang:timestamp(), T1),
%%    io:format("cost us_time:~p~n~n", [DiffTime]).
