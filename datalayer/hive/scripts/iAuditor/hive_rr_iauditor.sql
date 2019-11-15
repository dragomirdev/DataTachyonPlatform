
SHOW DATABASES;
# DROP DATABASE dtprriauditordb;

CREATE DATABASE dtprriauditordb LOCATION "hdfs://JP-DTP-HADOOP-NM-VM:9000/user/hive/warehouse/dtprriauditordb";
USE dtprriauditordb;

## Create External Table in Hive to read from hadoop
DROP TABLE IF EXISTS RR_IAUDITOR_INSPECTION_REPORT;
CREATE EXTERNAL TABLE  RR_IAUDITOR_INSPECTION_REPORT (
audit_id string,
archived boolean,
audit_name string,
template_id string,
template_name string,
audit_author string,
audit_authorId string,
audit_device_id  string,
audit_owner  string,
audit_owner_id string,
audit_date_started  timestamp,
audit_date_modified  timestamp,
audit_date_completed  timestamp,
audit_duration bigint,
audit_score float,
audit_score_percentage float,
audit_total_score float,
template_description  string,
inspection_label  string,
inspection_text string,
inspection_failed boolean
)
partitioned by (ingestiondate string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor/'
TBLPROPERTIES('skip.header.line.count'='1');

ALTER TABLE RR_IAUDITOR_INSPECTION_REPORT SET SERDEPROPERTIES ("timestamp.formats"="yyyy-MM-dd'T'HH:mm:ss.SSSZ");
DESC RR_IAUDITOR_INSPECTION_REPORT;
MSCK REPAIR TABLE RR_IAUDITOR_INSPECTION_REPORT;
SELECT * FROM RR_IAUDITOR_INSPECTION_REPORT;


ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ('quoteChar'='"', 'separatorChar'=',')
LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor/'
tblproperties('skip.header.line.count'='1');

## Create External Table in Hive for the ElasticSearch

USE dtprriauditordb;
DROP TABLE IF EXISTS RR_ES_IAUDITOR_INSPECTION_REPORT;

CREATE EXTERNAL TABLE RR_ES_IAUDITOR_INSPECTION_REPORT(
audit_id string,
archived boolean,
audit_name string,
template_id string,
template_name string,
audit_author string,
audit_authorId string,
audit_device_id  string,
audit_owner  string,
audit_owner_id string,
audit_date_started  timestamp,
audit_date_modified  timestamp,
audit_date_completed  timestamp,
audit_duration bigint,
audit_score float,
audit_score_percentage float,
audit_total_score float,
template_description  string,
inspection_label  string,
inspection_text string,
inspection_failed boolean
)
partitioned by (ingestiondate string)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtprriauditordb/RR_IAUDITOR_INSPECTION_REPORT',
'es.index.auto.create' = 'true',
'es.nodes.wan.only' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

desc RR_ES_IAUDITOR_INSPECTION_REPORT;

INSERT OVERWRITE TABLE RR_ES_IAUDITOR_INSPECTION_REPORT  SELECT * FROM RR_IAUDITOR_INSPECTION_REPORT;
SELECT * FROM RR_ES_IAUDITOR_INSPECTION_REPORT;

