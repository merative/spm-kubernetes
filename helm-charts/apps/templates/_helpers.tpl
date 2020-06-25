{{/*
Copyright 2019,2020 IBM Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.

Accepted Values:
    Curam,CuramWebServices,Rest,CuramBIRTViewer,CitizenPortal,MDTWorkspace,NavigatorS,NavigatorNS,CPMExternalS,CPMExternalNS
*/}}
{{- define "apps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "apps.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "apps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the image pull secret
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .registry (printf "%s:%s" .username (required "Credentials password is required" .password) | b64enc) | b64enc }}
{{- end }}

{{/*
Build up full image path
*/}}
{{- define "apps.imageFullName" -}}
{{- .ImageConfig.registry -}}/
{{- if .ImageConfig.imageLibrary -}}
{{- .ImageConfig.imageLibrary -}}/
{{- end -}}
{{- if .ImageConfig.imagePrefix -}}
{{- .ImageConfig.imagePrefix -}}
{{- end -}}
{{- .ImageName -}}:{{- .ImageConfig.imageTag -}}
{{- end -}}

{{/*
Define DB2 hostname
*/}}
{{- define "apps.dbhostname" -}}
{{- if .Values.global.database.hostname -}}
{{- .Values.global.database.hostname -}}
{{- else -}}
{{- .Release.Name -}}-db2
{{- end -}}
{{- end -}}

{{/*
Folder name where the Liberty application will store its logs
*/}}
{{- define "apps.logsDir" -}}
{{- if .Values.global.apps.common.persistence.enabled -}}
{{- "/tmp/logs" -}}
{{- else -}}
{{- "/logs" -}}
{{- end -}}
{{- end -}}

{{/*
Mountpoint for the persistence storage on the application pods (e.g. /tmp/persistence )
*/}}
{{- define "persistence.mountPoint" -}}
{{- if .Values.global.apps.common.persistence.mountPoint -}}
{{- .Values.global.apps.common.persistence.mountPoint -}}
{{- else -}}
{{- "/tmp/persistence" -}}
{{- end -}}
{{- end -}}

{{/*
Folder name to persist release files inside mountpoint (e.g. /tmp/persistence/release_name/")
*/}}
{{- define "persistence.subDir" -}}
{{- if .Values.global.apps.common.persistence.subDir -}}
{{- .Values.global.apps.common.persistence.subDir -}}
{{- else -}}
{{- printf "%s" $.Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
JMX Stats Persistence enablement options
*/}}
{{- define "persistence.jmxStats" -}}
{{- "-Dcuram.jmx.output_statistics_timer_enabled=true" }}
{{ "-Dcuram.jmx.output_statistics_timer_folder=/tmp/jmx/" }}
{{ printf "-Dcuram.jmx.output_statistics_timer_period=%d" ( .Values.global.apps.common.persistence.jmxstats.timerPeriod | default 60000 | int ) -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "apps.labels" -}}
app.kubernetes.io/name: {{ include "apps.name" . }}
helm.sh/chart: {{ include "apps.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
