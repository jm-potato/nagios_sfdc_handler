#!/bin/bash -x
#    Copyright 2016 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

function send_service_alert() {
    /usr/bin/printf "%b" "Notification Type: ${NOTIFICATIONTYPE}\nState: ${STATE}\nDate/Time: ${LONGDATETIME}\nHost: ${HOSTNAME}\nService: ${SERVICEDESC}\n\nAdditional info:\n${SERVICEOUTPUT}\n\nComment: ${COMMENT}" \
| ./sfdc_nagios.py \
                               -c config.yaml \
                               --long_date_time "$LONGDATETIME" \
                               --description "-" \
                               --host_name "$HOSTNAME" \
                               --service_description "$SERVICEDESC" \
                               --notification_type "$NOTIFICATIONTYPE" \
                               --state ${STATE} \
                               --debug \
                               --log_file "nagios_to_sfdc.log"
}

function send_host_alert() {
    /usr/bin/printf "%b" "Notification Type: ${NOTIFICATIONTYPE}\nState: ${STATE}\nDate/Time: ${LONGDATETIME}\nHost: ${HOSTNAME}\n\nAdditional Info:\n ${HOSTOUTPUT}\n\nComment: ${COMMENT}" \
| ./sfdc_nagios.py \
                               -c config.yaml \
                               --long_date_time "$LONGDATETIME" \
                               --description "-" \
                               --host_name "$HOSTNAME" \
                               --notification_type "$NOTIFICATIONTYPE" \
                               --state ${STATE} \
                               --debug \
                               --log_file "nagios_to_sfdc.log"
}


LONGDATETIME=`date`
IP_ADDRESS="1.1.1.1"
HOSTNAME="${1}"


SERVICEDESC="linux_system_network_rx"
SERVICEOUTPUT="linux_system_network_rx OKAY"
NOTIFICATIONTYPE="RECOVERY"
STATE="OK"
COMMENT=""
send_service_alert



SERVICEDESC="linux_system_root_fs"
SERVICEOUTPUT="linux_system_root_fs OKAY"
NOTIFICATIONTYPE="RECOVERY"
STATE="OK"
COMMENT=""
send_service_alert



SERVICEDESC="zookeeper_server"
SERVICEOUTPUT="zookeeper_server OKAY"
NOTIFICATIONTYPE="RECOVERY"
STATE="OK"
COMMENT=""
send_service_alert



SERVICEDESC=""
HOSTOUTPUT="PING OK - Packet loss = 0%, RTA = 3.95 ms"
NOTIFICATIONTYPE="RECOVERY"
STATE="UP"
COMMENT=""
send_host_alert

