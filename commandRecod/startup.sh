#!/bin/sh

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------------------
# Start Script for the CATALINA Server
#
# $Id: startup.sh 562770 2007-08-04 22:13:58Z markt $
# -----------------------------------------------------------------------------

# Better OS/400 detection: see Bugzilla 31132
# 定义两个变量，这两个变量是用来确定，电脑是那个系统的，在百度中查询CYGWIN，OS400，Darwin 可知道，这是三个系统的名称
os400=false
darwin=false
case "`uname`" in
CYGWIN*) cygwin=true;;
OS400*) os400=true;;
Darwin*) darwin=true;;
esac

# resolve links - $0 may be a softlink
# 获取当前文件名称，就是start.sh
PRG="$0"

# 判断这个文件是否为软连接，一般都是在tomcat中启动的，所以这个while循环是不会进入的
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done
 
# 获取文件的，路径。如果再当前文件下执行的，那么PRGDIR=. 。如果是绝对路径，那么这个就是PRGDIR=绝对路径
PRGDIR=`dirname "$PRG"`
# tomcat真正要执行的shell脚本
EXECUTABLE=catalina.sh

# Check that target executable exists
# 一般，你使用shell运行，那么说明你的系统是linux的，所以都是会走的 else中的方法
# 然后再else中，就是判断下，catalina.sh 这个脚本是不是一个可执行文件，如果不是，那么就会提示你，就相当于报错啦
if $os400; then
  # -x will Only work on the os400 if the files are: 
  # 1. owned by the user
  # 2. owned by the PRIMARY group of the user
  # this will not work if the user belongs in secondary groups
  eval
else
  if [ ! -x "$PRGDIR"/"$EXECUTABLE" ]; then
    echo "Cannot find $PRGDIR/$EXECUTABLE"
    echo "This file is needed to run this program"
    exit 1
  fi
fi 

#这个才是真正执行的tomcat脚本语句，起始上面的都只是在做校验，就可以把这个启动脚本，认为，就只有这一个命令脚本
# $@ 是看，这个./start 后面接的参数，起始，我们启动start的时候，一般都没有加什么参数，所以，下面就是这个文件所有命令
# 解开命令 exec ./catalina.sh start 
exec "$PRGDIR"/"$EXECUTABLE" start "$@"
