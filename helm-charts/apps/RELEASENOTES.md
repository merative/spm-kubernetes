# What's new

* Red Hat OpenShift support introduced
* Runs with `restricted` (default) pod security policy

### Fixes

# Breaking Changes

* The structure of values for configuring the Liberty runtime of the application has changed:

  | Old property | New property | Default value | Comment |
  | ------------ | ------------ | ------------- | ------- |
  | `global.apps.common.cookieHttpOnly` | `sessionConfig.cookie.httpOnly` | `true` | Value relocated from `configmaps` chart. |
  | `global.apps.common.initialDelaySeconds` | `initialDelaySeconds` | `150` | Reduced from 300 set previously. |
  | `global.apps.common.loginTrace` | `loginConfig.trace` | `true` | Value relocated from `configmaps` chart. |
  | `global.apps.common.port` | `httpsPort` | `8443` | Port configuration has been separated from other deployment components. |
  | `global.apps.config.rest.enabled` | Updated | `false` | The Rest application was previously marked to deploy by default. |
  | `global.apps.common.runAs` | Removed | `-` | Overriding the user for running the application is not supported by `restricted` security policies. |
  | `global.apps.common.security.*` | `systemUser.*` | See [values.yaml](./values.yaml#L235) | Specifies the system user for consuming JMS messages (user must exist in the Curam database). |
  | `global.apps.common.sessionTimeout` | `sessionConfig.sessionTimeout` | `30m` | Value relocated from `configmaps` chart. |
  | `global.apps.common.transactionTimeout` | `sessionConfig.transactionTimeout` | `3m` | Value relocated from `configmaps` chart. |
  | `global.commonAppConfig.maxInMemorySessionCount` | `sessionConfig.maxInMemorySessionCount` | `1000` | Value relocated from `configmaps` chart. |
  | `global.commonAppConfig.ltpa.*` | Replaced | `-` | The previously hard-coded LTPA keys have been removed are now generated using `pre-install` and `pre-upgrade` hooks. |
  | `global.resources.*` | `defaultResources.*` | See [values.yaml](./values.yaml#L269) | Default resources have been reduced for less cluttered configuration of the deployed applications. |
  | `global.xmlserver.port` | Removed | `- `| Specifying the XML server port is not relevant in the Kubernetes environment. |


* When specifying value overrides using the umbrella chart the new values must be nested under `apps`, for example:

  ```yaml
  apps:
    httpsPort: 9443
    sessionConfig:
      sessionTimeout: 60m
    loginConfig:
      trace: false
  ```

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

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
