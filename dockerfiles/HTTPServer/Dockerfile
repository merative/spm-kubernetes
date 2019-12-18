ARG HTTP_VERSION=9.0.0.11

#Unzip static content in to temp
FROM alpine AS ExplodedStaticzip
COPY staticcontent/StaticContent.zip /tmp/
RUN mkdir -p /work/staticcontent/ \
    && unzip -o -q /tmp/StaticContent.zip -d /work/staticcontent/

#Final
FROM ibmcom/ibm-http-server:${HTTP_VERSION}
USER root
COPY httpdconfig/custom_*.conf /opt/IBM/HTTPServer/conf/

RUN echo "include /opt/IBM/HTTPServer/conf/custom_ihs_perf.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf \
  && echo "include /opt/IBM/HTTPServer/conf/custom_ssl.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf \
  && echo "include /opt/IBM/HTTPServer/conf/custom_staticcontent.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf

RUN  /opt/IBM/HTTPServer/bin/htpasswd -b -cm /opt/IBM/HTTPServer/conf/admin.passwd wasadmin wasadmin
#Note label must match the SSLServerCert setting located within custom_ssl.conf file
#The certificate label name, when viewed in the Key Management Utility (iKeyman), should not contain reserved characters such as "; ; - _" ( semicolon, colon, dash, and so on). These are reserved characters and should not be used as part of the label name.
RUN  gskcapicmd -keydb -create -db "/opt/IBM/WebSphere/Plugins/config/key.kdb" -pw wasadmin -type cms -stash \
  && gskcapicmd -cert -create -db "/opt/IBM/WebSphere/Plugins/config/key.kdb" -pw wasadmin -label websphere -size 2048 -sigalg SHA256WithRSA -expire 820 -dn "CN=websphere,O=IBM,C=IE" -default_cert yes -eku serverAuth

COPY --from=ExplodedStaticzip --chown=1001:0 /work/staticcontent/WebContent /opt/IBM/HTTPServer/htdocs/CuramStatic

CMD ["/work/ihsstart.sh"]
