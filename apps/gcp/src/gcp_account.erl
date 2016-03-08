%% @author 余健<yujian1018@163.com>
%% @doc 用户登录验证用户名密码

-module(gcp_account).
-include("../include/yaws_api.hrl").
-include("../include/gcp_def.hrl").
-include("../include/gcp.hrl").
-export( [handle/2] ).

-define( USER_SESSION_KEY, "gcp_session" ).

handle(_A, {"reg", UserName, Pwd, Nick}) ->
    case mnesia:dirty_read(?user_tab, UserName) of
      [] -> 
        Record = #user_tab{user_name=UserName, pwd=Pwd,nick_name=Nick,reg_time=gcp_init:now()},
        gcp_manager:update(?user_tab, Record),
        ok;
      [_UserVO] -> 
          {error, ?REPLY_USERNAME_REPEART}
    end;

handle(A, {"login", UserName, Pwd}) ->
    case check_cookie({A, ?USER_SESSION_KEY}) of
        {ok, _User, _} -> ok;
        _ ->
            case gcp_manager:lookup(?user_tab, UserName) of
              [] -> {error, ?REPLY_NO_USER};
              [UserVO] -> 
                  if
                      UserVO#user_tab.pwd  == Pwd -> ok;
                      true -> {error, ?REPLY_PWD_ERROR}
                  end
            end
    end;

handle(A, {"loginOut"}) -> 
    case check_cookie({A, ?USER_SESSION_KEY}) of
        {ok, _Sess, Cookie} ->
            yaws_api:delete_cookie_session(Cookie),
            ok;
        _ -> ok
    end;

handle(A, {"isSession"}) ->
    case check_cookie({A, ?USER_SESSION_KEY}) of
        { ok, Session, _ } -> {ok, erlang_term, Session};
        _ -> {error, ?REPLY_NO_COOKIE}
    end.

check_cookie({A, Key}) ->
    H = A#arg.headers,
    case yaws_api:find_cookie_val(Key, H#headers.cookie) of
        CookieVal when CookieVal /= [] ->
            case yaws_api:cookieval_to_opaque(CookieVal) of
                {ok, Session} ->
                    {ok, Session, CookieVal};
                {error, { has_session, Session}} ->
                    {ok, Session, CookieVal};
                Else ->
                    {error, Else}
            end;
        [] ->
            {error, "nocookie"}
    end.
