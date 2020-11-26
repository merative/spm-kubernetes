# mqserver

## Introduction

* The MQ Server chart is a component of IBM Cúram Social Program Management (SPM) Platform responsible for providing an MQ instance for JMS processing. For more information about MQ, see [About IBM MQ](https://www.ibm.com/support/knowledgecenter/SSFKSJ_9.1.0/com.ibm.mq.pro.doc/q001010_.htm).

## Chart Details

* Deployment of a single MQ instance (if desired).
* Deployment of a multi-instance MQ via NFS or Ceph (if desired).

## Prerequisites

* Kubernetes 1.16 or later
* Helm 3.0.0 or later
* A configured NFS server (for use with NFS)
* A populated OpenShift Cluster (for use with Ceph)

### PodSecurityPolicy Requirements

Custom PodSecurityPolicy definition:

```
Not required as the underlying db2 instance runs with the default restricted policy
```

### SecurityContextConstraints Requirements

Custom SecurityContextConstraints definition:

```
Not required as the underlying db2 instance runs with the default restricted policy
```

## Configuration

See [Configuration reference](https://ibm.github.io/spm-kubernetes/deployment/config-reference) section of the runbook.
