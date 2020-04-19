#!/bin/bash

clear
input_image_fullpath='/Users/dilipts/Dev/Projects/JP/DTP/DataTachyonPlatform/businesslayer/ai/deep-learning/elasticsearch_images/cute-kittens-in-basket.jpg'
echo "Running upload_image_to_elasticsearch"
python3 upload_image_to_elasticsearch.py input_image_fullpath