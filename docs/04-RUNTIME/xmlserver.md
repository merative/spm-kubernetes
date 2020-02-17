# XML server

Similar to batch processes, XML server usage is limited in this deployment. However, a pod containing the XML server is created and runs in the deployment.

To connect the XML server to the application server, change the `curam.xmlserver.host` in the system to point to the service name that you created during deployment.

To verify the service name, run the following command:

```shell
kubectl get services
```

The XML server is listed with the name: `releaseName-xmlserver` where `releaseName` was defined during deployment.

The change to `curam.xmlserver.host` allows the application sever to connect to the XML server.
