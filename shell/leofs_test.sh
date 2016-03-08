#!/bin/sh
#./redis-cli -h 192.168.1.18 -p 7777 -n 1
#SMEMBERS tokens
#srem|sismember, tokens, Token
#curl -H "token:5602fb08588a25a552ddab0e6d7bd120 -F "filename=@text.txt" -i http://192.168.1.16/4b939e397ca34eb974595f5e09a6e500
DATE=`date '+%Y-%m-%d'`
DATE_MD5=""
TEXT_MD5=""

date_md5()
{
    echo -n ${DATE} | md5sum | awk '{print $1}'
}

text_md5()
{
    md5sum text.txt | awk '{print $1}'
}

get()
{
     DATE_MD5=`date_md5`
     echo $DATE_MD5
     curl -H "special-info:${DATE_MD5}" -i -o get.16.txt http://192.168.1.16/246021aa2dcbfe44dda60e6a78bf5265
     curl -H "special-info:${DATE_MD5}" -i -o get.17.txt http://192.168.1.17:8080/246021aa2dcbfe44dda60e6a78bf5265
}

post()
{
    echo `text_md5`
}

case $1 in
    date)
        date_md5
        ;;
    get)
        get
        ;;
    post)
        post
        ;;
    text)
        text_md5
        ;;
    *)
        echo "other"
    ;;
esac

curl -F "filename=@5.jpg" -i http://192.168.1.17:8020/bdc616b9641ec7a4aef0a40259439b54

curl -o all http://192.168.1.17:8020/bdc616b9641ec7a4aef0a40259439b54
curl -o 1 http://192.168.1.17:8020/bdc616b9641ec7a4aef0a40259439b54-60x60
curl -o 2 http://192.168.1.17:8020/bdc616b9641ec7a4aef0a40259439b54-120x120
curl -o 3 http://192.168.1.17:8020/bdc616b9641ec7a4aef0a40259439b54-512x512
curl -o 4 http://192.168.1.17:8020/bdc616b9641ec7a4aef0a40259439b54-800x800