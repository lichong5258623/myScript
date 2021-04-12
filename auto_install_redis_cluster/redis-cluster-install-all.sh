#!/usr/bin/env bash
rm -rf /usr/local/redis-cluster

#使用redis版本为6.0.9
#本机ip
local_ip=123.56.151.26
#密码
password=123456
#集群开始端口
start_port=26380
#集群结束端口
end_port=26385

#创建资源文件夹
for port in $(seq ${start_port} ${end_port}); do
  mkdir -p /usr/local/redis-cluster/${port}/conf &&
    PASSOWRD=${password} LOCALIP=${local_ip} BUSPORT=$((${port} + 10000)) PORT=${port} envsubst <./redis-cluster.tmpl >/usr/local/redis-cluster/${port}/conf/redis.conf &&
    mkdir -p /usr/local/redis-cluster/${port}/data
done

#启动docker
for port in $(seq ${start_port} ${end_port}); do
  docker run -d \
    -v /usr/local/redis-cluster/${port}/conf/redis.conf:/usr/local/etc/redis/redis.conf \
    --restart always --name redis-${port} --net host \
    --sysctl net.core.somaxconn=1024 redis \
    redis-server /usr/local/etc/redis/redis.conf
done

#集群信息
ips=$(for port in $(seq ${start_port} ${end_port}); do
  echo -n ${local_ip}:${port}' '
done)

#设置集群
docker exec -it redis-${start_port} sh -c '\
  redis-cli -a '"${password}"' --cluster  create '"${ips}"' --cluster-replicas 1'