
SHOW DATABASES;
# DROP DATABASE dtpiauditordb;

CREATE DATABASE dtpiauditordb LOCATION "hdfs://JP-DTP-HADOOP-NM-VM:9000/user/hive/warehouse/dtpiauditordb";
USE dtpiauditordb;

## Create External Table in Hive to read from hadoop
DROP TABLE IF EXISTS IAUDITOR_INSPECTION_REPORT;
CREATE EXTERNAL TABLE  IAUDITOR_INSPECTION_REPORT (
audit_id string,
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
inspector_full_name  string,
inspector_signature_image_url  string,
inspection_signature_image_filename  string,
inspected_timestamp  timestamp,
inspection_date_created  timestamp
)
partitioned by (ingestiondate string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor/'
TBLPROPERTIES('skip.header.line.count'='1');

ALTER TABLE IAUDITOR_INSPECTION_REPORT SET SERDEPROPERTIES ("timestamp.formats"="yyyy-MM-dd'T'HH:mm:ss.SSSZ");
DESC IAUDITOR_INSPECTION_REPORT;
MSCK REPAIR TABLE IAUDITOR_INSPECTION_REPORT;
SELECT * FROM IAUDITOR_INSPECTION_REPORT;



# OpenCSVSerde converts the datatype to string
#ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
#WITH SERDEPROPERTIES ('quoteChar'='"', 'separatorChar'=',')
#LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor/'
#tblproperties('skip.header.line.count'='1');


## Create External Table in Hive for the ElasticSearch

USE dtpiauditordb;
DROP TABLE IF EXISTS ES_IAUDITOR_INSPECTION_REPORT;

CREATE EXTERNAL TABLE ES_IAUDITOR_INSPECTION_REPORT(
audit_id string,
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
inspector_full_name  string,
inspector_signature_image_url  string,
inspection_signature_image_filename  string,
inspected_timestamp  timestamp,
inspection_date_created  timestamp
)
partitioned by (ingestiondate string)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtpiauditordb/IAUDITOR_INSPECTION_REPORT',
'es.index.auto.create' = 'true',
'es.nodes.wan.only' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

desc ES_IAUDITOR_INSPECTION_REPORT;

INSERT OVERWRITE TABLE ES_IAUDITOR_INSPECTION_REPORT  SELECT * FROM IAUDITOR_INSPECTION_REPORT;
SELECT * FROM ES_IAUDITOR_INSPECTION_REPORT;


#ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'


####################################################################################################



USE DTPIAUDITORDB;
DROP TABLE IF EXISTS IAUDITOR_INSPECTION_TEST;

CREATE EXTERNAL TABLE IAUDITOR_INSPECTION_TEST(
    json_data String
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\u0001' LINES TERMINATED BY '\n' STORED AS TEXTFILE
LOCATION "hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor/";

SELECT * FROM IAUDITOR_INSPECTION_TEST;

DROP TABLE IF EXISTS ES_IAUDITOR_INSPECTION_TEST;
CREATE EXTERNAL TABLE ES_IAUDITOR_INSPECTION_TEST (json_data string)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtpiauditor/IAUDITOR_INSPECTION_TEST',
'es.input.json' = 'yes',
'es.index.auto.create' = 'true',
'es.index.read.missing.as.empty' = 'true',
'es.nodes.wan.only' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

INSERT OVERWRITE TABLE  ES_IAUDITOR_INSPECTION_TEST   SELECT *  FROM ES_IAUDITOR_INSPECTION_TEST s;
SELECT * FROM ES_IAUDITOR_INSPECTION_TEST;


####################################################################################################

USE DTPIAUDITORDB;
DROP TABLE IF EXISTS IAUDITOR_INSPECTION_JSON;
CREATE EXTERNAL TABLE  IAUDITOR_INSPECTION_JSON (
template_id string,
audit_id string,
archived boolean,
created_at string,
modified_at string,
date_completed string,
date_modified string,
date_started string,
audit_data struct<score:float,
                  total_score:float,
                  score_percentage:float,
                  name:string,
                  duration:float,
                  authorship:struct<device_id:string, owner:string, owner_id:string, author:string, author_id:string>>,
template_data struct<authorship:struct<device_id:string, owner:string, owner_id:string, author:string, author_id:string>,
                    metadata:struct<description:string, name:string,
                                     image:struct<date_created:string,
                                                  file_ext:string,
                                                  label:string,
                                                  media_id:string,
                                                  href:string>>,
                    response_sets:struct<id:string, type:string, responses:array<struct<id:string,
                                                                                        label:string,
                                                                                        colour:string,
                                                                                        score:float,
                                                                                        enable_score:boolean>>>
                    >
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

ALTER TABLE IAUDITOR_INSPECTION_JSON SET SERDEPROPERTIES ( "ignore.malformed.json" = "true");
ALTER TABLE IAUDITOR_INSPECTION_JSON SET LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor1/';


DESC IAUDITOR_INSPECTION_JSON;
MSCK REPAIR TABLE IAUDITOR_INSPECTION_JSON;

SELECT * FROM IAUDITOR_INSPECTION_JSON;


USE DTPIAUDITORDB;

DROP TABLE IF EXISTS ES_IAUDITOR_INSPECTION_JSON;

CREATE EXTERNAL TABLE ES_IAUDITOR_INSPECTION_JSON(
template_id string,
audit_id string,
archived boolean,
created_at string,
modified_at string,
date_completed string,
date_modified string,
date_started string,
audit_data struct<score:float,
                  total_score:float,
                  score_percentage:float,
                  name:string,
                  duration:float,
                  authorship:struct<device_id:string, owner:string, owner_id:string, author:string, author_id:string>>,
template_data struct<authorship:struct<device_id:string, owner:string, owner_id:string, author:string, author_id:string>,
                    metadata:struct<description:string, name:string,
                                     image:struct<date_created:string,
                                                  file_ext:string,
                                                  label:string,
                                                  media_id:string,
                                                  href:string>>>
)
ROW FORMAT SERDE 'org.elasticsearch.hadoop.hive.EsSerDe'
stored by 'org.elasticsearch.hadoop.hive.EsStorageHandler'
tblproperties('es.resource' = 'dtpiauditor/IAUDITOR_INSPECTION_JSON',
'es.index.auto.create' = 'true',
'es.nodes.wan.only' = 'true',
'es.index.read.missing.as.empty' = 'true',
'es.nodes' = '10.0.4.10',
'es.net.http.auth.user' = 'elastic',
'es.net.http.auth.pass' = 'JPSpace2019$',
'es.port' = '9200');

desc ES_IAUDITOR_INSPECTION_JSON;

INSERT OVERWRITE TABLE  ES_IAUDITOR_INSPECTION_JSON   SELECT *  FROM IAUDITOR_INSPECTION_JSON s;
SELECT * FROM ES_IAUDITOR_INSPECTION_JSON s;

SELECT template_id, audit_id, archived, created_at, modified_at, date_completed, date_modified, date_started, named_struct('audit_data',s.audit_data), named_struct('template_data',s.template_data) FROM IAUDITOR_INSPECTION_JSON s;
SELECT named_struct('audit_data',s.audit_data), named_struct('template_data',s.template_data) FROM IAUDITOR_INSPECTION_JSON s;


INSERT OVERWRITE TABLE ES_IAUDITOR_INSPECTION_JSON SELECT template_id, audit_id, archived, created_at, modified_at, date_completed, date_modified, date_started, named_struct('audit_data',s.audit_data), named_struct('template_data',s.template_data) FROM IAUDITOR_INSPECTION_JSON s;
SELECT * FROM ES_IAUDITOR_INSPECTION_JSON s;


####################################################################################################

USE DTPIAUDITORDB;


## Create External Table in Hive to read from hadoop
DROP TABLE IF EXISTS IAUDITOR_INSPECTION;
CREATE EXTERNAL TABLE  IAUDITOR_INSPECTION (
template_id string,
audit_id string,
archived boolean,
name string,
total_score float,
score_percentage float,
date_completed string,
date_modified string,
date_started string,
description string,
date_created string,
file_ext string,
label string,
media_id string,
href string,
audit_data string,
template_data string,
image string
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE;

#template_data string,
#struct<metadata: struct<description: string, name: string, image: struct<date_created: string, file_ext: string, label: string,  media_id:string, href:string>>>

#partitioned by (ingestiondate string)

ALTER TABLE IAUDITOR_INSPECTION SET SERDEPROPERTIES ( "ignore.malformed.json" = "true");
ALTER TABLE IAUDITOR_INSPECTION SET LOCATION 'hdfs://JP-DTP-HADOOP-NM-VM:9000/data/dtp/processed/iAuditor1/';
ALTER TABLE IAUDITOR_INSPECTION SET  SERDEPROPERTIES ( 'paths'='template_id, audit_id, archived, audit_data, name, total_score, score_percentage, date_completed, date_modified, date_started, template_data, metadata, description, name, image, date_created, file_ext, label, media_id ' );
ALTER TABLE IAUDITOR_INSPECTION SET SERDEPROPERTIES ('input.regex'=".*:\"(.*?)\",\"audit_data\":\\{\"name\":(\\d),\"total_score\":(\\d),\"score_percentage\":(\\d),\"date_completed\":(\\d),\"date_modified\":(\\d),\"date_started\":(\\d).*$");
ALTER TABLE IAUDITOR_INSPECTION SET SERDEPROPERTIES ('input.regex'=".*:\"(.*?)\",\"template_data\":\\{\"metadata\":\\{\"description\":(\\d),\"name\":(\\d).*$");
ALTER TABLE IAUDITOR_INSPECTION SET SERDEPROPERTIES ('input.regex'=".*:\"(.*?)\",\"template_data\":\\{\"metadata\":\\{\"image\":\\{\"date_created\":(\\d),\"file_ext\":(\\d),\"label\":(\\d),\"media_id\":(\\d),\"href\":(\\d).*$");

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
name string,
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