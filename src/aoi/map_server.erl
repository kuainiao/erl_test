%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc 像素为单位， 一格10像素
%%%
%%% Created : 23. 六月 2016 下午4:53
%%%-------------------------------------------------------------------
-module(map_server).

-behaviour(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


-define(MAP_R, 3000). %地图半径 格
-define(PLAYER_SPEED_INIT, 10). %10格/s
-define(PLAYER_BODY_INIT_LEN, 10).

-define(PLAYER_ANGLE, 0). %转弯，针对全局角度
-define(NPC_BODY_INIT, 1).%初始化身体宽
-define(CAPTURE_RANGE, 2).%抓捕范围，在正前方距离多少格可以被抓过来

-define(FPS, 30).

-record(item, {
    type = 1,   %1npc 2玩家蛇的非头部分
    priv_location,
    next_location = 0
}).

-record(state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).


init([]) ->
    init(),
    {ok, #state{}}.


handle_call(_Request, _From, State) ->
    {reply, ok, State}.


handle_cast(_Request, State) ->
    {noreply, State}.


handle_info(send_data, State) ->
    Npc = get(npc),
    RoleMy = get(role_my),
    Socket = get(socket),
    gen_tcp:send(Socket, [Npc, RoleMy]),
    {noreply, State};

handle_info(player_join_map, State) ->
    init_player(),

    Npc = get(npc),
    RoleMy = get(role_my),
    Socket = get(socket),
    gen_tcp:send(Socket, [Npc, RoleMy]),
    {noreply, State};

handle_info({move, Angle}, State) ->


    {noreply, State};


handle_info(_Info, State) ->
    {noreply, State}.


terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% 生成小圆点, 先随机块，在随机分布数量, 以直径的正方形，随机数量时判断是否过界
%% 小圆点，不能重叠，蛇死后也不能重叠，可以加数值
-define(npc_chunk_count, 400). %圆圈地图块的数量
-define(npc_num_count, 6000).  %一个大块总计由6000格组成

-define(TOTLE_NPC, totle_npc).

init() ->
    Chunk = erl_random:random(400),
    random_chunk(Chunk, 0).


random_chunk(CountChunk, CountChunk) -> ok;
random_chunk(CountChunk, Num) ->
    Chunk = erl_random:random(?npc_chunk_count),
    {X, Y} = chunk_coordinate(Chunk),

    Count = erl_random:random(?npc_num_count),
    random_npc(Count, 0, X, Y),
    random_chunk(CountChunk, Num + 1).


random_npc(_Count, _Count, _MaxX, _MaxY) -> ok;

random_npc(Count, Num, MaxX, MaxY) when MaxX > 0 andalso MaxY > 0 ->
    LocationX = erl_random:random(MaxX),
    LocationY = erl_random:random(MaxY),
    put({LocationX, LocationY}, #item{}),
    random_npc(Count, Num + 1, MaxX, MaxY);

random_npc(Count, Num, MaxX, MaxY) when MaxX < 0 andalso MaxY > 0 ->
    LocationX = erl_random:random(MaxX),
    LocationY = erl_random:random(MaxY),
    put({-LocationX, LocationY}, #item{}),
    random_npc(Count, Num + 1, MaxX, MaxY);

random_npc(Count, Num, MaxX, MaxY) when MaxX < 0 andalso MaxY < 0 ->
    LocationX = erl_random:random(MaxX),
    LocationY = erl_random:random(MaxY),
    put({-LocationX, -LocationY}, #item{}),
    random_npc(Count, Num + 1, MaxX, MaxY);

random_npc(Count, Num, MaxX, MaxY) when MaxX > 0 andalso MaxY < 0 ->
    LocationX = erl_random:random(MaxX),
    LocationY = erl_random:random(MaxY),
    put({LocationX, -LocationY}, #item{}),
    random_npc(Count, Num + 1, MaxX, MaxY).


chunk_coordinate(Chunk) when Chunk > 0 and Chunk =< 100 -> {3000, 3000};
chunk_coordinate(Chunk) when Chunk > 100 and Chunk =< 200 -> {-3000, 3000};
chunk_coordinate(Chunk) when Chunk > 200 and Chunk =< 300 -> {-3000, -3000};
chunk_coordinate(Chunk) when Chunk > 300 and Chunk =< 400 -> {3000, -3000}.



-record(body, {
    location,
    priv_location,
    next_location = 0
}).


-record(player, {
    model,
    speed,
    direction,
    head,   %%
    next_location,   %%[{}]
    body_len = 10 %不带头部， 初始化有10节
}).

init_player() ->
    Model = erl_random:random(6),
    X = erl_random:random(2000),
    Y = erl_random:random(2000),
    X - 1000,
    Y - 1000,
    Angle = erl_random:random(360),
    Head = player_location().



%%最高点， 最低点，最左端， 最右端， 取整占用的格子数量。
player_location(Weight, X, Y, Angle) ->
    R = (Weight / 2),
    MaxX = X,
    MaxY = Y + R / math:sin(Angle - 90),

    MinX = X + math:sin(Angle + 90),
    MinY = Y + math:sin(Angle + 90),

    LeftX = X + R / math:cos(Angle + 90),
    LeftY = Y + math:sin(Angle + 90),

    RightX = X + R / math:sin(Angle - 90),
    RightY = Y + R / math:sin(Angle - 90),

    XPoint = lists:seq(LeftX, RightX),
    YPoint = lists:seq(MinY, MaxY),
    [{X1, Y1} || X1 <- XPoint, Y1 <- YPoint].



is_out_map(X, Y) ->
    X * X + Y * Y >= ?MAP_R * ?MAP_R.










