%% @author 余健
%% @doc 抓取网页的操作放入该进程，使用倒计时，保证每天都会抓取数据。

-module(spider).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([start_link/0, stop/0, start/0]).

-record(state, {}).

start() ->
	gen_server:cast( ?MODULE, {start} ).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() -> gen_server:call( ?MODULE, stop ).

init([]) -> {ok, #state{}}.


handle_call(stop, _From, State) -> {stop, normal, stopped, State};

handle_call(Request, From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast({start}, State) ->
	spider_conf:start( "start" ),
    {noreply, State}.


handle_info(tick, State) ->
	Tick = spider_fun:getHourTime(6),
	erlang:send_after(Tick, self(), tick),
	spider_conf:start( "everyday" ),
    {noreply, State};

handle_info(Info, State) ->
	
    {noreply, State}.

terminate(Reason, State) ->
    ok.

code_change(OldVsn, State, Extra) ->
    {ok, State}.

