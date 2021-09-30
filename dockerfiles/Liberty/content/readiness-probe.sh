#!/bin/bash
# The readiness probe is an initial draft to check if the pods are ready to take workload. If a pod is long-running we may see failures due to spill-over of the logs in the tmp/logs directory.  
for entry in ${1}
do
    if ! (curl -k https://${2} | grep -q "Application is not available") || ((head -n 500 $entry | grep -q "CWWKZ0001I") && (head -n 500 $entry | grep -q "CWWKF0011I")); then
        printf "\n%sThe application is ready to take workload."
        exit 0
    else
        continue
    fi
done
printf "\n%sThe application is not ready to take workload."
exit 1