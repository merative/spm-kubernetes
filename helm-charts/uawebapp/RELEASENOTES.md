# What's new

* OpenShift support introduced
* Runs with `restricted` (default) pod security policy

### Fixes

# Breaking Changes

* The structure of values for specifying the Universal Access image has changed

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


* The new values must be nest under `uawebapp`, when specifying values using the umbrella chart to take effect, for example:

  ```yaml
  uawebapp:
    imageConfig:
      name: 'my-universal-access-app'
    readinessProbe:
      path: '/public-portal/'
  ```

## Prerequisites

* See README.md

# Version History

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
* OpenShift support introduced

## v1.1.0

* Add a guard on image selection to make chart optional

## v1.0.0

* Initial release
