%% @author 余健
%% @doc 程序入口

-module(spider_conf).

-include( "spider.hrl" ).

%% -compile( export_all ).
-export([start/1]).


-define( MAXPAGE, 500 ).

start( Action ) ->
	inets:start(),
	mnesia:start(),
	ssl:start(),
	Xml = args(),
	Fun = fun( {Url, FileName, _FileTitle} ) ->
				  PageUrls = make_url( Url, Action ),
				  lists:map( fun( PageUrl ) -> action( PageUrl, FileName, Xml ) end, PageUrls )
			end,
	%spider_fun:upmap( Fun, ?URL_CONF ). %防止被屏蔽，所以不使用并发
	lists:map( Fun, ?URL_CONF ).
	
make_url( Url, Action ) ->
	Nums = 
		case Action of
			"start" -> lists:seq(1, ?MAXPAGE);
			"everyday" -> lists:seq(1, 5)
		end,
	[Url++"?page="++integer_to_list(I)||I<- Nums].
	
action( PageUrl, FileName, Xml ) ->
	case mnesia:dirty_read(spider_url, PageUrl) of
		[] ->
			Ehtml = spider_http:get_html(PageUrl, FileName),
			HrefLists = spider_action:action( "start", Ehtml, Xml ),
			lists:map( fun(ResDom) -> do_task_each( ResDom, FileName ) end, HrefLists );
		[_SpiderVO] ->
			ok
	end.

do_task_each( [{"title", Title}, {url, "001", Url}], FileName ) ->
	NewUrl = "http://www.zhihu.com"++Url,
	spider_http:get_html(NewUrl, FileName),
	[SpiderVO] = mnesia:dirty_read( spider_url, NewUrl ),
	mnesia:dirty_write( SpiderVO#spider_url{ title = Title } ).

args() ->
    File = spider_init:get_path( "../include/zhihu.xml" ),
    {ok, S} = file:read_file( File ),
    {_, _, Xml} = mochiweb_html:parse( S ),
    [ { binary_to_list( I ), I2 } ||
            {<<"page">>, [{<<"id">>, I}], [I2] } <- Xml ].
