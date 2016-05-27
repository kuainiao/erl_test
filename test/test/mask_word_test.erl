%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc 屏蔽字符
%%%
%%% Created : 16. 五月 2016 下午6:49
%%%-------------------------------------------------------------------
-module(mask_word_test).

-export([check/1, test/0]).

-behaviour(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(ETS_TAB_MASK_WORD, ets_tab_mask_word).
-record(ets_tab_mask_word, {
    content
}).
-record(state, {vsn = 0}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    ets:new(?ETS_TAB_MASK_WORD, [named_table, public, {read_concurrency, true}]),

    {ok, S} = file:read_file("/home/yujian/mask_word"),

    List = binary:split(S, <<"**##">>, [global, trim_all]),

    ets:insert(?ETS_TAB_MASK_WORD, #ets_tab_mask_word{content = List}),

    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Request, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State#state{vsn = 1}}.


check(Str) ->
    [#ets_tab_mask_word{content = Content}] = ets:lookup(?ETS_TAB_MASK_WORD, ?ETS_TAB_MASK_WORD),
    check(Str, byte_size(Str), Content).


%% 4000ms
check(_Str, _StrLen, []) -> _Str;
check(Str, StrLen, [MastWord | R]) ->
    case binary:match(Str, MastWord) of
        nomatch -> check(Str, StrLen, R);
        {Index, Len} ->
            First = binary:part(Str, 0, Index),
            Last = binary:part(Str, Index + Len, StrLen - Index - Len),
            NewStr = <<First/binary, "***", Last/binary>>,
            check(NewStr, byte_size(NewStr), R)
    end.



test() ->
    mask_word_test:start_link(),
    T1 = erlang:monotonic_time(),
    AAA = test(1),
    T2 = erlang:monotonic_time(),
    Time = erlang:convert_time_unit(T2 - T1, native, micro_seconds),
    io:format("111:~p~n222:~p~n", [AAA, Time]).

test(1000) -> check(<<"我么那都由一个家名字叫中国，wogan，wocao"/utf8>>);
test(N) ->
    check(<<"我么那都由一个家名字叫中国，wogan，wocao"/utf8>>),
    test(N + 1).
