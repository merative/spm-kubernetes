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

# Intermediate image: extract Ant
FROM alpine AS AntStage
ARG ANT_VERSION
COPY content/apache-ant-${ANT_VERSION}-bin.zip /tmp/apache-ant.zip
RUN unzip -qo /tmp/apache-ant.zip -d /opt/

# Final image
FROM registry.connect.redhat.com/ibm/ibmjava8

EXPOSE 1800
WORKDIR /opt/ibm/Curam/xmlserver
ENTRYPOINT ["/opt/ibm/Curam/xmlserver/start-xmlserver.sh"]

ARG ANT_VERSION
ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION} \
    ANT_OPTS='-Xmx1400m -Dcmp.maxmemory=1400m' \
    JAVA_HOME=/opt/ibm/java
ENV PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH:.

USER root
RUN mkdir -p /opt/ibm/Curam/xmlserver \
    && chown -Rc 1001:0 /opt/ibm/Curam
USER 1001

COPY --from=AntStage --chown=1001:0 /opt/apache-ant-${ANT_VERSION} /opt/apache-ant-${ANT_VERSION}
COPY --chown=1001:0 content/release-stage/CuramSDEJ/xmlserver /opt/ibm/Curam/xmlserver
COPY --chown=1001:0 content/start-xmlserver.sh /opt/ibm/Curam/xmlserver/start-xmlserver.sh
