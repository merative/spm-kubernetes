#!/bin/bash
errorList=("The Connection Manager received a fatal connection error from the Resource Adapter for resource jdbc/curamsessdb.")

for i in "${errorList[@]}"
do
    if tail -n 1000 ${1} | grep -q "$i" ${1}; then
        printf "\n%sError: The following error: \n%s\"$i\" \n%s Was detected in the messages log at ${1}\n%s"
        exit 1
    else
        printf "\n%sNo Errors were found in the logs at ${1}"
        exit 0
    fi
done