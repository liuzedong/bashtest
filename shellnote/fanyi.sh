#!/bin/bash
# Name: fanyi.sh
# Description: 翻译文本，可以使用百度翻译，有道翻译
# Author: Super DD
# Version: 0.0.1
# Datetime: 2017-10-09 11:44:39
# Usage: fanyi.sh [b|y] TEXT

# 先检测，是否安装 jq
jq --version 1> /dev/null 2> /dev/null

if [ $? -eq 127 ];then
	echo "jp 这个命令不存在，请使用 sudo apt-get install jq 进行安装"
	exit 1;	
fi

if [ ! -n "$1" ];then
	echo -e "脚本使用方式：\n$0 翻译文本"
	exit 2;
fi

BAIDUFANYI() {
	Q=`echo $* | tr -d '\n' | od -An -t x1 | tr -d '\n' | tr ' ' %`
	APPID=
	KEY=
	SALT=123
	# MD5 编码
	SIGN=`echo -n "$APPID$*$SALT$KEY" | md5sum | cut -d' ' -f1`
	URL=`echo "https://fanyi-api.baidu.com/api/trans/vip/translate?q=$Q&from=auto&to=auto&appid=$APPID&salt=$SALT&sign=$SIGN"`

	RESULT=`curl -s -X GET "$URL"`

	#翻译结果
	SRC=`echo "$RESULT" | jq '.trans_result[].src'`
	DST=`echo "$RESULT" | jq '.trans_result[].dst'`

	# echo "$RESULT"

	# 打印出翻译的结果
	echo "查询："
	echo -e "    $SRC"
	echo "翻译："
	echo -e "    $DST"
}

YOUDAOFFANYI() {
	Q=`echo $* | tr -d '\n' | od -An -t x1 | tr -d '\n' | tr ' ' %`
	APPID=
	KEY=
	SALT=456
	# MD5 编码
	SIGN=`echo -n "$APPID$*$SALT$KEY" | md5sum | cut -d' ' -f1`
	URL=`echo "https://openapi.youdao.com/api?q=$Q&from=auto&to=auto&appKey=$APPID&salt=$SALT&sign=$SIGN"` 
	RESULT=`curl -s -X GET "$URL"`

	#翻译文本
	QUERY=`echo "$RESULT" | jq '.query'`
	#词典
	EXPLAIS=`echo "$RESULT" | jq '.basic.explains'`
	#翻译结果
	ERANSLATION=`echo "$RESULT" | jq '.translation'`

	# echo "$RESULT"

	# 打印出翻译的结果
	echo "查询："
	echo -e "    $QUERY"
	echo "词典："
	echo "$EXPLAIS"
	echo "翻译："
	echo "$ERANSLATION"
}

echo -e "1:百度翻译\n2:有道翻译\n"
read -p "选择:" OPT
# clear

# echo "$OPT" 

case $OPT in
	1)
		BAIDUFANYI $*
		;;
	2)
		YOUDAOFFANYI $*
		;;
	*)
		echo "Usage: $0 [b|y] TEXT"
		;;
esac
