#!/bin/bash

# 作者：刘泽栋
# 时间：2016.07.17
# 描述：备份，本地数据到百度有上，使用的bypy这个开源工具
# 备注：每隔一个月，百度云的令牌就会失效，所以使用bypy.py -c  来取消令牌，重新生成
# 添加任务 crontab -e        显示任务列表 crontab -l
# 每天晚上11点备份到百度云上
# 0 23 * * * /home/liuzedong/git/bashtest/shellnote/bytyupload.sh >/dev/null 2>&1
#
# 安装 : 如果,先前安装过 sudo pip uninstall bypy , 然后安装 sudo pip install -U bypy

# 使用的命令
#export bypy=/home/liuzedong/tools/baiduyunbypy/bypy/bypy.py


# 指定要备份的目录
backuprootdir=/home/liuzedong/edisk/
backupdir=(备份 光华金科研发 work 小帮规划)
# 指定备份日志放在那个目录
bypylogfile=/home/liuzedong/edisk/备份/log/bypy.log

if [ ! -f $bypylogfile ]; then
	touch $bypylogfile
fi

for dir in ${backupdir[@]}
do
	echo -e "$dir `date "+%Y-%m-%d %H:%M"` ： 目录开始进行备份" >> $bypylogfile
	/usr/local/bin/bypy syncup $backuprootdir$dir myPCbackup/$dir 1>> $bypylogfile 2>> $bypylogfile
	echo -e "$dir `date "+%Y-%m-%d %H:%M"` ： 目录结束备份\n" >> $bypylogfile
done

# 每次备份完, 重新更下 token, 可以不用每个月去 生成啦
/usr/local/bin/bypy refreshtoken 1>> $bypylogfile 2>> $bypylogfile
# 对日志文件, 进行换行
echo -e "\n\n" >> $bypylogfile
