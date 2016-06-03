#!/bin/bash
# 描述：用户输入一个数字，然后，计算出1+2+...+你输入的数字。
# 时间：2016.05.02 周一 15：01
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo -e "计算出你1+2+3+...+你输入的数字。\r\n"

read -p "请你输入一个数字：" nu

s=0
for ((i=1;i<=$nu;i=i+1))
do
	s=$(($s+$i))
done

echo "1+2+...+$nu=$s"

