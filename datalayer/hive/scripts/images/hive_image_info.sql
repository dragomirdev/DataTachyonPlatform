
SHOW DATABASES;
# DROP DATABASE dtpimages;

CREATE DATABASE dtpimages LOCATION "hdfs://JP-DTP-HADOOP-NM-VM:9000/user/hive/warehouse/dtpimages";
USE dtpimages;

## Create External Table in Hive to read from hadoop
DROP TABLE IF EXISTS IMAGE;
CREATE EXTERNAL TABLE  IMAGE (
id string,
image binary
)
LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/images/';

ALTER TABLE IMAGE SET SERDEPROPERTIES ("timestamp.formats"="yyyy-MM-dd'T'HH:mm:ss.SSSZ");
DESC IMAGE;
MSCK REPAIR TABLE IMAGE;
SELECT * FROM IMAGE;



## Create External Table in Hive for the ElasticSearch

USE dtpimages;
DROP TABLE IF EXISTS ES_IMAGE;

CREATE EXTERNAL TABLE ES_IMAGE(
id string,
image binary
)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtpimages/IMAGE',
'es.index.auto.create' = 'true',
'es.nodes.wan.only' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

desc ES_IMAGE;

INSERT OVERWRITE TABLE ES_IMAGE  SELECT * FROM IMAGE;
SELECT * FROM ES_IMAGE;

