%% @author 余健
%% @doc 初始化数据库


-module(spider_init).

-include( "spider.hrl" ).

-export([load/0, start/0, init/0, get_path/1]).

init() ->
	mnesia:stop(),
	mnesia:create_schema([node()]),
	start().

start() ->
	mnesia:start(),
	 mnesia:create_table( spider_url, [{disc_only_copies, [node()]},
		  						   {attributes, record_info( fields, spider_url )}]).

load() ->
    Path = get_path("../ebin/" ),
    { ok, List } = file:list_dir( Path ),
    List_fit = [ I||I <- List, lists:suffix( ".beam", I ) ],
    [ load( I )||I <- List_fit ].

load( StringTemp ) ->
    case string:tokens( StringTemp, "." ) of
        [ Temp, _ ] ->
            c:l( list_to_atom( Temp ) );
        _Other ->
            []
    end.

get_path( Str )->
    Root = filename:split( code:which( ?MODULE ) ),
    join( Root, Str ).  
join( List, "../"++Str )-> join( lists:sublist( List, length( List )-1 ), Str );
join( List, Str )-> string:join( lists:sublist( List, length( List )-1 )++[Str], "/" )--"/".
    