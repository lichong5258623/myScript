#!/usr/bin/env bash

echo "开始安装gradle"

SOFTWARE_HOME=/usr/local/share

GRADLE_INSTALL_PATH=$SOFTWARE_HOME/gradle

if [ ! -f gradle.zip ]; then
	echo "开始下载gradle"
	wget -O gradle.zip https://downloads.gradle-dn.com/distributions/gradle-5.6.2-bin.zip
fi

if [ ! -f gradle.zip ]; then
	echo "gradle下载失败..退出"
	exit 1
fi
if [ ! -d $GRADLE_INSTALL_PATH ]; then
  echo "开始安装gradle"
  unzip -d tmpgradle gradle.zip && mv tmpgradle/gradle*/ $GRADLE_INSTALL_PATH
  echo "删除临时目录"
  rm -rf tmpgradle
else
  echo "gradle已安装"
  exit 0
fi
echo "写入gradle环境变量"
cat >> /etc/profile << EOF
#GRADLE_HOME
export GRADLE_HOME=$GRADLE_INSTALL_PATH
export GRADLE_HOME
export PATH=\$PATH:\$GRADLE_HOME/bin
EOF
echo "写入gradle环境变量完毕"
source /etc/profile
gradle -version
echo "gradle安装完毕"