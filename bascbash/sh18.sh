#!/bin/bash
# 描述：列出某个目录下所有文件的权限
# 时间：2016.05.02 周一 14：47
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "这个案例是，您输入一个目录，然后查询目录里面所有文件的权限\r\n"

read -p "请输入目录名：" dir

# 1,检测是否是一个目录
if [ -z "$dir" -o ! -d "$dir" ]; then 
	echo "你输入的不是一个目录名"
	exit 1
fi 

# 2,开始检测文档权限
fileList=$(ls $dir)

for file in $fileList
do
	perm=""
	test -r "$dir/$file" && perm="$perm 只读"
	test -w "$dir/$file" && perm="$perm 可写"
	test -x "$dir/$file" && perm="$perm 可执行"
	echo "这个文件 $dir/$file 具有："$perm" 权限 "
done
