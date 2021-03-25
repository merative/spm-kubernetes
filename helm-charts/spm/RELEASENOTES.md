# What's new

* OpenShift technical preview.
* Runs with `restricted` (default) pod security policy.

### Fixes

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

## v2.5.0

* Update `apps` dependency to version 3.4.1
* Update `batch` dependency to version 2.1.1
* Update `mqserver` dependency to version 1.9.0
* Update `uawebapp` dependency to version 3.2.1
* Update `web` dependency to version 3.2.1
* Update `xmlserver` dependency to version 2.1.1

## v2.4.0

* Update `apps` dependency to version 3.4.0

## v2.3.0

* Patch verb tampering vulnerability in `uawebapp` and `web` charts' configmaps

## v2.2.0

* Add a route in OpenShift to allow connections to SSO, when enabled

## v2.1.0

* Remove hard requirement on OpenLDAP for elasticity.

## v2.0.2

* Add `global.timezone` value for managing timezone in pods
* Add support for Cúram application timer-based JMX statistics

## v2.0.1

* Add override option for enabling WebSphere Liberty Admin Center
* Add option to provide pull secret name created outside the release
* Add `proxy-read-timeout` for NGinx-based Ingress controllers
* Add option to provide the `ibm.io/region` annotation to PVC

## v2.0.0

* Reduce privilege requirements to run with the `restricted` security policy

## v1.4.0

* OpenShift Early Adopter availability

## v1.3.0

* Make Universal Access (React App) deployment optional

## v1.2.0

* Change Ingress APIVersion from `extensions/v1beta1` to `networking.k8s.io/v1beta1` for compatibility with Kubernetes 1.16
* Add Ingress annotations for configuring on IBM Cloud Kubernetes Service
* Add Ingress mapping for Universal Access (React App)

## v1.1.0

* Initial release

## v1.0.0

* Limited availability preview
