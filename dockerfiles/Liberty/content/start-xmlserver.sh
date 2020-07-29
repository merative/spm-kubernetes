#!/bin/bash
set -e
###############################################################################
# Copyright 2020 IBM Corporation
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

if [ `id -u` -ge 10000 ]; then
  echo "xmlserver:x:`id -u`:`id -g`:,,,:$XMLSERVER_PATH:/bin/bash" >> /etc/passwd
fi

stopServer() {
  echo "Stopping XML Server "
  ant -f $XMLSERVER_PATH/xmlserver.xml stop 2>&1 | tee -a tmp/xmlserver.log
  if [ $? = 0 ]
  then
      echo "XML Server stopped successfully"
  fi
}

# Creates directories for persistence on the PV volume (if set by Helm)
if [ -n "$MOUNT_POINT" ]; then
  # Persistence volume can be slow to mount
  while [ ! -d "$MOUNT_POINT" ]; do
    sleep 1
  done
  mkdir -p $MOUNT_POINT/$HOSTNAME/tmp
  mkdir -p $MOUNT_POINT/$HOSTNAME/template
  mkdir -p $MOUNT_POINT/$HOSTNAME/stats
  rm -rf $XMLSERVER_PATH/tmp $XMLSERVER_PATH/template $XMLSERVER_PATH/stats
  ln -s $MOUNT_POINT/$HOSTNAME/tmp $XMLSERVER_PATH/tmp
  ln -s $MOUNT_POINT/$HOSTNAME/template  $XMLSERVER_PATH/template
  ln -s $MOUNT_POINT/$HOSTNAME/stats $XMLSERVER_PATH/stats
fi

trap "stopServer" SIGTERM

# Starts XML Server
cd $XMLSERVER_PATH
ant -f xmlserver.xml 2>&1 | tee -a tmp/xmlserver.log
