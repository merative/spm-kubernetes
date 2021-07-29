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

ARG ANT_VERSION=1.10.6

# If set, must end with a forward slash, e.g. "registry.connect.redhat.com/"
ARG BASE_REGISTRY

# Intermediate image: extract Ant
FROM alpine AS ExtractAndMod
ARG ANT_VERSION
COPY content/apache-ant-${ANT_VERSION}-bin.zip /tmp/apache-ant.zip
COPY content/release-stage/CuramSDEJ/xmlserver /opt/ibm/Curam/xmlserver
COPY content/start-xmlserver.sh /opt/ibm/Curam/xmlserver/start-xmlserver.sh
COPY content/stop-xmlserver.sh /opt/ibm/Curam/xmlserver/stop-xmlserver.sh
RUN unzip -qo /tmp/apache-ant.zip -d /opt/ \
    && chgrp -Rc 0 /opt/ibm/Curam \
    && chmod -Rc g=u /opt/ibm/Curam \
    && chmod -c +x /opt/ibm/Curam/xmlserver/*.sh

# Final image
FROM ${BASE_REGISTRY}ibm/ibmjava8-sdk-ubi8-minimal:latest

EXPOSE 1800
WORKDIR /opt/ibm/Curam/xmlserver
ENTRYPOINT ["/opt/ibm/Curam/xmlserver/start-xmlserver.sh"]

ARG ANT_VERSION
ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION} \
    ANT_OPTS='-Xmx1400m -Dcmp.maxmemory=1400m' \
    JAVA_HOME=/opt/ibm/java
ENV PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH:.

USER root
RUN rpm -e --nodeps tzdata \
    && microdnf install -y tzdata \
    && microdnf install -y hostname \
    && microdnf clean all \
    && rm -rf /var/cache/yum
RUN mkdir -p /opt/ibm/Curam/xmlserver \
    && chmod -c g+w /etc/passwd $JAVA_HOME/jre/lib/security/cacerts

COPY --from=ExtractAndMod --chown=1001:0 /opt/apache-ant-${ANT_VERSION} /opt/apache-ant-${ANT_VERSION}
COPY --from=ExtractAndMod --chown=1001:0 /opt/ibm/Curam /opt/ibm/Curam

USER 1001
