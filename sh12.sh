#!/bin/bash
# 描述：让case的使用方式，案例
# 时间：2016.05.01 周日 22：42
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "这是，让你请你输入一个参数，然后进行判断的程序"
#read -p "请你输入一个参数：" choice # 使用read的方式，暂时注销

#case $choice in # 使用read的方式，暂时注销
case $1 in
	"one")
		echo "你选择的第一个"
		;;
	"two")
		echo "你选择的第二个"
		;;
	"three")
		echo "你选择的第三个"
		;;
	*)
		echo "请你使用 ， bash $0 (one|two|three)"
		;;
esac
