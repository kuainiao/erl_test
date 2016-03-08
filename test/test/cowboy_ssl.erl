%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%%-------------------------------------------------------------------
-module(cowboy_ssl).

-export([test_get/0, test_post/0]).

-define(URL_GET_SSL, "https://127.0.0.1:8443").
-define(URL_POST_SSL, "https://127.0.0.1:8443/upload/").

-define(URL_GET, "http://127.0.0.1:8080/file/e5965156b09fc699a7f8892b108ee7e3").
-define(URL_POST, "http://127.0.0.1:8080/upload/").

-define(TEST_MAX_NUMBER, 100000).
-define(PROCESS_NUM, 4096).
% ssl 49.5s 75.9s  76.0s
% http 22.7s 26.1s 24.7s
test_get() ->
    ssl:start(),
    inets:start(),
    T1 = os:system_time(),
    test_get(0),
    io:format("diff time :~p~n", [ os:system_time()-T1 ]).

test_get(?TEST_MAX_NUMBER) -> ok;
test_get(N) ->
    case N rem ?PROCESS_NUM of
        0 ->
            lists_spawn(N);
        _ ->
            ok
    end,
    %est_file:log("/home/yujian/project/test/log/ssl.log", "num:~p~n", [N], write),
    test_get(N+1).

get_file() ->
    httpc:request(?URL_GET),
    ok.

% ssl 50.9s 77.8s
% http 22.0s
test_post() ->
    ssl:start(),
    inets:start(),
    T1 = os:system_time(),
    test_post(0),
    io:format("diff time :~p~n", [ os:system_time()-T1 ]).

test_post(?TEST_MAX_NUMBER) -> ok;
test_post(N) ->
    httpc:request(post, {?URL_POST_SSL, [], [], "a=b&c=d"}, [], []),
    %test_file:log("/home/yujian/project/test/log/ssl.log", "num:~p~n", [N], write),
    test_get(N+1).


lists_spawn(Num) ->
    List = lists:seq(Num, Num + ?PROCESS_NUM - 1),
    Ref = erlang:make_ref(),
    Pid = self(),
    [receive {Ref, Res} -> Res; _ -> ok end || _ <- [spawn(fun() -> Res = get_file(),
        Pid ! {Ref, Res} end) || _INum <- List]].


test() ->
    httpc:request(get, {?URL_POST, [{"tokens", "aabbcc"}], [], []}, [], []).