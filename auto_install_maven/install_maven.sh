#!/usr/bin/env bash

echo "开始安装maven"

SOFTWARE_HOME=/usr/local/share

MAVEN_INSTALL_PATH=$SOFTWARE_HOME/maven

if [ ! -f apache-maven.tar.gz ]; then
	echo "开始下载maven"
	wget -O apache-maven.tar.gz https://github.com/lichong5258623/lc-studay-data/raw/master/software/envs/apache-maven-3.6.2-bin.tar.gz
fi
if [ ! -f apache-maven.tar.gz ]; then
	echo "maven下载失败..退出"
	exit 1
fi
if [ ! -d $MAVEN_INSTALL_PATH ]; then
  echo "开始安装maven"
  mkdir $MAVEN_INSTALL_PATH && tar -xzvf apache-maven.tar.gz -C $MAVEN_INSTALL_PATH --strip-components 1
else
  echo "maven已安装"
  exit 0
fi
echo "写入maven环境变量"
cat >> /etc/profile << EOF
#MAVEN_HOME
export MAVEN_HOME=$MAVEN_INSTALL_PATH
export MAVEN_HOME
export PATH=\$PATH:\$MAVEN_HOME/bin
EOF
echo "写入maven环境变量完毕"
source /etc/profile
mvn -version
echo "maven安装完毕"