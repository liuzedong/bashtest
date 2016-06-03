#!/bin/bash
# 描述：让用户输入一个值，然后判断他输入的y还是n，大小写都没有问题，这个将修改成使用if then的形式
# 时间：2016.05.01 周日 10：50
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "请你输入一个Y(y)或者N(n):\r\n"
read -p "请输入：" yn


if [ -z "${yn}" ]; then
	echo "请至少输入一个字符"
	exit 0
fi

if [ "${yn}" = "y" ] || [ "${yn}" = "Y"  ]; then
	echo "你输入的是Y/y"
	exit 0
fi

if [ "${yn}" = "n" ] || [ "${yn}" = "N" ]; then
	echo "你输入的是N/n"
	exit 0
fi

echo "你输入的不是Y/N，而是：${yn}"
