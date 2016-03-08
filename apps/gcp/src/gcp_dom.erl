-module( gcp_dom ).
-export( [ do_dom/2 ] ).
-compile( export_all ).
% #a | .a | #a ul li | #a ul:2 | div | div:2 | title=name | a=href,img=src|src2, p=name | #a ul li:all|first|last|N
% #a ul li 默认找出 #a下的第一个ul下的所有li
do_dom( [], Ehtml ) -> Ehtml;
do_dom( _, [] ) -> [];
do_dom( Str, Ehtml ) when is_integer( hd( Str ) ) ->
    do_dom( parse_dom( Str ), Ehtml);

do_dom( [ H|R ], Ehtml ) when is_tuple( H ) ->
    DomEthml =
        try dom_each( H, Ehtml ) of
            NewDom ->
                NewDom
        catch
            _:_Why ->
                []
        end,
    do_dom( R, DomEthml );

do_dom( _Str, _Ehtml ) ->
    { error, "bad argument" }.
%%  @doc    解析dom操作
parse_dom( Str ) ->
    Doms = string:tokens( Str, "," ),
    [ parse_dom_each( Dom ) || Dom <- Doms ].
-define( Attr, ["style", "name", "title", "id", "class", "href", "type", "src", "alt", "data-src"] ).
parse_dom_each( Dom ) ->
    case lists:member( $=, Dom ) of
        true ->
            [Tag, Attr] = string:tokens( Dom, "=" ),
            case lists:member( Tag, ?Attr ) of
                true ->
                    {attr, list_to_binary( Tag ), list_to_binary( Attr )};
                false ->
                    { get_attr, list_to_binary( Tag ), Attr }
            end;
        false ->
            case lists:member( $:, Dom ) of
                true ->
                    [Tag, Nth] = string:tokens( Dom, ":" ),
                    { tag, list_to_binary( Tag ), Nth };
                false -> 
                    case Dom of
                        "#" ++ NewDom ->
                            { attr, <<"id">>, list_to_binary( NewDom ) };
                        "." ++ NewDom ->
                            { attr, <<"class">>, list_to_binary( NewDom ) };
                        NewDom ->
                            { tag, list_to_binary( NewDom ), [] }
                    end
            end
    end.

dom_each( {attr, Attr, Value}, Ehtml ) ->
    dom_value( { Attr, Value }, Ehtml );

dom_each( {tag, Tag, _Nth}, Ehtml ) when Tag==<<"self">>; Tag==<<>>; Tag==<<" ">> ->
    Ehtml;
dom_each( {tag, <<"list">>, Nth}, {_, _, Ehtml} ) ->
    [Key, Value] = string:tokens( Nth, "-" ),
    dom_ehtml_list( list_to_binary( Key ), list_to_binary( Value ), Ehtml, [] );
    
dom_each( {tag, Tag, Nth}, {_, _, Ehtml} ) ->
    case dom_tag_all( Tag, Ehtml ) of
        [[]] when is_binary( hd( Ehtml ) ) ->
            binary_to_list( hd( Ehtml ) );
        Res_list ->
            case string:tokens( Nth, "-" ) of
                [] ->
                    hd( Res_list );
                ["all"] ->
                    Res_list;
                ["last"] ->
                    hd( lists:reverse( Res_list ) );
                ["first"] ->
                    hd( Res_list );
                [ N, "nextall" ] ->
                    N_integer = list_to_integer( N ),
                    if
                        length( Res_list ) < N_integer ->
                            [];
                        length( Res_list ) >= N_integer ->
                            lists:nthtail(  N_integer-1, Res_list)
                    end;
                [ N, M ] ->
                    N_integer = list_to_integer( N ),
                    M_integer = list_to_integer( M ),
                    if
                        length( Res_list ) < N_integer ->
                            [];
                        length( Res_list ) >= N_integer ->
                            Totle =  M_integer - N_integer,
                            lists:sublist( Res_list, N_integer, Totle )
                    end;                    
                [N] ->
                    N_integer = list_to_integer( N ),
                    if
                        length( Res_list ) < N_integer ->
                            [];
                        length( Res_list ) >= N_integer ->
                            lists:nth( N_integer, Res_list )
                    end
            end
    end;
dom_each( {tag, _Tag, _Nth}, _Ehtml ) ->
    [];
dom_each( {get_attr, _Tag, _Attr}, [] ) ->
    [];
dom_each( {get_attr, Tag, Attr}, {Tag, Ehtml_Attr, _} ) ->
    Attrs = string:tokens( Attr, "|" ),
    dom_attr_value( Attrs, Ehtml_Attr );
