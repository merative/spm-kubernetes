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
JAVA_CLIENT_PKGNAME=com.ibm.spm.xmlserver
JAVA_CLIENT_JAR=xmlserver_prometheus.jar
JAVA_CLIENT_NAME="Prometheus collector/exporter"
LOGFILE=${JAVA_CLIENT_CLASSNAME}.log
PIDFILE=${JAVA_CLIENT_CLASSNAME}.pid

echo "`date '+%0k:%0M:%0S'` INFO - Starting the $JAVA_CLIENT_NAME for XML server statistics data ..." 2>&1 | tee -a tmp/$LOGFILE

# Creates shared persistent directories on the PV volume (if set by Helm)
if [ -n "$MOUNT_POINT" ]; then
  # Persistence volume can be slow to mount
  while [ ! -d "$MOUNT_POINT" ]; do
    sleep 1
  done
  mkdir -p $MOUNT_POINT/$HOSTNAME/tmp
  mkdir -p $MOUNT_POINT/$HOSTNAME/stats
  rm -rf $XMLSERVER_PATH/tmp $XMLSERVER_PATH/stats
  ln -s $MOUNT_POINT/$HOSTNAME/tmp $XMLSERVER_PATH/tmp
  ln -s $MOUNT_POINT/$HOSTNAME/stats $XMLSERVER_PATH/stats
else
  mkdir -p tmp stats
fi

# Start the Java process for XML server statistics data

if [ -e  tmp/$PIDFILE ] ; then
  echo "`date '+%0k:%0M:%0S'` WARNING - A  tmp/$PIDFILE file already exists, containing: " `tmp/$PIDFILE`"." 2>&1 | tee -a tmp/$LOGFILE
  echo "`date '+%0k:%0M:%0S'`           It will be overridden" 2>&1 | tee -a tmp/$LOGFILE
fi
printf "" > tmp/$PIDFILE

if [ ! -e $JAVA_CLIENT_JAR ] ; then
  echo "`date '+%0k:%0M:%0S'` ERROR - Required jar file $JAVA_CLIENT_JAR not found. "
  exit 1
fi

# Note: There are optional arguments that can be passed in:
#    -httpPort <port>  Port that Prometheus will listen on.  Defaults to: 8080
#    -checkInterval <seconds>            Number of seconds between checks for stats data and termination. Defaults to: 10
#	   -statisticsFolder <directory-name>  Folder containing ThreadPoolWorker-* files. Defaults to: ./stats
java -cp $JAVA_CLIENT_JAR ${JAVA_CLIENT_PKGNAME}.${JAVA_CLIENT_CLASSNAME} >> tmp/$LOGFILE &

LASTCC=$?
if [ $LASTCC == "0" ] ; then 
  JAVA_CLIENT_PID=$!
  echo $JAVA_CLIENT_PID >> tmp/$PIDFILE
  echo "`date '+%0k:%0M:%0S'` INFO - The $JAVA_CLIENT_NAME for XML server statistics has been started with pid: $!" 2>&1 | tee -a tmp/$LOGFILE
else
  echo "`date '+%0k:%0M:%0S'` ERROR - The $JAVA_CLIENT_NAME for XML server statistics failed to start; LASTCC=$LASTCC" 2>&1 | tee -a tmp/$LOGFILE
fi

echo
echo "`date '+%0k:%0M:%0S'` INFO - $JAVA_CLIENT_NAME processing ..." 2>&1 | tee -a tmp/$LOGFILE

# Wait for the end of the Java process for XML server statistics data

# Because we run the Java client in the background in order to get its PID we now need to keep the script running, else the pod goes into CrashLoopBackOff
while [ -e "tmp/$PIDFILE" ]; do
  sleep 5
  set +x
done

set -x
echo "`date '+%0k:%0M:%0S'` INFO - At end of the $JAVA_CLIENT_NAME for XML server statistics." 2>&1 | tee -a tmp/$LOGFILE
