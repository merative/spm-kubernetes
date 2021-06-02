# What's new

* Update messaging configuration to use a common `CuramCacheInvalidationTopic` across all applications
* Red Hat OpenShift support introduced
* Runs with `restricted` (default) pod security policy

# Breaking Changes

* The structure of values for specifying the tuning defaults for applications has changed:

  | Old property | New property | Default value |
  | ------------ | ------------ | ------------- |
  | `apps.tuningDefaults.maxPoolSize` | `apps.tuningDefaults.curamdb_maxPoolSize` | `8` |
  | `apps.tuningDefaults.numConnectionsPerThreadLocal` | `apps.tuningDefaults.curamdb_numConnectionsPerThreadLocal` | `2` |
  | `apps.tuningDefaults.purgePolicy` | `apps.tuningDefaults.curamdb_purgePolicy` | `EntirePool` |
  | `apps.tuningDefaults.statementCacheSize` | `apps.tuningDefaults.curamdb_statementCacheSize` | `1000` |

### Fixes

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v3.6.1

* Fix reference to Oracle datasource fragment

## v3.6.0

* Add ability to tune K8s resources on an app by app basis
* Extend database and JMS tuning parameters
* Add option to provide hub pull secret name created outside the release
* Apply values from `properties` at deployment
* Add ability for Prometheus to scrape Liberty metrics from pods
* Move `HTTPSessionDatabase` default configuration to timer based

## v3.5.0

* Extend WebSphere Liberty tuning options
* Remove `wait-for-database` initContainer
* Add `app` / `version` pod labels
* Update `ibm-sch` dependency to version 1.2.19

## v3.4.1

* Cleanup hook pull secret on deletion
* Remove reference to a non-existent pull secret for service account

## v3.4.0

* Fixes readiness probe when messages.log are being rotated

## v3.3.0

* Adds pod Anti-affinity rules to distribute a replica across the availability zones, and nodes within them.
* Activate logout for SAML when using single sign-on (SSO)

## v3.2.2

* Adds values from `podAnnotations` at deployment
* Synchronise logic for handling MQ TLS certificate secrets with `mqserver` chart.

## v3.2.1

* Activate SAML when using single sign-on (SSO)

## v3.2.0

* Remove hard requirement on OpenLDAP for elasticity.

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
