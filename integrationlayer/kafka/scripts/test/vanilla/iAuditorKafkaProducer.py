import logging
import json
import sys
from datetime import datetime, timedelta
import requests
from KafkaUitls import getKafkaProducer

logging.basicConfig(format='%(asctime)s - %(levelname)s  %(message)s', level=logging.DEBUG)

# iAuditor Search Api Endpoint
audit_search_url = "https://api.safetyculture.io/audits/search"
bearer_token = "2826331ab2e41fa2eec7172e07e9819db375242b6bbfecf93f225a1b28575f8f"
headers = {"Authorization": "Bearer {}".format(bearer_token)}
# iAuditor Inspection Report Api Endpoint
inspection_url = "https://api.safetyculture.io/audits/audit_id"
current_datetime = datetime.now().isoformat()
modified_before = current_datetime
no_of_days = 1
modified_after = '2019-11-11T00:00:00.000Z'
#modified_after = modified_before - timedelta(days = 1)


def sendMessages(args, payload):
    kafka_listener = args[1]
    kafka_topic_name = args[2]
    kafka_listener = 'JP-DTP-KAFKA-VM:9092'
    kafka_topic_name = 'DTPiAuditorTopic'
    producer = getKafkaProducer(kafka_listener)
    dict_obj = json.loads(payload)
    # dict_obj = json.loads(json.dumps(payload, cls=DateTimeEncoder), cls=DateTimeDecoder)
    print("payload", dict_obj)
    print('Sending Messages to Kafka Topic: ' + kafka_topic_name)
    producer.send(kafka_topic_name, value=dict_obj)
    producer.flush()


def getAuditIds(audits):
    audit_ids = []
    for audit in audits:
        audit_ids.append(audit['audit_id'])
    print("audit_ids", str(audit_ids))
    return audit_ids


def getAuditInspectionReport(args, audit_ids):
    for audit_id in audit_ids:
        audit_inspection_url = inspection_url.replace('audit_id', str(audit_id))
        logging.debug("audit_Search_Request:{} ".format(str(audit_inspection_url)))
        audit_response = requests.get(url=audit_inspection_url, headers=headers)
        logging.debug("audit_Search_Request:{} ".format(str(audit_inspection_url)))
        # extracting data in json format
        inspection_report = audit_response.json()
        logging.debug("inspection_report:%s", inspection_report)
        sendMessages(args, audit_response.text)

def getAuditInspectionReports(args):
    # defining a params dict for the parameters to be sent to the API
    search_params = {'modified_after':modified_after, 'modified_before':modified_before }
    # sending get request and saving the response as response object
    iAudits_Response = requests.get(url=audit_search_url, params=search_params, headers=headers)
    logging.debug("iAudit_Search_Request:{} with params: ".format(str(audit_search_url)), search_params)
    # extracting data in json format
    inspection_reports = iAudits_Response.json()
    logging.debug("iAudit_Search_Response:%s", inspection_reports)
    count = inspection_reports["count"]
    total = inspection_reports["total"]
    logging.debug("count%d total:%d", count, total)
    audits = inspection_reports["audits"]
    logging.debug("audits:%s", audits)
    audit_ids = getAuditIds(audits)
    getAuditInspectionReport(args, audit_ids)


if __name__ == '__main__':
    getAuditInspectionReports(sys.argv)
