#!/bin/bash
set -e
###############################################################################
# Copyright 2021 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################
XMLSERVER_PATH=/opt/ibm/Curam/xmlserver
cd $XMLSERVER_PATH

JAVA_CLIENT_CLASSNAME=StatsForPrometheus
JAVA_CLIENT_NAME="Prometheus collector/exporter"
LOGFILE=${JAVA_CLIENT_CLASSNAME}.log
PIDFILE=${JAVA_CLIENT_CLASSNAME}.pid

echo "`date '+%0k:%0M:%0S'` INFO - Stopping the $JAVA_CLIENT_NAME for XML server statistics data ..." 2>&1 | tee -a tmp/$LOGFILE

JAVA_CLIENT_NAME=java_client
if [ ! -e  tmp/$PIDFILE ] ; then
  echo "`date '+%0k:%0M:%0S'` ERROR - No tmp/$PIDFILE file was found." 2>&1 | tee -a tmp/$LOGFILE
else
  rm -f tmp/$PIDFILE
  echo "`date '+%0k:%0M:%0S'` INFO - Stop invoked for the $JAVA_CLIENT_NAME." 2>&1 | tee -a tmp/$LOGFILE
fi
