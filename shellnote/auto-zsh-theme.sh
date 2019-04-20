#!/bin/bash
# Name: auto-zsh-theme.sh
# Description: 自动替换zsh的文本样式
# Author: Super DD
# Version: 0.0.1
# Datetime: 2019-04-20 15:07:57
# Usage: auto-zsh-theme.sh

zsh_themes_dir=$ZSH/themes
zshrc_file=$HOME/.zshrc
zsh_theme_key=ZSH_THEME

# 获取模板的随机数
zsh_themes_rand=$(ls $zsh_themes_dir | grep "theme" | awk -F '.' '{count++} END{print int(count*rand())}')

# 随机获取模板
zsh_themes=$(ls $zsh_themes_dir | grep "theme" | awk -v rnd=$zsh_themes_rand -F '.' '{if(rnd == NR) print $1}')

# 将模板写入到文件中
zsh_old_theme=$(grep "^$zsh_theme_key" $zshrc_file)
zsh_new_theme=$zsh_theme_key=\"$zsh_themes\"

sed -i "s/$zsh_old_theme/$zsh_new_theme/" $zshrc_file
