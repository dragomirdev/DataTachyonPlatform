
from os.path import expanduser, join, abspath

from pyspark.sql import SparkSession
from pyspark.sql import Row
from  pyspark.sql.functions import input_file_name

# warehouse_location points to the default location for managed databases and tables
#warehouse_location = abspath('/opt/hive')

#spark = SparkSession \
#    .builder \
#    .appName("C19") \
#    .config("spark.sql.warehouse.dir", warehouse_location) \
#    .enableHiveSupport() \
#    .getOrCreate()

hdfs_namenode_host_name = "JP-DTP-CORONA-DEV-VM"
spark_master_host = "spark://JP-DTP-CORONA-DEV-VM:7077"

spark =  SparkSession.builder.enableHiveSupport().appName("C19") \
.config("spark.master", spark_master_host) \
.config("spark.sql.hive.thriftServer.singleSession", "True") \
.config("spark.sql.warehouse.dir", "/opt/hive/metastore_db") \
.config("spark.sql.hive.hiveserver2.jdbc.url", "jdbc:hive2://localhost:10000")\
.config('spark.datasource.hive.warehouse.metastoreUri', 'thrift://127.0.0.1:9083')\
.enableHiveSupport()\
.getOrCreate()

# Queries are expressed in HiveQL
spark.sql("SHOW DATABASES").show()

input_csv_folder = '/data/landing/images/xray/Covid-19-XRayImage.jpg'

hdfs_client_url = "hdfs://"+hdfs_namenode_host_name+":9000/"

input_hdfs_dir = hdfs_client_url + input_csv_folder
image_info_df = spark.read.format("image").load(input_hdfs_dir).withColumn("filename", input_file_name())
image_info_df.printSchema()
image_info_df.show()
