import json
import sys
import ntpath
from pyspark.sql import SparkSession
from datetime import date
from pyspark.sql.functions import col, slice, explode, monotonically_increasing_id
import pyspark.sql.functions as F
from pyspark.sql.functions import size
today=date.today().strftime('%Y%m%d')
print("Date:"+today)

app_name= "ProcessiAuditorInspectionReports"
hdfs_client = "hdfs://JP-DTP-HADOOP-NM-VM:9000"
#input_path = "/data/dtp/landing/iAuditor/{}/".format("20191112")
#output_path = "/data/dtp/processed/iAuditor/"

import requests
bearer_token = "2826331ab2e41fa2eec7172e07e9819db375242b6bbfecf93f225a1b28575f8f"
headers = {"Authorization": "Bearer {}".format(bearer_token)}
# iAuditor Inspection Report Api Endpoint
inspection_url = "https://api.safetyculture.io/audits/audit_id"

# Defining all required functions
def get_spark_session():
    spark =  SparkSession.builder.appName(app_name)\
        .config('spark.hadoop.validateOutputSpecs', 'false')\
        .config('spark.files.overwrite','true').getOrCreate()
    return spark

spark = get_spark_session()


def getAuditInspectionReport():
    audit_id = "audit_9aa9e2c145364130886cdc7cc46e60dd"
    audit_inspection_url = inspection_url.replace('audit_id', str(audit_id))
    print("audit_Search_Request:{} ".format(str(audit_inspection_url)))
    audit_response = requests.get(url=audit_inspection_url, headers=headers)
    print("audit_Search_Request:{} ".format(str(audit_inspection_url)))
    # extracting data in json format
    inspection_report = audit_response.json()
    #print("inspection_report:%s", inspection_report)
    return  audit_response

def getFileFromHdfs(input_path):
    hdfs_input_path = hdfs_client + input_path
    print("Reading the HDFS Input Json File ", hdfs_input_path)
    json_df = spark.read.option('multiline', "true").json(hdfs_input_path)
    return json_df

def get_last_element(l):
    return l[-1]


def extract_ingestion_date(path):
    head, tail = ntpath.split(path)
    return tail or ntpath.basename(head)


def write_sdf_to_csv(output_filepath, result_df):
    print("Writing the output to: ", output_filepath)
    result_df.repartition(1).write.csv(output_filepath, sep=',', header='true', mode='overwrite')
    print("Completed Writing the CSV output to: ", output_filepath)


def processiAuditorInspectionReport(args):
    print("Starting Process iAuditor InspectionReport")
    sc = spark.sparkContext
    input_date = args[1]
    input_path = args[2]
    output_path = args[3]
    json_df = getFileFromHdfs(input_path)
    json_df.printSchema()
    json_df.show()

    last_item_df = json_df.withColumn('items_size', F.size(F.col('items')))\
        .withColumn("last_item", F.col('items')[F.col('items_size') - 1]) \
        .drop('items', 'items_size')
    last_item_df.printSchema()
    last_item_df.show()

    result_df = last_item_df.select([col("audit_id").alias("audit_id"),
                             col("archived").alias("archived"),
                             col("template_id").alias("template_id"),
                             col("audit_data.name").alias("audit_name"),
                             col("template_data.metadata.name").alias("template_name"),
                             col("audit_data.authorship.author").alias("audit_author"),
                             col("audit_data.authorship.author_id").alias("audit_authorId"),
                             col("audit_data.authorship.device_id").alias("audit_device_id"),
                             col("audit_data.authorship.owner").alias("audit_owner"),
                             col("audit_data.authorship.owner_id").alias("audit_owner_id"),
                             col("audit_data.date_started").alias("audit_date_started"),
                             col("audit_data.date_modified").alias("audit_date_modified"),
                             col("audit_data.date_completed").alias("audit_date_completed"),
                             col("audit_data.duration").alias("audit_duration"),
                             col("audit_data.score").alias("audit_score"),
                             col("audit_data.score_percentage").alias("audit_score_percentage"),
                             col("audit_data.total_score").alias("audit_total_score"),
                             col("template_data.metadata.description").alias("template_description"),
                             col("last_item.responses.name").alias("inspector_full_name"),
                             col("last_item.responses.failed").alias("inspected_failed"),
                             col("last_item.responses.text").alias("inspected_text"),
                             col("last_item.responses.media.href").alias("inspector_signature_image_url"),
                             col("last_item.responses.media.label").alias("inspection_signature_image_filename"),
                             col("last_item.responses.media.date_created").alias("inspection_date_created")])

    result_df.printSchema()
    result_df.show()
    #ingestion_date = extract_ingestion_date(input_path)
    #print("ingestion_date:"+ingestion_date)
    ingestion_date = input_date
    ingestion_date_info = '/ingestiondate=' + ingestion_date
    output_filepath = hdfs_client + output_path + ingestion_date_info
    write_sdf_to_csv(output_filepath, result_df)

if __name__ == '__main__':
    processiAuditorInspectionReport(sys.argv)


