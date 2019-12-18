# ChartMuseum

Helm charts are stored in a repository. For development purposes, you can use a local repository to use Helm along with Minikube. This Runbook uses [ChartMuseum](https://chartmuseum.com/) as the local repository.

A Helm chart is a collection of files that describe a related set of Kubernetes resources. Helm Charts are the recommended way to distribute deployments on Kubernetes clusters.

Use ChartMuseum to develop, test, and deploy locally before you distribute the charts. For more information, see [Introduction to Helm](https://helm.sh/docs/intro/).

## Installing ChartMuseum in a Docker container

ChartMuseum can run in a Docker container by using the `docker run` command when the docker container is created and entered in a folder that stores the charts.

Take the following steps:

* Define and create the folder to contain the chart museum in your preferred path. This path is referred to as `$CHART_MUSEUM` for the rest of the document.

```shell
mkdir -p $CHART_MUSEUM/charts
```

* Start a Docker container that mounts the `$CHART_MUSEUM/charts` folder and is accessible locally on port 8080:

```
docker run --rm -d --name chartmuseum \
  -p 8080:8080 \
  -v $CHART_MUSEUM/charts:/charts \
  -e DEBUG=true \
  -e STORAGE=local \
  -e STORAGE_LOCAL_ROOTDIR=/charts \
  chartmuseum/chartmuseum:v0.8.1
```

* Run the `docker logs` command to view the Chart Museum logs:

```
docker logs chartmuseum
```

### Testing ChartMuseum connectivity

Run the following command to test connectivity. `127.0.0.1` is the localhost IP address:

```
curl http://127.0.0.1:8080/index.yaml
```

You see something like the following example:

```
apiVersion: v1
entries: {}
generated: "2019-06-17T10:55:37Z"
serverInfo: {}
```

## Provisioning Charts

When ChartMuseum is running, you can copy the compressed tar files that are produced by Helm.
Creating these files is covered later in the runbook when you run the `helm package` command. For more information, see [Preparing Helm Charts](../03-DEPLOYMENT/hc_preparation.md).

## Configure Helm to access the local repository

To use ChartMuseum as a repository, you must configure Helm to point to it. Run the following command:

```shell
helm repo add local-development http://127.0.0.1:8080/
```

Verify the list of repositories by running the following command:

```shell
helm repo list
```

The helm repo list command also returns the `local-development` repository that you added when you ran the `helm repo add` command.

When the repository is added, run the following command to refresh the Helm index:

```shell
helm repo update
```
