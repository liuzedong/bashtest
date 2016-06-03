#!/bin/bash
# 描述：1，判断$1是否为hello，如果是的话，就显示Hello, How are you ?,2,如果没有添加参数的话，就提示用户必须使用参数的方法。3,如果用户输入的不是Hello，就提示用户需要使用hello
# 时间：2016.05.01 周日 20：44
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

if [ -z "$1" ]; then
	echo "你请必须输入一个参数。"

elif [ "$1" = "hello" ]; then 
	echo "Hello, How are you"

else 
	echo "你输入的不是Hello，请必须输入hello哦"
fi
