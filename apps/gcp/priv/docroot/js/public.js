$(function(){
    $("#options .option").mouseover(function(){
        var $isLogin = $("#options .title span").html();
        if($isLogin == "登录"){

        }else{
            var $index = $(this).index();
            $("#options .more").eq( $index ).show();
        }
    }).mouseout(function(){
        var $isLogin = $("#options .title span").html();
        if($isLogin == "登录"){

        }else{
            var $index = $(this).index();
            $("#options .more").eq( $index ).hide();
        }
    });
})

function setCookie(key,value,expiredays)
{
    var exdate=new Date()
    exdate.setDate(exdate.getDate()+expiredays)
    document.cookie=key+ "=" +escape(value)+
    ((expiredays==null) ? "" : ";expires="+exdate.toGMTString())
}

function getCookie(key)
{
    if (document.cookie.length>0)
    {
        c_start=document.cookie.indexOf(key + "=")
        if (c_start!=-1){ 
            c_start=c_start + key.length+1 
            c_end=document.cookie.indexOf(";",c_start)
            if (c_end==-1) c_end=document.cookie.length
            return unescape(document.cookie.substring(c_start,c_end))
        } 
    }
    return ""
}

//ajax 发送数据给服务端
function ajax($url, $callback){
    $.ajax({
        url:$url,
        dataType: "json",
        error:function(){
            alert( "链接服务器失败，请稍后重试！" );
        },
        success:function(data){
            callback( data, $callback );
            
        }
    })
}
