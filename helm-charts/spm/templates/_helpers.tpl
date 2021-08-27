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
Create the image pull secret
*/}}
{{- define "spm.imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .registry (printf "%s:%s" .username (required "Credentials password is required" .password) | b64enc) | b64enc }}
{{- end }}

{{/*
Create the persistence secret
*/}}
{{- define "spm.persistenceSecret" -}}
secret-key: {{ required "secretKey is required" .secretKey | b64enc | quote }}
access-key: {{ required "accessKey is required" .accessKey | b64enc | quote}}
service-instance-id: {{ required "instanceId is required" .instanceId | b64enc | quote }}
{{- end -}}

{{/*
Build up ssl-services value
*/}}
{{- define "spm.sslServicesChain" }}
{{- range $name, $app := .Values.global.apps.config -}}
{{- if $app.enabled -}}
ssl-service={{ $.Release.Name }}-apps-{{ $name }};
{{- end -}}
{{- end -}}
{{- if .Values.uawebapp.imageConfig.name -}}
ssl-service={{ $.Release.Name }}-uawebapp;
{{- end -}}
ssl-service={{ $.Release.Name }}-web;
{{- end }}

{{/*
Build up sticky-cookie-services value
*/}}
{{- define "spm.stickyCookieServicesChain" }}
{{- range $name, $app := .Values.global.apps.config -}}
{{- if $app.enabled -}}
serviceName={{ $.Release.Name }}-apps-{{ $name }} name={{ $name }}Route hash=sha1 path=/;
{{- end -}}
{{- end -}}
{{- if .Values.uawebapp.imageConfig.name -}}
serviceName={{ $.Release.Name }}-uawebapp name=uaRoute hash=sha1 path=/;
{{- end -}}
serviceName={{ $.Release.Name }}-web name=webRoute hash=sha1 path=/;
{{- end }}

{{/*
Template for Ingress path definitions
*/}}
{{- define "spm.ingress.item" -}}
- path: {{ .path }}
  pathType: ImplementationSpecific
  backend:
    {{- if .caps.APIVersions.Has "networking.k8s.io/v1" }}
    service:
      name: {{ .name }}
      port:
        {{- if (kindIs "int" .port) }}
        number: {{ .port }}
        {{- else }}
        name: {{ .port }}
        {{- end }}
    {{- else }}
    serviceName: {{ .name }}
    servicePort: {{ .port }}
    {{- end }}
{{- end -}}
