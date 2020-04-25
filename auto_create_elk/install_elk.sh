#!/usr/bin/env bash

mkdir -p /usr/share/elasticsearch/config
mkdir -p /usr/share/elasticsearch/data
mkdir -p /usr/share/logstash/pipeline

chmod 770 /usr/share/elasticsearch/data
cp elasticsearch.yml /usr/share/elasticsearch/config
cp logstash01.conf /usr/share/logstash/pipeline
docker-compose up -d