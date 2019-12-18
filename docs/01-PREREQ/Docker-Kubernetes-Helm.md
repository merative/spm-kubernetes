# Docker, Kubernetes, Minikube, and Helm

## Docker

[Docker](https://www.docker.com/get-started) is an open source tool that creates, deploys, and runs applications by using containers.
Install Docker by following the instructions in [docker.com](https://docs.docker.com/install/overview/). You can follow this runbook by using any Docker edition, including the community edition.

_**NOTE:**_ Docker version used to verify this runbook: 19.03.5

## Kubernetes and Minikube

[Kubernetes](https://kubernetes.io/) (also referred to as "K8s") is an open source system for automating deployment, scaling, and management of containerized applications.
You will use the command-line tool, `kubectl` extensively when you follow the steps that are described in this runbook. `kubectl` installation steps are described in [kubernetes.io](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

Minikube is a variant of Kubernetes that runs a single-node cluster inside a virtual machine (VM) on your laptop.

In this guide, the kubectl command is used with [Minikube](minikube.md).

_**NOTE:**_ Kubernetes version used to verify this runbook: 1.14.7

_**NOTE:**_ MiniKube version used to verify this runbook: 1.6.0

## Helm V2

_**NOTE:**_ Helm version used to verify this runbook: 2.16.1. All the Helm commands that are used in this runbook are based on Helm version 2.

[Helm](https://helm.sh/) is a package manager that helps you to find, share, and use software that is built for Kubernetes.
Helm streamlines the installation and management of Kubernetes applications, it can be thought of as the equivalent of the apt, yum, or homebrew utilities for Kubernetes.

Helm uses a packaging format called Chart. A chart is a collection of files that describe a related set of Kubernetes resources.
A single chart might be used to deploy something simple, like a memcached pod, or a complex deployment, like a full web app stack with HTTP servers, databases, and caches.
Charts are created as files laid out in a particular directory tree, then they can be packaged into versioned archives for deployment. For more information, see the [Helm documentation](https://helm.sh/docs/).

This guide uses Helm Charts and describes how to package and deploy them. For more information, see [Preparing Helm Charts](../03-DEPLOYMENT/hc_preparation.md).

The server portion of Helm, named Tiller, runs inside of your Kubernetes cluster.
Tiller interacts directly with the Kubernetes API server to install, upgrade, query, and remove Kubernetes resources. It also stores the objects that represent releases.

Install Helm by following the steps described in [Helm install](https://github.com/helm/helm#install).
