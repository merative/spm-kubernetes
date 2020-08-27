# xmlserver

## Introduction

* XMLServer is a component of IBM Curam Social Program Management (SPM) Platform responsible for producing PDF files for the SPM application.
* This component should not be deployed outside of the [`spm`](../spm) chart.

## Chart Details

* Deployment of a single pod listening on port 1800
* Exposed to SPM using a service for potential load balancing

## Prerequisites

* Kubernetes 1.16 or later
* Helm 3.0.0 or later
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

See [README.md](../spm/README.md) in the `spm` umbrella chart.
