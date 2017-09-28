#!/bin/bash
# Name: getinterface.sh
# Description: 获取网卡信息
# Author: Super DD
# Version: 0.0.1
# Datetime: 2017-09-28 10:21:08
# Usage: getinterface.sh


# 显示IP信息， grep的-o是使用正则，仅显示匹配值
SHOWIP() {
	if ! ifconfig | grep -o "^[^[:space:]]\{1,\}" | grep $1 &> /dev/null; then
		return 13
	fi

	echo -n "${1}:"
	ifconfig $1 | grep -o "inet 地址:[0-9\.]\{1,\}" | cut -d: -f2
	echo
}

SHOWETHER() {
	if ! ifconfig | grep -o "inet 地址:[0-9\.]\{1,\}" | cut -d: -f2 | grep $1 &> /dev/null; then
		return 14
	fi

	echo -n "${1}:"
	ifconfig | grep -B 1 "$1" | grep -o "^[^[:space:]]\{1,\}"
	echo
}

USAGE() {
	echo "`basename $0` <-i interface | -I IP>"
}

while getopts ":i:I:" SWITCH; do
	case $SWITCH in
		i)
			SHOWIP $OPTARG
			[ $? -eq 13 ] && echo "Wrong ehtercard"
			;;
		I)
			SHOWETHER $OPTARG
			[ $? -eq 14 ] && echo "Wrong IP."
			;;
		\?)
			USAGE
			;;
	esac
done
