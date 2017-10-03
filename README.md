
## Testing

Create alerts

`./send_critical.sh TEST_HOSTNAME_HERE`
ie:
`./send_critical.sh node-50.test`

Check Salesforce for new alerts.

Send alerts again to make sure no duplicate cases are made

`./send_critical.sh TEST_HOSTNAME_HERE`

Send recovery alerts

`./send_recovery.sh TEST_HOSTNAME_HERE`

Check that Salesforce alerts are now in 'Auto-solved' status.

