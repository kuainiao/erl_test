%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 23. 一月 2016 上午11:27
%%%-------------------------------------------------------------------
-module(erl_util).

-export([md5/1, md5_to_str/1, get_path/1, now/0, sec_to_localtime/1, uuid/0, random/1, lists_spawn/3]).

md5(S) ->
    Md5_bin = erlang:md5(S),
    Md5_list = binary_to_list(Md5_bin),
    lists:flatten(list_to_hex(Md5_list)).

list_to_hex(L) ->
    lists:map(fun(X) -> int_to_hex(X) end, L).

int_to_hex(N) when N < 256 ->
    [hex(N div 16), hex(N rem 16)].

hex(N) when N < 10 ->
    $0 + N;

hex(N) when N >= 10, N < 16 ->
    $a + (N - 10).

md5_to_str(Str) ->
    <<M:128/integer>> = crypto:hash(md5, Str),
    int_to_hex(M, 32).
    %lists:flatten(io_lib:format("~32.16.0b", [Mac])).

int_to_hex(I, Len) ->
    Hex = string:to_lower(erlang:integer_to_list(I, 16)),
    LenDiff = Len - length(Hex),
    case LenDiff > 0 of
        true -> string:chars($0, LenDiff) ++ Hex;
        false -> Hex
    end.


%% @doc 只考虑linux路径下
get_path(FilePath) ->
    ModPath = string:tokens(code:which(?MODULE), "/"),
    {NewFilePath, N} = position_path(FilePath, 0),
    ModPathLen = length(ModPath),
    case os:type() of
        {win32, _} -> string:join(lists:sublist(ModPath, ModPathLen - 1 - N) ++ [NewFilePath], "/");
        _ -> "/" ++ string:join(lists:sublist(ModPath, ModPathLen - 1 - N) ++ [NewFilePath], "/")
    end.

%% (相对路径，../的层数)
-spec position_path(FilePath :: string(), N :: integer()) -> {FilePath :: string(), N :: integer()}.
position_path("../" ++ FilePath, N) -> position_path(FilePath, N + 1);
position_path(FilePath, N) -> {FilePath, N}.

now() ->
    os:system_time(seconds).

sec_to_localtime(Times) ->
    MSec = (Times + 8 * 3600) div 1000000,
    Sec = Times - MSec * 1000000,
    calendar:now_to_datetime({MSec, Sec, 0}).

uuid() ->
    Pid = self(),
    Ref = erlang:make_ref(),
    {MegaSecs, Secs, MicroSecs} = erlang:timestamp(),
    Timers = MegaSecs * 1000000000000 + Secs * 1000000 + MicroSecs,
    md5_to_str(term_to_binary({Pid, Ref, Timers})).

random(Max) ->
    <<A:32, B:32, C:32>> = crypto:strong_rand_bytes(12),
    random:seed({A, B, C}),
    random:uniform(Max).


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