-module( gcp_log ).
-export( [add_view/2, crashmsg/3] ).
-include( "../include/gcp.hrl" ).
crashmsg(Arg, SC, Str) ->
    write_log( [Arg, SC, Str] ),
    Html ="<meta http-equiv=\"Content-Type\" content=\"text/html\"; charset=\"utf-8\">
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\">
            <style>*{margin: 0;padding: 0;}body{text-align: center;font-family: 'Helvetica Neue',sans-serif;overflow-x: hidden;background-color:#eee;}
            span.t2 {margin-top: 50px;display: inline-block;width: 100px;height: 115px;margin-top: -10px;background: url('/images/wei_card.png') no-repeat -200px 0;}
            p.t2 {text-align: center;padding-left: 10px;color: #666;margin-top: 25px;}</style>
            <div style=\"width:180px;margin:20px auto;\"><span class=\"t2\"></span><p class=\"t2\">系统繁忙,请稍候再试.</p></div>",
    {html, Html}.

write_log( Arg ) ->
    file:write_file("crash.log", 
                    erlang:list_to_binary(
                      io_lib:format("time ~p Crash ~p ~n", [erlang:localtime(), Arg]))).

add_view(Url, _A) ->
    gcp_ctrl:add_shop( Url, +1, 0, 0, 0, 0 ).

