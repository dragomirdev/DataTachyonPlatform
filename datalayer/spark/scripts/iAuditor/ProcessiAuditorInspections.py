import json
import sys

from pyspark.sql import SparkSession
from datetime import date
from pyspark.sql.functions import col, explode, monotonically_increasing_id

today=date.today().strftime('%Y%m%d')
print("Date:"+today)

app_name= "ProcessiAuditorInspectionReports"
hdfs_client = "hdfs://JP-DTP-HADOOP-NM-VM:9000"
#input_path = "/data/dtp/landing/iAuditor/{}/".format("20191112")
output_path = "/data/dtp/processed/iAuditor/"

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

def getFileFromHdfs(args):
    input_path = args[1]
    hdfs_input_path = hdfs_client + input_path
    print("Reading the HDFS Input Json File ", hdfs_input_path)
    json_df = spark.read.option('multiline', "true").json(hdfs_input_path)
    return json_df


def processiAuditorInspectionReport(args):
    print("Test")
    sc = spark.sparkContext
    json_df = getFileFromHdfs(args)
    #json_df = spark.read.option("multiline", "true").json("sample.json")
    json_df.printSchema()
    audit_id = "audit_id"

    new_df = json_df.select([col(audit_id).alias("audit_id"),
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
                             col("template_data.metadata.description").alias("template_description")])

    new_df.printSchema()
    new_df.show()

    items_df = json_df.select(col(audit_id), explode(json_df.items)).withColumn("rownum", monotonically_increasing_id())
    items_count = items_df.count()
    items_df.printSchema()
    items_df.show(items_count)
    inspection_df = items_df.where(items_df.rownum == items_count-1)
    inspection_df.printSchema()
    inspection_df.show()
    inspector_info_df = inspection_df.select(col("audit_id").alias("audit_id"),
                                          col("col.responses.name").alias("inspector_full_name"),
                                          col("col.responses.image.href").alias("inspector_signature_image_url"),
                                          col("col.responses.image.label").alias("inspection_signature_image_filename"),
                                          col("col.responses.timestamp").alias("inspected_timestamp"),
                                          col("col.responses.image.date_created").alias("inspection_date_created"))
    inspector_info_df.show()


    result_df = new_df.join(inspector_info_df, new_df.audit_id == inspector_info_df.audit_id).drop(inspector_info_df.audit_id)
    result_df.printSchema()
    result_df.show()
    hdfs_input_file_name = args[2]
    output_filename = hdfs_client + output_path +  "audit_inspection_report_"+str(hdfs_input_file_name)
    print("Saving the output to: ", output_filename)
    #result_df.repartition(1).write.format('json').save(output_filename)
    result_df.repartition(1).write.csv(output_filename, sep='|', header = 'true')


if __name__ == '__main__':
    processiAuditorInspectionReport(sys.argv)


