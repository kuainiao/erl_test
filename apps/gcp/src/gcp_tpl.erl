-module( gcp_tpl ).
-export( [tpl/3, select_comment/4] ).
-include( "../include/gcp.hrl" ).
-include("../include/gcp_def.hrl").

tpl( "show_shop_info", Url, A ) ->
    [UrlHead, Arg] = string:tokens( Url, "?" ),
    TplData = case gcp_manager:lookup(?url_dom, UrlHead) of
                  [] -> [];
                  [UrlRecord] ->
                      case lists:keyfind(UrlRecord#url_dom.url_key, 1, [list_to_tuple(string:tokens(I, "="))||I<- string:tokens( Arg, "&" )]) of
                          false -> [];
                          {_, ShopId} ->
                            HttpUrl = UrlHead++"?"++UrlRecord#url_dom.url_key++"="++ShopId,
                              ShopInfoTpl = case gcp_manager:lookup( ?shop_taobao_info, HttpUrl ) of
                                                [] ->
                                                    case gcp_httpc:url_get( HttpUrl, UrlRecord#url_dom.url_dom, UrlRecord#url_dom.url_encode ) of
                                                        [] -> [];
                                                        [{"img_url", ImgUrl}, {"shop_title", ShopTitle}, {"shop_name", ShopName}, {"shop_score", ShopScore}] ->
                                                            gcp_ctrl:add_shop_info( ?shop_taobao_info, {HttpUrl, ImgUrl, ShopTitle, ShopName, ShopScore} ),
                                                            [{"shop_url",HttpUrl}, {"img_url", ImgUrl}, {"shop_title", ShopTitle}, {"shop_name", ShopName}, {"shop_score", ShopScore}, {"websit", "淘宝"}]
                                                    end;
                                                [ShopTaobaoInfo] ->
                                                    [{"shop_url",HttpUrl},
                                                        {"img_url", ShopTaobaoInfo#shop_taobao_info.img_url},
                                                        {"shop_title", ShopTaobaoInfo#shop_taobao_info.shop_title},
                                                        {"shop_name", ShopTaobaoInfo#shop_taobao_info.shop_name},
                                                        {"shop_score", ShopTaobaoInfo#shop_taobao_info.shop_score},
                                                        {"websit", "淘宝"}]
                                            end,
                              case ShopInfoTpl of
                                [] -> [];
                                ShopInfoTpl -> {ShopInfoTpl++select_len(gcp_ctrl:select_review(HttpUrl)), HttpUrl}
                              end
                      end
              end,
    case TplData of
        [] -> "<div style='width:100%;height:100%;border: 1px solid #E4E4E4;background-color: #FFF;padding:11px 0px;text-align: center;font-size: 16px;color: red;'>没有获取到商品信息</div>";
        {TplInfo, UrlId} ->
            ViewCountTpl = gcp_log:add_view(UrlId, A),
            {ok, Html} = tpl_s_show_shop:render(ViewCountTpl++TplInfo),
            Html
    end;

tpl( _Action, _Msg, _A ) ->
    ok.

select_len( SortObjs ) ->
    Good = select_comment( SortObjs, {?GOOD_COMMENT_LEVEL, 1, ?GOOD_COMMENT_MAX_LENGTH}, 1, [] ),
    Medium = select_comment( SortObjs, {?MEDIUM_COMMENT_LEVEL, 1, ?MEDIUM_COMMENT_MAX_LENGTH}, 1, [] ),
    Bad = select_comment( SortObjs, {?BAD_COMMENT_LEVEL, 1, ?BAD_COMMENT_MAX_LENGTH}, 1, [] ),
    [{"good", Good}, {"medium", Medium}, {"bad", Bad}].

select_comment( [], _, _, Data ) -> 
  FunMap = fun(Obj) ->
              {gcp_init:diff(Obj#shop_review.review_time), Obj#shop_review.user_name, Obj#shop_review.review}
            end,
  lists:map(FunMap, lists:reverse( Data ));
select_comment( [Obj|Objs], {Level, Start, End}, Index, Data ) ->
   if
       Obj#shop_review.review_level =:= Level ->
           if
               Index >= Start ->
                   select_comment(Objs, {Level, Start, End}, Index+1, [Obj|Data]);
               Index =:= End ->
                   select_comment([], {Level, Start, End}, Index+1, [Obj|Data]);
               true ->
                   select_comment(Objs, {Level, Start, End}, Index+1, Data)
           end;
      true -> select_comment(Objs, {Level, Start, End}, Index, Data)
   end.

