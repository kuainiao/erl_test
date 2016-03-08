#!/bin/bash
string="alibaba is a great company"
echo `expr index "$string" is`


# @doc 文本操作 find xargs sed
#find . -name rebar.config|xargs sed -i 's/require_otp_vsn,\s\+"\(.\+\)"/require_otp_vsn, "R15B03|R16B*|17|18"/g'
#sed -i 's/127.0.0.1/192.168.1.16/' priv/docroot/index.html  %把index.html 中的127.0.0.1替换成192.168.1.6


