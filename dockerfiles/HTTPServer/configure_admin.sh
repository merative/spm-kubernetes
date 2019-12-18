#!/bin/sh

if [ ! -f /opt/IBM/HTTPServer/conf/admin.conf.ready ]; then
  echo "Adding custom include directives to /opt/IBM/HTTPServer/conf/httpd.conf ..."
  echo "include /opt/IBM/HTTPServer/conf/custom_ihs_perf.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf
  echo "include /opt/IBM/HTTPServer/conf/custom_ssl.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf
  echo "include /opt/IBM/HTTPServer/conf/custom_staticcontent.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf
  echo "Done."

  echo "IHS Admin Server needs to be configured."
  /opt/IBM/WebSphere/Toolbox/WCT/wctcmd.sh -tool pct -defLocPathname /opt/IBM/WebSphere/Plugins -defLocName loc1 -createDefinition -response /work/ihs_responsefile.txt
  /opt/IBM/HTTPServer/bin/htpasswd -b -cm /opt/IBM/HTTPServer/conf/admin.passwd wasadmin wasadmin

  gskcapicmd -keydb -create -db "/opt/IBM/WebSphere/Plugins/config/key.kdb" -pw wasadmin -type cms -stash
  gskcapicmd -cert -create -db "/opt/IBM/WebSphere/Plugins/config/key.kdb" -pw wasadmin -label ibm-http-server -size 2048 -sigalg SHA256WithRSA -expire 3650 -dn "CN=ibm-http-server,O=IBM,C=IE" -default_cert yes

  touch /opt/IBM/HTTPServer/conf/admin.conf.ready
fi
