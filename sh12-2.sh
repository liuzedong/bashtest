#!/bin/bash
# 描述：让case的使用方式，案例，这个是修改sh12.sh案例的， 使用function函数来进行编写的
# 时间：2016.05.01 周日 22：42
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


echo "这是，让你请你输入一个参数，然后进行判断的程序"


function printit(){
	echo -n "你选择啦" # 加上-n 可以不间断的输出在统一行
}



case $1 in
	"one")
		printit; echo $1 | tr "a-z" "A-Z"		# 小写转换成大写
		;;
	"two")
		printit; echo $1 | tr "a-z" "A-Z"
		;;
	"three")
		printit; echo $1 | tr "a-z" "A-Z"
		;;
	*)
		echo "请你使用 ， bash $0 (one|two|three)"
		;;
esac
