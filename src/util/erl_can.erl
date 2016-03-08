%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 23. 一月 2016 上午11:32
%%% 验证，can can can do do do，当某一个can没有验证通过时，返回错误
%%%-------------------------------------------------------------------
-module(erl_can).

-export([can/1]).

%%can:can([
%%    fun() -> ping_can:check_token(BodyParse, Cmd) end,
%%    fun() -> ping_can:check_times(Times) end,
%%    fun() -> ping_can:check_md5(CheckMd5, Times, Cmd) end
%%]).

can(FunList) ->
    can(FunList, []).

can([], Arg) -> {ok, lists:reverse(Arg)};
can([Fun | FunList], Arg) ->
    case Fun() of
        {error, Err} -> {error, Err};
        ok -> can(FunList, [[] | Arg]);
        {ok, Data} -> can(FunList, [Data | Arg])
    end.

