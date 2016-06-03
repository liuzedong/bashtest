#!/bin/bash
# 描述：让用户输入一个值，然后判断他输入的y还是n，大小写都没有问题
# 时间：2016.04.28 周四 21：36
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "请你输入一个Y(y)或者N(n):\r\n"
read -p "请输入：" yn

[ -z "${yn}" ] && echo "请至少输入一个值" && exit 0
echo ${yn}
[ "$yn" = "'y'" -o "$yn" = "Y" ] && echo "你输入的是y" && exit 0
[ "$yn" = "n" -o "$yn" = "N" ] && echo "你输入的是n" && exit 0

echo "你输入的不是Y或者N，你输入的是：${yn}" && exit 0
