#!/bin/sh

# 下面是一大堆的 协议，许可证信息，我还以为是什么很重要的信息勒，直接忽略
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
# 到这里许可信息才算完毕，这之间的信息 直接忽略


# 下面的这些，是该脚本中，会定义的变量，以及这些变量的描述信息。可以看看
# -----------------------------------------------------------------------------
# Start/Stop Script for the CATALINA Server
#
# Environment Variable Prerequisites
#   CATALINA_HOME   为tomcat的安装目录
#   CATALINA_HOME   May point at your Catalina "build" directory.
#
#   CATALINA_BASE   (Optional) Base directory for resolving dynamic portions
#                   of a Catalina installation.  If not present, resolves to
#                   the same directory that CATALINA_HOME points to.
#
#   CATALINA_OUT    (Optional) Full path to a file where stdout and stderr
#                   will be redirected.
#                   Default is $CATALINA_BASE/logs/catalina.out
#
#   CATALINA_OPTS   (Optional) Java runtime options used when the "start",
#                   or "run" command is executed.
#
#   CATALINA_TMPDIR (Optional) Directory path location of temporary directory
#                   the JVM should use (java.io.tmpdir).  Defaults to
#                   $CATALINA_BASE/temp.
#
#   JAVA_HOME       Must point at your Java Development Kit installation.
#                   Required to run the with the "debug" argument.
#
#   JRE_HOME        Must point at your Java Development Kit installation.
#                   Defaults to JAVA_HOME if empty.
#
#   JAVA_OPTS       (Optional) Java runtime options used when the "start",
#                   "stop", or "run" command is executed.
#
#   JAVA_ENDORSED_DIRS (Optional) Lists of of colon separated directories
#                   containing some jars in order to allow replacement of APIs
#                   created outside of the JCP (i.e. DOM and SAX from W3C).
#                   It can also be used to update the XML parser implementation.
#                   Defaults to $CATALINA_HOME/endorsed.
#
#   JPDA_TRANSPORT  (Optional) JPDA transport used when the "jpda start"
#                   command is executed. The default is "dt_socket".
#
#   JPDA_ADDRESS    (Optional) Java runtime options used when the "jpda start"
#                   command is executed. The default is 8000.
#
#   JPDA_SUSPEND    (Optional) Java runtime options used when the "jpda start"
#                   command is executed. Specifies whether JVM should suspend
#                   execution immediately after startup. Default is "n".
#
#   JPDA_OPTS       (Optional) Java runtime options used when the "jpda start"
#                   command is executed. If used, JPDA_TRANSPORT, JPDA_ADDRESS,
#                   and JPDA_SUSPEND are ignored. Thus, all required jpda
#                   options MUST be specified. The default is:
#
#                   -agentlib:jdwp=transport=$JPDA_TRANSPORT,
#                       address=$JPDA_ADDRESS,server=y,suspend=$JPDA_SUSPEND
#
#   CATALINA_PID    (Optional) Path of the file which should contains the pid
#                   of the catalina startup java process, when start (fork) is
#                   used
#
#   LOGGING_CONFIG  (Optional) Override Tomcat's logging config file
#                   Example (all one line)
#                   LOGGING_CONFIG="-Djava.util.logging.config.file=$CATALINA_BASE/conf/logging.properties"
#
#   LOGGING_MANAGER (Optional) Override Tomcat's logging manager
#                   Example (all one line)
#                   LOGGING_MANAGER="-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"
#
# $Id: catalina.sh 1040546 2010-11-30 14:47:34Z markt $
# -----------------------------------------------------------------------------


# 用来判断下面的三个系统，看看你的系统是什么，我的linux，所以下面的三个会一直是false
# OS specific support.  $var _must_ be set to either true or false.
cygwin=false
os400=false
darwin=false

# 我的uname输出为linux，所以下面的三个为false
case "`uname`" in
CYGWIN*) cygwin=true;;
OS400*) os400=true;;
Darwin*) darwin=true;;
esac

# 这个文件的执行命令exec ./catalina.sh star  。 所以，得到的$0 起始就是 catalina.sh  这个执行脚本的名称
# resolve links - $0 may be a softlink
PRG="$0"

