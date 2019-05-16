
# 脚本环境变量
export SCRIPT_PATH=/opt/devtools/git/bashtest/shellnote

# Java 环境变量
export JAVA_HOME=/opt/devtools/jdk1.8.0_161
# gradle 环境变量
export GRADLE_HOME=/opt/devtools/gradle-4.10.2
# Maven 环境变量
export MAVEN_HOME=/opt/devtools/apache-maven-3.5.4

export PATH=$GRADLE_HOME/bin:$MAVEN_HOME/bin:$SCRIPT_PATH:$JAVA_HOME/bin:$PATH

# crontab 使用vim进行编辑
export EDITOR=vim
