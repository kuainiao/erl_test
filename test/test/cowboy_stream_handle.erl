%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%%-------------------------------------------------------------------
-module(cowboy_stream_handle).

% -export([init/2]).
%-behaviour(cowboy_http_handler).
% init(Req, Opts) ->
%     test_file:log( "111...Opts:~p~n", [ Opts ], append ),
%     Req2 = multipart(Req),
%     {ok, cowboy_req:reply(200, Req2), Opts}.

% multipart(Req) ->
%     test_file:log( "222...multipart:~p~n", [tuple_size(cowboy_req:part(Req))], append ),
%     case cowboy_req:part(Req) of
%         {ok, [{<<"content-length">>, BinLength}], Req2} ->
%             test_file:log( "333...cowboy_req:part/1:~p~n", [BinLength], append ),
%             Length = list_to_integer(binary_to_list(BinLength)),
%             {Length, Req3} = stream_body(Req2, 0),
%             multipart(Req3);
%         {done, Req2} ->
%             test_file:log( ["444...cowboy_req:part/1 done."], append ),
%             Req2
%     end.

% stream_body(Req, N) ->
%     test_file:log( "555...stream_body:~p~n", [ N ], append ),
%     case cowboy_req:part_body(Req) of
%         {ok, Data, Req2} ->
%             test_file:log( "666...cowboy_req:part_body/1 ok:~p~n", [ N ], append ),
%             {N + byte_size(Data), Req2};
%         {more, Data, Req2} ->
%             test_file:log( "666...cowboy_req:part_body/1 more:~p~n", [ N ], append ),
%             stream_body(Req2, N + byte_size(Data))
%     end.


-export([init/2]).
-export([info/3]).
-export([terminate/3]).

init(Req, Opts) ->
    erl_file:log( "111...Opts:~p~n", [ Opts ], append ),
    receive after 100 -> ok end,
    self() ! stream,
    {cowboy_loop, Req, undefined, 100}.

info(stream, Req, undefined) ->
    erl_file:log( "222...Opts:~p~n", [ undefined ], append ),
    stream(Req, 1, <<>>).

stream(Req, ID, Acc) ->
    erl_file:log( "333...ID:~p~n", [ ID ], append ),
    case cowboy_req:body(Req) of
        {ok, <<>>, Req2} ->
            {stop, cowboy_req:reply(200, Req2), undefined};
        {_, Data, Req2} ->
            parse_id(Req2, ID, << Acc/binary, Data/binary >>)
    end.

parse_id(Req, ID, Data) ->
    erl_file:log( "444...ID:~p~n", [ ID ], append ),
    case Data of
        << ID:32, Rest/bits >> ->
            parse_id(Req, ID + 1, Rest);
        _ ->
            stream(Req, ID, Data)
    end.

terminate(stop, _, _) ->
    erl_file:log( "555...stop:~p~n", [ stop ], append ),
    ok.


