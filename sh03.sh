#!/bin/bash
# 描述：用户输入文件名称，然后创建出前天，昨天，今天  日期的后缀名称的三个文件，类似file_20160427
# 时间：2016.04.27 周三 21:48
# 作者：刘泽栋

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "请输入你文件名称：" fileName

date1=$(date --date '2 day ago' +%Y%m%d)
date2=$(date --date '1 day ago' +%Y%m%d)
date3=$(date +%Y%m%d)

file1=${fileName}_${date1}
file2=${fileName}_${date2}
file3=${fileName}_${date3}

touch ${file1}
touch ${file2}
touch ${file3}

echo "文件创建成功啦：${file1}, ${file2}, ${file3} \r\n"
