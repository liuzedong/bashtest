#!/bin/bash

# 作者：刘泽栋
# 时间：2016.07.17
# 描述：备份，本地数据到百度有上，使用的bypy这个开源工具


export bypy=/home/liuzedong/tools/baiduyunbypy/bypy/bypy.py

#$bypy upload /home/liuzedong/git/bashtest/shellnote/bytyupload.sh*
#$bypy upload /home/liuzedong/git/bashtest/shellnote/abc.tar.gz ubuntu-answern/

# 压缩文件
# 指定压缩的路径
#backuplocate=/media/liuzedong/0002239100048DF2/backup/
#gitfilezip=git.zip
#zip -r $backuplocate$gitfilezip /home/liuzedong/git/*

# 上传
#$bypy upload $backuplocate$gitfilezip ubuntu-answern/


# 同步指定的目录
#$bypy syncup /home/liuzedong/test ubuntu-answern/test

# 指定要备份的目录
backuprootdir=/media/liuzedong/0002239100048DF2/
backupdir=answern\ iso\ JD\ 备份
#backupdir=key\ test

for dir in $backupdir
do
	 $bypy syncup $backuprootdir$dir isoftstonePCbackup/$dir
done
