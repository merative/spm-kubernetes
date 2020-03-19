###############################################################################
# Copyright 2019,2020 IBM Corporation
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

ARG HTTP_VERSION=9.0.0.11

#Unzip static content in to temp
FROM alpine AS ExplodedStaticzip
COPY StaticContent.zip /tmp/
RUN mkdir -p /work/staticcontent/ \
    && unzip -o -q /tmp/StaticContent.zip -d /work/staticcontent/

#Final
FROM ibmcom/ibm-http-server:${HTTP_VERSION}
ARG HTTP_VERSION
LABEL IHS_VERSION=${HTTP_VERSION}

CMD ["/work/ihsstart.sh"]

RUN useradd -g 0 -M default && usermod -L default \
    && echo "include conf.d/*.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf \
    && sed -i 's/^Listen 80$/Listen 8080/' /opt/IBM/HTTPServer/conf/httpd.conf \
    && chmod g+w /opt/IBM/HTTPServer \
    && chmod -Rc g+w /opt/IBM/HTTPServer/logs

#Note label must match the SSLServerCert setting located within custom_ssl.conf file
#The certificate label name, when viewed in the Key Management Utility (iKeyman), should not contain reserved characters such as "; ; - _" ( semicolon, colon, dash, and so on). These are reserved characters and should not be used as part of the label name.
RUN gskcapicmd -keydb -create -db "/opt/IBM/WebSphere/Plugins/config/key.kdb" -pw wasadmin -type cms -stash \
    && gskcapicmd -cert -create -db "/opt/IBM/WebSphere/Plugins/config/key.kdb" -pw wasadmin -label websphere -size 2048 -sigalg SHA256WithRSA -expire 3650 -dn "CN=websphere,O=IBM,C=IE" -default_cert yes \
    && chmod -Rc g+rw /opt/IBM/WebSphere/Plugins/config \
    && chmod -Rc g+rw /opt/IBM/WebSphere/Plugins/logs

COPY --from=ExplodedStaticzip /work/staticcontent/WebContent /opt/IBM/HTTPServer/htdocs/CuramStatic
COPY httpdconfig/custom_*.conf /opt/IBM/HTTPServer/conf.d/
COPY ihsstart.sh /work/

USER default
