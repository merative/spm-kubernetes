# Building the Docker images

Now that all the elements are in place, build the images as follows:

* To build the XML server, batch, and Cúram images, run the following commands:

```shell
cd $SPM_HOME/dockerfiles/Liberty/
docker build -t minikube.local:5000/xmlserver:latest -f XMLServer.Dockerfile .
docker build -t minikube.local:5000/batch:latest -f Batch.Dockerfile .
docker build -t minikube.local:5000/curam:latest -f EAR.Dockerfile .
```

* To build the IBM MQ server image, run the following commands:

```shell
cd $SPM_HOME/dockerfiles/MQ/
docker build -t minikube.local:5000/mqserver:latest -f Dockerfile .
```

* To build the IHS HTTP server, run the following commands:

```shell
cd $SPM_HOME/dockerfiles/HTTPServer/
docker build -t minikube.local:5000/ihs:latest -f Dockerfile .
```

## Pushing the images to the registry

When you set up MiniKube following the steps in [Minikube](../01-PREREQ/minikube.md), a registry was also created to store the Docker images.
Push the new images that you created to the registry. Run the following command:

```shell
docker push minikube.local:5000/xmlserver:latest
docker push minikube.local:5000/batch:latest
docker push minikube.local:5000/curam:latest
docker push minikube.local:5000/mqserver:latest
docker push minikube.local:5000/ihs:latest
```

## View the artifacts in the repository

Confirm that the pushes to the Docker registry succeeded. Run the following command:

```shell  
curl http://minikube.local:5000/v2/_catalog
```

The command returns the following result:

```
  {"repositories":["batch","curam","mqserver","xmlserver","ihs"]}
```

_**NOTE:**_ When you shut down Minikube, you might need to repush the Docker images to the registry.

For more information about the Docker Registry HTTP API, see [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/).
