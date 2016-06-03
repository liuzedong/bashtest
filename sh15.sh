#!/bin/bash
# 描述：for循环的练习
# 时间：2016.05.02 周一 13：36
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

for animal in dog cat elephant
do 
	echo "There are ${animal} ..."
done 
