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

ARG EAR_NAME
ARG WLP_VERSION=19.0.0.12-full-java8-ibmjava-ubi
ARG MQ_ADAPTER_VERSION=9.1.3.0
ARG MQ_RA_LICENSE

# Explode EARs in a disposable environment
FROM alpine AS ExplodedEARs
ARG EAR_NAME
ARG MQ_RA_LICENSE

COPY content/release-stage/ear/WLP/CuramServerCode.ear content/release-stage/ear/WLP/${EAR_NAME}.ear /tmp/
RUN mkdir -p /work/CuramServerCode.ear /work/${EAR_NAME}.ear \
    && unzip -q /tmp/CuramServerCode.ear -d /work/CuramServerCode.ear \
    && unzip -q /tmp/${EAR_NAME}.ear -d /work/${EAR_NAME}.ear \
    && ORIG_WAR_PATH=`find /work/${EAR_NAME}.ear -type f -name "*.war"` \
    && mv $ORIG_WAR_PATH /tmp/ \
    && mkdir -p $ORIG_WAR_PATH \
    && unzip -q /tmp/`basename $ORIG_WAR_PATH` -d $ORIG_WAR_PATH \
    && rm -rf /tmp/*.ear /tmp/*.war \
    && find /work -type f -name ibm-web-bnd.xm* | xargs -n1 sed -i 's|client_host|default_host|g' \
    && find /work -type f -name ibm-web-bnd.xm* | xargs -n1 sed -i 's|webservices_host|default_host|g'

# Run MQ Adapter installer in a disposable environment
FROM ibmjava:8-sdk AS MQAdapter
ARG MQ_ADAPTER_VERSION
ARG MQ_RA_LICENSE

COPY content/${MQ_ADAPTER_VERSION}-IBM-MQ-Java-InstallRA.jar /tmp/
RUN java -jar /tmp/${MQ_ADAPTER_VERSION}-IBM-MQ-Java-InstallRA.jar ${MQ_RA_LICENSE} /opt

# Create final image
FROM ibmcom/websphere-liberty:${WLP_VERSION}
ARG EAR_NAME

USER root
RUN ln -s /opt/ibm/wlp/usr/shared/resources /shared_resources \
    && chown -Rc 1001:0 /config/configDropins \
    && chown -Rc 1001:0 /opt/ibm/wlp/usr/shared \
    && chmod -Rc g+rw /opt/ibm/wlp/usr/shared \
    && rm -f /config/configDropins/defaults/*
USER 1001

COPY --chown=1001:0 content/docker-server.sh /opt/ibm/helpers/runtime/docker-server.sh
COPY --from=MQAdapter --chown=1001:0 /opt/wmq /opt/wmq
COPY --chown=1001:0 content/release-stage/CuramSDEJ/drivers/db2jcc*.jar /shared_resources/drivers/
COPY --chown=1001:0 content/release-stage/CuramSDEJ/drivers/ojdbc*.jar /shared_resources/drivers/
COPY --chown=1001:0 content/release-stage/CuramSDEJ/lib/WLPRegistry.jar /shared_resources/
COPY --chown=1001:0 content/release-stage/CuramSDEJ/lib/coreinf-ejb-interfaces.jar /shared_resources/
COPY --chown=1001:0 content/release-stage/build/CryptoConfig.jar /opt/ibm/java/jre/lib/ext/
COPY --from=ExplodedEARs --chown=1001:0 /work /config/apps

RUN installUtility install defaultServer \
    && (installUtility install wmqJmsClient-2.0 || true)