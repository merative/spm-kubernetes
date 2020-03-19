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
*/}}
{{- define "xmlserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "xmlserver.fullname" -}}
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
{{- define "xmlserver.chart" -}}
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
{{- define "xmlserver.imageFullName" -}}
{{- .registry -}}/
{{- if .imageLibrary -}}
{{- .imageLibrary -}}/
{{- end -}}
{{- if .imagePrefix -}}
{{- .imagePrefix -}}
{{- end -}}
xmlserver:{{- .imageTag -}}
{{- end -}}

{{/*
Define Database hostname
*/}}
{{- define "xmlserver.dbhostname" -}}
{{- if .Values.global.database.hostname -}}
{{- .Values.global.database.hostname -}}
{{- else -}}
{{- .Release.Name -}}-db2
{{- end -}}
{{- end -}}

{{/*
Define Database username (or use default)
*/}}
{{- define "xmlserver.db2username" -}}
{{- if .Values.global.database.username -}}
{{- .Values.global.database.username -}}
{{- else -}}
{{- printf "db2admin" -}}
{{- end -}}
{{- end -}}

{{/*
Define Database password (or use default)
*/}}
{{- define "xmlserver.db2password" -}}
{{- if .Values.global.database.password -}}
{{- .Values.global.database.password -}}
{{- else -}}
{{- printf "%s" "ZGIyYWRtaW4=" | b64dec -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "xmlserver.labels" -}}
app.kubernetes.io/name: {{ include "xmlserver.name" . }}
helm.sh/chart: {{ include "xmlserver.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
