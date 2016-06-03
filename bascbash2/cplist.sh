#!/bin/bash
# 描述：复制目录结构，
# 时间：2016.06.03 
# 作者：刘泽栋

# 获得指定目录

taget=com.isoftstone.iics.www/

dir=/home/liuzedong/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/com.isoftstone.iics.www/

list=$(find ${dir} -type d) 


for l in ${list} 
do
	#echo ${l} | awk -F "${taget}" '{print $2}' | mkdir -p
	dir2=$(echo ${l} | awk -F "${taget}" '{print $2}')
	mkdir -p www/$dir2
done
#awk -F "com.isoftstone.iics.www/" '{print $2}'

