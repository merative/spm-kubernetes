{{/*
Copyright 2019 IBM Corporation

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
{{- define "configmaps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "configmaps.fullname" -}}
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
{{- define "configmaps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define Database hostname
*/}}
{{- define "configmaps.dbhostname" -}}
{{- if .Values.global.database.hostname -}}
{{- .Values.global.database.hostname -}}
{{- else -}}
{{- .Release.Name -}}-db2
{{- end -}}
{{- end -}}

{{/*
SSL properties for JDBC connection in Liberty. If global.database.ssl.secretName is provided, assume it has been imported into a Trust Store
*/}}
{{- define "configmaps.ssljdbc" -}}
{{- if .enabled }}
  sslConnection="true"
  {{- if .secretName }}
  sslTrustStoreLocation="/output/resources/security/db2TrustStore.jks"
  sslTrustStorePassword="{xor}PDc+MTg6Nis="
  {{- end }}
{{- end }}
{{- end }}

{{/*
Liberty Datastore properties fragment
*/}}
{{- define "configmaps.dsprops.fragment" -}}
{{- $dbConfig := .Values.global.database -}}
{{- if eq ($dbConfig.type | upper) "DB2" -}}
<properties.db2.jcc databaseName="{{ $dbConfig.dbName }}"
  fullyMaterializeLobData="false"
  portNumber="{{ $dbConfig.port }}"
  serverName="{{ include "configmaps.dbhostname" . }}"
  password="{{ $dbConfig.wlp_psw }}"
  user="{{ $dbConfig.username }}"
  {{- include "configmaps.ssljdbc" $dbConfig.ssl }}
/>
{{- else if eq ($dbConfig.type | upper) "ORA" -}}
<properties.oracle 
  URL="{{ include "configmaps.oracleurl" . }}" 
  password="{{ required "XOR-encoded password is required" $dbConfig.wlp_psw }}" 
  user="{{ required "Database username is required" $dbConfig.username }}"
/>
{{- else -}}
{{ fail ("Unsupported database type provided: " $dbConfig.type) }}
{{- end -}}
{{- end -}}

{{/*
Oracle JDBC URL
*/}}
{{- define "configmaps.oracleurl" -}}
{{- $dbConfig := .Values.global.database -}}
{{- if $dbConfig.serviceName -}}
jdbc:oracle:thin:/@//{{ include "configmaps.dbhostname" . }}:{{ $dbConfig.port }}/{{ $dbConfig.serviceName }}
{{- else -}}
jdbc:oracle:thin:@{{ include "configmaps.dbhostname" . }}:{{ $dbConfig.port }}:{{ $dbConfig.dbName }}
{{- end }}
{{- end }}

{{/*
JDBC Connection driver JAR list
*/}}
{{- define "configmaps.dbdriver.jars" -}}
{{- if eq (.type | upper) "DB2" -}}
db2jcc4.jar db2jcc_license_cu.jar
{{- else if eq (.type | upper) "ORA" -}}
ojdbc.jar
{{- else -}}
{{ fail ("Unsupported database type provided: " .type) }}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "configmaps.labels" -}}
app.kubernetes.io/name: {{ include "configmaps.name" . }}
helm.sh/chart: {{ include "configmaps.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
