# spm

## Introduction

* The SPM chart is the umbrella Helm chart for IBM Cúram Social Program Management (SPM) Platform responsible for coordinating the deployment of the application across multiple subcharts.

## Chart Details

* Deployment of a single XML server replica
* Deployment of a single IHS replica with static content
* Deployment of a single MQ replica
* Deployment of a single Cúram application replica (one producer pod, one consumer pod)

## Prerequisites

* Kubernetes 1.16 or later
* Helm 3.0.0 or later
* [`PodDisruptionBudgets`](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) are recommended for high resiliency in an application during risky operations, such as draining a node for maintenance or scaling down a cluster.

### PodSecurityPolicy Requirements

All of the components of SPM can be run under the `restricted` (default) security policy, with the exception of one scenario.

When deploying SPM with OpenLDAP as the identity provider, you must create the following custom PodSecurityPolicy definition:

```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  annotations:
    kubernetes.io/description: "This policy allows pods to run with
      any UID and GID, but preventing access to the host."
  name: ibm-anyuid-psp
spec:
  allowPrivilegeEscalation: true
  fsGroup:
    rule: RunAsAny
  requiredDropCapabilities:
  - MKNOD
  allowedCapabilities:
  - SETPCAP
  - AUDIT_WRITE
  - CHOWN
  - NET_RAW
  - DAC_OVERRIDE
  - FOWNER
  - FSETID
  - KILL
  - SETUID
  - SETGID
  - NET_BIND_SERVICE
  - SYS_CHROOT
  - SETFCAP
  runAsUser:
    rule: RunAsAny
  runAsGroup:
    rule: RunAsAny
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  volumes:
  - configMap
  - emptyDir
  - projected
  - secret
  - downwardAPI
  - persistentVolumeClaim
  forbiddenSysctls:
  - '*'
```

### SecurityContextConstraints Requirements

All of the components of SPM can be run under the `restricted` (default) security context, with the exception of one scenario.

When deploying SPM with OpenLDAP as the identity provider, you must create the following custom SecurityContextConstraints definition:

```yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  annotations:
    release.openshift.io/create-only: "true"
    kubernetes.io/description: anyuid provides all features of the restricted SCC
      but allows users to run with any UID and any GID.
  name: anyuid
priority: 10
allowHostDirVolumePlugin: false
allowHostIPC: false
allowHostNetwork: false
allowHostPID: false
allowHostPorts: false
allowPrivilegeEscalation: true
allowPrivilegedContainer: false
allowedCapabilities:
defaultAddCapabilities:
fsGroup:
  type: RunAsAny
readOnlyRootFilesystem: false
requiredDropCapabilities:
- MKNOD
runAsUser:
  type: RunAsAny
seLinuxContext:
  type: MustRunAs
supplementalGroups:
  type: RunAsAny
volumes:
- configMap
- downwardAPI
- emptyDir
- persistentVolumeClaim
- projected
- secret
users: []
groups:
- system:cluster-admins
```

## Configuration

See [Configuration reference](https://ibm.github.io/spm-kubernetes/deployment/config-reference) section of the runbook.
