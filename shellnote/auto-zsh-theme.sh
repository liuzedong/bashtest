#!/bin/bash
# Name: auto-zsh-theme.sh
# Description: 自动替换zsh的模板，下面定义为每一分钟
# */1 * * * * /opt/devtools/git/bashtest/shellnote/auto-zsh-theme.sh >/dev/null 2>&1
# Author: Super DD
# Version: 0.0.1
# Datetime: 2019-04-20 15:07:57
# Usage: auto-zsh-theme.sh

zsh_themes_dir=$HOME/.oh-my-zsh/themes
zshrc_file=$HOME/.zshrc
zsh_theme_key=ZSH_THEME
# 指定备份日志放在那个目录
zsh_theme_log=$HOME/edisk/备份/log/zsh.log

if [ ! -f $zsh_theme_log ]; then
        touch $zsh_theme_log
fi


# 获取模板的随机数
zsh_themes_rand=$(ls $zsh_themes_dir | grep "theme" | awk -F '.' '{count++} END{print int(count*rand())}')

# 随机获取模板
zsh_themes=$(ls $zsh_themes_dir | grep "theme" | awk -v rnd=$zsh_themes_rand -F '.' '{if(rnd == NR) print $1}')

# 将模板写入到文件中
zsh_old_theme=$(grep "^$zsh_theme_key" $zshrc_file)
zsh_new_theme=($zsh_theme_key="$zsh_themes")

sed -i "s/$zsh_old_theme/$zsh_new_theme/" $zshrc_file

echo -e "$(date "+%Y-%m-%d %H:%M") ：$zsh_old_theme------------>>$zsh_new_theme" >> $zsh_theme_log
