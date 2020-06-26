# Changelog

All notable changes to this project will be documented in this file.

## v20.6.1 Changes

### Changed

* Updated URL format to match path prefix used by Gatsby build

## v20.6.0 Changes

### Added

* Preview of enablement material for RedHat OpenShift
* Deployment instructions for RedHat CodeReady Containers (CRC)

### Changed

* Change Batch and EAR images to use the UBI version by default
* Change XML Server image to use the UBI IBM Java8 from registry.connect.redhat.com
* Change SSL keystore type from JKS to PKCS#12
* Changed IHS image to run as non-root user
* Changed IHS image to mount in SSL certificates provided by Kubernetes secrets
* Updated Architecture Diagram to clearly demark producers, consumers and types of worker nodes.
* Changed EAR readiness pathes to avoid multiple redirections in the logs

### Fixed

* [Broken Links in Prerequisites.](https://github.com/IBM/spm-kubernetes/issues/18)

## v20.5.0 Changes

### Added

* Document how to build and push images to IBM Cloud Container Registry.
* Add documentation on repositories, runbook URLS, and release process.

### Fixed

* [helm commands not working.](https://github.com/IBM/spm-kubernetes/issues/6)
* [ChartMuseum links broken.](https://github.com/IBM/spm-kubernetes/issues/7)
* [Documentation correction for license check.](https://github.com/IBM/spm-kubernetes/issues/10)
* [Helm dependency for ce-app needs conditional adding.](https://github.com/IBM/spm-kubernetes/issues/13)
* [CE Ingress controller Rules created when the Application isn't deployed.](https://github.com/IBM/spm-kubernetes/issues/14)
* [Duplicate ihs elements in spm/values.yaml.](https://github.com/IBM/spm-kubernetes/issues/15)
* Addition of heapSize parameter in batch chart to allow for custom heap size specification.
