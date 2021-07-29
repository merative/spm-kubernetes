# xmlserver

## Introduction

* XMLServer is a component of IBM Cúram Social Program Management (SPM) Platform responsible for producing PDF files for the SPM application.
* This component should not be deployed outside of the [`spm`](../spm) chart.
* Starting from `spm-kubernetes` release `21.7.0`, chart versions have been updated to align with the release version.

## Chart Details

* Deployment of a single pod listening on port 1800
* Exposed to SPM using a service for potential load balancing

## Prerequisites

* [`PodDisruptionBudgets`](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) are recommended for high resiliency in an application during risky operations, such as draining a node for maintenance or scaling down a cluster.

### PodSecurityPolicy Requirements

Custom PodSecurityPolicy definition:

```
Not required as XML server runs with the default restricted policy
```

### SecurityContextConstraints Requirements

Custom SecurityContextConstraints definition:

```
Not required as XML server runs with the default restricted policy
```

## Configuration

See [Configuration reference](https://ibm.github.io/spm-kubernetes/deployment/config-reference) section of the runbook.
