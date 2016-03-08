<script type="text/javascript">
var $userName;
$(function(){
	$userName = $("#binding_username").val();
	var $left = (document.body.clientWidth - $("#account").width()) /2;
    var $top = ($(window).height() - $("#account").height()) /2;
    $("#account").attr("style", "top:"+$top+"px;left:"+$left+"px");

	$("#head_login").click(function(){
		$(".body_bg").show();
		$("#account").show();
		$("#account .title .font").html("登录帐号");
		$("#login").show();
		$("#reg").hide();
	});
	$("#login_reg_a").click(function(){
		$("#account .title .font").html("注册账号");
		$("#login").hide();
		$("#reg").show();
	});
	$("#login_a").click(function(){
		$("#account .title .font").html("登录帐号");
		$("#login").show();
		$("#reg").hide();
	});
	$("#account .close").click(function(){
		$(".body_bg").hide();
		$("#account").hide();
	});
	$(".input").focus(function(){
		$(this).addClass("focus");
	}).blur(function(){
		$(this).removeClass("focus");
	});

	$("#login_account").click(function(){
		$userName = $("#username").val();
		var $pwd = $("#password").val();

		if( $userName == "" || $userName == undefined || $userName == null )
		{
			$("#err_msg").html( "请输入手机号！" );
			return false;
		}

		if( $pwd == "" || $pwd == undefined || $pwd == null )
		{
			$("#err_msg").html( "请输入密码！" );
			return false;
		}

		var $url = "/action.yaws?action=account&username="+$userName+"&pwd="+$pwd;
		if( document.getElementById("checkbox").checked ){
			setCookie( "userName", $userName, 365 );
			setCookie( "pwd", $pwd, 365 );
		}
		ajax( $url, "account_login" );
	});

	$("#reg_login").click(function(){
		$userName = $("#reg_username").val();
		var $pwd = $("#reg_password").val();
		var $nick = $("#reg_nick").val();
		console.log($userName, $pwd, $nick);
		if( $userName == "" || $userName == undefined || $userName == null )
		{
			$("#err_msg").html( "请输入手机号！" );
			return false;
		}

		if( $pwd == "" || $pwd == undefined || $pwd == null )
		{
			$("#err_msg").html( "请输入密码！" );
			return false;
		}

		if( $nick == "" || $nick == undefined || $nick == null )
		{
			$("#err_msg").html( "请输入昵称！" );
			return false;
		}
		var $url = "/action.yaws?action=account&reg_username="+$userName+"&reg_pwd="+$pwd+"&reg_nick="+$nick;
		ajax( $url, "account_login" );
	});

	if( $userName != null && $userName != "" && $userName != "%%username%%" ){
		show_name($userName);
	}else{
		$userName = getCookie( "userName" );
		if( $userName != null && $userName != "" ){
			var $pwd = getCookie( "pwd" );
			var $url = "/action.yaws?action=account&username="+$userName+"&pwd="+$pwd;
			ajax( $url, "account_login" );
		}
		else{}
	};

	$("#head_login_out").click(function(){
        var $url = "/action.yaws?action=account&arg=loginOut";
        ajax($url, "loginOut");
    });
})

function callback( data, callback ){
	console.log("111111", data, callback);
	if(data.state == "200"){
		if(callback == "account_login" ){
			show_name(data.msg);
		}else if(callback=="loginOut"){
			show_guest();
		}else if(callback == "scroll_b" || callback == "scroll_m"){
			show_comment(data, callback);
		}
		else{

		}	
    }else if(data.state == "105"){
    	$("#comment_good").hide();
    	$("#comment_bad").hide();
		$("#account").show();
		$("#account .title .font").html("请先登录");
		$("#login").show();
		show_guest();
    }else if(data.state == "106"){
    	$("#err_msg").html( "没有查找到该用户！" );
    }else if(data.state == "107"){
    	$("#err_msg").html( "密码错误！" );
    }else if(data.state == "108"){
    	$("#err_msg").html( "用户名重复！" );
    }else{
    	if(callback == "account_login" || callback == "loginOut"){
    		$("#err_msg").html( data.state+"..."+data.msg );
    	}else if(callback == "1"){
    		$("#msg").html( "<font color=red>"+data.state+"..."+data.msg+"</font>" );
    	}else{
    		$("#msg_bad").html( "<font color=red>"+data.state+"..."+data.msg+"</font>" );
    	}
        
    }
}

