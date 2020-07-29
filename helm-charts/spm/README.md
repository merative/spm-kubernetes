# spm

## Introduction

* The SPM chart is the umbrella Helm chart for IBM Curam Social Program Management (SPM) Platform responsible for coordinating the deployment of the application across multiple subcharts.

## Chart Details

* Deployment of a single XML server replica
* Deployment of a single IHS replica with static content
* Deployment of a single MQ replica
* Deployment of a single Curam application replica (one producer pod, one consumer pod)

## Prerequisites

* Kubernetes 1.16 or later
* Helm 3.0.0 or later
* [`PodDisruptionBudgets`](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) are recommended for high resiliency in an application during risky operations, such as draining a node for maintenance or scaling down a cluster.

### PodSecurityPolicy Requirements

Custom PodSecurityPolicy definition:

```
TBC
```

### SecurityContextConstraints Requirements

Custom SecurityContextConstraints definition:

```
TBC
```

## Configuration

### Global properties

### Liberty runtime

### MQ

### IHS (Static Content)

### XML Server

### Universal Access (React App) - optional
