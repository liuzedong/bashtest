#!/bin/bash
# 描述：使脚本后面的变量进行偏移，shift
# 时间：2016.05.01 周日 10：35
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "你输入的参数总个数为：$#"
echo "你输入的参数为：$@"

shift # 这里进行一次偏移，就是相当与把第一个参数给删除掉啦

echo "进行一次偏移后的变量个数：$#"
echo "进行一次偏移侯的变量为：$@"

shift 3 # 这里进行第二次偏移，偏移三个变量，相当于把前三个变量全部去掉

echo "进行第二次3个偏移后的个数：$#"
echo "进行第二次3个偏移侯的变量：$@"
