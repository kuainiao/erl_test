%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%% Created : 15. 二月 2016 上午9:44
%%%-------------------------------------------------------------------
-module(gm_test).

-export([convert/0]).

convert() ->
    {ok, S} = file:read_file("./test.jpg"),
    file:write_file("./input", S),
    os:cmd("gm convert input -thumbnail '60x60' output_1.png"),
    os:cmd("gm convert input -thumbnail '120x120' output_2.png"),
    os:cmd("gm convert input -thumbnail '512x512' output_3.png"),
    os:cmd("gm convert input -thumbnail '800x800' output_4.png"),
    file:read_file("./output_1.png").