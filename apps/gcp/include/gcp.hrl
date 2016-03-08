%% @doc 用户表
-record(user_tab, {
    user_name,
    pwd,
    email,
    tel,
    nick_name,
    reg_time}).

%% @doc 用户评论次数表
-record(user_review,{
    user_name,
    review_time,
    good_review_count=0,
    medium_review_count=0,
    bad_review_count=0}).

%http://item.taobao.com/item.htm?id=45225229273
%http://detail.tmall.hk/hk/item.htm?id=40420980345
%% @doc 淘宝网商品信息
-record(shop_taobao_info, {
    url,
    img_url,
    shop_title,
    shop_name,
    shop_score
    }).

%% @doc 商品信息统计表
-record(shop_info, {
    shop_id,
    pv_30,
    comment_num_30,
    good_review_count,
    medium_review_count,
    bad_review_count}).

%% @doc 商品评论信息表,一个商品多个评论
-record(shop_review,{
    shop_id,
    review_time,
    user_name,
    review_level,
    review}).

-record(unique_id, {name, id}).

%% @doc pv统计
-record(page_view,{
    user_name,
    review_time,
    good_review_count,
    medium_review_count,
    bad_review_count}).

-record(url_dom, {
    url_head = "http://item.taobao.com/item.htm",
    url_name,
    url_encode,
    url_key = "id",
    url_dom = [{"img_url","#J_ImgBooth,img=data-src"}, {"shop_title", ".tb-main-title,h3=data-title"}, {"shop_name", ".tb-shop-name,a=title"}, 
               {"shop_score", ".tb-rate-higher,a"}]
    }).

-record( codeChange, {utf8, gbk, des} ).