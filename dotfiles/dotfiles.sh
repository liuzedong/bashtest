#!/bin/bash
# Name: dotfiles.sh
# Description: 装机必备
# Author: Super DD
# Version: 0.0.1
# Datetime: 2019-04-19 21:11:45
# Usage: dotfiles.sh

echo "安装软件"
# 文件变量加载
source config
# 创建备份文件目录
if [ ! -d "backup" ]; then
  mkdir backup
fi



##################### ##################### 


##################### 配置阿里云的镜像 ##################### 
aliyunAptSource=/etc/apt/sources.list.d/aliyun.list
if [ ! -f "$aliyunAptSource" ]; then
  sudo cp ./etc/aliyun.list $aliyunAptSource 
fi



##################### 安装文件前更新 ##################### 
if [ "${update}" == "y" ]; then
  sudo rm -rf /var/lib/apt/lists/lock
  sudo rm -rf /var/lib/dpkg/lock
  sudo apt autoclean
  sudo apt clean
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove
fi


##################### 常用命令安装 ##################### 
for commandName in ${commandList[@]}
do
  if ! type $commandName >/dev/null 2>&1 ; then
    echo "$commandName 不存在，现在安装"
    sudo apt install -y $commandName
  else
    echo "$commandName 存在"
  fi
done

##################### 安装zsh和oh-my-zsh #####################
if ! type zsh > /dev/null 2>&1; then	
  sudo apt -y install zsh
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
  sudo chsh -s /bin/zsh
fi

##################### 安装lantern蓝灯 #####################
if ! type lantern > /dev/null 2>&1; then
  sudo dpkg -i lantern-installer-64-bit.deb
fi


## ============================================= 修改ubuntu盒盖联网
sudo sed  -i 's/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/' /etc/systemd/logind.conf


## ============================================= nvm，node的版本选择器
if [ ! -d "$HOME/.nvm" ]; then
  sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
  if [ -f "$HOME/.zshrc" ]; then
    echo -e "\n\n" >> $HOME/.zshrc
    cat etc/nvm.cof >> $HOME/.zshrc
  fi
fi



