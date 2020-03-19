#! /bin/bash
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

#####################################################################################
#                                                                                   #
#  Script to start the server (based on orignal ihsstart.sh)                        #
#                                                                                   #
#  Usage : start_ihs.sh                                                             #
#                                                                                   #
#####################################################################################
LOG_PATH=/opt/IBM/HTTPServer/logs

startServer()
{
    echo "Starting IBM HTTP Server "
    # Starting IBM HTTPServer
    /opt/IBM/HTTPServer/bin/apachectl start

    if [ $? = 0 ]
    then
       echo "IBM HTTP Server started successfully"
    else
       echo "Failed to start IBM HTTP Server"
    fi
}

stopServer()
{
    echo "Stopping IBM HTTP Server "
    # Stopping IBM HTTPServer
    /opt/IBM/HTTPServer/bin/apachectl graceful-stop
    if [ $? = 0 ]
    then
       echo "IBM HTTP Server stopped successfully"
    fi
}

# Creates a directory for persistence on the PV volume (if set by Helm)
if [ -n "$MOUNT_POINT" ]; then
  LOG_PATH=$MOUNT_POINT/$HOSTNAME/logs
  mkdir -p $LOG_PATH
  rm -rf /opt/IBM/HTTPServer/logs
  ln -s $LOG_PATH /opt/IBM/HTTPServer/logs
fi

# Starts the server and catchs exit signal
startServer
trap "stopServer" SIGTERM
sleep 10

# Only start tailing logs if a pid file has been created (i.e. IHS started successfully)
if [ -f "/opt/IBM/HTTPServer/logs/httpd.pid" ]; then
  tail -F $LOG_PATH/access_log -F $LOG_PATH/error_log
fi
