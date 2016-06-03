#!/bin/bash
# 描述：1,程序的文件名为何？2,共有几个参数？3,若参数个数少于2个则提示参数过少。4,全部的参数为何？5,第一个参数为何？6，第二个参数为何？
# 时间：2016.05.01 周日 10：25
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "这个脚本的名称：$0"
echo "总共有参数的个数：$#"
[ "$#" -lt 2 ] && echo "你输入的参数少于两个" && exit 0
echo "你输入的参数为：$@"
echo "你输入的第一个参数为：$1"
echo "你输入的第二个参数为：$2"
