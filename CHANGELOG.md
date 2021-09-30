# Changelog

All notable changes to this project will be documented in this file

## v21.9.0

### Added

* Add a startup probe to the `apps` producer and consumers pods

### Changed

* Updated WebSphere Liberty version to include 21.0.0.9
* Updated support statement for Helm v3 in prerequisite
  * Due to breaking changes in Helm release `v3.7.0`, IBM Cúram Social Program Management only supports up to Helm `v3.6.3`
* The following helm-charts have been updated to chart version `21.9.0`: `apps`, `batch`, `mqserver`, `spm`, `uawebapp`, `web`, `xmlserver`
* Timeout for `linkchecker` updated from 60 to 120
* Clarified prerequisite software statements
* Update the readiness probe of the `apps` producer and consumers pods, consider a pod ready if curl to application link gives successful response or if codes `CWWKZ0001I` & `CWWKF0011I` are found in message logs
* Updated the liveness probe to check only the last 1000 lines of the logs file

### Fixed

## v21.8.0

### Breaking Changes

* `Ingress` and `IngressClass` resources have graduated to `networking.k8s.io/v1`, see [Ingress graduates to General Availability](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md#ingress-graduates-to-general-availability)
  * Due to ingress graduating to `networking.k8s.io/v1` spm `ingress.yaml` has been updated to check `networking.k8s.io` version
  * Definition of the ingress path has been moved to the `spm.ingress.item` template
* SPM-Kubernetes default branch has been renamed from `master` to `main`

### Added

* Configure `PodMonitor` resources for the `apps` producer and consumers pods and for the `mqserver` metrics pods to integrate with OpenShift's [built-in Prometheus](https://docs.openshift.com/container-platform/4.6/monitoring/enabling-monitoring-for-user-defined-projects.html) or [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator)

### Changed

* The following helm-charts have been updated to chart version `21.8.0`: `apps`, `batch`, `mqserver`, `spm`, `uawebapp`, `web`, `xmlserver`
* Changed DB2 datasources isolation level for the `apps` producer and consumers pods. See [Transaction control/Underlying design/DB2/Repeatable Read](https://www.ibm.com/docs/en/spm/8.0.0?topic=design-db2)
* Updated IBM Documentation link to SPM V8
* Clarified prerequisite software statements ([#83](https://github.com/IBM/spm-kubernetes/issues/83))

### Fixed

* Update Oracle Database driver name to `ojdbc8.jar` ([#84](https://github.com/IBM/spm-kubernetes/issues/84))
* Fixed issue where MQ pods deployed by MQ Operator on Openshift were not respecting tuning params

### Removed

## v21.7.0 ![SPM 8.0.0.0](https://img.shields.io/badge/-SPM_8.0.0.0-green)

> This release introduces support for SPM 8.0.0.0 and contains breaking changes for deployment of SPM 7.0.11.0

### Breaking Changes

* Due to the upgrade to IBM MQ 9.2, the following breaking changes have been introduced:
  * On existing deployments, the upgrade of IBM MQ requires the applications pods to be scaled down completely, followed by a delay to process any remaining messages, before updating the deployment
  * Moved `global.mq.multiInstance.availabilityType` to `global.mq.availabilityType`
  * Moved `global.mq.multiInstance.storageType` to `global.mq.storageType`
  * Moved `global.mq.multiInstance.storageClassName` to `global.mq.storageClassName`
  * Removed `global.mq.multiInstance` as a configuration, and the following children parameters:
    * `operatorsEnabled`, `cephEnabled`, `useDynamicProvisioning`, `nfsEnabled`, `nfsIP`, `nfsFolder`, `nfsMountOptions`
  * Support for manual creation of persistent volumes and persistent volume claims has been removed
* Removed `global.apps.common.persistence.subDir` as a configuration
  * The paths on the storage volume have now change from `<root>/<HelmRelease_or_subDir>/<podName>` to `<root>/<podName>`. This is to accommodate pod initialization on start-up

### Added

* Add the ability to tune java options for the XMLServer application
* Add TLS certificates for Secure XML server
* Add OpenID configuration for authentication using JSON Web Tokens for SPM Chatbot **only**
* Add signing certificates for JSON Web Tokens for SPM Chatbot **only**
* Added SPM 8.0.0.0 annotations to SPM v8 specific content in the runbook
* Added known issue to account for WebSphere Liberty timeout messages WTRN0006W and WTRN0124I

### Changed

* Upgraded IBM MQ image from `9.1.5` to `9.2.2`
* Updated IBM MQ Resource Adapter to `9.2.2.0`
* Starting from `spm-kubernetes` release `21.7.0`, chart versions have been updated to align with the release version.
  * The following helm-charts have been updated: `apps`, `batch`, `mqserver`, `spm`, `uawebapp`, `web`, `xmlserver`.
  * All changes in helm-charts will now detailed in the `CHANGELOG.md` file
* `kubeVersion` for all helm-charts updated to `">=1.19"`
* `appVersion` for all helm-charts updated to `8.0.0.0`
* Liberty persistent timer tables are no longer created per pod, but are created and shared by pod-type
* Updated runbook pre-requisites page to add information on Docker
* Changed MQ configuration for the `apps` producer and consumers pods to be using separated channels
* Moved tuning settings from `initContainer` to a new ConfigMap
* IBM Documentation has now replaced IBM Knowledge Center. Runbook links have been updated accordingly.

### Fixed

* Fixed XML Server shutdown by adding a pod preStop hook

### Removed

* Removed `RELEASENOTES.md` for the following helm-charts: `apps`, `batch`, `mqserver`, `spm`, `uawebapp`, `web`, `xmlserver`.
  * All changes in helm-charts will now detailed in the `CHANGELOG.md` file
* Removed `global.apps.common.persistence.subDir` as a configuration
* Removed `persistence.subDir` from the following helm-charts: `apps`, `batch`, `spm`, `uawebapp`, `web`, `xmlserver`
* Removed obsolete Helm Chart known issue

## v21.6.0

### Added

* Added capability to tune Kubernetes resources for MQ pods for individual applications
* Added clarification regarding sample values files.
* Added JVM garbage collection and tuning settings for XML server pods
  * Updated sample override files to include example settings
* Added capability to specify thread pool size, thread queue size, and socket timeout value for XML server pods
* Added capability to tune various JMS tuning parameters for producers and consumers
  * Extended jmsActivationSpec to include maxEndpoints parameter for the following JMS queues:
    * DPError
    * WorkflowError
    * CuramDeadMessageQueue
    * DPEnactment
    * WorkflowEnactment
    * WorkflowActivity
* Added capability to tune the minPoolSize setting of the JMS connection manager
* Documented how to tune the resources for the uawebapp, web and xmlserver pods

### Changed

* Upgrade to latest Gatsby library
* Updated the minimum supported version of Kubernetes to `1.19`

### Removed

* Removed support for Kubernetes `1.18`

## v21.5.1

### Fixed

* Fixed reference to Oracle datasource fragment ([#78](https://github.com/IBM/spm-kubernetes/issues/78))

## v21.5.0

### Added

* Added capability for Prometheus to scrape Liberty metrics from pods
* Added clarification in the Runbook introduction page regarding the flexibility to modify or develop **Helm Charts** or **Dockerfiles**
* Added information in the **MustGather** introduction page about Helm Charts and Dockerfiles
* Added capability to tune various database and JMS tuning parameters for individual producers and consumers
  * Created tuning-values.yaml as example.
* Added capability for Docker Hub details to be used to avoid **toomanyrequests** ([#69](https://github.com/IBM/spm-kubernetes/issues/69))
* Added capability to set applications properties at deployment

### Changed

* Allows for the simultaneous scraping of multiple metrics sources (eg JMX and Liberty) on `apps` charts
* Moved `HTTPSessionDatabase` default configuration to timer based
* Update `unzip` when unpacking the client EAR file
* Ensure MQ directory structure exists, when using NFS ([#31](https://github.com/IBM/spm-kubernetes/issues/31))
* Upgrade to Gatsby v3 (and associated dependencies)

## v21.4.1

### Added

* IBM MQ XAER_PROTO reported as a known issue

## v21.4.0

### Added

* Extended WebSphere Liberty tuning options

### Changed

* Changed the OpenShift reference architecture diagram to provide additional clarity regarding the statefulsets
* Improved pod labels for compatibility with service meshes ([#61](https://github.com/IBM/spm-kubernetes/issues/61))
* Improved navigation links to avoid 404 errors ([#68](https://github.com/IBM/spm-kubernetes/issues/68))

### Removed

* Removed the `wait-for-database` initContainer from producer and consumer pods
  * Validation of the database configuration is already handled by the pre-install hook

## v21.3.0

### Added

* Adds values from `podAnnotations` at deployment of `mqserver` chart
* Pass parameter to MQ Operators to enable or disable the metrics

### Changed

* Clarify instructions for building base images
* Clarify initial setup of CodeReady Containers
* Update recommended drivers for running Minikube

### Fixed

* Remove references to a non-existent pull secret for service accounts

## v21.2.0

### Added

* Introduced support for Docker 20.10

### Changed

* Clarified steps on Remote Debug process
* Updated Third party Prerequisite software
  * Extended support for Docker, Helm, IBM MQ LTS and IBM MQ CD to include future fix packs
  * Added note for Docker version 19.03. `Docker is due to drop support for Docker 19.03 in July 2021. After this date Docker 19.03 is not supported by IBM Cúram Social Program Management`
* Clarified memory allocation for CRC
* Removed errant apostrophe when setting ANT_HOME

### Fixed

* Certificate Error when logging in to the Open Shift Registry. Added clarification on enabling Docker trust certificates ([#58](https://github.com/IBM/spm-kubernetes/issues/58))
* Supporting the rotation of the `apps` logs

## v21.1.0

### Added

* Adds pod Anti-affinity rules to distribute a replica across the availability zones, and nodes within them.
* Activate logout for SAML when using single sign-on (SSO)

## v20.12.0

### Changed

* Limit allowed HTTP verbs as detailed in the [IBM Documentation](https://www.ibm.com/docs/en/spm/7.0.11?topic=considerations-enabling-http-verb-permissions)
* Set `-Xshareclasses` to `none` for Liberty-based images as workaround for OpenJ9 issue ([#51](https://github.com/IBM/spm-kubernetes/issues/51))
* Adds values from `podAnnotations` at deployment of `apps` chart

### Fixed

* Added clarification that NFS folders must be configured prior to using MQ with NFS ([#31](https://github.com/IBM/spm-kubernetes/issues/31))
* Added `mountOptions` configuration to `mqserver` PVs ([#30](https://github.com/IBM/spm-kubernetes/issues/30))
* Synchronised handling of MQ TLS certificate secrets between `apps` and `mqserver` charts ([#28](https://github.com/IBM/spm-kubernetes/issues/28))

## v20.11.0

### Added

* Activate SAML when using single sign-on (SSO)
* Add a route in OpenShift to allow connections to SSO, when enabled
* Updated the `ServerEAR.Dockerfile` to reduce layers
* Added note with fix needed for an update in IBM MQ, the details of which can be found
[here](https://github.com/IBM/charts/blob/master/stable/ibm-mqadvanced-server-dev/RELEASENOTES.md)
* Added links to Architecture and Troubleshooting sections from within the flow of the document

### Changed

* Updated SPM 7.0.10.0 Supported Prereqs
  * Kubernetes version 1.18 support introduced
  * Kubernetes version 1.16 is now in a state of deprecated
* Clarified MQ configuration reference for container or VM
* Moved IKS and OpenShift considerations into Architecture
* Updated Nav items for considerations. *Note:* any bookmarked pages will no longer work
* Replaced inline links with anchor links in "MustGather"
* Provided rationale for building own images
* Provided clarification on use of `$PROJECT` environment variable
* Link to helm defect for the need to repush docker images
* Provided clarification on the use of helm releasename
* Provided clarification on the use of subnet
* Restructure command examples so that required additional information is before the command
* Update architecture diagram to differentiate the cluster content for a local development workstation

### Fixed

* Updated sample override values to have minimal install highlighted and specifically for CRC to not include image registry credentials
* Fixed the SPM OpenShift Reference Architecture diagram regarding the IBM MQ statefulset

### Removed

* Removed custom `SecurityContextConstraint` as it is no longer required for running SPM in OpenShift

## v20.10.2

### Fixed

* Corrected the sentence on OpenShift support in Introduction page

## v20.10.1

### Fixed

* Fixed the SPM IKS Reference Architecture diagram
* Fixed line duplication in mq-secret.yaml file

## v20.10.0 ![SPM 7.0.11.0](https://img.shields.io/badge/-SPM_7.0.11.0-green)

### Added

* Added SPM 7.0.11.0 supported prerequisites
* Added SPM release tag to ChangeLog
* Added OpenShift Reference Architecture
* Added statement for usage of IBM MQ certified containers on OpenShift
* Add the ability to create an MQ deployment via Operators
* Add a `queue manager` object for use in MQ Operator deployments
* Add instructions to access IBM MQ certified containers on IBM Cloud Container Registry
* Added Consideration section to runbook
  * Section on IKS: Security, Networking Authentication, Container Registry, Storage
  * Section on OpenShift: Security, Networking Authentication, Container Registry, Storage
* Updated documentation to include target to precompile SPM ear files
* Added OpenShift Overview page to runbook
* Add a reference implementation for Batch streaming jobs
* Update the charts to internal content verification linter standards
* Updated some inpage navigation

### Changed

* Implemented accessibility recommendations on the runbook content
* Refactored and reorganised the architecture pages. Added Architecture Overview diagram
* Add `operatorsEnabled` if clause to `mqserver` deployment, statefulset, and service objects
* Correcting product name on first use to "IBM® Cúram Social Program Management (SPM)" and "SPM" thereafter
* Reduced default backoff limit for Batch jobs to 1
* Updated MQ on VM reference configuration to use `SHA256WithRSA` signature algorithm
* Clarified CRC minimum system requirements

### Removed

* Remove hard requirement on OpenLDAP for elasticity

## v20.9.0

### Added

* Add an overridable affinity for nodes with a label of `worker-type:application`
* Add an option to specify the timezone for the running containers (`global.timezone: UTC`)
* Add detailed guide of available values for configuring the `spm` Helm chart
* Add JDBC configuration for persistent EJB timers
* Add page "Monitoring performance using JMX statistics"

### Changed

* Included changes to navigation flow
* Exposing MQ username via Kubernetes secret
* Truncate MQ object labels to be under 20 characters
* Updated IBM SDK for Java image name
* Updated Nav items links for all pages. *Note:* any bookmarked pages will no longer work
* Included embedded videos in Architecture Overview
* Included list of supported software requirements
* Updated WebSphere Liberty version to 20.0.0.9

### Fixed

* Use common `CuramCacheInvalidationTopic` across all applications to correctly invalidate the SPM property cache

## v20.8.0

### Added

* Add option to provide pull secret name created outside the Helm release
* Add `proxy-read-timeout` for NGinx-based Ingress controllers
* Add option to provide the `ibm.io/region` annotation to PVC
* Add supplementGroup value to MQ chart that may be required depending on the persistent volume
* Add troubleshooting section to cover IBM Cloud Object storage connection issue
* Add Note explaining Universal Base Images (UBI)

### Changed

* Remove hardcoded WebSphere Liberty credentials
* Disable Admin Center by default
* Move custom SQL execution to pre-install hook
* Upgraded MQ image from 9.1.3 to 9.1.5

### Fixed

* InitContainer for Batch does not meet pod security policy requirements
* Missing Batch debug-file configmap ([#29](https://github.com/IBM/spm-kubernetes/issues/29))
* Fixed Helm Chart syntax for enabling JMX Stats

### Removed

* Removed initContainers from statefulset.yaml in MQ chart

## v20.7.0

### Added

* Integration with [IBM Security Access manager](https://www.ibm.com/ie-en/marketplace/access-management/details)
* Dependency on IBM [Shared Configuration Helper](https://github.com/IBM/charts/tree/master/samples/ibm-sch) (SCH) chart for aligning with CloudPak code standards
* Dockerfile for a utilities image (used as init containers to import certificates into keystores & wait for other components to become available)
* Chart hooks for managing LTPA keys and MQ client user
* Liberty runtime liveness probe (checks log for specific error messages)
* Instructions for handling failed JMS messages on the MQ dead message queue
* In the MQ chart, a check before creating deployment to see if multi-instance MQ is desired
* Values for use in multi-instance MQ, with both static and dynamic storage
* A stateful set YAML file for use in multi-instance MQ
* PV and PVC YAML files for use in multi-instance MQ

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

### Removed

* `configmaps` chart (ConfigMaps are now part of `apps` chart)
* Dockerfile for IBM MQ (custom image not required anymore - use `ibmcom/mq` directly)
* Removed Helm v2, and related tiller documentation and commands

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
* Updated Architecture Diagram to clearly demark producers, consumers and types of worker nodes
* Changed EAR readiness pathes to avoid multiple redirections in the logs

### Fixed

* [Broken Links in Prerequisites.](https://github.com/IBM/spm-kubernetes/issues/18)

## v20.5.0 ![SPM 7.0.10.0](https://img.shields.io/badge/-SPM_7.0.10.0-green)

### Added

* Document how to build and push images to IBM Cloud Container Registry
* Add documentation on repositories, runbook URLS, and release process

### Fixed

* [helm commands not working.](https://github.com/IBM/spm-kubernetes/issues/6)
* [ChartMuseum links broken.](https://github.com/IBM/spm-kubernetes/issues/7)
* [Documentation correction for license check.](https://github.com/IBM/spm-kubernetes/issues/10)
* [Helm dependency for ce-app needs conditional adding.](https://github.com/IBM/spm-kubernetes/issues/13)
* [CE Ingress controller Rules created when the Application isn't deployed.](https://github.com/IBM/spm-kubernetes/issues/14)
* [Duplicate ihs elements in spm/values.yaml.](https://github.com/IBM/spm-kubernetes/issues/15)
* Addition of heapSize parameter in batch chart to allow for custom heap size specification
