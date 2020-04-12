#!/usr/bin/env bash

echo "开始安装jdkServer"

SOFTWARE_HOME=/usr/local/share

JDK_SERVER_PATH=$SOFTWARE_HOME/jdk-server

if [ ! -f jdk_server.tar.gz ]; then
	echo "jdk不存在下载jdk"
	wget -O jdk_server.tar.gz https://github.com/lichong5258623/lc-studay-data/raw/master/software/envs/OpenJDK8U-jdk_x64_linux_hotspot_8u222b10.tar.gz
fi

if [ ! -f jdk_server.tar.gz ]; then
	echo "jdk下载失败..退出"
	exit 1
fi

if [ ! -d $JDK_SERVER_PATH ]; then
  mkdir $JDK_SERVER_PATH && tar -xzvf jdk_server.tar.gz -C $JDK_SERVER_PATH --strip-components 1
else
  echo "jdk-server已安装"
  exit 0
fi

cat >> /etc/profile << EOF
#JAVA_HOME
export JAVA_HOME=$JDK_SERVER_PATH
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
#使用对应的sh声明下
sed -i '1i\source /etc/profile' ~/.*shrc
source /etc/profile
java -version
echo "jdk-server安装完毕"