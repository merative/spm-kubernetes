# batch

## Introduction

* The Batch chart is a component of IBM Curam Social Program Management (SPM) Platform responsible for running various batch (deferred) processes.

## Chart Details

* Creates cron jobs for executing various batch programs

## Prerequisites

* Kubernetes 1.16 or later
* Helm 3.0.0 or later
* [`PodDisruptionBudgets`](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) are recommended for high resiliency in an application during risky operations, such as draining a node for maintenance or scaling down a cluster.

### PodSecurityPolicy Requirements

Custom PodSecurityPolicy definition:

```
Not required as the underlying IHS server runs with the default restricted policy
```

### SecurityContextConstraints Requirements

Custom SecurityContextConstraints definition:

```
Not required as the underlying IHS server runs with the default restricted policy
```

## Configuration

See [README.md](../spm/README.md) in the `spm` umbrella chart.
