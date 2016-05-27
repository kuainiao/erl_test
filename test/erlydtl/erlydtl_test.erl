%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%%
%%% Created : 27. 五月 2016 下午3:51
%%%-------------------------------------------------------------------
-module(erlydtl_test).

-export([test/0]).


test() ->
    erlydtl:compile("html.dtl", html, [{outdir, ""}]),
    {ok, Html} = html:render([{head, <<"这是一个erlydtl测试"/utf8>>}, {list, [{"a", "b"}, {"c", "d"}]}]),
    file:write_file("./html.html", Html).
