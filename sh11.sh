#!/bin/bash
# 描述：1,让使用者输入他们的退伍日期。2,再由现在的日期对比退伍日期。3,由两个日期的比较来显示[还需要几天]才能退伍的字样
# 时间：2016.05.01 周日 21：31
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# 1，告知用户这支程序的用途，并且告知应该如何输入日期格式
echo "这个程序是用来算出你离退伍还需要多久!\r\n"
read -p "请你输入日期（YYYYMMDD ex>20160501）" date2

# 2，测试一下，这个输入的内容是否正确，利用正则表达式法
date_d=$(echo $date2 | grep "[0-9]\{8\}") # 看看是不是 8个数字

if [ "$date_d" = "" ]; then 
	echo "你输入的日期格式不正确"
	exit 1
fi


# 3，开始计算日期
declare -i date_dem=`date --date="$date2" +%s` #退伍日期的秒数
declare -i date_now=`date +%s` #现在时间的秒数
declare -i date_total_s=$(($date_dem-$date_now)) #剩下秒数
declare -i date_d=$(($date_total_s/60/60/24)) # 转换成天

if [ "$date_d" -lt "0" ]; then # 判断是否退伍啦
	echo "你已经退伍啦,已经退伍:"$((-1*$date_d))" 天"
else 
	declare -i date_h=$(($(($date_total_s-$date_d*60*60*24))/60/60))
	echo "你离退伍还有$date_d 天，$date_h 小时"
fi
