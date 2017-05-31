#/bin/bash 

if [ -z $CLASS_HOME ]; then
	CLASS_HOME=`cd ./.. ; pwd`
	echo "我是空的，所以运行啦"
fi


SETEPATH="${CATALINA_BASE:-$CLASS_HOME}"

echo $SETEPATH

echo $CATALINA_BASE

echo $CLASS_HOME


CLASSPATH=asd

if [ ! -z "$CLASSPATH" ]; then
	echo "我是空的文件，这个是没有问题的"
	echo "我不是空的时候运行"
fi


