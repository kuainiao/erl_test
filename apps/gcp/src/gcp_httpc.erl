-module( gcp_httpc ).

-export( [url_get/3] ).

-define(TIMEOUT, 10000).
-include("../include/gcp_def.hrl").
-define(HEADER, "Mozilla/5.0 (Windows NT 6.3; WOW64; rv:37.0) Gecko/20100101 Firefox/37.0").

url_get( Url, Dom, Encode ) ->
    case httpc:request(get, {Url, [{"header", ?HEADER}]}, [{timeout, ?TIMEOUT}], []) of
         {ok, {{_Protocol, 200, _State}, _Head, Html}} ->
            dom(Dom, mochiweb_html:parse(Html), [], Encode);
        _Other ->
            []
    end.

dom([], _Ehtml, Data, _Encode) -> [{M,N}||{M,N} <- lists:reverse(Data), N =/= []];
dom( [{Key, Dom}|RList], Ehtml, Data, Encode ) ->
    NewValue = case gcp_dom:do_dom( Dom, Ehtml ) of
                    Value when is_list( Value ) -> Value;
                    {_, _, [Value]} -> lists:flatten(re:split(Value,"\r\n ", [{return, list}]))
                end,
    ResValue = case Encode of
                    "gbk" -> gcp_init:iconv(gbk_to_utf8, NewValue);
                    _ -> NewValue
                end,
    dom( RList, Ehtml, [{Key, ResValue}|Data], Encode ).

