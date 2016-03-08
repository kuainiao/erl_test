%% @author 余健
%% @doc 公共函数

-module(spider_fun).

-export([upmap/2, upmap/4, to_url/1, nowTime/0, todayNow/0, getHourTime/1]).

%-------------------------------------------------------------------------------
%%   @doc    并发执行列表,没有限制
%%   @spec   upmap( fun(), list() ) -> list().
upmap( F, L ) ->
    Parent = self(),
    Ref = erlang:make_ref(),
    [ receive {Ref, Result} -> Result end
     || _ <- [spawn( fun() -> Parent ! {Ref, F( X )} end ) || X <- L]
    ].

%%  @doc    准备控制并发的个数
upmap( num, F, L, N ) ->
    upmap( F, L, N, [], [] ).
    
upmap( F, L, N, Data, Res ) when length( Data ) =:= N->
    NumLists = upmap( F, Data ),
    upmap( F, L, N, [], [ NumLists|Res ] );

upmap( _F, [], _N, _Data, Res ) -> Res;
   
upmap( F, L, N, _Data, Res ) when length( L ) < N->
    NumLists = upmap( F, L ),
    upmap( F, [], N, [], [ NumLists|Res ] );

upmap( F, [ H|R ], N, Data, Res ) when length( Data ) < N->
    upmap( F, R, N, [H|Data], Res ).

%%  @spec   to_url( Str::string() ) -> string()
to_url( [] ) -> [];  
to_url( 32 ) -> "%20";
to_url( 43 ) -> "%2B";
to_url( Str ) when Str =< $~ -> Str;
to_url( Str ) when is_integer( Str ) -> lists:concat(["%",integer_to_list(Str, 16)]);
to_url( "www."++Str ) -> to_url( "http://www."++Str );
to_url( Str ) when is_list( Str ) -> lists:flatten( [ to_url(I) || I<-Str]).


-define(SC, 8*3600).
nowTime() ->
	{MegaSecs, Secs, _MicroSecs} = erlang:now(),
	MegaSecs * 1000000 + Secs + ?SC.

todayNow() ->
	Now = nowTime(),
	{_, {Hour, Minute, Second}} = erlang:localtime(),
	Now -  (Hour*3600+Minute*60+Second).

%%获取今天某小时的时间
getHourTime(Hour) ->
	NowTime = nowTime(),
	HourTime = todayNow()+Hour*3600,	
	if HourTime >= NowTime ->
		   NowTime - HourTime;
	   true ->
		   (HourTime+86400)-NowTime
	end.