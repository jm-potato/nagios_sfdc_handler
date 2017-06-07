
## Testing

Create alerts

`./send_critical.sh node-50-testing`

Check Salesforce for new alerts.

Send alerts again to make sure no duplicate cases are made

`./send_critical.sh node-50-testing`

Send recovery alerts

`./send_recovery.sh node-50-testing`

Check that Salesforce alerts are now Solved.

