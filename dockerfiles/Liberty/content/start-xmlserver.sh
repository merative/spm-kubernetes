#!/bin/bash
set -e
###############################################################################
# Copyright 2020,2021 IBM Corporation
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

# Creates directories for persistence on the PV volume (if set by Helm)
if [ -n "$MOUNT_POINT" ]; then
  # Persistence volume can be slow to mount
  while [ ! -d "$MOUNT_POINT" ]; do
    sleep 1
  done
  mkdir -p $MOUNT_POINT/$HOSTNAME/gc
  mkdir -p $MOUNT_POINT/$HOSTNAME/dump
  mkdir -p $MOUNT_POINT/$HOSTNAME/tmp
  mkdir -p $MOUNT_POINT/$HOSTNAME/template
  mkdir -p $MOUNT_POINT/$HOSTNAME/stats
  rm -rf $XMLSERVER_PATH/tmp $XMLSERVER_PATH/template $XMLSERVER_PATH/stats
  ln -s $MOUNT_POINT/$HOSTNAME/tmp $XMLSERVER_PATH/tmp
  ln -s $MOUNT_POINT/$HOSTNAME/template  $XMLSERVER_PATH/template
  ln -s $MOUNT_POINT/$HOSTNAME/stats $XMLSERVER_PATH/stats
  JVM_GC_OPTS="-verbose:gc -Xverbosegclog:$MOUNT_POINT/$HOSTNAME/gc/verbosegc.log -Xdump:directory=$MOUNT_POINT/$HOSTNAME/gc/dump"
else
  JVM_GC_OPTS="-verbose:gc -Xverbosegclog:tmp/verbosegc.log"
fi

# Starts XML Server
cd $XMLSERVER_PATH
# The values for JVM_MAX_MEM JVM_THREAD_STACK_SIZE will come from the Helm charts

# use sed to edit the xmlserver.xml file to incorporate the new max memory as well as any jvm arguments
# first change the maxmemory size, if the JVM_MAX_MEM param is set

if [ ! -z ${JVM_MAX_MEM} ]; then
  sed -i "s/<property name=\"java.maxmemory\"   value=\"768m\"\/>/<property name=\"java.maxmemory\"   value=\"$JVM_MAX_MEM\"\/>/g" xmlserver.xml
fi

# now remove the reference to maxmemory from the java task

sed -i "/maxmemory=\"\${java.maxmemory}\"/d" xmlserver.xml

# now add in an additional line into the java task to use the java.maxmemory as a jvmarg

sed -zEi 's/>([^\n]*\n[^\n]*<jvmarg line=\"\$\{java.jvmargs\}\" \/>)/>\n      <jvmarg value=\"-Xmx\$\{java.maxmemory\}\" \/>\1/'  xmlserver.xml

# if the JAVA_THREAD_STACK_SIZE param is set,include the java thread stack size by replacing the default
if [ ! -z ${JAVA_THREAD_STACK_SIZE} ]; then
  sed -i "s/<property name=\"java.thread.stack.size\" value=\"-Xss4m\"\/>/<property name=\"java.thread.stack.size\" value=\"$JAVA_THREAD_STACK_SIZE\"\/>/g" xmlserver.xml
fi

# now update the xmlserver.xml to update the java options <property name="java.jvmargs" value="-Dfake.property=1"/> to include any jvm options passed in
# note the use of the # char in the sed expression, this is to account for slashes that may be in the paths
JVM_OPTIONS="$JVM_OPTIONS $JVM_GC_OPTS"

sed -i "s#<property name=\"java.jvmargs\" value=\"-Dfake.property=1\"\/>#<property name=\"java.jvmargs\" value=\"$JVM_OPTIONS\"\/>#g" xmlserver.xml
ant -f xmlserver.xml  2>&1 | tee -a tmp/xmlserver.log

