
SHOW DATABASES;

CREATE DATABASE DTPIAUDITORDB LOCATION "hdfs://JP-DTP-HADOOP-NM-VM:9000/user/hive/warehouse/dtpiauditor";

USE DTPIAUDITORDB;

## Create External Table in Hive to read from hadoop
DROP TABLE IF EXISTS IAUDITOR_INSPECTION;
CREATE EXTERNAL TABLE  IAUDITOR_INSPECTION (
template_id string,
audit_id string,
archived boolean,
audit_data string,
total_score float,
score_percentage float
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

#partitioned by (ingestiondate string)

ALTER TABLE IAUDITOR_INSPECTION SET SERDEPROPERTIES ( "ignore.malformed.json" = "true");
ALTER TABLE IAUDITOR_INSPECTION SET LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor/';
ALTER TABLE IAUDITOR_INSPECTION SET  SERDEPROPERTIES ( 'paths'='template_id', 'audit_id', 'archived', 'audit_data', 'total_score', 'score_percentage' );
ALTER TABLE IAUDITOR_INSPECTION SET SERDEPROPERTIES ('input.regex'=".*:\"(.*?)\",\"audit_data\":\\{\"name\":(\\d),\"total_score\":(\\d),\"score_percentage\":(\\d).*$");

DESC IAUDITOR_INSPECTION;
MSCK REPAIR TABLE IAUDITOR_INSPECTION;

SELECT * FROM IAUDITOR_INSPECTION;

## Create External Table in Hive for the ElasticSearch

USE DTPIAUDITORDB;

DROP TABLE IF EXISTS ES_IAUDITOR_INSPECTION;

CREATE EXTERNAL TABLE ES_IAUDITOR_INSPECTION(
template_id string,
audit_id string,
archived boolean,
audit_data string,
total_score float,
score_percentage float
)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtpiauditor/IAUDITOR_INSPECTION',
'es.index.auto.create' = 'true',
'es.nodes.wan.only' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

desc ES_IAUDITOR_INSPECTION;

INSERT OVERWRITE TABLE  ES_IAUDITOR_INSPECTION   SELECT *  FROM IAUDITOR_INSPECTION s;
SELECT * FROM ES_IAUDITOR_INSPECTION;


# geo_location STRUCT<lat:float,lat:float>
# ,'es.mapping.names'='geo_location:@geo_point'
# INSERT OVERWRITE TABLE  ES_SENSOR_INFO SELECT s.id, s.name, s.temperature, s.pressure, s.humidity, s.latitude, s.longitude,
# named_struct('lat',s.latitude,'lon',s.longitude) as geo_location FROM SENSOR_INFO s;