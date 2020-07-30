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
Create chart name and version as used by the chart label.
*/}}
{{- define "xmlserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

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
Create the image pull secret
*/}}
{{- define "xmlserver.imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .registry (printf "%s:%s" .username (required "Credentials password is required" .password) | b64enc) | b64enc }}
{{- end }}

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
Folder name to persist release files inside mountpoint (e.g. /tmp/persistence/release_name")
*/}}
{{- define "persistence.subDir" -}}
{{- if .Values.global.apps.common.persistence.subDir -}}
{{- .Values.global.apps.common.persistence.subDir -}}
{{- else -}}
{{- printf "%s" $.Release.Name -}}
{{- end -}}
{{- end -}}
