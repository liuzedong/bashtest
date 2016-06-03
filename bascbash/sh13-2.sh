#!/bin/bash
# 描述：until语句的练习，当使用条件成立的时候，就结束循环
# 时间：2016.05.02 周一 13：17
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

until [ "$yn" = "yes" -o "$yn" = "YES" ]
do 
	read -p "请输入yes/YES进行结束循环:" yn
done

echo "OK，你输入啦正确的答案"
