#!/bin/bash

# tomcat名称
tomcat_name=apache-dubbo-admin

#添加java目录
export JAVA_HOME=/usr/local/java/jdk1.7.0_79
export JRE_HOME=$JAVA_HOME/jre

cd `dirname $0`
#./shutdown.sh
PIDS=`ps -ef | grep java | grep "$tomcat_name" |awk '{print $2}'`

if [ -z "$PIDS" ]; then
    echo "ERROR: The $tomcat_name does not started!"
	./startup.sh
   exit 1
fi

# 循环杀死进程
for PID in $PIDS ; do
     kill -9 $PID > /dev/null 2>&1
done


# 添加休眠时间,以防止,还没停止服务,就开启,端口占用
sleep 5
./startup.sh
