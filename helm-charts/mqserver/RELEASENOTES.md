# What's new

* Updated the topic structure to correctly invalidate the SPM properties cache.

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## Unreleased

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
