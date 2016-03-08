%% @author 余健
%% @doc 解析xml文档，从hmtl中获取数据

-module(spider_action).

-export([action/3]).

action( "start", Ehtml, Args )->
    Arg_start = get_arg( "start", Args ),
    action( Arg_start, Ehtml ).

action( Args,  Ehtml )->
    action_xml_each( Args, Ehtml ).

get_arg( Id, Args )->
    case lists:keyfind( Id, 1, Args) of
            false      ->  {[], [], []};
            { _, Val } ->  Val
    end.  

action_xml_each([], Html)-> 
	Html;

action_xml_each( _, Html ) when Html==[]; is_binary( Html )-> 
	[];

action_xml_each({<<"script">>, _, _}, _)->
    [];

action_xml_each({Tag, Attr, Content}, Html)->
    Res = { get_item("id", Attr), get_item( "list", Attr ),
            get_dom( Tag, Attr ), Content, get_item( "itemprop", Attr ) },
    xml_do_dom( Res, Html ).

xml_do_dom( { false, "true", Dom, Content, false }, Html )->
    Html_new = spider_dom:do_dom( Dom, Html ),
    action_xml_list( Content, Html_new );

xml_do_dom( { false, "append", Dom, Content, false }, Html )->
    Html_new = spider_dom:do_dom( Dom, Html ),
    lists:append( action_xml( Content, Html_new ) );

xml_do_dom( { false, "flatten", Dom, Content, false }, Html )->
    Html_new = spider_dom:do_dom( Dom, Html ),
    lists:flatten( action_xml( Content, Html_new ) );

xml_do_dom( { false, false, Dom, Content, false }, Html )->
    Html_new = spider_dom:do_dom( Dom, Html ),
    action_xml( Content, Html_new );

xml_do_dom( { false, false, Dom, _, Item }, Html )->
    { Item, striptags( spider_dom:do_dom( Dom, Html ) )}; 

xml_do_dom( { Id, false, Dom, _, false }, Html )->
    Url = spider_dom:do_dom( Dom, Html ),
    {url, Id, Url}.
                        
action_xml_list( Arg, Html )->
    [ action_xml( Arg, I ) || I <- Html ].

action_xml( [], _ )->
    [];
action_xml( [Args], Html )->
    action_xml_each( Args, Html);
action_xml( Args, Html )->
	
    [ action_xml_each(I, Html)|| I <- Args, I/=[] ].

get_item( A, Attr )->
    case lists:keyfind(list_to_binary(A), 1, Attr) of
            {_, Dom_bin}    -> binary_to_list( Dom_bin );
            false           -> false
    end.

get_dom( Tag, Attr )->
    case get_item("dom", Attr) of
            false when is_binary( Tag )-> binary_to_list( Tag );
            false -> Tag;
            Dom -> Dom
    end.

striptags( {_, _, Ehtml} ) ->
    striptags( Ehtml );
striptags( Str ) when Str==[]; is_tuple( Str )->
    [];  
striptags( [ Str ] ) ->
    striptags( Str );
striptags( [ H|T ] ) when is_integer(H)->
    [H|T];
striptags( Str ) when is_binary( Str )->
    binary_to_list( Str );  
striptags( Ehtml_list ) when is_list( Ehtml_list )->
     string:join( [ striptags( I ) ||I <- Ehtml_list], " " ).