# -h 判断这个脚本文件，是否是一个软件连接文件，这里肯定不是软链接文件，所以，这个while条件是进不去的，所以没有研究
while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

# 获取到这个catalina.sh  这个文件的所在的目录，以什么路径执行的，就显示的什么目录，如果是绝对路径执行，那么就是显示目录，不然就显示.
# 所以一般的值 PRGDIR=.
# Get standard environment variables
PRGDIR=`dirname "$PRG"`

# -z 用来判断，这个值是否为空，如果为空，那么就为真，   因为CATALINA_HOME 这个个变量，在前面没有被定义，也没有被使用，这个这个判断为真，会执行&&后面的命令
# 后面的命令 CATALINA_HOME=`cd ./..`	，其实就是回到上层目录，其实就是tomcat的安装目录，然后再执行pwd，把tomcat的目录地址赋值给CATALINA_HOME
# CATALINA_HOME 为tomcat的安装目录，CATALINA_HOME=/home/liuzedong/tools/apache-tomcat-7.0.8
# Only set CATALINA_HOME if not already set
[ -z "$CATALINA_HOME" ] && CATALINA_HOME=`cd "$PRGDIR/.." >/dev/null; pwd`

# 定义CLASSPATH变量，这里，什么都没设置，因为，是怕原来设置的影响，所以在这里相当于清零啦，下面还会再判断的，可以在这里加上自己的路径
# Ensure that any user defined CLASSPATH variables are not used on startup,
# but allow them to be specified in setenv.sh, in rare case when it is needed.
CLASSPATH=

# 这个SETENVPATH=":-/home/liuzedong/tools/apache-tomcat-7.0.8"
# 这里使用到勒，变量=${变量1:-变量2}  这里，变量1的值不为空的话，那么变量=变量1.  如果变量1的值为空，那么变量=变量2.  如果变量1和变量2都是空，那么变量=
# 所以这里SETENVPATH=${CATALINA_HOME=/home/liuzedong/tools/apache-tomcat-7.0.8

# 然后，后面的文件，判断 /home/liuzedong/tools/apache-tomcat-7.0.8/bin/setenv.sh  这个文件是否为可读文件，因为我的tomcat下面没有这个文件，所以这里会返回false，
# 所以会运行，下面的文件，CATALINA_HOME 就会读取这个目录下面的。那个文件，其实是同一个文件，除非，配置啦CATALINA_BASE 这个变量，那么就会有这个文件的
# 所以在默认的tomcat中，这个下面是不会执行的，因为 没有这个文件
SETENVPATH="${CATALINA_BASE:-$CATALINA_HOME}"
if [ -r "$SETENVPATH/bin/setenv.sh" ]; then
  . "$SETENVPATH/bin/setenv.sh"
elif [ -r "$CATALINA_HOME/bin/setenv.sh" ]; then
  . "$CATALINA_HOME/bin/setenv.sh"
fi

