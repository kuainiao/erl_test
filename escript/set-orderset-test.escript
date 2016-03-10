#!/usr/bin/env escript
%%! -smp enable -sname erl-test1 -mnesia debug verbose

-define(set_table, set_table).
-define(ordered_set_table, ordered_set_table).

main([StrNum, StrType]) ->
    try
    N = list_to_integer(StrNum),
    Type = list_to_atom(StrType),
    init_table(),
    insert_data(N , Type)
  catch
    _:Error ->
      io:format("Error: ~p~n", [Error]),
      manual()
  end,
  exit();
main(_) ->
  manual().

manual() ->
  io:format("input data number and type eg:~n
  ./set-orderset-test.erl 100000 int ~n", []).


exit() ->
  halt(1).

init_table() ->
  ets:new(?set_table, [set, named_table, public]),
  ets:new(?ordered_set_table, [ordered_set, named_table, public]).


insert_data(N, Type) ->
  T1 = timer_start(),
  Data = data(N, Type),
  F = fun(Table) ->
    lists:foreach(fun(Item) ->
      ets:insert(Table, Item)
      end, Data) end,
  timer_stop(T1, "process data"),
  Time1 = timer:tc(F,[?set_table]),
  Time2 = timer:tc(F,[?ordered_set_table]),
  io:format("insert ~p data to ~p time: ~p~n", [N, ?set_table, Time1]),
  io:format("insert ~p data to ~p time: ~p~n", [N, ?ordered_set_table, Time2]).


timer_start() ->
  erlang:now().

timer_stop(T1, Arg) ->
  io:format("~p cost:~p us~n", [Arg, timer:now_diff(erlang:now(), T1)]).

data(N, binary) ->
  lists:map(fun(_I) ->
    {msgid(), 1}
  end, lists:seq(1, N));
data(N, int) ->
  lists:map(fun(I) ->
    {I, I}
  end, lists:seq(1, N)).

msgid() ->
  Initial = random:uniform(62) - 1,
  msgid(<<Initial>>, 7).
msgid(Bin, 0) ->
  Chars = <<"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890">>,
  << <<(binary_part(Chars, B, 1))/binary>> || <<B>> <= Bin >>;
msgid(Bin, Rem) ->
  Next = random:uniform(62) - 1,
  msgid(<<Bin/binary, Next>>, Rem - 1).