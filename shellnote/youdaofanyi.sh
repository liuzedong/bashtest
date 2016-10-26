#!/bin/bash

#作者：刘泽栋
#时间：2016.10.26
#描述：使用有道翻译的接口，进行翻译,此处使用到jq进行解析json数据
#	所以，先安装jq软件。sudo apt-get install jq
#	keyfrom=DongDongXia，key=899140312


if [ -n "$1" ];then
	#将中文，进行urlencode，
	q=`echo $1 | tr -d '\n' | od -An -t x1 | tr -d '\n' | tr ' ' %`
	#echo $q

	#使用get访问有道API,获得返回的json数据
	resultJson=`curl -s -X GET "http://fanyi.youdao.com/openapi.do?keyfrom=DongDongXia&key=899140312&type=data&doctype=json&version=1.1&q=$q"`
	#echo $resultJson

	# 此处做一个简单判断，查看，你系统上是否有jq命令
	jq --version 1> /dev/null 2> /dev/null
	if [ ! $? -eq 127 ];then
		#解析json字符串，获得需要的数据
		#翻译文本
		QUERY=`echo "$resultJson" | jq '.query'`
		#词典
		EXPLAIS=`echo "$resultJson" | jq '.basic.explains'`
		#翻译结果
		ERANSLATION=`echo "$resultJson" | jq '.translation'`

		# 格式，将查询的内容打印
		echo "查询："
		echo -e "\t$QUERY"
		echo "词典："
		echo "$EXPLAIS"
		echo "翻译："
		echo "$ERANSLATION"
		#echo "查询：\r\n\t$QUERY\r\n词典：\r\n$EXPLAIS\r\n翻译：\r\n\t$ERANSLATION"
	else
		echo "jp 这个命令不存在，请使用 sudo apt-get install jq 进行安装"
	fi

else 
	echo -e "脚本使用方式：\n$0 翻译文本"
fi