# 检查系统是否是cygwin 的，我的是linux，所以下面不会执行，下面是设置当前环境脚本变量的
# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
  [ -n "$JRE_HOME" ] && JRE_HOME=`cygpath --unix "$JRE_HOME"`
  [ -n "$CATALINA_HOME" ] && CATALINA_HOME=`cygpath --unix "$CATALINA_HOME"`
  [ -n "$CATALINA_BASE" ] && CATALINA_BASE=`cygpath --unix "$CATALINA_BASE"`
  [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --unix "$CLASSPATH"`
fi

# 检测系统是否是OS400 的，因为我的是linux，所以下面的不会执行，下面也是设置当前脚本的环境变量的
# For OS400
if $os400; then
  # Set job priority to standard for interactive (interactive - 6) by using
  # the interactive priority - 6, the helper threads that respond to requests
  # will be running at the same priority as interactive jobs.
  COMMAND='chgjob job('$JOBNAME') runpty(6)'
  system $COMMAND

  # Enable multi threading
  export QIBM_MULTI_THREADED=Y
fi

# Get standard Java environment variables
if $os400; then
  # -r will Only work on the os400 if the files are:
  # 1. owned by the user
  # 2. owned by the PRIMARY group of the user
  # this will not work if the user belongs in secondary groups
  BASEDIR="$CATALINA_HOME"
  . "$CATALINA_HOME"/bin/setclasspath.sh
else
  if [ -r "$CATALINA_HOME"/bin/setclasspath.sh ]; then #### 检测/home/liuzedong/tools/apache-tomcat-7.0.8/bin/setclasspath.sh 是否可读,这个是设置classpath的脚本, 是存在的 
    BASEDIR="$CATALINA_HOME" ### BASEDIR=/home/liuzedong/tools/apache-tomcat-7.0.8
    . "$CATALINA_HOME"/bin/setclasspath.sh  ### 这里是要是执行/home/liuzedong/tools/apache-tomcat-7.0.8/bin/setclasspath.sh 这个脚本的
  else
    echo "Cannot find $CATALINA_HOME/bin/setclasspath.sh"
    echo "This file is needed to run this program"
    exit 1
  fi
fi

# 一直到这里绘制，都是OS400  系统的脚本环境变量的设置范围



# CLASSPATH这个变量，因为前面CLASSPATH=  有这行代码，所以返回为true，前面加上! 所以这个if [false] ，中的判断是false，所以这个判断是不会走的
# Add on extra jar files to CLASSPATH
if [ ! -z "$CLASSPATH" ] ; then
  CLASSPATH="$CLASSPATH":
fi

# 因为上面的没走, 所以CLASSPATH= , 所以 CLASSPATH="CATALINA_HOME"/bin/bootstrap.jar = /home/liuzedong/tools/apache-tomcat-7.0.8/bin/bootstrap.jar
CLASSPATH="$CLASSPATH""$CATALINA_HOME"/bin/bootstrap.jar

#### 因为没有定义CATALINA_BASE 变量, 所以CATALINA_BASE=/home/liuzedong/tools/apache-tomcat-7.0.8 ####
if [ -z "$CATALINA_BASE" ] ; then
  CATALINA_BASE="$CATALINA_HOME"
fi

#### 指定输出文件, 为空,所以,设置 CATALINA_OUT=/home/liuzedong/tools/apache-tomcat-7.0.8/logs/catalina.out ####
if [ -z "$CATALINA_OUT" ] ; then
  CATALINA_OUT="$CATALINA_BASE"/logs/catalina.out
fi

#### 缓存目录,没有设置,所以定义 CATALINA_TMPDIR=/home/liuzedong/tools/apache-tomcat-7.0.8/temp ####
if [ -z "$CATALINA_TMPDIR" ] ; then
  # Define the java.io.tmpdir to use for Catalina
  CATALINA_TMPDIR="$CATALINA_BASE"/temp
fi


#### 因为有这个jar包,且可读, 所以 添加一个环境变量的包 CLASSPATH=/home/liuzedong/tools/apache-tomcat-7.0.8/bin/bootstrap.jar:/home/liuzedong/tools/apache-tomcat-7.0.8/bin/tomcat-juli.jar ####
# Add tomcat-juli.jar to classpath
# tomcat-juli.jar can be over-ridden per instance
if [ -r "$CATALINA_BASE/bin/tomcat-juli.jar" ] ; then
  CLASSPATH=$CLASSPATH:$CATALINA_BASE/bin/tomcat-juli.jar
else
  CLASSPATH=$CLASSPATH:$CATALINA_HOME/bin/tomcat-juli.jar
fi

# Bugzilla 37848: When no TTY is available, don't output to console
have_tty=0
#### tty 是Linux中的屏幕代号,下面的判断的true, 所以hava_tty=1 ####
if [ "`tty`" != "not a tty" ]; then
    have_tty=1
fi

#### 不是cygwin系统,所系下面的方法不会进入 ####
# For Cygwin, switch paths to Windows format before running java
if $cygwin; then
  JAVA_HOME=`cygpath --absolute --windows "$JAVA_HOME"`
  JRE_HOME=`cygpath --absolute --windows "$JRE_HOME"`
  CATALINA_HOME=`cygpath --absolute --windows "$CATALINA_HOME"`
  CATALINA_BASE=`cygpath --absolute --windows "$CATALINA_BASE"`
  CATALINA_TMPDIR=`cygpath --absolute --windows "$CATALINA_TMPDIR"`
  CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
  JAVA_ENDORSED_DIRS=`cygpath --path --windows "$JAVA_ENDORSED_DIRS"`
fi
#### 到此结束,上面是定义的变量,没有定义Linux系统下 ####


#### 检测,日志配置文件是否存在,不存在,则 检测 "$CATALINA_BASE"/conf/logging.properties=/home/liuzedong/tools/apache-tomcat-7.0.8/conf/logging.properties 此配置文件是否可读 ####
#### 因为可读,所以,就设置Java 参数 LOGGING_CONFIG=-Djava.util.logging.config.file=/home/liuzedong/tools/apache-tomcat-7.0.8/conf/logging.properties ####
# Set juli LogManager config file if it is present and an override has not been issued
if [ -z "$LOGGING_CONFIG" ]; then
  if [ -r "$CATALINA_BASE"/conf/logging.properties ]; then
    LOGGING_CONFIG="-Djava.util.logging.config.file=$CATALINA_BASE/conf/logging.properties"
  else
    # Bugzilla 45585
    LOGGING_CONFIG="-Dnop"
  fi
fi

#### $LOGGING_MANAGER 为空 ####
#### 检测,是否有日志的管理器,可以自己设置, 如果没有, 就设置apache的 JAVA_OPTS= -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager ####
if [ -z "$LOGGING_MANAGER" ]; then
  JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager"
else
  JAVA_OPTS="$JAVA_OPTS $LOGGING_MANAGER"
fi

# ----- Execute The Requested Command -----------------------------------------

#### 检测,tty是否为1,因为上面有定义, 所以下面的方法会进入, 主要是打印出当前的目录
#### Using CATALINA_BASE:   /home/liuzedong/tools/apache-tomcat-7.0.8
#### Using CATALINA_HOME:   /home/liuzedong/tools/apache-tomcat-7.0.8
#### Using CATALINA_TMPDIR: /home/liuzedong/tools/apache-tomcat-7.0.8/temp
#### 因为$1=start,所以打印else 中的 Using JRE_HOME:        /usr/local/java/jdk1.7.0_79
#### Using CLASSPATH:       /home/liuzedong/tools/apache-tomcat-7.0.8/bin/bootstrap.jar:/home/liuzedong/tools/apache-tomcat-7.0.8/bin/tomcat-juli.jar
# Bugzilla 37848: only output this if we have a TTY
if [ $have_tty -eq 1 ]; then
  echo "Using CATALINA_BASE:   $CATALINA_BASE"
  echo "Using CATALINA_HOME:   $CATALINA_HOME"
  echo "Using CATALINA_TMPDIR: $CATALINA_TMPDIR"
  if [ "$1" = "debug" ] ; then
    echo "Using JAVA_HOME:       $JAVA_HOME"
  else
    echo "Using JRE_HOME:        $JRE_HOME"
  fi
  echo "Using CLASSPATH:       $CLASSPATH"
  if [ ! -z "$CATALINA_PID" ]; then
    echo "Using CATALINA_PID:    $CATALINA_PID"
  fi
fi


#### 下面,是 start=jpda ####
if [ "$1" = "jpda" ] ; then
  if [ -z "$JPDA_TRANSPORT" ]; then
    JPDA_TRANSPORT="dt_socket"
  fi
  if [ -z "$JPDA_ADDRESS" ]; then
    JPDA_ADDRESS="8000"
  fi
  if [ -z "$JPDA_SUSPEND" ]; then
    JPDA_SUSPEND="n"
  fi
  if [ -z "$JPDA_OPTS" ]; then
    JPDA_OPTS="-agentlib:jdwp=transport=$JPDA_TRANSPORT,address=$JPDA_ADDRESS,server=y,suspend=$JPDA_SUSPEND"
  fi
  CATALINA_OPTS="$CATALINA_OPTS $JPDA_OPTS"
  shift
fi
#### 判断结束 ####


#### 下面是,start = debug 判断 ####
if [ "$1" = "debug" ] ; then
  if $os400; then
    echo "Debug command not available on OS400"
    exit 1
  else
    shift
    if [ "$1" = "-security" ] ; then
      if [ $have_tty -eq 1 ]; then
        echo "Using Security Manager"
      fi
      shift
      exec "$_RUNJDB" "$LOGGING_CONFIG" $JAVA_OPTS $CATALINA_OPTS \
        -Djava.endorsed.dirs="$JAVA_ENDORSED_DIRS" -classpath "$CLASSPATH" \
        -sourcepath "$CATALINA_HOME"/../../java \
        -Djava.security.manager \
        -Djava.security.policy=="$CATALINA_BASE"/conf/catalina.policy \
        -Dcatalina.base="$CATALINA_BASE" \
        -Dcatalina.home="$CATALINA_HOME" \
        -Djava.io.tmpdir="$CATALINA_TMPDIR" \
        org.apache.catalina.startup.Bootstrap "$@" start
    else
      exec "$_RUNJDB" "$LOGGING_CONFIG" $JAVA_OPTS $CATALINA_OPTS \
        -Djava.endorsed.dirs="$JAVA_ENDORSED_DIRS" -classpath "$CLASSPATH" \
        -sourcepath "$CATALINA_HOME"/../../java \
        -Dcatalina.base="$CATALINA_BASE" \
        -Dcatalina.home="$CATALINA_HOME" \
        -Djava.io.tmpdir="$CATALINA_TMPDIR" \
        org.apache.catalina.startup.Bootstrap "$@" start
    fi
  fi
#### 到此结束,start = debug 配置 ####






#### 下面是,start = run 判断 ####
elif [ "$1" = "run" ]; then

  shift
  if [ "$1" = "-security" ] ; then
    if [ $have_tty -eq 1 ]; then
      echo "Using Security Manager"
    fi
    shift
    eval \"$_RUNJAVA\" \"$LOGGING_CONFIG\" $JAVA_OPTS $CATALINA_OPTS \
      -Djava.endorsed.dirs=\"$JAVA_ENDORSED_DIRS\" -classpath \"$CLASSPATH\" \
      -Djava.security.manager \
      -Djava.security.policy==\"$CATALINA_BASE/conf/catalina.policy\" \
      -Dcatalina.base=\"$CATALINA_BASE\" \
      -Dcatalina.home=\"$CATALINA_HOME\" \
      -Djava.io.tmpdir=\"$CATALINA_TMPDIR\" \
      org.apache.catalina.startup.Bootstrap "$@" start
  else
    eval \"$_RUNJAVA\" \"$LOGGING_CONFIG\" $JAVA_OPTS $CATALINA_OPTS \
      -Djava.endorsed.dirs=\"$JAVA_ENDORSED_DIRS\" -classpath \"$CLASSPATH\" \
      -Dcatalina.base=\"$CATALINA_BASE\" \
      -Dcatalina.home=\"$CATALINA_HOME\" \
      -Djava.io.tmpdir=\"$CATALINA_TMPDIR\" \
      org.apache.catalina.startup.Bootstrap "$@" start
  fi
#### 到此结束,start = run 配置 ####



#### 下面是,start = start  因为,默认使用的,是start启动,所以下面的方法会走 ####
elif [ "$1" = "start" ] ; then
  #### 此处的CATALINA_PID 一般会空, 所以, ! -z $CATALINA_PID  为false
  if [ ! -z "$CATALINA_PID" ]; then
    if [ -f "$CATALINA_PID" ]; then
      if [ -s "$CATALINA_PID" ]; then
        echo "Existing PID file found during start."
        if [ -r "$CATALINA_PID" ]; then
          PID=`cat "$CATALINA_PID"`
          ps -p $PID >/dev/null 2>&1
          if [ $? -eq 0 ] ; then
            echo "Tomcat appears to still be running with PID $PID. Start aborted."
            exit 1
          else
            echo "Removing/clearing stale PID file."
            rm -f "$CATALINA_PID" >/dev/null 2>&1
            if [ $? != 0 ]; then
              if [ -w "$CATALINA_PID" ]; then
                cat /dev/null > "$CATALINA_PID"
              else
                echo "Unable to remove or clear stale PID file. Start aborted."
                exit 1
              fi
            fi
          fi
        else
          echo "Unable to read PID file. Start aborted."
          exit 1
        fi
      else
        rm -f "$CATALINA_PID" >/dev/null 2>&1
        if [ $? != 0 ]; then
          if [ ! -w "$CATALINA_PID" ]; then
            echo "Unable to remove or write to empty PID file. Start aborted."
            exit 1
          fi
        fi
      fi
    fi
  fi
  #### 到此处是判断CATALINA_PID 结束的位置 ####



  #### 直接使用shift命令 , 就是将参数,向左移动, ####
  shift

  #### touch /home/liuzedong/tools/apache-tomcat-7.0.8/logs/catalina.out, 创建日志输出文件 ####
  touch "$CATALINA_OUT"

  #### 因为, 使用shift 将参数, 向左移动勒, 所以$1= 空, 取第二个参数, 所以,下面的判断也 不进去,进入else 方法 ####
  if [ "$1" = "-security" ] ; then
    if [ $have_tty -eq 1 ]; then
      echo "Using Security Manager"
    fi
    shift
    eval \"$_RUNJAVA\" \"$LOGGING_CONFIG\" $JAVA_OPTS $CATALINA_OPTS \
      -Djava.endorsed.dirs=\"$JAVA_ENDORSED_DIRS\" -classpath \"$CLASSPATH\" \
      -Djava.security.manager \
      -Djava.security.policy==\"$CATALINA_BASE/conf/catalina.policy\" \
      -Dcatalina.base=\"$CATALINA_BASE\" \
      -Dcatalina.home=\"$CATALINA_HOME\" \
      -Djava.io.tmpdir=\"$CATALINA_TMPDIR\" \
      org.apache.catalina.startup.Bootstrap "$@" start \
      >> "$CATALINA_OUT" 2>&1 "&"
  #### 此处就是 主要的 启动方法 ####
  #### /usr/local/java/jdk1.7.0_79/bin/java 
  #### -Djava.util.logging.config.file=/home/liuzedong/tools/apache-tomcat-7.0.8/conf/logging.properties
  #### -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
  #### -Djava.endorsed.dirs="/home/liuzedong/tools/apache-tomcat-7.0.8/endorsed
  #### -classpath /home/liuzedong/tools/apache-tomcat-7.0.8/bin/bootstrap.jar:/home/liuzedong/tools/apache-tomcat-7.0.8/bin/tomcat-juli.jar
  #### -Dcatalina.base="/home/liuzedong/tools/apache-tomcat-7.0.8"
  #### -Dcatalina.home="/home/liuzedong/tools/apache-tomcat-7.0.8"
  #### -Djava.io.tmpdir="/home/liuzedong/tools/apache-tomcat-7.0.8/temp"
  #### org.apache.catalina.startup.Bootstrap start &
  else
    eval \"$_RUNJAVA\" \"$LOGGING_CONFIG\" $JAVA_OPTS $CATALINA_OPTS \
      -Djava.endorsed.dirs=\"$JAVA_ENDORSED_DIRS\" -classpath \"$CLASSPATH\" \
      -Dcatalina.base=\"$CATALINA_BASE\" \
      -Dcatalina.home=\"$CATALINA_HOME\" \
      -Djava.io.tmpdir=\"$CATALINA_TMPDIR\" \
      org.apache.catalina.startup.Bootstrap "$@" start \
      >> "$CATALINA_OUT" 2>&1 "&"

  fi
  

  #### CATALINA_PID 变量为空, 所以下面的判断是进不去的 ####
  if [ ! -z "$CATALINA_PID" ]; then
    echo $! > "$CATALINA_PID"
  fi


#### 因为进入的 start方法, 所以下面的 stop 方法,没有进入 ####
elif [ "$1" = "stop" ] ; then

  shift

  SLEEP=5
  if [ ! -z "$1" ]; then
    echo $1 | grep "[^0-9]" >/dev/null 2>&1
    if [ $? -gt 0 ]; then
      SLEEP=$1
      shift
    fi
  fi

  FORCE=0
  if [ "$1" = "-force" ]; then
    shift
    FORCE=1
  fi

  if [ ! -z "$CATALINA_PID" ]; then
    if [ -s "$CATALINA_PID" ]; then
      if [ -f "$CATALINA_PID" ]; then
        kill -0 `cat "$CATALINA_PID"` >/dev/null 2>&1
        if [ $? -gt 0 ]; then
          echo "PID file found but no matching process was found. Stop aborted."
          exit 1
        fi
      else
        echo "\$CATALINA_PID was set but the specified file does not exist. Is Tomcat running? Stop aborted."
        exit 1
      fi
    else
      echo "PID file is empty and has been ignored."
    fi
  fi

  eval \"$_RUNJAVA\" $JAVA_OPTS \
    -Djava.endorsed.dirs=\"$JAVA_ENDORSED_DIRS\" -classpath \"$CLASSPATH\" \
    -Dcatalina.base=\"$CATALINA_BASE\" \
    -Dcatalina.home=\"$CATALINA_HOME\" \
    -Djava.io.tmpdir=\"$CATALINA_TMPDIR\" \
    org.apache.catalina.startup.Bootstrap "$@" stop

  if [ ! -z "$CATALINA_PID" ]; then
    if [ -f "$CATALINA_PID" ]; then
      while [ $SLEEP -ge 0 ]; do
        kill -0 `cat "$CATALINA_PID"` >/dev/null 2>&1
        if [ $? -gt 0 ]; then
          rm -f "$CATALINA_PID" >/dev/null 2>&1
          if [ $? != 0 ]; then
            if [ -w "$CATALINA_PID" ]; then
              cat /dev/null > "$CATALINA_PID"
            else
              echo "Tomcat stopped but the PID file could not be removed or cleared."
            fi
          fi
          break
        fi
        if [ $SLEEP -gt 0 ]; then
          sleep 1
        fi
        if [ $SLEEP -eq 0 ]; then
          if [ $FORCE -eq 0 ]; then
            echo "Tomcat did not stop in time. PID file was not removed."
          fi
        fi
        SLEEP=`expr $SLEEP - 1 `
      done
    fi
  fi

  if [ $FORCE -eq 1 ]; then
    if [ -z "$CATALINA_PID" ]; then
      echo "Kill failed: \$CATALINA_PID not set"
    else
      if [ -f "$CATALINA_PID" ]; then
        PID=`cat "$CATALINA_PID"`
        echo "Killing Tomcat with the PID: $PID"
        kill -9 $PID
        rm -f "$CATALINA_PID" >/dev/null 2>&1
        if [ $? != 0 ]; then
          echo "Tomcat was killed but the PID file could not be removed."
        fi
      fi
    fi
  fi

elif [ "$1" = "configtest" ] ; then

    eval \"$_RUNJAVA\" $JAVA_OPTS $CATALINA_OPTS \
      -Djava.endorsed.dirs=\"$JAVA_ENDORSED_DIRS\" -classpath \"$CLASSPATH\" \
      -Dcatalina.base=\"$CATALINA_BASE\" \
      -Dcatalina.home=\"$CATALINA_HOME\" \
      -Djava.io.tmpdir=\"$CATALINA_TMPDIR\" \
      org.apache.catalina.startup.Bootstrap configtest 
    exit $?

elif [ "$1" = "version" ] ; then

    "$_RUNJAVA"   \
      -classpath "$CATALINA_HOME/lib/catalina.jar" \
      org.apache.catalina.util.ServerInfo

else

  echo "Usage: catalina.sh ( commands ... )"
  echo "commands:"
  if $os400; then
    echo "  debug             Start Catalina in a debugger (not available on OS400)"
    echo "  debug -security   Debug Catalina with a security manager (not available on OS400)"
  else
    echo "  debug             Start Catalina in a debugger"
    echo "  debug -security   Debug Catalina with a security manager"
  fi
  echo "  jpda start        Start Catalina under JPDA debugger"
  echo "  run               Start Catalina in the current window"
  echo "  run -security     Start in the current window with security manager"
  echo "  start             Start Catalina in a separate window"
  echo "  start -security   Start in a separate window with security manager"
  echo "  stop              Stop Catalina, waiting up to 5 seconds for the process to end"
  echo "  stop n            Stop Catalina, waiting up to n seconds for the process to end"
  echo "  stop -force       Stop Catalina, wait up to 5 seconds and then use kill -KILL if still running"
  echo "  stop n -force     Stop Catalina, wait up to n seconds and then use kill -KILL if still running"
  echo "  version           What version of tomcat are you running?"
  echo "Note: Waiting for the process to end and use of the -force option require that \$CATALINA_PID is defined"
  exit 1

fi
