#!/bin/bash
# 描述：用户输入一个文件名称，判断这个文件是否存在，若不存在，就输出不存在，存在，就判断这个文件的类型，最后判断下，用户对这个文件的权限
# 时间：2016.04.27 周三 23:39
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "判断您输入的文件是否存在，然后判断他是什么类型的文件，最后判断下你对该文件是否拥有权限\r\n"
read -p "请输入你要判断的文件名：" fileName

test -z ${fileName} && echo "必须输入一个文件名" && exit 0	#让用户输入一个文件名称，没有输入的话，正常退出

test ! -e ${fileName} && echo "${fileName}：这个文件文件不存在" && exit 0	#判断这个文件不存在，然后输出信息，正常推出

# 开始判断文件的类型
test -f ${fileName} && echo "${fileName}：为文件" 
test -d ${fileName} && echo "${fileName}：为目录"
test -b ${fileName} && echo "${fileName}：为块设备"
test -c ${fileName} && echo "${fileName}：为字符驱动"
test -S ${fileName} && echo "${fileName}：为Socket链接文件"
test -p ${fileName} && echo "${fileName}：为FIFO文件"
test -L ${fileName} && echo "${fileName}：为链接文件"

# 开始判断用户对该文件是否拥有权限
test -r ${fileName} && echo "${fileName}：拥有只读权限"
test -w ${fileName} && echo "${fileName}：拥有可写权限"
test -x ${fileName} && echo "${fileName}：拥有执行权限"


