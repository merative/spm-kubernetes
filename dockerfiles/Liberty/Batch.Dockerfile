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

ARG WLP_VERSION=19.0.0.6
FROM alpine
ARG ANT_VERSION=1.9.9
COPY content/apache-ant-${ANT_VERSION}-bin.zip /tmp/apache-ant.zip
RUN unzip -qo /tmp/apache-ant.zip -d /opt/

FROM websphere-liberty:${WLP_VERSION}-javaee7

WORKDIR /opt/ibm/Curam/release
ENTRYPOINT ["build.sh"]
CMD ["runbatch"]

ARG ANT_VERSION=1.9.9
ENV ANT_HOME=/opt/apache-ant-${ANT_VERSION} \
    ANT_OPTS='-Xmx1400m -Dcmp.maxmemory=1400m' \
    JAVA_HOME=/opt/ibm/java \
    JAVAMAIL_HOME=/opt/javamail \
    WLP_HOME=/opt/ibm/wlp
ENV PATH=$ANT_HOME/bin:$JAVA_HOME/bin:$PATH:.

COPY --from=0 --chown=1001:0 /opt/apache-ant-${ANT_VERSION} /opt/apache-ant-${ANT_VERSION}

USER root
RUN mkdir -p /opt/ibm/Curam/release \
    && chown -Rv 1001:0 /opt/ibm/Curam
USER 1001

COPY --chown=1001:0 content/res-stage/CryptoConfig.jar /opt/ibm/java/jre/lib/ext/
COPY --chown=1001:0 content/dependencies/javax.mail.jar /opt/javamail/mail.jar
COPY --chown=1001:0 content/dependencies/activation.jar /opt/javamail/activation.jar
COPY --chown=1001:0 content/batch-stage/SetEnvironment.sh /opt/ibm/Curam/
COPY --chown=1001:0 content/batch-stage /opt/ibm/Curam/release

RUN chmod +x /opt/ibm/Curam/release/*.sh
