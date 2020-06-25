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

ARG DOCKER_REGISTRY="internal.docker.repository"
ARG HTTP_VERSION=9.0.0.11

#Unzip static content in to temp
FROM alpine AS ExplodedStaticzip
COPY StaticContent.zip /tmp/
RUN mkdir -p /work/staticcontent/ \
    && unzip -o -q /tmp/StaticContent.zip -d /work/staticcontent/

#Final
FROM ${DOCKER_REGISTRY}/ubi7/ibm-http-server:${HTTP_VERSION}
ARG HTTP_VERSION
LABEL IHS_VERSION=${HTTP_VERSION}

CMD ["/work/ihsstart.sh"]

USER root
RUN echo "include conf.d/*.conf" >> /opt/IBM/HTTPServer/conf/httpd.conf \
    && chmod g+w /opt/IBM/HTTPServer \
    && chmod -Rc g+w /opt/IBM/HTTPServer/logs \
    && chmod -Rc g+rw /opt/IBM/WebSphere/Plugins/config \
    && chmod -Rc g+rw /opt/IBM/WebSphere/Plugins/logs

# Provide authority to bind as non-root
RUN setcap CAP_NET_BIND_SERVICE+ep /opt/IBM/HTTPServer/bin/httpd \
    && echo /opt/IBM/HTTPServer/lib > /etc/ld.so.conf.d/httpd-lib.conf \
    && echo /opt/IBM/HTTPServer/gsk8/lib64 >> /etc/ld.so.conf.d/httpd-lib.conf \
    && rm -rf /etc/ld.so.cache \
    && /sbin/ldconfig

COPY --from=ExplodedStaticzip /work/staticcontent/WebContent /opt/IBM/HTTPServer/htdocs/CuramStatic
COPY httpdconfig/custom_*.conf /opt/IBM/HTTPServer/conf.d/
COPY ihsstart.sh /work/

USER 1000
