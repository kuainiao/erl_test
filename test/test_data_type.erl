%%%-------------------------------------------------------------------
%%% @author yj
%%% @doc
%%%
%%% Created : 04. 八月 2016 下午5:37
%%%-------------------------------------------------------------------
-module(test_data_type).

-export([test/0]).


test() ->
    S = s(sets:new(), 0),
    D = d(dict:new(), 0),
    T = t(gb_trees:empty(), 0),
    L = l([], 0),
    
    io:format("start~n"),
    
    T1 = erlang:timestamp(),
    test_sets(S, 0),
    DiffTime = timer:now_diff(erlang:timestamp(), T1),
    io:format("test_sets ms_time:~p~n", [DiffTime]),
    
    T2 = erlang:timestamp(),
    test_dict(D, 0),
    DiffTime2 = timer:now_diff(erlang:timestamp(), T2),
    io:format("test_dict ms_time:~p~n", [DiffTime2]),
    
    T3 = erlang:timestamp(),
    test_trees(T, 0),
    DiffTime3 = timer:now_diff(erlang:timestamp(), T3),
    io:format("test_trees ms_time:~p~n", [DiffTime3]),
    
    T4 = erlang:timestamp(),
    test_list(L, 0),
    DiffTime4 = timer:now_diff(erlang:timestamp(), T4),
    io:format("test_list ms_time:~p~n", [DiffTime4]).


s(S, 600) -> S;
s(S, Num) ->
    S1 = sets:add_element(Num, S),
    s(S1, Num + 1).

test_sets(S, 1000000) -> S;
test_sets(S, Num) ->
    sets:fold(fun(I, _Acc) -> I + 1 end, [], S),
    test_sets(S, Num + 1).

d(D, 600) -> D;
d(D, Num) ->
    D1 = dict:append(Num, Num, D),
    d(D1, Num + 1).

test_dict(D, 1000000) -> D;
test_dict(D, Num) ->
    dict:fold(fun(I, _V, _Acc) -> I + 1 end, [], D),
    test_dict(D, Num + 1).


t(T, 600) -> T;
t(T, Num) ->
    T1 = gb_trees:insert(Num, Num, T),
    t(T1, Num + 1).

test_trees(T, 1000000) -> T;
test_trees(T, Num) ->
    gb_trees:map(fun(_K, V) -> V + 1 end, T),
    test_trees(T, Num + 1).


l(L, 600) -> L;
l(L, Num) ->
    l([{Num, Num} | L], Num + 1).

test_list(L, 1000000) -> L;
test_list(L, Num) ->
    lists:map(fun({_K, V}) -> V + 1 end, L),
    test_list(L, Num + 1).