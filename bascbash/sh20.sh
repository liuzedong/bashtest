#!/bin/bash
# 作者：刘泽栋
# 时间：2016.07.07
# 描述：探测局域网类的ip主机是否开启


for siteip in $(seq 1 254)
do
	# ip地址
	site="192.168.18.${siteip}"
	ping -c1 -W1 ${site} 1> /dev/null 2> /dev/null
	if [ "$?" = "0" ]; then
		echo "$site is UP"
	else
		echo "$site is DOWN"
	fi
done
