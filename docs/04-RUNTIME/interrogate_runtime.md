# Monitoring the application in Minikube

You can interrogate a Kubernetes system to debug or verify its status in the following ways:

* View the Minikube dashboard
* View pod status and logs
* Log in to a pod to investigate its status
* Modify a Kubernetes object

## Kubernetes dashboard

The dashboard addon is enabled by default in Minikube and is used to verify the health of the system.
Because Minikube is a minimal environment, the dashboard addon doesn't have the full capability of the dashboard in a fully deployed Kubernetes cluster. However, the dashboard shows the most important data.

Use the dashboard to list the Kubernetes objects, including the status and names of the pods, and more information such as how long the pods are running.

Start the dashboard by running the following command:

```shell
minikube dashboard
```

An example of the dashboard:

![Minikube dashboard](../IMAGES/MiniKube-dashboard.png)

## Pods status and logs

All Kubernetes objects can be also accessed by running the `kubectl` command-line tool. To list the objects, run the `kubectl get` command followed by the types of object to retrieve, for example: pods, services, cron jobs, or other objects.
A useful option is the `-w` (watch) option. The watch option keeps the command in a pending state, showing how the pods change over time, it also follows the pods through the initialization, waiting, and running phases.

An example of `kubectl` is as follows:

```shell
kubectl get pods -w
```

This command lists the names of all the pods and their status.

When a pod is running, you can read the log of that pod by running the following command:

```shell
kubectl logs pod-name
```

Where `pod-name` is the name of the pod you want to query. The `kubectl logs` command behaves in the same way as the Docker `logs` command, so you can use the `-f` option to leave the command open and show the log updating in real time.

When the pod is not running but is in another state such as pending, initializing, or failed, you can `describe` it for debugging purposes if there is a problem.

Run `describe` on any Kubernetes object to show its configuration, for example:

```shell
kubectl describe pod/pod-name
```

## Log in to a pod

Like any other Docker container when a pod is in running status, you can log in to it to conduct a more detailed investigation.
The commands that you use depend on the pod, but the following command should work because `bash` is generally available:

```shell
kubectl exec -ti pod-name bash
```

THe command opens a `bash` session within the pod.

## Modify Kubernetes object

You can also modify Kubernetes objects at run time by running the `edit` command. Use this command carefully because it might modify the health of the system.
For example, to modify a deployment object called `deploymentname`, run the following command:

```shell
kubectl edit deployment/deploymentname
```

The configuration opens in the default editor, but you can specify a different editor by setting the `KUBE_EDITOR` environment variable.
