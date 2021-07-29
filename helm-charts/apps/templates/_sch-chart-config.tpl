{{- /*
"<chart>.sch.chart.config.values" contains the default configuration values used by
the Shared Configurable Helpers overridden for this chart.
*/ -}}
{{- define "apps.sch.chart.config.values" -}}
sch:
  chart:
    nodeAffinity:
      nodeAffinityRequiredDuringScheduling:
        key: beta.kubernetes.io/arch
        operator: In
        values:
          - amd64
      nodeAffinityPreferredDuringScheduling:
        {{ default "application" $.Values.affinityValue }}:
          key: {{ default "worker-type" $.Values.affinityKey }}
          operator: In
          weight: 100
    labelType: "prefixed"
    metering:
      productName: "IBM Curam Social Program Management Platform"
      productVersion: "8.0"
      productID: "1bba719a1b4744a9901f85563744c0d1"
    podSecurityContext:
      hostIPC: false
      hostNetwork: false
      hostPID: false
      securityContext:
        runAsNonRoot: true
    containerSecurityContext:
      securityContext:
        privileged: false
        readOnlyRootFilesystem: false
        allowPrivilegeEscalation: false
        capabilities:
          drop:
            - ALL
{{- end -}}
