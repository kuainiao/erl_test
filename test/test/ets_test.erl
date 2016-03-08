%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 04. 三月 2016 下午4:44
%%%-------------------------------------------------------------------
-module(ets_test).

-compile(export_all).

-record(ets_test, {
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

init() ->
    ets:new(ets_test, [set,named_table, {keypos, #ets_test.key}]),
    io:format( "set insert:~n" ),
    insert(),
    io:format( "set select:~n" ),
    select(),
    io:format( "ets info:~p~n", [ ets:info(ets_test) ] ),
    ets:delete(ets_test),
    ets:new(ets_test, [ordered_set,named_table, {keypos, #ets_test.key}]),
    io:format( "ordered_set insert:~n" ),
    insert(),
    io:format( "ordered_set select:~n" ),
    select(),
    io:format( "ets info:~p~n", [ ets:info(ets_test) ] ),
    ets:delete(ets_test).

insert() ->
    T1 = erlang:timestamp(),
    insert(0),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format( "cost time:~p us~n~n", [DiffTime] ).

insert(1000000) -> ok;
insert(N) ->
    Key = N,
    ets:insert(ets_test, #ets_test{key=Key}),
    insert(N+1).

%%    Fun = fun(I, Num) ->
%%        NewI = Num*100+I,
%%        ets:insert(ets_test, #ets_test{key=NewI})
%%          end,
%%    T1 = erlang:timestamp(),
%%    test_pub:lists_spawn({0, 1000}, 1000, Fun),
%%    DiffTime = timer:now_diff(erlang:timestamp(), T1),
%%    io:format("cost us_time:~p~n~n", [DiffTime]).


select() ->
    T1 = erlang:timestamp(),
    select(0),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format( "cost time:~p us~n~n", [DiffTime] ).

select(100000) -> ok;
select(N) ->
    Key = random:uniform(100000),
%%    Key = N,
    ets:lookup                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  (ets_test, Key),
    select(N+1).

%%    Fun = fun(I, Num) ->
%%        Key = I+random:uniform(Num+1),
%%        ets:lookup(ets_test, Key)
%%          end,
%%    T1 = erlang:timestamp(),
%%    test_pub:lists_spawn({0, 1000}, 1000, Fun),
%%    DiffTime = timer:now_diff(erlang:timestamp(), T1),
%%    io:format("cost ms_time:~p~n", [DiffTime]).

dict() ->
    D = dict:new(),
    T1 = erlang:timestamp(),
    dict(D, 1),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format( "cost time:~p us~n~n", [DiffTime] ).

dict(_D,100000) -> ok;
dict(D,N) ->
    D1 = dict:append(N,N,D),
    dict(D1, N+1).

tree() ->
    T = gb_trees:empty(),
    T1 = erlang:timestamp(),
    tree(T, 1),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format( "cost time:~p us~n~n", [DiffTime] ).

tree(_T, 1000000) -> ok;
tree(T, N) ->
    T1 = gb_trees:insert(N,N,T),
    tree(T1, N+1).