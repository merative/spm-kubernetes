# Minikube

Minikube runs a single-node Kubernetes cluster inside a virtual machine (VM) on your laptop for users who want to try out Kubernetes or develop with it.
Minikube documentation is available at [Installing Kubernetes with Minikube](https://kubernetes.io/docs/setup/minikube/).
The following sections are not a substitute for the official documentation but they get you started in a classic configuration.

_**NOTE:**_ MiniKube version used to verify this runbook: 1.5.0

The following installation steps are described:

* Installing Minikube
* Setting up the Docker registry
* Configuring the hosts file for Minikube
* Starting Minikube
* Enabling Helm for Minikube
* A summary of some useful Minikube commands

## Minikube installation

Minikube installation steps are described in the official documentation for your preferred Operating System: [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/).

## Docker registry

You need a registry to use docker images with Helm in Minikube.
There are different types of registries that can be used. However, this page describes a simple registry option that doesn't require extra components.

Minikube provides an addon to run a registry in a container. For more information, see [How to access the Docker registry within minikube](https://minikube.sigs.k8s.io/docs/tasks/docker_registry/).

The addon can be enabled as follows:

```shell
minikube addons enable registry
```

When enabled, starting Minikube starts two pods on the `kube-system` namespace, named `registry` and `registry-proxy`. Now the registry is active and can be used. The registry points to the Minikube IP address on port 5000.

These containers don't mount any volumes, so stopping Minikube deletes the registry content.

### Configuring Docker registry security

There is a limitation in the Docker registry. The private repository does not use HTTPS connections, so you must white-flag it both in the `daemon.json` docker configuration
file and the corresponding setting that is used when you start Minikube, see "Starting Minikube".

To configure the Docker registry, you must get the Minikube IP address by starting Minikube for the first time:

```shell
minikube start
```

Run the following command to get the Minikube IP address:

```shell
minikube ip
```

## Hosts file configuration for Minikube

Because the convention in this guide is to use a generic hostname of `minikube.local` for example in commands and the configuration files,
you should add the Minikube IP address by using the generic hostname to the `hosts` file (`/etc/hosts` on Linux systems).
Alternatively, you must modify the usage of `minikube.local` in this guide to reflect your local hostname.

Run the following commend to get the Minikube IP address:

```shell
minikube ip
```

The Minikube IP address might change when you run `minikube delete`, if it changes you must repeat these steps.

Therefore, reconfirm the Minikube IP and its setting in the `hosts` file every time you start Minikube, or after you run `minikube delete`.

### Choosing Docker desktop or Docker service

Use either Docker desktop or Docker service to start the Docker daemon.
Docker Desktop for Windows is Docker designed to run on Windows 10.

#### Docker desktop

If you are using Docker Desktop, take the following steps:

1. Navigate to: Docker Desktop icon > Preferences > Daemon > +
1. Add `<<minikube ip value>>:5000`
1. Select Apply & Restart

#### Docker service

If you are using Docker service instead of Docker desktop, take the following steps:

1. Update the `daemon.json` docker configuration file with the Minikube IP address. This file is usually located in `~/.docker/daemon.json` on OSX or `/etc/docker/daemon.json` on Linux.
1. Run the following command to generate the subnet IP for the `"insecure-registries"` entry for creating a new `daemon.json` file:  

  ```shell
  printf "{\n\"insecure-registries\" : [\"`minikube ip | cut -d'.' -f 1,2`.0.0/16\"]\n}\n"
  ```

1. If a `daemon.json` file exists, add the `"insecure-registries"` entry to it.
1. After every change to `daemon.json`, you must restart the Docker service.

#### Specifying `"insecure-registries"`

Use the same `"insecure-registries"` value that you specified in `daemon.json` when you start Minikube, see "Starting Minikube".
Configuring `"insecure-registries"` in Docker and later when you start Minikube pushes the Docker images to the registry and allows Kubernetes to download images from the insecure Docker registry.

Now stop Minikube because you must create it later with extra arguments:

```shell
minikube delete
```

## Starting Minikube

### Specifying the resource allocation

You can add properties to specify the resource allocation. For example:

* `--cpus 4` to use 4 CPUs
* `--memory 8000` to use 8 GB of RAM
* `--disk-size=30000mb` to use 30 GB of disk space

### Specifying the VM driver

Add the `--vm-driver=` option to the `minikube start` command to specify the underlying virtual machine driver. IBM tested the following drivers:

* `--vm-driver=virtualbox` - VirtualBox on OSX
* `--vm-driver=vmware` - VMware Fusion on OSX
* `--vm-driver=none` - Minikube running directly on a Linux node without virtualization

The [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) page gives you more information on available VM driver options.

### Specifying the insecure registry

You must also specify the `--insecure-registry` option to reference the Docker registry that you created. The `--insecure-registry` value is the same as specified in the  `daemon.json` file.

_**NOTE:**_  Because of a limitation in the current version of Minikube, adding the `--insecure-registry` option works on a new Minikube instance only.
If you start Minikube, be sure to run `minikube stop` and `minikube delete` before you start it again with the `--insecure-registry` option.

### Specifying the Kubernetes version

You can override the version of Kubernetes that gets installed inside the Minikube VM by using the `--kubernetes-version` flag. This flag controls the compatibility between the client tools and the Kubernetes specification.

If you override the Kubernetes version, make sure to download and install the corresponding version of `kubectl` - this version must be the same version as the Kubernetes cluster.

_**NOTE:**_ The `kubectl` version running locally and on Minikube should be compatible, so it's possible to use this property to keep them consistent.

### Example start command

Example `minikube start` command is as follows:

```shell
minikube start --vm-driver=virtualbox --cpus 4 --memory 8000 --insecure-registry "192.168.0.0/16" --disk-size='30000mb' --kubernetes-version v1.15.4
```

Where `192.168.0.0/16` is the subnet that contains the IP address that is assigned to the MiniKube VM. You can verify the IP address by using by the `minikube ip` command.
The IP address might vary depending on your development environment, therefore start a MiniKube instance to get the IP address and then delete it
and restart it with the start command. See the note in "Specifying the insecure registry".

When it starts, Minikube creates and runs a number of pods that are used for its own operation. These pods run in a namespace called `kube-system`. `kube-system` can be considered as a logical partition within a Kubernetes cluster.

## Enabling Helm version 2 to run on Minikube

To use Helm v2 commands on Minikube you must initialize Tiller, which is the Helm server pod within Kubernetes. Run the following commands:

```shell
# Enable Tiller on Minikube to allow executing Helm commands
kubectl create serviceaccount -n kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

# Initialise Helm
helm init --service-account tiller
```

To verify whether Tiller is properly initialized, run the following command and look for the Tiller pod:

```shell
kubectl get pods -n kube-system | grep tiller
```

This command gives you the list of the pods in the system namespace, which is filtered for Tiller. The command returns one line that looks like the following example:

```shell
tiller-deploy-79c578486f-vnrhd              1/1     Running   1          18h
```

## Minikube Ingress

Ingress is a reverse proxy, which sits in front of the application that is deployed in Kubernetes. It facilitates use of a custom domain name to access a deployed application, instead of using service ports.
To enable Ingress for Minikube, you must enable two add-ons: `ingress` and `ingress-dns`.

```shell
minikube addons enable ingress
minikube addons enable ingress-dns
```

When ingress is enabled, [update your DNS configuration](https://github.com/kubernetes/minikube/tree/master/deploy/addons/ingress-dns#add-the-minikube-ip-as-a-dns-server) to add the Ingress DNS service as a valid server.

## Useful Minikube commands

Some useful Minikube commands are as follows:

```shell
# Sample commands
minikube status       # See if minikube is running
minikube start        # Create and start minikube
minikube dashboard    # Access the kubernetes dashboard running within the minikube cluster
minikube ssh          # Login into minikube vm
minikube addons list  # Show the status of the available addons
minikube stop         # Stop minikube
minikube delete       # Delete the minikube virtual machine
minikube ip           # Show the minikube ip
```

For a full list of commands, see [Kubernetes.io's Minikube](https://kubernetes.io/docs/setup/minikube/).
