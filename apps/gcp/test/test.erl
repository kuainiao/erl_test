%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%%
%%%-------------------------------------------------------------------
%% coding: utf-8
-module(test).
-author("yujian").

-export([define/0]).

-define(debug, true).
-ifdef(debug).
-define(debug(Error), io:format( "~p ~p ERROR:~p~n", [?MODULE, ?LINE, Error] )).
-else.
-define(debug(Error), ok).
-endif.

define() ->
    Error = "test define ifdef",
    ?debug( Error ).

