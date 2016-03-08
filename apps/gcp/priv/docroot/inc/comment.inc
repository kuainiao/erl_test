<script type="text/javascript">
var $textarea;
$(function(){
	var $left = ($(window).width() - $("#comment_good").width()) /2;	
    var $top = ($(window).height() - $("#comment_good").height()) /2;
    $("#comment_good").attr("style", "top:"+$top+"px;left:"+$left+"px");

    var $left = ($(window).width() - $("#comment_bad").width()) /2;	
    var $top = ($(window).height() - $("#comment_bad").height()) /2;
    $("#comment_bad").attr("style", "top:"+$top+"px;left:"+$left+"px");

	$(".div4 .com_info .nav").click(function(){
		$(".body_bg").show();
		$("#comment_good").show();
		$("#comment_good .title .font").html("好评");
	});

	$(".div4 .com .nav").click(function(){
		$(".body_bg").show();
		$("#comment_bad").show();
		$("#comment_bad .title .font").html("给此产品差评");
	});

	$("#comment_good .close").click(function(){
		$(".body_bg").hide();
		$("#comment_good").hide();
	});

	$("#comment_bad .close").click(function(){
		$(".body_bg").hide();
		$("#comment_bad").hide();
	});

	$("#submit_g").click(function(){
		$textarea = $("#textarea_g").val();
		console.log( $textarea );
		if( $textarea == "" || $textarea == undefined || $textarea == null )
		{
			$("#msg").html( "请填写评论信息！" );
			return false;
		}
		var $shop_id = $("#shop_id").val();
		var $url = "/action.yaws?action=comment&shop_id="+$shop_id+"&comment_level=1&textarea="+$textarea;
		console.log($url);
		ajax( $url, "1" );
	});

	$("#submit_m").click(function(){
		$textarea = $("#textarea_m").val();
		if( $textarea == "" || $textarea == undefined || $textarea == null )
		{
			$("#msg").html( "请填写评论信息！" );
			return false;
		}
		var $val=$('input:radio[name="select_lv"]:checked').val();
		var $url;
		if($val == "1"){
			var $shop_id = $("#shop_id").val();
			$url = "/action.yaws?action=comment&shop_id="+$shop_id+"&comment_level=2&textarea="+$textarea;
			ajax( $url, "2" );
		}else if($val == "2"){
			var $shop_id = $("#shop_id").val();
			$url = "/action.yaws?action=comment&shop_id="+$shop_id+"&comment_level=3&textarea="+$textarea;
			ajax( $url, "3" );
		}
	});
	$("#bad_comment").click(function(){
		$("#b_bander").show();
		$("#negative_comment").show();
		$("#commentary").hide();
		$("#m_bander").hide();
	});
	$("#medium_comment").click(function(){
		$("#m_bander").show();
		$("#commentary").show();
		$("#negative_comment").hide();
		$("#b_bander").hide();
	});
	var $b_is_true = 0;
	var $m_is_true = 0;
	$("#negative_comment").scroll(function(){
		if($b_is_true == 0){
			var $scrolltop = $("#negative_comment").scrollTop();
			var $scrollheight = $("#negative_comment").get(0).scrollHeight;
			var $bodyheight = $("#negative_comment").height();
			if($scrolltop + $bodyheight + 50 >= $scrollheight ){
				$b_is_true = 1;
				var $shop_id = $("#shop_id").val();
				var $page_b = $("page_b").val();
				var $url = "action.yaws?action=comment_page&shop_id="+$shop_id+"&comment_level=3&page="+$page_b;
				ajax($url, "scroll_b");
			}
		}else{
		}
	});
	$("#commentary").scroll(function(){
		if($m_is_true == 0){
			var $scrolltop = $("#commentary").scrollTop();
			var $scrollheight = $("#commentary").get(0).scrollHeight;
			var $bodyheight = $("#commentary").height();
			if($scrolltop + $bodyheight + 50 >= $scrollheight ){
				$m_is_true = 1;
				var $shop_id = $("#shop_id").val();
				var $page_b = $("page_b").val();
				var $url = "action.yaws?action=comment_page&shop_id="+$shop_id+"&comment_level=2&page="+$page_b;
				ajax($url, "scroll_m");
			}
		}else{
		}
	})

})

function show_comment(data, callback){
	if( callback == "scroll_b" ){
		$.each(data.msg, function(i, item){
			$("negative_comment").append( tpl_shop_comment( item ) );
		});
	}
	else{
		$.each(data.msg, function(i, item){
			$("commentary").append( tpl_shop_comment( item ) );
		});
	}
}
function tpl_shop_comment( item ){
	return "<li><p class='head'><span style=\"font-weight: 700;\">"+item.name+"</span><span style=\"font-size: 12px;color: #BCBCBC;display: inline-block;float: right;\">"+item.time+"前</span></p>"+item.review+"<p></p></li>";
}
</script>
<style type="text/css">
.account .textarea{height: 202px; width:100%;line-height:2;background-color: rgb(242,242,242);border:1px;padding:10px;}
#comment_good,#comment_bad{width:550px;}
#comment_good .in_box, #comment_bad .in_box{padding-bottom: 0px;}

#comment_bad .in_box input[type="radio"]{vertical-align: middle;margin-right:3px;}
#comment_bad .in_box i{display: inline-block;vertical-align: middle;width: 16px;height: 16px;}
#comment_bad .meduim_comment{background: url(/images/dot2.png) 0px -34px no-repeat;margin-right: 32px;}
#comment_bad .bad_comment{background: url(/images/dot2.png) 0px -18px no-repeat;}
</style>
<div id="comment_good" class="account">
	<div class="title">
		<span class="font">好评</span>
		<div class="close"></div>
	</div>
	<div class="out_box">
		<div class="border_top">
			<div class="in_box">
				<p style="line-height:30px;margin-bottom:0px;" id="msg">本月您还可以对<font color="red">5</font>个商品进行好评</p>
				<p><textarea class="textarea" id="textarea_g"></textarea></p>
				<p><input type="submit" value="发布" class="submit" id="submit_g"/></p>
			</div>
		</div>
	</div>
</div>

<div id="comment_bad" class="account">
	<div class="title">
		<span class="font">给此产品差评</span>
		<div class="close"></div>
	</div>
	<div class="out_box">
		<div class="border_top">
			<div class="in_box">
				<p style="line-height:30px;margin-bottom:0px;">
					<input type="radio" class="checkbox" name="select_lv" checked="checked" value="1" /><i class="meduim_comment"></i>
					<input type="radio" class="checkbox" name="select_lv" value="2" /><i class="bad_comment"></i>
				</p>
				<p style="line-height:30px;margin-bottom:0px;" id="msg_bad">本月您还可以对<font color="red">5</font>个商品进行差评</p>
				<p><textarea class="textarea" id="textarea_m"></textarea></p>
				<p><input type="submit" value="发布" class="submit"  id="submit_m" /></p>
			</div>
		</div>
	</div>
</div>