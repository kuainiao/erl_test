%%%-------------------------------------------------------------------
%%% @author yujian
%%% @doc
%%%
%%%-------------------------------------------------------------------
-module(gcp_ctrl).
-include( "../include/gcp.hrl" ).
-include("../include/gcp_def.hrl").
-include_lib("stdlib/include/qlc.hrl").
-export([handle/1, add_shop_info/2, add_shop/6, select_review/1]).

-define(Return_Data(Pv, ComCount, GCount, MCount, BCount), [{"pv_30",Pv},{"totle_30",ComCount},{"gcount",GCount},{"mcount",MCount},{"bcount", BCount}]).

handle({"tpl_comment", ShopId, UserName, Level, Textarea}) ->
    case Level of
        "1" -> add_shop( ShopId, 0, +1, +1, 0, 0 );
        "2" -> add_shop( ShopId, 0, +1, 0, +1, 0 );
        "3" -> add_shop( ShopId, 0, +1, 0, 0, +1 )
    end,
    add_review( ShopId, UserName, Level, Textarea );


handle( {"tpl_comment_page", ShopId, Level, Page} ) ->
    {Start, End} = case {Level, Page} of
                {"2", 1} -> {?MEDIUM_COMMENT_MAX_LENGTH+1, ?MEDIUM_COMMENT_MAX_LENGTH+1+(?GOOD_COMMENT_PAGE_SIZE*1-1)};
                {"2", _} -> {?MEDIUM_COMMENT_MAX_LENGTH+1+Page*?GOOD_COMMENT_PAGE_SIZE, ?MEDIUM_COMMENT_MAX_LENGTH+1+(?GOOD_COMMENT_PAGE_SIZE*Page-1)};
                {"3" ,1} -> {?BAD_COMMENT_MAX_LENGTH+1, ?BAD_COMMENT_MAX_LENGTH+1+(?GOOD_COMMENT_PAGE_SIZE*1-1)};
                {"3", _} -> {?BAD_COMMENT_MAX_LENGTH+1+Page*?GOOD_COMMENT_PAGE_SIZE, ?BAD_COMMENT_MAX_LENGTH+1+(?GOOD_COMMENT_PAGE_SIZE*Page-1)}
            end,
    SortObjs = gcp_ctrl:select_review(ShopId),
    NewObjs = gcp_tpl:select_comment( SortObjs, {Level, Start, End}, 1, [] ),
    [{obj, [{"time", DiffTime}, {"name", Name}, {"review", Review}]}||{DiffTime, Name, Review} <- NewObjs];

handle( _Arg ) -> ok.


add_shop_info( ?shop_taobao_info, {Url, ImgUrl, ShopTitle, ShopName, ShopScore} ) ->
    gcp_manager:insert(#shop_taobao_info{url=Url, img_url=ImgUrl, shop_title=ShopTitle, shop_name=ShopName, shop_score=ShopScore}).

add_shop( Id, Pv, ComCount, GCount, MCount, BCount ) ->
    case gcp_manager:lookup(?shop_taobao_info, Id) of
        [] -> [];
        _ ->
            case gcp_manager:lookup(?shop_info, Id) of
                [] ->
                    gcp_manager:insert(#shop_info{shop_id=Id,
                                                    pv_30=Pv,
                                                    comment_num_30=ComCount,
                                                    good_review_count=GCount,
                                                    medium_review_count=MCount,
                                                    bad_review_count=BCount}),
                    ?Return_Data(Pv, ComCount, GCount, MCount, BCount);
                [ShopInfo] ->
                    gcp_manager:insert(#shop_info{shop_id=Id,
                                                    pv_30=ShopInfo#shop_info.pv_30+Pv,
                                                    comment_num_30=ShopInfo#shop_info.comment_num_30+ComCount,
                                                    good_review_count=ShopInfo#shop_info.good_review_count+GCount,
                                                    medium_review_count=ShopInfo#shop_info.medium_review_count+MCount,
                                                    bad_review_count=ShopInfo#shop_info.bad_review_count+BCount}),
                    ?Return_Data(ShopInfo#shop_info.pv_30+Pv,
                                ShopInfo#shop_info.comment_num_30+ComCount,
                                ShopInfo#shop_info.good_review_count+GCount,
                                ShopInfo#shop_info.medium_review_count+MCount,
                                ShopInfo#shop_info.bad_review_count+BCount)
            end
    end.

add_review( ShopId, UserName, Level, Textarea ) ->
    case gcp_manager:lookup(?shop_taobao_info, ShopId) of
        [] -> {error, ?REPLY_NO_THIS_SHOP};
        [_R] ->
            gcp_manager:insert(?shop_review, #shop_review{shop_id=ShopId,
                                                            review_time=gcp_init:now(),
                                                            user_name=UserName,
                                                            review_level=Level,
                                                            review=Textarea}),
            ok
    end.

select_review( ShopId ) ->
    case gcp_manager:lookup(?shop_review, ShopId) of
        [] -> [];
        Objs ->
            qlc:e(qlc:keysort( #shop_review.review_time, qlc:q( [Obj||Obj<- Objs] ), [{order, descending}] ))
    end.