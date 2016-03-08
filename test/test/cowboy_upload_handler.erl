%% Feel free to use, reuse and abuse the code in this file.

%% @doc Upload handler.
-module(cowboy_upload_handler).


% init(Req, Opts) ->

%     %Headers = cowboy_req:headers(Req),
%     %{ok, _Data, Req3} = cowboy_req:body(Req, Opts),
%     %Head = cow_multipart:form_data(Headers),
%     %io:format("111:~p~n",[[Headers]]),

%     % Req1 = cowboy_req:reply(202, [{<<"content-type">>, <<"text/plain; charset=utf-8">>}], "ok", Req),
%     % Req2 = cowboy_req:set([{connection, close}], Req1),
%     case cowboy_req:body(Req, BodyOpts) of
%         {more, Acc, Req1} ->
%     {ok, Req, Opts}.


-export([init/2]).

init(Req, Opts) ->
    io:format("aaa:~p~n", [[Req]]),
%%    case cowboy_req:has_body(Req) of
%%        true ->
%%            BodyOpts = [{read_timeout, 5000}],
%%            case cowboy_req:body(Req, BodyOpts) of
%%                {ok, Bin0, _Req0} ->
%%                    io:format( "upload:~p~n", [ [Bin0] ] );
%%                {error, Cause} ->
%%                    io:format( "222:~p~n", [ Cause ] )
%%            end;
%%        false ->
%%            io:format( "333:~n" )
%%    end,:
    %Req1 = cowboy_req:reply(200, cowboy_req:set_resp_body("ok", Req)),
    Req2 = cowboy_req:reply(200, [{<<"content-type">>, <<"text/plain">>}], <<"Hello world!">>, Req),
    {ok, Req2, Opts}.
