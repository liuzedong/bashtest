#!/bin/bash
# 描述：1，判断$1是否为hello，如果是的话，就显示Hello, How are you ?,2,如果没有添加参数的话，就提示用户必须使用参数的方法。3,如果用户输入的不是Hello，就提示用户需要使用hello
#		修改sh09.sh 的案例，使用case 的方式来进行
# 时间：2016.05.01 周日 20：44
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

case $1 in 
	"hello") 
		echo "Hello, How are you"
		;;
	"")
		echo "请至少输入一个参数,类似 ex ==> {$0 smoeword} "
		;;
	*)
		echo "请输入 {$0 hello}"
		;;
esac
