#!/usr/bin/env bash

mkdir -p /usr/share/elasticsearch01/config
mkdir -p /usr/share/elasticsearch01/data
mkdir -p /usr/share/elasticsearch02/config
mkdir -p /usr/share/elasticsearch02/data
mkdir -p /usr/share/elasticsearch03/config
mkdir -p /usr/share/elasticsearch03/data
mkdir -p /usr/share/logstash/pipeline
mkdir -p /usr/share/kibana/config/

chmod 770 /usr/share/elasticsearch01/data
chmod 770 /usr/share/elasticsearch02/data
chmod 770 /usr/share/elasticsearch03/data
cp elasticsearch01.yml /usr/share/elasticsearch/config/elasticsearch.yml
cp elasticsearch02.yml /usr/share/elasticsearch/config/elasticsearch.yml
cp elasticsearch03.yml /usr/share/elasticsearch/config/elasticsearch.yml
cp logstash01.conf /usr/share/logstash/pipeline
cp kibana.yml /usr/share/kibana/config/
docker-compose -f docker-compose-cluster.yaml up -d