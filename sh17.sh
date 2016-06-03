#!/bin/bash
# 描述：检测1-100之间的网段，是否存在
# 时间：2016.05.02 周一 13：51
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local:/sbin:~/bin
export PATH

network="192.168.1"	# 定义一个网段的前面的部分

for sitenu in $(seq 100 200) # seq为sequence（缩写）,就是输出1-100
do
	ping -c 1 -w 1 ${network}.${sitenu} &> /dev/null && result=0 || result=1

	# 下面启动判断
	if [ "$result" = 0 ]; then 
		echo "${network}.${sitenu} 这个是打开的"
	else
		echo "${network}.${sitenu} 这个是关闭的"
	fi
done
