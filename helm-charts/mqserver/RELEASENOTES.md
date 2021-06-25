# What's new

* Enable use of dynamic storage provisioners, such as IBM Cloud File Storage, by initialising the volumes prior to launching the MQ container.
  * If using dynamic provisioner, please review the [storage considerations](https://www.ibm.com/docs/en/ibm-mq/9.1?topic=containers-storage-considerations-mq-advanced-certified-container) as you may require a custom storage class to be defined.
  * In a multi-zone cluster, you may need to create a custom storage class with the `volumeBindingMode` attribute set to `WaitForFirstConsumer`
  to make sure that the storage is provisioned in the same zone as the node on which the corresponding pod has been scheduled.

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v1.12.0

* Add ability to tune K8s resources for MQ pods related to each app on an app by app basis
* Add facility to deploy pod to report metrics for MQ Queue Depths Events

## v1.11.0

* Enable use of dynamic storage provisioners
* Add option to initialise Persistent Volume as `root`

## v1.10.0

* Add `app` / `version` pod labels
* Update `ibm-sch` dependency to version 1.2.19

## v1.9.0

* Adds values from `podAnnotations` at deployment
* Pass parameter to MQ Operators to enable or disable the metrics

## v1.8.0

* Adds pod Anti-affinity rules to distribute a replica across the availability zones, and nodes within them.

## v1.7.2

* Added `mountOptions` value configuration to PVs and `values` file.
* Synchronise logic for handling TLS certificate secrets with `apps` chart.

## v1.6.1

* Updated `CuramCacheInvalidationTopic` to only be defined for the `Curam` application.
* Specify `TZ` environment variable for managing timezone in pods

## v1.6.0

* Chart changed to use IBM MQ 9.1.5.0-r2 development image.
* Removed initContainers from Statefulset; IBM MQ volume not required to be initialized as root.
* Changed SCC for both Deployment.yaml and Statefulset.yaml required by IBM MQ 9.1.5.0-r2 development image.
* Added dynamically generatation to TLS certificates.

## v1.5.1

* Ignore missing hook secrets on deletion.
* Remove unused pull secret definition.

## v1.5.0

* Added a check before creating deployment to see if multi-instance MQ is desired.
* Added values for use in multi-instance MQ, with both static and dynamic storage.
* Added a stateful set YAML file for use in multi-instance MQ.
* Added PV and PVC YAML files for use in multi-instance MQ.

## v1.4.0

* Moved Liberty configuration fragment to `apps` Chart.
* Added pre-install hook to encrypt the password for use in Liberty.
* Added support for a multi-instance topology.

## v1.3.0

* Revert to pre-created certificates.

## v1.2.0

* Add support for running with multi-instance IBM MQ hosted outside Kubernetes.

## v1.1.0

* Initial release.

## v1.0.0

* Limited availability preview.
