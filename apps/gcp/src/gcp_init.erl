-module( gcp_init ).
-include("../include/gcp_def.hrl").
-include("../include/gcp.hrl").
-export([start/0, tpl_init/0, load/0, init/0, get_path/1,update_id/1, iconv/2]).
-export([now/0, diff/1] ).
-compile({d,debug}).

start() ->
    application:set_env( mnesia, dc_dump_limit, 40 ),
    application:set_env( mnesia, dump_log_write_threshold, 10000 ),
    mnesia:start(),
    inets:start(),
    tpl_init().

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

init() ->
    mnesia:stop(),
    mnesia:delete_schema([node()]),
    mnesia:create_schema([node()]),
    mnesia:start(),
    mnesia:create_table( user_tab, [{disc_copies,[node()]},
        {attributes, record_info( fields, user_tab )}]),

    mnesia:create_table( user_review, [{disc_copies,[node()]},
        {attributes, record_info( fields, user_review )}]),

    mnesia:create_table( shop_taobao_info, [{disc_copies,[node()]},
        {attributes, record_info( fields, shop_taobao_info )}]),

    mnesia:create_table( shop_info, [{disc_copies,[node()]},
        {attributes, record_info( fields, shop_info )}]),

    mnesia:create_table( shop_review, [{disc_copies,[node()]},
        {type,bag},
        {attributes, record_info( fields, shop_review )}]),

    mnesia:create_table( unique_id, [{disc_copies,[node()]},
        {attributes, record_info( fields, unique_id )}]),
    mnesia:dirty_write({unique_id, shop_id, 0}),

%%     ets:new( url_dom, [named_table, {read_concurrency, true},{keypos, #url_dom.url_name}] ),
%%     ets:new( codeChange, [named_table, {read_concurrency, true},{keypos, #codeChange.utf8}] ),
    mnesia:create_table( url_dom, [{disc_copies,[node()]},
        {attributes, record_info( fields, url_dom )}]),
    mnesia:create_table( codeChange, [{disc_copies,[node()]},
        {attributes, record_info( fields, codeChange )}]),

    mnesia:dirty_write(url_dom, {url_dom, "http://item.taobao.com/item.htm", "淘宝", "gbk", "id",
                         [{"img_url","#J_ImgBooth,img=data-src"}, {"shop_title", ".tb-main-title,h3=data-title"}, {"shop_name", ".tb-shop-name,a=title"}, {"shop_score", ".tb-rate-higher,a"}]}),

    import_all( get_path("../doc/_codeChange.dat") ).

update_id(shop_id) ->
    mnesia:dirty_update_counter(unique_id, shop_id, 1).

tpl_init() ->
    Path = get_path(?TPL_FILE_PATH),
    {ok, List} = file:list_dir( Path ),
    List_fit = [ I||I <- List, lists:suffix( ".tpl", I ) ],
    lists:foreach( fun( I )-> add_tpl( I ) end, List_fit ).

add_tpl( File )->
    List = string:tokens( File, "./" ),
    Tpl = list_to_atom(lists:nth( length( List ) -1, List )),
    erlydtl:compile(get_path( "../include/"++File ), Tpl ). 

get_path( Str )->
    Root = filename:split( code:which( ?MODULE ) ),
    join( Root, Str ).  
join( List, "../"++Str )-> join( lists:sublist( List, length( List )-1 ), Str );
join( List, Str )-> string:join( lists:sublist( List, length( List )-1 )++[Str], "/" )--"/".

import_all( Dat ) ->
    {ok, S} = file:open( Dat, read ),
    case io:read(S, '') of
        {ok, {tables, Term} }->
            mnesia:create_table( Term ),
            add_data(S);
        eof->
            [];
        Error->
            {error, Error}
    end.
        
add_data( S )->
    case io:read(S, '') of
        {ok, Term}->
            gcp_manager:insert( Term ),
            add_data( S );
        eof->
            file:close( S );
        Error->
            file:close( S ),
            {error, Error}
    end.


iconv( _, [] ) ->
    [];
iconv( _Atom, [H|T] )when H < 128 ->
    [H | iconv(_Atom, T)];
iconv( gbk_to_utf8, [F] ) -> [F];
iconv( gbk_to_utf8, [F, S| T] ) ->
    case actionCodeChange( gbk_to_utf8, [F, S] ) of
        [F,S] ->
            [F,S|T];
        NewText ->
            NewText ++ iconv( gbk_to_utf8, T )
    end.

actionCodeChange( gbk_to_utf8, Text ) ->
    case mnesia:dirty_select( codeChange, [{ #codeChange{ utf8 = '$1', gbk = Text, _ = '_' }, [], ['$1'] }] ) of
        []  -> Text;
        [R] -> R
    end.

now() ->
    {Me, Sec, _} = os:timestamp(),
    Me * 1000000 + Sec.

diff(Timer) ->
    NewTimer = gcp_init:now() - Timer,
    Minit = NewTimer div 60,
    if
        Minit < 60 -> integer_to_list(Minit)++"分钟";
        Minit < (60*24) -> integer_to_list(Minit div 60) ++ "小时";
        true -> integer_to_list(Minit div (60*24)) ++ "天"
    end.