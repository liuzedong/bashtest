#!/bin/bash
# Name: mkscript.sh
# Description: create script template
# Author: Super DD
# Version: 0.0.1
# Datetime: 2017-09-28 09:05:12
# Usage: mkscript.sh FILENAME

# 循环询问，是否添加描述信息，Description
# getopts 这个命令，是用来获取，脚本后面的参数的， $OPT: 参数Key， $OPTARG: 参数名, $OPTIND 参数下标
while getopts ":d:" SWITCH; do
	case $SWITCH in
		d)
			DESC=$OPTARG
			;;
		\?)
			echo "Usage: `basename $0` [ -d DESCRIPTION ] FILENAME"
			sleep 1
			;;
	esac
done

# 下面的shift 是将参数，移位
shift $[$OPTIND-1]

# 判断，第一个参数中的文件，是否有内容，如果没有，就写入模板
if ! grep "[^[:space:]]" $1 &> /dev/null; then
	cat > $1 << EOF
#!/bin/bash
# Name: `basename $1`
# Description: $DESC
# Author: Super DD
# Version: 0.0.1
# Datetime: `date "+%F %T"`
# Usage: `basename $1`

EOF
fi

# 使用vim编辑打开，并将光标定位在最后一行
vim + $1

# 当退出编辑的时候，检测语法错误，如果有错误的话，可以选择继续编辑或者退出
until bash -n $1 &> /dev/null; do
	read -p "Syntax error, q|Q quitiong, others for edition:" OPT
	case $OPT in
		q|Q)
			echo "Quit..."
			exit 8
			;;
	  *)
			vim $1
			;;
	esac
done

chmod 755 $1
