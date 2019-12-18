# Deploying Helm charts

When the Helm charts are uploaded to the repository, you can deploy the application by using the following shell script:

```shell
helm install spm --name releaseName
```

Where `releaseName` is the name of this Helm release. For example, MyRelease-1.0.
If you do not specify a name, Helm auto generates one. All the names of the Kubernetes objects are created with `releaseName-` as prefix.

The `helm install` command installs the Helm charts in the order in which they were loaded in the repository, with all the values defined in the files.
However, as described in [Building Docker containers](../02-BUILD-CONTAINERS/build_docker.html), you can override the configuration value, run the following shell script:

```shell
helm install local-development/spm --name releaseName -f override-values.yaml
```

## Status of the system

The `helm install` command shows all the Kubernetes objects and also runs the containers. You can track the status of the containers on real time by running the following shell script:

```shell
kubectl get pods -w
```

The command lists the pods and their status, each status change is on a new line.

Some of the pods have initialization steps, so they are not shown until satisfied.

The output of the `kubectl get pods` command provides the names of the pods that you can use to substitute for `podname` in the following example commands.
For example, the Liberty pod that contains SPM code is named that uses a pattern of: `releaseName-apps-curam-`).

You can also describe a pod by running the following command:

```shell
kubectl describe pod/pod name
```

You can also read the log, when the status is `running` by running the following shell script:

```shell
kubectl logs -f pod/podname
```

## Accessing the application

To access the application, a URL is provided to access the pod within the cluster. Usually this access is done by using an ingress object, for example:

`https://minikube.local/cúram`

However, on Minikube there is a more convenient way to access the application. To access the application on Minikube, you must the service to which you want to connect. Run the following shell script:

```shell
kubectl get services
```

The SPM application service should be called `releaseName-apps-curam`. For example, if you run the `helm install` command with a service name of `spm` you can then get the SPM application URL by running the following shell script:

```shell
minikube service spm-apps-curam --url
```

This command provides an IP address and a port to connect to.  To use the provided URL, replace  `http` with `https`. Pointing your browser to that URL opens the SPM login page.

When running `minikube service spm-apps-curam --url` on Red Hat, you might encounter
[MiniKube issue 3558](https://github.com/kubernetes/minikube/issues/3558) where the command attempts to start a browser by using X Window System. Ignore this error if it occurs.
