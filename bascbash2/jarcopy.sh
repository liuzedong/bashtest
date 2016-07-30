#!/bin/bash
# 描述：复制jar包到/home/liuzedong/fabu/ 目录下
# 作者：刘泽栋
# 时间：2016.07.13

dirfile=/media/liuzedong/0002239100048DF2/answern/发布的jar包/member和product/`date "+%Y%m%d%H%M" `
if [ -d ${dirfile}${datefile} ]; then
	echo "存在"
else 
	echo "不存在"
	mkdir -p ${dirfile}
# memberApi
	cp /home/liuzedong/.m2/repository/com/isoftstone/iics/www/com.isoftstone.iics.www.service.member.api/0.0.1-SNAPSHOT/com.isoftstone.iics.www.service.member.api-0.0.1-SNAPSHOT.jar \
	${dirfile}
# memberImpl
	cp /home/liuzedong/.m2/repository/com/isoftstone/iics/www/com.isoftstone.iics.www.service.member.impl/0.0.1-SNAPSHOT/com.isoftstone.iics.www.service.member.impl-0.0.1-SNAPSHOT.jar \
	${dirfile}
# productImpl
	cp /home/liuzedong/.m2/repository/com/isoftstone/iics/com.isoftstone.iics.www.service.product.impl/0.0.1-SNAPSHOT/com.isoftstone.iics.www.service.product.impl-0.0.1-SNAPSHOT.jar \
	${dirfile}
# productApi
	cp /home/liuzedong/.m2/repository/com/isoftstone/iics/com.isoftstone.iics.www.service.product.api/0.0.1-SNAPSHOT/com.isoftstone.iics.www.service.product.api-0.0.1-SNAPSHOT.jar \
	${dirfile}

	echo "复制完成"
fi


#cp /home/liuzedong/.m2/repository/com/isoftstone/iics/www/com.isoftstone.iics.www.service.member.api/0.0.1-SNAPSHOT/com.isoftstone.iics.www.service.member.api-0.0.1-SNAPSHOT.jar \
#/home/liuzedong/fabu/`date "+%Y%m%d%H%M" `/
