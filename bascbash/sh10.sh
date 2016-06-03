#!/bin/bash
# 描述：使用netstat和grep ，查找出WWW，SSH，FTP，and Mail等信息
# 时间：2016.05.01 周日 20：52
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#1,先做一些告知的动作
echo "Now, I will detect your Linux server's service !"
echo "The www,ssh,ftp and mail will be detect! \r\n"

#2,进行一些检测的动作并输出信息
testing=$(netstat -tuln | grep ":80") # 探测80端口是否打开

if [ "$testing" != "" ]; then
	echo "www is runing in you system"
fi

testing=$(netstat -tuln | grep ":22") # 探测22端口是否存在
if [ "$testing" != "" ]; then
	echo "ssh is runing in you system"
fi

testing=$(netstat -tuln | grep ":21") # 探测21端口是否存在
if [ "$testing" != "" ]; then 
	echo "FTP is runing in you system"
fi

testing=$(netstat -tuln | grep ":25") # 探测25端口是否存在
if [ "$testing" != "" ]; then 
	echo "Mail is runing in you system"
fi
