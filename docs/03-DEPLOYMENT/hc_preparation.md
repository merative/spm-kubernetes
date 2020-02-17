# Preparing Helm Charts

The [spm-containerization](https://github.com/IBM/spm-containerization) repository provides six Helm charts:

* *apps:* defines how to deploy the IBM WebSphere Liberty container with the SPM application.
* *mqserver:* defines the mqserver container configuration.
* *batch:* defines the batch container configuration.
* *xmlserver:* defines the xmlserver container configuration.
* *configmaps:* contains a group of common configurations across multiple containers.
* *spm:* an umbrella chart to contain all the other charts.

The charts use a templating mechanism to create the YAML file that is used by Kubernetes.
For this reason, the main configuration values are stored for each chart in a `values.yaml` file in the main folder of the charts.
These values can be also overwritten by the `spm:*` umbrella chart or by a provided override file at the deployment as described in [Deploying Helm charts](hc_deployment.md).

YAML is a human-readable structured data format. It provides powerful configuration settings, without having to learn a more complex code type like CSS, JavaScript, or PHP.

## Preparing to run the Helm charts

Before you run the charts, you must configure the database, configure IBM MQ, and test the charts.

### Configuring the database

Update the Helm charts to point to the database that you installed in
[Install Prerequisite Software](../01-PREREQ/prereq.md).
These values are provided in the  `values.yaml` files and must be modified before deployment to reflect your local environment:

```
global:
  database:
    type: "DB2"
    hostname: "dbhostname"
    dbName: "dbName"
    serviceName: ""
    username: "dbuser"
    password: "dbuserpassword"
    spm_psw: "spmEncryptedDBPassword"
    wlp_psw: "xorEncodedDBPassword"
    port: 50000
```

_**NOTE:**_ `serviceName:` can be of type "oracle" only, for Oracle databases.

The required values are self-explanatory however, `dbuserpassword` is the plain text database password and the value to replace `spmEncryptedDBPassword` can be obtained by running the command
`./build.sh encrypt -Dpassword=<password>` from any SPM installation.

`xorEncryptedDBPassword` is the Liberty WebSphere `{xor}` encoding of the database password. The value can be obtained by using `$WLP_HOME/bin/securityUtility encode <password>`.

If you are implementing an Oracle database, change the `type` value to `ORA`. Additionally, to pass the connection service name (`curam.db.oracle.servicename`), update the `serviceName` value.

You have two options for setting these values:

1. Provide a custom YAML file, which you reference on the `helm install` command as described in [Deploying Helm charts](hc_deployment.md).
The contents of your custom YAML file, for example `override-values.yaml`, contains content as above.
SPM's Helm Charts follow the parent chart/subcharts model, and therefore the values must be within the `global:` mapping to be applied globally.
1. Modify the `spm:*` umbrella chart. You can find the chart's `values.yaml` file in  `$SPM_HOME/helm-charts/spm`.

### Configuring MQ

MQ is already configured to work out of the box with a secure connection with IBM Liberty.
The commands that create all the objects that are needed on the queue manager are defined in a config map, in the `configmap-mqsc.yaml` file.
However, there is a default password that you must change, as in the case of the database.
The password is in the `$SPM_HOME/helm-charts/mqserver/values.yaml` file under the name `adminPasswordKey`. This password allows access to the MQ web console.

Passwords can also be stored in secrets, as for the certificates. However, for the scope of this guide, passwords can be configured in values files or preferably, overwritten at run time.

### Linting the Helm charts

Use the following command during development to verify the syntax and correctness of the generated YAML files. Run the command inside a Chart folder:

```shell
cd $SPM_HOME/helm-charts/spm
helm lint .
```

## Packaging the Helm charts

To use the Helm Charts to install SPM on Minikube, package the charts and load them into a repository. For more information, see [ChartMuseum](../01-PREREQ/chartmuseum.md).

To publish the individual charts to the Chart museum repository, run the following commands from the helm-charts folder. These commands also use the `$SPM_HOME` that is defined in [Install prerequisite software](../01-PREREQ/git.md):

```shell
cd $SPM_HOME/helm-charts
helm push apps local-development
helm push mqserver local-development
helm push configmaps local-development
helm push xmlserver local-development
helm push batch local-development
helm push ihs local-development
helm repo update
```

To generate the umbrella chart that is used for the deployment, run the following commands:

```shell
cd $SPM_HOME/helm-charts
helm dep up spm/
helm push spm local-development
helm repo update
```
