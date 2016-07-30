#!/bin/bash
# 描述：复制目录结构，
# 时间：2016.06.03 
# 作者：刘泽栋

# 获得指定目录


# 需要发布的目录文件。里面每行写一个
forFileName=`cat ./line.txt`

# 发布的项目名称
projectName=epartner   # 渠道
#projectName=B2C_Fabu-	# 电商


# 这个是用来分割的目录
taget='com\.isoftstone\.iics\.bizsupport\.epartner/'   # 渠道
#taget='com.isoftstone.iics.www/'		# 电商

# 项目的目录
dir=/home/liuzedong/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/com.isoftstone.iics.bizsupport.epartner	# 渠道
#dir=/home/liuzedong/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/com.isoftstone.iics.www			# 电商
# 创建一个目录，来存放那些文件
tagetDir=/tmp/project
# 打包后jar的位置
jardir=/media/liuzedong/0002239100048DF2/answern/发布的jar包/渠道

# 创建这个目录，如果存在，就删除，然后创建。不存就创建
if [ -d "${tagetDir}" ]; then
	rm -rf ${tagetDir}
	mkdir ${tagetDir}
else 
	mkdir ${tagetDir}
fi



# 查询出这些目录
list=$(find ${dir} -type d) 


for l in ${list} 
do
	#echo ${l} | awk -F "${taget}" '{print $2}' | mkdir -p
	dir2=$(echo ${l} | awk -F "${taget}" '{print $2}')
	mkdir -p $tagetDir/$dir2
done
#awk -F "com.isoftstone.iics.www/" '{print $2}'

# 把需要发布文件复制过去
for line in $forFileName
do
	cp $dir/$line $tagetDir/$line
done


# 获取当前时间
jarDate=`date "+%Y%m%d%H%M"`
jarName=${projectName}${jarDate}.jar
cd ${tagetDir}

# 进行项目打jar包
# jar -cvf ${projectName}.${jarDate}.${1}.jar * 1> /dev/null 2> /dev/null
jar -cvf $jarName $forFileName 1> /dev/null 2> /dev/null

cp `ls | grep jar` $jardir

# 返回原来的目录，并且删掉那个目录
cd - 1> /dev/null 2> /dev/null
rm -rf ${tagetDir}
echo "打包成功：$jardir/$jarName"