dom_each( {get_attr, Tag, Attr}, Ehtml ) ->
    New_Ehtml = dom_each( {tag, Tag,[]}, Ehtml ),
    dom_each( {get_attr, Tag, Attr}, New_Ehtml ).
    

dom_value( _, [] ) -> [];
%%  @doc    过滤网页中的无关的数据和标签
dom_value( _, [Bin] ) when is_binary( Bin ) -> [];
dom_value( Value, [ H|Res ] ) when is_binary( H ) -> dom_value( Value, Res );
dom_value( Value, [ { comment, _ }|Res ] ) -> dom_value( Value, Res );
dom_value( Value, [ { <<"script">>, _, _ }|Res ] ) -> dom_value( Value, Res );

dom_value( Key, { Tag, Attr, Content } ) when is_tuple( Key ) ->
    case lists:member( Key, Attr ) of
        true ->
            { Tag, Attr, Content };
        false ->
            dom_value( Key, Content )
    end;
dom_value( Key, { Tag, Attr, Content } ) ->
    case Key =:= Tag of
        true ->
            { Tag, Attr, Content };
        false ->
            dom_value( Key, Content )
    end;
dom_value( Key, [ {Tag, Attr, Content} | R ] ) ->
    case dom_value( Key, { Tag, Attr, Content } ) of
        [] ->
            dom_value( Key, R );
        Res ->
            Res
    end.
%%  @doc    获得当前标签的下一级标签中的所有Key值的标签
dom_tag_all( Key, Content ) ->
    Ehtml = case Content of
                R when is_tuple( R ) ->
                    [R];
                R ->
                    R
            end,
    case dom_next_tag_all( Key, Ehtml ) of
        [] ->
            [dom_value( Key, Ehtml )];
        List ->
            List
    end.
        
dom_next_tag_all( Key, Ehtml ) ->
    case lists:keyfind( Key, 1, Ehtml ) of
        false ->
            [];
        Data ->
            Con = lists:keydelete( Key, 1, Ehtml ),
            [Data] ++ dom_next_tag_all( Key, Con )
    end.

dom_attr_value( [], _Attr ) ->
    [];

dom_attr_value( [ Attr_Key | R ], Ehtml_Attr ) ->
    Key = list_to_binary( Attr_Key ),
    case lists:keyfind( Key, 1, Ehtml_Attr ) of
        false       ->  dom_attr_value( R, Ehtml_Attr );
        {Key, Val}  ->  binary_to_list( Val )
    end.

%%  @doc    在同一级的标签中取出数据组装成新数据
dom_ehtml_list( _, _, [], Data ) -> lists:reverse( Data );

dom_ehtml_list( Key, Value, [{Tag, Attr}|R], Data ) ->
    dom_ehtml_list( Key, Value, R, Data );
    
dom_ehtml_list( Key, Value, [{Tag, Attr, Content}|R], Data ) when Content =:= [] ->
    dom_ehtml_list( Key, Value, R, Data );
    
dom_ehtml_list( Key, Value, [{Tag, Attr, Content},{ Tag1, Attr1 }|R], Data ) ->
    dom_ehtml_list( Key, Value, [{Tag, Attr, Content}|R], Data );
    
dom_ehtml_list( Key, Value, [{Tag, Attr, Content},{ Tag1, Attr1, Content1 }|R], Data ) ->
    if
        Tag /= Key, Tag /= Value ->
            dom_ehtml_list( Key, Value, [{ Tag1, Attr1, Content1 }|R], Data );
        Tag =:= Value ->
            case Data of
                [] ->
                    dom_ehtml_list( Key, Value, [{ Tag1, Attr1, Content1 }|R], Data );
                [First|Tail] ->
                    { <<"test">>, [], Totle } = First,
                    New_Totle = { <<"test">>, [], Totle ++ [{Tag, Attr, Content}] },
                    dom_ehtml_list( Key, Value, [{ Tag1, Attr1, Content1 }|R], [New_Totle|Tail] )
            end;
        Tag =:= Key, Tag1 /= Value ->
            List = get_next_key( Key, [{ Tag1, Attr1, Content1 }|R] ),
            dom_ehtml_list( Key, Value, List, Data );
        Tag =:= Key, Tag1 == Value ->
            Key_totle = { <<"test">>, [], [ {Tag, Attr, Content} ] },
            dom_ehtml_list( Key, Value, [{ Tag1, Attr1, Content1 }|R], [ Key_totle|Data ] )
    end.

get_next_key( Key, [] ) ->
    [];
get_next_key( Key, [{Tag, _Attr}|R] ) ->
    get_next_key( Key, R );
get_next_key( Key, [{Tag, _Attr, _Content}|R] ) ->
    case Key =:= Tag of
        true ->
            [{Tag, _Attr, _Content}|R];
        false ->
            get_next_key( Key, R )
    end.