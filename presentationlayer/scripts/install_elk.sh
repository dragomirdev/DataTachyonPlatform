#!/bin/bash

cd ..

echo "Initiating ElasticSearch"
./presentationlayer/elasticsearch/scripts/install_elasticsearch.sh

echo "Initiating ElasticSearch"
./presentationlayer/kibana/scripts/install_kibana.sh
