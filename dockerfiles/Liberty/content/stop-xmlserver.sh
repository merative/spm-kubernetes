#!/bin/bash
set -e
XMLSERVER_PATH=/opt/ibm/Curam/xmlserver

echo "INFO - Stopping XML Server ..."
ant -f $XMLSERVER_PATH/xmlserver.xml stop 2>&1 | tee -a tmp/xmlserver.log
if [ $? = 0 ]
then
  echo "INFO - XML Server stop invoked."
else
  echo "ERROR - XML Server stop invocation failed; more information may be found in tmp/xmlserver.log"
fi

