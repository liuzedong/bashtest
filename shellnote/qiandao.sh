#!/bin/bash

# 作者：刘泽栋
# 时间：2016.10.19
# 描述：18云系统，自动签到

# 获取token
result=`curl -d "LoginInfo=zdliuc&Password=8f24e337fc6605f2ddfe50d1a404669b" "http://www.18bg.com/api/sign/post"`
result=${result#*\"Token\":\"}
result=${result%%\"*}

# 进行签到请求
#curl -d "isWeb=true&auth=authentication D3F90A2BC949274C959B9B9BCFBF7299" "http://www.18bg.com//check/signin" 1> /dev/null 2> /dev/null
curl -d "isWeb=true&auth=authentication ${result}" "http://www.18bg.com//check/signin" 1> /dev/null 2> /dev/null

# 日志目录
bypylogfile=/media/liuzedong/0002239100048DF2/answern/log/bypy.log
echo -e "$result `date "+%Y-%m-%d %H:%M"`： 签到成功" >> $bypylogfile
