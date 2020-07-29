# Changelog

All notable changes to this project will be documented in this file.

## v20.7.0

### Removed

* `configmaps` chart (ConfigMaps are now part of `apps` chart)
* Dockerfile for IBM MQ (custom image not required anymore - use `ibmcom/mq` directly)
* Removed Helm v2, and related tiller documentation and commands

### Added

* Integration with [IBM Security Access manager](https://www.ibm.com/ie-en/marketplace/access-management/details)
* Dependency on IBM [Shared Configuration Helper](https://github.com/IBM/charts/tree/master/samples/ibm-sch) (SCH) chart for aligning with CloudPak code standards
* Dockerfile for a utilities image (used as init containers to import certificates into keystores & wait for other components to become available)
* Chart hooks for managing LTPA keys and MQ client user
* Liberty runtime liveness probe (checks log for specific error messages)
* Instructions for handling failed JMS messages on the MQ dead message queue
* In the MQ chart, a check before creating deployment to see if multi-instance MQ is desired.
* Values for use in multi-instance MQ, with both static and dynamic storage.
* A stateful set YAML file for use in multi-instance MQ.
* PV and PVC YAML files for use in multi-instance MQ.

### Changed

* Reduced the privilege requirement of `apps` chart to run with the `restricted` policy
* Reduced the privilege requirement of `batch` chart to run with the `restricted` policy
* Reduced the privilege requirement of `xmlserver` chart to run with the `restricted` policy
* Renamed `ihs` chart to `web` and switched to Apache HTTP server
* Renamed `ce-app` chart to `uawebapp` and switched to Apache HTTP server
* Moved web server configuration to ConfigMaps for `uawebapp` and `web` charts
* Added facility to add multiple batch programs
* Allow the generated UID in OpenShift to run the Liberty runtime
* Changed value file to allow specifying the `storageClassName` when using persistence
* Included database connection override values in `crc-values.yaml`, `iks-values.yaml` and `minikube-values.yaml`
* Updated minikube version to `1.12`
* Updated kubectl version to `1.18`
* Updated Helm to `v3`
* Updated IBM MQ Resource Adapter to `v9.1.5.0`

### Fixed

* Incorrect formatting of heredoc in `createSSC.sh` ([#24](https://github.com/IBM/spm-kubernetes/issues/24))
* Db2 dependency in `spm/requirements.yaml` ([#23](https://github.com/IBM/spm-kubernetes/issues/23))
* Duplicate `ihs` elements in `spm/values.yaml` ([#15](https://github.com/IBM/spm-kubernetes/issues/15))


## v20.6.1

### Changed

* Updated URL format to match path prefix used by Gatsby build


## v20.6.0

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


## v20.5.0

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
