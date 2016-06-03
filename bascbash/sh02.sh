#!/bin/bash
# 描述：让用户填写自己的姓与名 ，然后打印出来
# 时间：2016.04.27 周三 21：43
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "请输入你的姓：" firstName
read -p "请输入你的名子：" lastName

echo "你的姓名是：${firstName}${lastName}"
