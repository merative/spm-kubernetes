#! /bin/bash
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
  # Persistence volume can be slow to mount
  while [ ! -d "$MOUNT_POINT" ]; do
    sleep 1
  done
  LOG_PATH=$MOUNT_POINT/$HOSTNAME/logs
  mkdir -p $LOG_PATH
  rm -rf /opt/IBM/HTTPServer/logs
  ln -s $LOG_PATH /opt/IBM/HTTPServer/logs
fi

mkdir -p /opt/IBM/WebSphere/Plugins/config/ssl
# Note label must match the SSLServerCert setting located within custom_ssl.conf file
gskcapicmd -keydb -create -db /opt/IBM/WebSphere/Plugins/config/ssl/key.kdb -pw wasadmin -type cms -stash
if [ -n "$SSL_CERT_PATH" ]; then
  echo "Importing SSL certificate from $SSL_CERT_PATH ..."
  openssl pkcs12 -export -inkey $SSL_CERT_PATH/tls.key -in $SSL_CERT_PATH/tls.crt -out /tmp/keystore.p12 -password pass:password -name websphere
  gskcapicmd -cert -import -db /tmp/keystore.p12 -type pkcs12 -pw password -target /opt/IBM/WebSphere/Plugins/config/ssl/key.kdb -target_stashed
  gskcapicmd -cert -setdefault -db /opt/IBM/WebSphere/Plugins/config/ssl/key.kdb -stashed -label websphere
else
  echo "Generating self-signed SSL certificate ..."
  gskcapicmd -cert -create -db /opt/IBM/WebSphere/Plugins/config/ssl/key.kdb -stashed -label websphere -size 2048 -sigalg SHA256WithRSA -expire 3650 -dn "CN=$HOSTNAME,OU=SPM,O=IBM Watson Health,C=US" -default_cert yes
fi

# Starts the server and catchs exit signal
startServer
trap "stopServer" SIGTERM  
sleep 10

# Only start tailing logs if a pid file has been created (i.e. IHS started successfully)
if [ -f "/opt/IBM/HTTPServer/logs/httpd.pid" ]; then
  tail -F $LOG_PATH/access_log -F $LOG_PATH/error_log
fi
