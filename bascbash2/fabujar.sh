#/bin/bash
# 描述：打jar包
# 时间：2016.07.18
# 作者：刘泽栋

# 渠道
#projectdir=/home/liuzedong/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp2/wtpwebapps/com.isoftstone.iics.bizsupport.epartner
projectdir=/home/liuzedong/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/com.isoftstone.iics.www

# 打包名称
#jarName=epartner-`date "+%Y%m%d%H%M"`.jar
jarName=B2C_Fabu-`date "+%Y%m%d%H%M"`.jar

# 需要打包的文件
classList=`cat ./line.txt`

# jar包放置的位置
#tagterdir=/media/liuzedong/0002239100048DF2/answern/发布的jar包/渠道
tagterdir=/media/liuzedong/0002239100048DF2/answern/发布的jar包/电商


# 开始打包
cd $projectdir
jar -cvf $jarName $classList 1> /dev/null 2> /dev/null 

mv $jarName $tagterdir
cd - 1> /dev/null 2> /dev/null

echo "打包成功：$tagterdir/$jarName"
