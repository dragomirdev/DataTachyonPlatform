#==========================================================
#Load libraies and constants
#==========================================================

import sys
import requests
import re
import time


def main(args):

    process_group = "14678882-b46d-3468-cd94-2ab469ee33d3"
    hostname_port = "JP-DTP-NIFI-VM:9090"

    data_input_path = args[1]
    data_output_path = args[2]
    data_bkp_path = args[3]
    data_err_path = args[4]

    print("From the Script")
    print("Input path: " + data_input_path)
    print("output path: " + data_output_path)
    print("Backup path: " + data_bkp_path)
    print("Error path: " + data_err_path)

    ############################
    ############################
    # Stop the process group
    ############################
    ############################
    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/javascript, */*; q=0.01',
        'Host': hostname_port,
        'Origin': 'http://' + hostname_port,
    }

    data = '{"id":"' + process_group + '","state":"STOPPED"}'
    response = requests.put('http://' + hostname_port + '/nifi-api/flow/process-groups/' + process_group, headers=headers, data=data)
    print(response)


    time.sleep(30)
    #####################################################################
    #####################################################################
    # Update the input and output locations in the process group variables
    #####################################################################
    #####################################################################
    var_reg_current = requests.get('http://' + hostname_port + '/nifi-api/process-groups/' + process_group + '/variable-registry').text
    print("######### Original Variables ###########")
    print(var_reg_current)

    new_out_path = 'out_path\",\"value\":\"'+data_output_path+'\"'
    var_reg_out_updt = re.sub('out_path\",\"value\":\"/[\w|=|\d\-\d\-\d|/]*\"', new_out_path, var_reg_current)
    new_in_path = 'in_path\",\"value\":\"'+data_input_path+'\"'
    var_reg_in_updt = re.sub('in_path\",\"value\":\"/[\w|=|\d\-\d\-\d|/]*\"', new_in_path, var_reg_out_updt)
    new_bkp_path = 'bkp_path\",\"value\":\"' + data_bkp_path + '\"'
    var_reg_bkp_updt = re.sub('bkp_path\",\"value\":\"/[\w|=|\d\-\d\-\d|/]*\"', new_bkp_path, var_reg_in_updt)
    new_err_path = 'err_path\",\"value\":\"' + data_err_path + '\"'
    var_reg_mod = re.sub('err_path\",\"value\":\"/[\w|=|\d\-\d\-\d|/]*\"', new_err_path, var_reg_bkp_updt)
    print("######### Updated Variables ###########")
    print(var_reg_mod)

    response = requests.put('http://' + hostname_port + '/nifi-api/process-groups/' + process_group + '/variable-registry', headers=headers, data=var_reg_mod)
    print(response)
    time.sleep(30)


    ############################
    ############################
    # Restart the process group
    ############################
    ############################
    headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/javascript, */*; q=0.01',
        'Host': hostname_port,
        'Origin': 'http://' + hostname_port,
    }

    data = '{"id":"' + process_group + '","state":"RUNNING"}'
    response = requests.put('http://' + hostname_port + '/nifi-api/flow/process-groups/' + process_group, headers=headers, data=data)
    print(response)


if __name__ == '__main__':
    main(sys.argv)
