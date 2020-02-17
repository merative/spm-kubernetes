# ChartMuseum

Helm charts are stored in a repository. For development purposes, you can use a local repository to use Helm along with Minikube. This Runbook uses [ChartMuseum](https://chartmuseum.com/) as the local repository.

A Helm chart is a collection of files that describe a related set of Kubernetes resources. Helm Charts are the recommended way to distribute deployments on Kubernetes clusters.

Use ChartMuseum to develop, test, and deploy locally before you distribute the charts. For more information, see [Introduction to Helm](https://helm.sh/docs/intro/).

## Installing ChartMuseum in a Docker container

ChartMuseum can run in a Docker container by using the `docker run` command when the docker container is created.

Take the following steps:

* Start a Docker container that is accessible locally on port 8080:

```shell
docker run --rm -d --name chartmuseum \
  -p 8080:8080 \
  -e DEBUG=true \
  -e STORAGE=local \
  -e STORAGE_LOCAL_ROOTDIR=/tmp/charts \
  chartmuseum/chartmuseum:v0.8.1
```

* Run the `docker logs` command to view the Chart Museum logs:

```shell
docker logs chartmuseum
```

### Testing ChartMuseum connectivity

Run the following command to test connectivity. `127.0.0.1` is the localhost IP address.

On OSX/Linux:

```shell
curl http://127.0.0.1:8080/index.yaml
```

On Windows:

```powershell
Invoke-RestMethod http://$(minikube ip):8080/index.yaml
# OR
Invoke-RestMethod http://$(docker-machine ip):8080/index.yaml
```

> **Note:** On Windows, the Docker Engine can run in a dedicated `docker-machine`, or can be reused from the Minikube VM

You will see something like the following example:

```yaml
apiVersion: v1
entries: {}
generated: "2019-06-17T10:55:37Z"
serverInfo: {}
```

## Provisioning Charts

When ChartMuseum is running, you can copy the compressed `tgz` files that are produced by Helm, or by using the [Helm Push](https://github.com/chartmuseum/helm-push) plugin (recommended approach).

```shell
helm plugin install https://github.com/chartmuseum/helm-push
```

> **Note:** On Windows, the Helm Push plugin must be installed from a Git Bash window.

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
