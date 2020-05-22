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
{{- define "batch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "batch.fullname" -}}
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
{{- define "batch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Build up full image path
*/}}
{{- define "batch.imageFullName" -}}
{{- .registry -}}/
{{- if .imageLibrary -}}
{{- .imageLibrary -}}/
{{- end -}}
{{- if .imagePrefix -}}
{{- .imagePrefix -}}
{{- end -}}
batch:{{- .imageTag -}}
{{- end -}}

{{/*
Build up Ant Options for general and JMS Stats configuration
*/}}
{{- define "antOpts" }}
{{- if ($.Values.global.batch.javaMetrics) ($.Values.global.batch.javaMetrics.antOpts) -}}
{{- $.Values.global.batch.javaMetrics.antOpts -}}
{{- end }}
{{- if ($.Values.global.batch.javaMetrics) ($.Values.global.batch.javaMetrics.heapSize) -}}
{{- $.Values.global.batch.javaMetrics.heapSize -}}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "batch.labels" -}}
app.kubernetes.io/name: {{ include "batch.name" . }}
helm.sh/chart: {{ include "batch.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
