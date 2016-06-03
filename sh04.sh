#!/bin/bash
# 描述：用户输入两个数字，然后进行乘法运算
# 时间：2016.04.27 周三 23:04
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "请你输入两个数字，我们将帮你进行乘法运算\r\n"
read -p "请你输入第一个数字：" firstNum
read -p "请你输入第二个数字：" lastNum

total=$((${firstNum}*${lastNum}))
echo "${firstNum} * ${lastNum} = ${total}"
