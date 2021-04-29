# What's new

* Red Hat OpenShift support introduced.
* Runs with `restricted` (default) pod security policy.

### Fixes

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v3.2.2

* Add `app` / `version` pod labels
* Update `ibm-sch` dependency to version 1.2.19

## v3.2.1

* Remove reference to a non-existent pull secret for service account

## v3.2.0

* Adds pod Anti-affinity rules to distribute a replica across the availability zones, and nodes within them.

## v3.1.0

* Add rewrite rule and condition to configmaps to fix verb tampering vulnerability.

## v3.0.3

* Update the chart to internal content verification linter standards.

## v3.0.2

* Specify `TZ` environment variable for managing timezone in pods

## v3.0.1

* Add option to provide pull secret name created outside the release

## v3.0.0

* Changed web server image from IHS to Apache HTTP
* Reduce privilege requirements to run with the `restricted` security policy
* Moved configuration to ConfigMap

## v2.1.0

* Change to UBI base images
* Add option to inject certificates
* Allow binding to privileged ports

## v2.0.0

* Enabling log persistence

## v1.1.0

* Applying Apache 2.0 license

## v1.0.0

* Initial release
