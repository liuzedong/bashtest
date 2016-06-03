#!/bin/bash
# 描述：使用for循环，查询出/etc/passwd中的所有用户，然后使用id 和 finger命令进行检测
# 时间：2016.05.02 周一 13：43
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


users=$(cut -d ":" -f1 /etc/passwd)

for username in $users
do 
	id $username
	finger $username
done
