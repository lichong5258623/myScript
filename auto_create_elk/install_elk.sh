#!/usr/bin/env bash

echo "创建配置文件夹"
mkdir -p /usr/share/elasticsearch/config
mkdir -p /usr/share/elasticsearch/data
mkdir -p /usr/share/logstash/pipeline

chmod 770 /usr/share/elasticsearch/data
echo "copy配置文件"
cp elasticsearch.yml /usr/share/elasticsearch/config
cp logstash01.conf /usr/share/logstash/pipeline
echo "使用docker-compose启动elk"
docker-compose up -d