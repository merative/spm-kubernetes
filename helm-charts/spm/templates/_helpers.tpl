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
{{- define "spm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spm.fullname" -}}
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
{{- define "spm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the image pull secret
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .registry (printf "%s:%s" .username (required "Credentials password is required" .password) | b64enc) | b64enc }}
{{- end }}

{{/*
Build up ssl-services value
*/}}
{{- define "sslServicesChain" }}
{{- range $name, $app := .Values.global.apps.config -}}
{{- if $app.enabled -}}
ssl-service={{ $.Release.Name }}-apps-{{ $name }};
{{- end -}}
{{- end -}}
{{- if .Values.global.images.ceDistTag -}}
ssl-service={{ $.Release.Name }}-ce-app
{{- end -}}
{{- end }}

{{/*
Build up sticky-cookie-services value
*/}}
{{- define "stickyCookieServicesChain" }}
{{- range $name, $app := .Values.global.apps.config -}}
{{- if $app.enabled -}}
serviceName={{ $.Release.Name }}-apps-{{ $name }} name={{ $name }}Route hash=sha1 path=/;
{{- end -}}
{{- end -}}
{{- if .Values.global.images.ceDistTag -}}
serviceName={{ $.Release.Name }}-ce-app name=ceRoute hash=sha1 path=/;
{{- end -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spm.labels" -}}
app.kubernetes.io/name: {{ include "spm.name" . }}
helm.sh/chart: {{ include "spm.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
