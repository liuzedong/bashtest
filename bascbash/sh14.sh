#!/bin/bash
# 描述：使用循环，进行1到100 相加的值
# 时间：2016.05.02 周一 13：29
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

while [ "$i" != 100 ]
do
	i=$(($i+1))	# 变量自增
	s=$(($s+$i))
done
echo "计算出来的结果是：$s"
