# What's new

* Red Hat OpenShift support introduced
* Runs with `restricted` (default) pod security policy

# Breaking Changes

* The structure of values for specifying the Universal Access image has changed:

  | Old property | New property | Default value | Comment |
  | ------------ | ------------ | ------------- | ------- |
  | `global.ceApp.replicaCount` | `replicaCount` | `1` |
  | `global.images.registry` | Unchanged | `minikube.local:5000` | All images must be retrieved from the same Container Registry, whether it is embedded in Minikube/CRC, or hosted like IBM Cloud Container Registry (ICR)
  | `global.ceApp.imageLibrary` | `imageConfig.library` | `''` |
  | `global.ceApp.imageName` | `imageConfig.name` | `''` |
  | `global.ceApp.imageTag` | `imageConfig.tag` | `latest` |
  | `global.ceApp.readinessPath` | `readinessProbe.path` | `/universal/` | This must match the `PUBLIC_URL` variable used when building the Universal Access application |
  | `global.ceApp.resources` | `resources` | See [values.yaml](./values.yaml#L59) |
  | `global.apps.common.port` | Removed | `-` | Port configuration has been removed with the change to an Apache HTTP server image |


* When specifying value overrides using the umbrella chart the new values must be nested under `uawebapp`, for example:

  ```yaml
  uawebapp:
    imageConfig:
      name: 'my-universal-access-app'
    readinessProbe:
      path: '/public-portal/'
  ```

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

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
* Chart renamed from `ce-app` to `uawebapp` to avoid aliasing of the chart
* Reduce privilege requirements to run with the `restricted` security policy
* Chart values have been reorganised for improved readability
* Moved web server configuration to ConfigMap

## v2.0.0

* Change to UBI base images
* Add option to inject certificates
* Allow binding to privileged ports
* Red Hat OpenShift support introduced

## v1.1.0

* Add a guard on image selection to make chart optional

## v1.0.0

* Initial release
