-module(erl_test_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1, start/0]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    init_cowboy(),

%%    recon_web:start(),

    erl_test_sup:start_link().

stop(_State) ->
    ok.

init_cowboy() ->
    application:start(crypto),
    application:start(ranch),
    application:start(cowlib),
    application:start(cowboy),

    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", cowboy_static, {priv_file, erl_test, "docroot/index.html"}},
            {"/test/[...]", erl_cowboy_handler, []},
            {"/img/[...]", cowboy_static, {priv_dir, erl_test, "docroot/img/"}}

        ]}
    ]),
    {ok, _} = cowboy:start_http(http, 10, [{port, 8000}], [
        {env, [{dispatch, Dispatch}]}
    ]).

start() ->
    application:start(erl_test).
