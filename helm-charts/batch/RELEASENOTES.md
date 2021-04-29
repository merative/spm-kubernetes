# What's new

* Reference implementation for Batch streaming jobs

### Fixes

# Breaking Changes

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v2.1.2

* Update `ibm-sch` dependency to version 1.2.19

## v2.1.1

* Remove reference to a non-existent pull secret for service account

## v2.1.0

* Add reference implementation for Batch streaming jobs
* Reduced default backoff limit to 1

## v2.0.2

* Specify `TZ` environment variable for managing timezone in pods

## v2.0.1

* Use a custom utilities image as the `initContainer`
* Remove unused volume definition
* Add option to provide pull secret name created outside the release

## v2.0.0

* Reduce privilege requirements to run with the `restricted` security policy
* Chart values have been reorganised for improved readability
* Add option to specify multiple batch programs with different parameters and schedules
* Add option to specify the username (`-Dbatch.username=`) of the SPM user to execute the batch program(s)

## v1.3.0

* Moved to UBI base images
* Add option to specify the `runAsUser` property
* OpenShift preview release

## v1.2.0

* Add option to specify various Java options via `ANT_OPTS`
* Add option to specify the `-Dbatch.parameters=` argument
* Add options to specify JMX properties
* Made values global to be overridden by the umbrella chart

## v1.1.0

* Initial release

## v1.0.0

* Limited availability preview
