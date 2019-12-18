# Troubleshooting problems

## Errors in the Docker Registry

The Docker registry can be a source of errors, which might occur when you run `docker push` commands. You might see errors like the following:

* `Get https://minikube.local:5000/v2/: http: server gave HTTP response to HTTPS client`
* `Get http://minikube.local:5000/v2/: dial tcp 192.168.39.112:5000: connect: no route to host`

These errors can occur if the registry is not properly configured.  Some ways to investigate these errors are as follows:

Make sure that the IP reflected by the `minikube ip` command is specified in the following locations:

* `/etc/hosts` - Ensure that there is a `minikube.local` entry that matches the Minikube IP address. If necessary, modify the file.
* `/etc/docker/daemon.json` -  Ensure that the specified subnet matches the Minikube IP address. If necessary edit the file and restart the docker service, you must also restart ChartMuseum.
* `minikube start` command `--insecure-registry` option - When you use this command, ensure that the specified subnet matches the Minikube IP.

Confirm the registry with the following command:

`curl http://minikube.local:5000/v2/_catalog`

The command should return the following result:  

`{"repositories":["batch","curam","mqserver","xmlserver"]}`

_Note_ An empty repository returns: `{"repositories":[]}`
