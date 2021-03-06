#!/bin/bash
# 描述：让用户输入一个值，然后判断他输入的y还是n，大小写都没有问题.这个是使用if elif fi 做判断的。
# 时间：2016.05.01 周四 20:34
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "请你输入一个Y(y)或者N(n):\r\n"
read -p "请输入：" yn

if [ -z "${yn}" ]; then
	echo "请你输入最少一个字符哦"
	exit 0

elif [ "${yn}" = "y" ] || [ "${yn}" = "Y" ]; then 
	echo "你输入的Y/y"
	exit 0

elif [ "${yn}" = "N" ] || [ "${yn}" = "n" ]; then
	echo "你输入的N/n"
	exit 0

else 
	echo "你输入的是：${yn}"
	exit 0
fi
