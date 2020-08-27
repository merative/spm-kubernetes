# What's new

* Red Hat OpenShift support introduced
* Runs with `restricted` (default) pod security policy
* Add the option to specify multiple batch programs

### Fixes

# Breaking Changes

* The structure of values for specifying the Batch programs has changed:

  | Old property | New property | Default value | Comment |
  | ------------ | ------------ | ------------- | ------- |
  | `global.batch.successfulJobsHistoryLimit` | `successfulJobsHistoryLimit` | `3` | Different jobs can maintain different history sizes by providing this key under the respective program specification. |
  | `global.batch.backoffLimit` | `backoffLimit` | `5` | Different jobs can maintain a different number of retries by providing this key under the respective program specification. |
  | `global.batch.javaMetrics.*` | `javaOptions` | `-Xms1g -Xmx1g` | Java options to be specified via `ANT_OPTS`. Previously specified as 2 separate keys, `antOpts` and `heapSize` |
  | `global.batch.schedule` | `programs.<progID>.schedule` | `*/30 * * * *` | Different schedules can be specified for different batch jobs. The default schedule applies to any jobs queued in the system. |
  | `global.batch.programName` | `programs.<progID>.className` | `''` | Java class for the Batch batch process (`-Dbatch.program=`) |
  | `global.batch.programParameters` | `programs.<progID>.parameters` | `''` | Parameters, if any, to be passed to the batch process (`-Dbatch.parameters=`) |


* When specifying value overrides using the umbrella chart the new values must be nested under `batch`, for example:

  ```yaml
  batch:
    programs:
      reassessment:
        schedule: "0 2 * * 6"
        className: curam.healthcare.sl.intf.BulkICReassessment.process
        parameters: "evidenceMigrationDetails=CASE|DET0026071;DET0026027|CT26301"
        username: system
        javaOptions: "-Xms2g -Xmx2g -Xgcpolicy:gencon"
  ```

## Prerequisites

* For a full list of any prerequisites please see the [README.md](README.md)

# Version History

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