function show_name(username) {
	$(".body_bg").hide();
	$("#account").hide();
    $("#head_login").hide();
	$("#head_user").show();
	$("#head_user .title span").html(username);
}
function show_guest() {
	$("#head_login").show();
	$("#head_user").hide();
}
</script>
<style type="text/css">
	.account{width: 393px;margin:0 auto;position:fixed;z-index: 199; display: none;}
	.account .title{background-color: #f7f7f7;border: 1px solid #ddd;border-width: 1px 1px 0 1px;border-bottom: 0;position: relative;}
	.account .title span{width: auto;height: 18px;font-size: 16px;font-weight: bold;color: #666;text-indent: 20px;padding: 15px 0 13px;margin-right: 29px;display: block;overflow: hidden;text-overflow: ellipsis;text-align: left;box-sizing: content-box;}

	.account .title .close{width: 16px;height: 16px;position: absolute;right: 20px;top: 16px;background: url(/images/dot.png) no-repeat -56px -48px;}
	.account .title .close:hover{background: url(/images/dot.png) no-repeat -72px -48px;}
	.account .out_box{background-color: #FFF;border: 1px solid #ddd;border-width: 0 1px 1px 1px;position: relative;overflow: visible;}
	.account .out_box .border_top{border-top: 1px solid #F2F2F2;}
	.account .out_box .in_box{padding:0px 20px 60px 20px;position: relative;}
	.account .out_box .in_box p{position: relative;margin: 0;margin-bottom: 15px;}
		.account .out_box .in_box p span{display:block;position:absolute;top:8px;left:6px;width:0;height:24px;overflow:hidden;padding:0 0 0 24px;z-index: 1;}
 	.account .out_box .in_box p span.username_icon{background: url(/images/dot1.png) no-repeat 0 -68px;;}
 	.account .out_box .in_box p span.pwd_icon{background: url(/images/dot1.png) no-repeat 0 -147px;;}

    .account .out_box .in_box p .input{width:300px;display:block;position:relative;padding:12px 10px 12px 38px;border:1px solid #ddd;font-size: 14px;color:#666;}

    .account .out_box .in_box .submit{width:100%;background-color: #3f89ec;  display: block;height: 48px;font-size: 16px;font-weight: bold;cursor: pointer;color: #fff;background: #3f89ec;border-radius: 3px;border: none;-moz-border-radius: 3px;-webkit-border-radius: 3px;transition: .3s;-moz-transition: .3s;-o-transition: .3s;-webkit-transition: .3s;}

 	.account .out_box .in_box .a{position:absolute;right:0; font-size:12px;text-decoration: none;color:#1b66c7;font-family: Arial, Helvetica, STHeiti,"宋体";cursor: pointer;}
    .label{display: inline;color: #666;font-size: 12px;margin-left:5px;}
    .account #reg input[type="input"]{padding-left: 10px;}
    .account #reg input[type="password"]{padding-left: 10px;}
	#account .focus{border-color:#488EE7}
    .body_bg{width:100%;height:100%;z-index:99;background-color:#000;display:none;position:fixed;left:0px;top:0px;opacity:0.6;-webkit-transition: opacity .6s ease-in-out;transition: opacity .6s ease-in-out;}
	</style>
<div class="body_bg"></div>
<div id="account" class="account">
	<div class="title">
		<span class="font">登录帐号</span>
		<div class="close"></div>
	</div>
	<div class="out_box">
		<div class="border_top">
			<p style="color:red;height:30px;line-height:30px;margin-bottom:0px;text-indent: 20px" id="err_msg"></p>
			<div class="in_box" id="login">
				<p><span class="username_icon"></span><input type="input" class="input" id="username" placeholder="用户名"/></p>
				<p><span class="pwd_icon"></span><input type="password" class="input" id="password" placeholder="密码"/></p>
			    <p><input type="checkbox" id="checkbox" style="vertical-align: middle;"/><label class="label">下次自动登录</label></p>
			    <p>
			    	<input type="submit" value="登陆" class="submit" id="login_account"/>
			    	<label class="a" style="top: 60px;" id="login_reg_a">立即注册</label>
			    	<label class="a" style="top: -28px;" >忘记密码？</label>
			    </p>
			</div>
			<div class="in_box" id="reg" style="display:none;">

				<p><input type="input" class="input" id="reg_username" placeholder="请输入手机号"/></p>
				<p><input type="password" class="input" id="reg_password" placeholder="请输入密码"/></p>
			    <p><input type="input" class="input" id="reg_nick" placeholder="输入您的昵称"/></p>
			    <p>
			    	<input type="submit" value="注册" class="submit" id="reg_login"/>
			    	<label class="a" style="top:60px;" id="login_a">已有账户</label>
			    </p>
			</div>
		</div>
	</div>
</div>	