#! /bin/sh

USER_NAME=`uname -n`
HOST='127.0.0.1'

show_help()
{
    echo "Usage:
    -h | -help show help
    st
    t
    default show info"
}

show_info()
{
    ps aux | grep $USER_NAME@$HOST | grep -v grep
}


close()
{
    local PID=$(ps aux | grep $USER_NAME@$HOST | grep -v grep | awk '{print($2)}')
    kill $PID
    echo $PID closed
}


case $1 in 
    '-h'|'--help')
        show_help ;;
    'st' | 'start')
        erl +pc unicode +K true -name $USER_NAME@$HOST -pa ebin/ deps/*/ebin -config rel/files/sys -s ping_app;;
    'bg')
        erl  -noshell -noinput -detached +pc unicode +K true -name $USER_NAME@$HOST -pa ebin/ deps/*/ebin -config rel/files/sys -s ping_app;;
    'test' )
        erl +pc unicode -pa ebin/ deps/*/ebin/ -s inets;;
    'cl'| 'top')
        close ;;

    *)
        show_info ;;
esac