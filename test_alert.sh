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
#
#



LONGDATETIME=`date`

IP_ADDRESS=`/sbin/ip ro get 8.8.8.8 |  awk '(/src/) { print $7}'`
HOSTNAME="node-97-testing"
SERVICEDESC="SSH"
SERVICEOUTPUT="CRITICAL - Socket timeout after 10 seconds"
NOTIFICATIONTYPE="PROBLEM"
COMMENT=""
#STATE="OK"
#STATE="UNCKNOWN"
#STATE="WARNING"
STATE="CRITICAL"


echo "Sending CRITICAL service alert..."
/usr/bin/printf "%b" "Notification Type: ${NOTIFICATIONTYPE} \n State: ${STATE}\n\n Date/Time: ${LONGDATETIME} \n Host: ${HOST} (Address: ${IP_ADDRESS})\n Service: ${SERVICEDESC} \n Additional Info:\n ${SERVICEOUTPUT}\n \n\n Comment: ${COMMENT}" \
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


sleep 5
echo "Sending recovery/OK service alert..."

NOTIFICATIONTYPE="PROBLEM"
STATE="OK"
/usr/bin/printf "%b" "Notification Type: ${NOTIFICATIONTYPE} \n State: ${STATE}\n\n Date/Time: ${LONGDATETIME} \n Host: ${HOST} (Address: ${IP_ADDRESS})\n Service: ${SERVICEDESC} \n Additional Info:\n ${SERVICEOUTPUT}\n \n\n Comment: ${COMMENT}" \
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


sleep 5
echo "Sending DOWN host alert..."

NOTIFICATIONTYPE="PROBLEM"
STATE="DOWN"
HOSTOUTPUT="CRITICAL - Host Unreachable (${IP_ADDRESS})"
/usr/bin/printf "%b" "Notification Type: ${NOTIFICATIONTYPE} \n State: ${STATE}\n\n Date/Time: ${LONGDATETIME} \n Host: ${HOST} (Address: ${IP_ADDRESS})\n Additional Info:\n ${HOSTOUTPUT}\n \n\n Comment: ${COMMENT}" \
| ./sfdc_nagios.py \
                               -c config.yaml \
                               --long_date_time "$LONGDATETIME" \
                               --description "-" \
                               --host_name "$HOSTNAME" \
                               --notification_type "$NOTIFICATIONTYPE" \
                               --state ${STATE} \
                               --debug \
                               --log_file "nagios_to_sfdc.log"


sleep 5
echo "Sending recovery/UP host alert..."

NOTIFICATIONTYPE="RECOVERY"
STATE="UP"
HOSTOUTPUT="CRITICAL - Host Unreachable (${IP_ADDRESS})"
/usr/bin/printf "%b" "Notification Type: ${NOTIFICATIONTYPE} \n State: ${STATE}\n\n Date/Time: ${LONGDATETIME} \n Host: ${HOST} (Address: ${IP_ADDRESS})\n Additional Info:\n ${HOSTOUTPUT}\n \n\n Comment: ${COMMENT}" \
| ./sfdc_nagios.py \
                               -c config.yaml \
                               --long_date_time "$LONGDATETIME" \
                               --description "-" \
                               --host_name "$HOSTNAME" \
                               --notification_type "$NOTIFICATIONTYPE" \
                               --state ${STATE} \
                               --debug \
                               --log_file "nagios_to_sfdc.log"


