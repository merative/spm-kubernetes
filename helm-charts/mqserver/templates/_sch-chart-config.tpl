{{- /*
"<chart>.sch.chart.config.values" contains the default configuration values used by
the Shared Configurable Helpers overridden for this chart.
*/ -}}
{{- define "mqserver.sch.chart.config.values" -}}
sch:
  chart:
    labelType: "prefixed"
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
