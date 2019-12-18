###############################################################################
# Copyright 2019 IBM Corporation
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

FROM alpine
ARG ANT_VERSION=1.9.9
COPY content/apache-ant-${ANT_VERSION}-bin.zip /tmp/apache-ant.zip
RUN unzip -qo /tmp/apache-ant.zip -d /opt/


FROM ibmjava:8-sdk

RUN useradd -u 1001 -r -g 0 -s /usr/sbin/nologin default
EXPOSE 1800
WORKDIR /opt/ibm/Curam/xmlserver
ENTRYPOINT ["ant", "-f", "xmlserver.xml"]

ARG ANT_VERSION=1.9.9
ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION} \
    ANT_OPTS='-Xmx1400m -Dcmp.maxmemory=1400m' \
    JAVA_HOME=/opt/ibm/java
ENV PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH:.

COPY --from=0 --chown=1001:0 /opt/apache-ant-${ANT_VERSION} /opt/apache-ant-${ANT_VERSION}


RUN mkdir -p /opt/ibm/Curam/xmlserver \
    && chown -Rc 1001:0 /opt/ibm/Curam

COPY --chown=1001:0 content/batch-stage/CuramSDEJ/xmlserver /opt/ibm/Curam/xmlserver

USER 1001
