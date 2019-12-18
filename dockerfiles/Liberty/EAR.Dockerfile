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

ARG EAR_NAME=Curam
ARG WLP_VERSION=19.0.0.6
ARG MQ_ADAPTER_VERSION=9.1.3.0

# Explode EARs in a disposable environment
FROM alpine AS ExplodedEARs
ARG EAR_NAME=Curam

COPY content/ear-stage/ear/WLP/CuramServerCode.ear content/ear-stage/ear/WLP/${EAR_NAME}.ear /tmp/
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
ARG MQ_ADAPTER_VERSION=9.1.3.0

COPY content/${MQ_ADAPTER_VERSION}-IBM-MQ-Java-InstallRA.jar /tmp/
RUN java -jar /tmp/${MQ_ADAPTER_VERSION}-IBM-MQ-Java-InstallRA.jar --acceptLicense /opt

# Create final image
FROM websphere-liberty:${WLP_VERSION}-javaee7
ARG EAR_NAME=Curam

ENV KEYSTORE_REQUIRED=false \
    LICENSE=accept

EXPOSE 10101 10102

USER root
RUN ln -s /opt/ibm/wlp/usr/shared/resources /shared_resources \
    && chown -Rc 1001:0 /config/configDropins \
    && chown -Rc 1001:0 /opt/ibm/wlp/usr/shared \
    && chmod -Rc g+rw /opt/ibm/wlp/usr/shared
USER 1001

COPY --chown=1001:0 content/res-stage/defaultServer /config
COPY --chown=1001:0 content/res-stage/resources /shared_resources
COPY --from=ExplodedEARs --chown=1001:0 /work /config/apps
COPY --from=MQAdapter --chown=1001:0 /opt/wmq /opt/wmq
COPY --chown=1001:0 content/res-stage/CryptoConfig.jar /opt/ibm/java/jre/lib/ext/

# CWWKS4001I: Security token warning message, when previous Liberty cookies already exist in the Browser
RUN sed -i "/\/server/i \  <include location=\"application_CuramServerCode.xml\" />" /config/adc_conf/server_applications.xml \
    && sed -i "/\/server/i \ <include location=\"application_${EAR_NAME}.xml\" />" /config/adc_conf/server_applications.xml \
    && echo 'com.ibm.ws.logging.hideMessage=CWWKE0100I,CWWKS4001I' > /config/bootstrap.properties \
    && sed -e "s|EAR_NAME|$EAR_NAME|g" \
           -e "s|WAR_FILE|`basename $(find /config/apps/${EAR_NAME}.ear -type d -name '*.war')`|g" \
           /config/adc_conf/application_TEMPLATE.xml > /config/adc_conf/application_${EAR_NAME}.xml

RUN installUtility install defaultServer \
    && installUtility install wmqJmsClient-2.0
