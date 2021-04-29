# What's new

* Red Hat OpenShift support introduced.

### Fixes

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v2.1.2

* Add `app` / `version` pod labels
* Update `ibm-sch` dependency to version 1.2.19

## v2.1.1

* Remove reference to a non-existent pull secret for service account

## v2.1.0

* Adds pod Anti-affinity rules to distribute a replica across the availability zones, and nodes within them.

## v2.0.3

* Update the charts to internal content verification linter standards.

## v2.0.2

* Specify `TZ` environment variable for managing timezone in pods

## v2.0.1

* Add option to provide pull secret name created outside the release

## v2.0.0

* Graceful shutdown enabled
* Support for running under restricted (default) policy added
  * XML server image must be rebuilt

## v1.2.0

* Log persistence enabled
* Security context defined for compatibility with OpenShift

## v1.1.0

* Post-install hook removed

## v1.0.0

* Initial release
