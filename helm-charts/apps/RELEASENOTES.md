# What's new

* Update messaging configuration to use a common `CuramCacheInvalidationTopic` across all applications
* Red Hat OpenShift support introduced
* Runs with `restricted` (default) pod security policy

### Fixes

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v3.1.1

* Update messaging configuration to use a common `CuramCacheInvalidationTopic` across all applications
* Specify `TZ` environment variable for managing timezone in pods
* Update hook cleanup syntax

## v3.1.0

* Generate WebSphere Liberty keystore and administrative credentials on install
* Move custom SQL execution to pre-install hook
* Add option to provide pull secret name created outside the release
* Fixed Helm Chart syntax for enabling JMX Stats

## v3.0.0

* Reduce privilege requirements to run with the `restricted` security policy
* Switch to a custom utility image for the init containers to run within the `restricted` security policy
* Add a liveness probe script to detect loss of connection to database or MQ servers
* Chart values have been reorganised for improved readability
* Relocated all ConfigMaps for configuring Liberty to the `apps` chart
* System credentials are securely stored in Secret objects
* Added `pre-install` hooks for securely generating LTPA keys

## v2.1.0

* Technical Preview of OpenShift
* Change to UBI base images
* Add options for persisting JMX stats to a persistent volume
* Add reference configuration for integrating with IBM Security Access Manager using SAML 2.0

## v2.0.0

* Split of producers and consumers of JMS messages into separate deployment units
* Relocated all configuration from image to chart
* Add options for persisting logs to a persistent volume
* Add options for overriding JVM arguments on a per-application basis

## v1.1.0

* Initial release

## v1.0.0

* Limited availability preview
