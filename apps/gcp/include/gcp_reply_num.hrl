-define(debug(Info), io:format("~p...~p...~p~n", [?MODULE, ?LINE, Info])).

-define( TPL_FILE_PATH, "../include/" ).

-define( Package_Json(Num, Msg), "{\"state\":\""++integer_to_list(Num)++"\",\"msg\":\""++Msg++"\"}"  ).
-define( REPLY_SUCCISE, 200 ). %运行成功
-define( REPLY_CODE_CRASH, 9 ).     %代码crash
-define( REPLY_NO_THIS_EVENT, 10 ). %没有找到对应的事件
-define( REPLY_CODE_VERIFY_FAIL, 101 ). %条件验证失败
-define( REPLY_NO_COOKIE, 105 ).        %没有登录
-define( REPLY_NO_USER, 106 ).          %没有该用户
-define( REPLY_PWD_ERROR, 107 ).        %密码错误
-define( REPLY_USERNAME_REPEART, 108 ). %用户名重复

-define( REPLY_NO_THIS_SHOP, 1001 ). % 没有该商品