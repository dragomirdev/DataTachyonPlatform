
SHOW DATABASES;

CREATE DATABASE DTPSTREAMINGDB LOCATION "hdfs://JP-DTP-HADOOP-NM-VM:9000/user/hive/warehouse/dtpstreamingdb";

USE DTPSTREAMINGDB;

## Create External Table in Hive to read from hadoop
DROP TABLE IF EXISTS SENSOR_INFO;
CREATE EXTERNAL TABLE  SENSOR_INFO (
id bigint,
name string,
temperature float,
pressure float,
humidity float,
latitude float,
longitude float
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

#partitioned by (ingestiondate string)

ALTER TABLE SENSOR_INFO SET SERDEPROPERTIES ( "ignore.malformed.json" = "true");
ALTER TABLE SENSOR_INFO SET LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/kafka-logs/';
ALTER TABLE SENSOR_INFO SET  SERDEPROPERTIES ( 'paths'='id, name, temperature, pressure, humidity, latitude, longitude' );

DESC SENSOR_INFO;
MSCK REPAIR TABLE SENSOR_INFO;

SELECT * FROM SENSOR_INFO;

## Create External Table in Hive for the ElasticSearch

USE DTPSTREAMINGDB;

DROP TABLE IF EXISTS ES_SENSOR_INFO;

CREATE EXTERNAL TABLE ES_SENSOR_INFO(
id bigint,
name string,
temperature float,
pressure float,
humidity float,
lat float,
lon float
)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtpstreamingdb/sensor_info',
'es.index.auto.create' = 'true',
'es.nodes.wan.only' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

desc ES_SENSOR_INFO;

INSERT OVERWRITE TABLE  ES_SENSOR_INFO   SELECT *  FROM SENSOR_INFO s;
SELECT * FROM ES_SENSOR_INFO;


# geo_location STRUCT<lat:float,lat:float>
# ,'es.mapping.names'='geo_location:@geo_point'
# INSERT OVERWRITE TABLE  ES_SENSOR_INFO SELECT s.id, s.name, s.temperature, s.pressure, s.humidity, s.latitude, s.longitude,
# named_struct('lat',s.latitude,'lon',s.longitude) as geo_location FROM SENSOR_INFO s;