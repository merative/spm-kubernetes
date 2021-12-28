###############################################################################
# Copyright 2021 IBM Corporation
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

ARG XMLSERVER_PROMETHEUS_JAR=xmlserver-metrics/xmlserver_prometheus.jar

# If set, must end with a forward slash, e.g. "registry.connect.redhat.com/"
ARG BASE_REGISTRY

# Final image
FROM ${BASE_REGISTRY}ibm/ibmjava8-sdk-ubi8-minimal:latest

EXPOSE 8080
WORKDIR /opt/ibm/Curam/xmlserver
# Using the deployment command: structure to specify and invoke the startup script

ENV JAVA_HOME=/opt/ibm/java
ENV PATH=$JAVA_HOME/bin:$PATH:.

ARG XMLSERVER_PROMETHEUS_JAR
USER root
ADD $XMLSERVER_PROMETHEUS_JAR /opt/ibm/Curam/xmlserver/
RUN rpm -e --nodeps tzdata \
    && microdnf install -y tzdata \
    && microdnf install -y vi \
    && microdnf install -y less \
    && microdnf install -y procps \
    && microdnf clean all \
    && rm -rf /var/cache/yum
RUN mkdir /opt/ibm/Curam/xmlserver/tmp \
    && mkdir /opt/ibm/Curam/xmlserver/stats \
    && chown 1001:0 /opt/ibm/Curam/xmlserver/xmlserver_prometheus.jar

COPY xmlserver-metrics/start-prometheus_collector_exporter.sh /opt/ibm/Curam/xmlserver/start-prometheus_collector_exporter.sh
COPY xmlserver-metrics/stop-prometheus_collector_exporter.sh /opt/ibm/Curam/xmlserver/stop-prometheus_collector_exporter.sh
RUN chgrp -Rc 0 /opt/ibm/Curam \
    && chmod -Rc g=u /opt/ibm/Curam \
    && chmod -c +x /opt/ibm/Curam/xmlserver/*.sh

USER 1001
