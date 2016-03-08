%% @author 余健<yujian1018@163.com>
%% @doc 产生数据发回给页面

-module(gcp_event).
-include("../include/gcp_def.hrl").
-export([api/3]).

-define( DispatchEvent, [{"account", gcp_account}, {"comment", gcp_ctrl}] ).

api( A, Event, Args ) ->
	% try 
		Res = case lists:keyfind( Event, 1, ?DispatchEvent ) of
					{"account", gcp_account} -> gcp_account:handle(A, Args);
					{Event, Module} -> Module:handle(Args);
					false ->
						?debug(Event),
						{error, ?REPLY_NO_THIS_EVENT, "no this event"}
				end,
		case Res of
			ok -> rfc4627:encode({obj, [{"state", ?REPLY_SUCCISE}, {"msg", <<"ok">>}]});
			{ok, Json} -> rfc4627:encode({obj, [{"state", ?REPLY_SUCCISE}, {"msg", Json}]});
			{ok, erlang_term, ErlangTerm} -> {ok, ErlangTerm};
			{error, ErrNum} when is_integer( ErrNum ) -> ?Package_Json(ErrNum, "");
			{error, ErrNum, ErrMsg} when is_integer( ErrNum ) -> ?Package_Json(ErrNum, ErrMsg);
			{error, Reason} -> ?Package_Json(?REPLY_CODE_VERIFY_FAIL, Reason)
	% 	end
	% catch
	% 	Catch:Why ->
	% 		?debug([Catch, Why]),
	% 		?Package_Json(?REPLY_CODE_CRASH, "code crash")
	end.
