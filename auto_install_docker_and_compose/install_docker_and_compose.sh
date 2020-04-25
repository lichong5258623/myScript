#!/usr/bin/env bash

#todo 还未测试

this_os=$(cat /proc/version |grep Debian |wc -l)

if [ $this_os -eq 0 ]
then
    echo "暂时只支持Debian..."
    exit 1
fi

#下载安装包
wget https://raw.githubusercontent.com/lichong5258623/mydocker/master/tools/docker-ce_17.12.0-ce-0-debian_amd64.deb
wget https://raw.githubusercontent.com/lichong5258623/mydocker/master/tools/libltdl7_2.4.6-0.1_amd64.deb
wget https://raw.githubusercontent.com/lichong5258623/mydocker/master/tools/libapparmor1_2.13.2-9_amd64.deb

#执行安装docker和依赖
dpkg -i libltdl7_2.4.6-0.1_amd64.deb
dpkg -i libapparmor1_2.13.2-9_amd64.deb
dpkg -i docker-ce_17.12.0-ce-0-debian_amd64.deb

echo"docker安装完毕，开始安装docker-compose"
#下载dockercompose

if [ !-f docker-compose ];then
    curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o docker-compose
fi
mv docker-compose /usr/local/bin/
chmod +x /usr/local/bin/docker-compose
docker-compose --version
echo "安装完毕"