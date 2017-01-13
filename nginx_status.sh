#!/bin/bash
HOST="127.0.0.1"
PORT="80"
 
function proc_num {
    num=$(pgrep nginx |wc -l)
}
function active {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |grep 'Active' |awk '{print $NF}')
}
function reading {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |grep 'Reading' |awk '{print $2}')
}
function writing {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |grep 'Writing' |awk '{print $4}')
}
function waiting {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |grep 'Waiting' |awk '{print $6}')
}
function accepts {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |awk NR==3 |awk '{print $1}')
}
function handled {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |awk NR==3 |awk '{print $2}')
}
function requests {
    num=$(curl "http://$HOST:$PORT/nginx_stat/" |awk NR==3 |awk '{print $3}')
}

$1
echo ${num:-0}
