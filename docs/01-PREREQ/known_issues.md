# Known Issues

Some issues might require product changes to resolve them.

* **`minikube dashboard` command on Red Hat**

When you follow the steps "Kubernetes dashboard" in [Monitoring the application in MiniKube](../04-RUNTIME/interrogate_runtime.md), the `minikube dashboard` command might not work on Red Hat operating systems.
For more information, see this [Minikube issue](https://github.com/kubernetes/minikube/issues/5815).

* **Using Helm on Red Hat**

When you use Helm on Red Hat, you might have to use the Linux `yum` command to install the `socat` utility. Otherwise, Tiller does not work properly.

* **"Context Root Not Found" error on the SPM home page, BIRT, or Caseload Summary pages**

The "Context Root Not Found" error occurs because the deployment does not install the BIRT application.

* **The logs can be filled by repetitions of the ICWWKS4001I message**

For example:

```
[1/22/19 8:48:18:272 GMT] 000000ba com.ibm.ws.security.token.internal.TokenManagerImpl ICWWKS4001I: The security token cannot be validated. This can be for the following reasons:
```

1. The security token was generated on another server using different keys.
2. The token configuration or the security keys of the token service which created the token has been changed.
3. The token service which created the token is no longer available.

The root cause is users not clearing the browser cache after the application is redeployed. Users might have old, local cookie files.

However, after a redeployment or an upgrade, the application does not recognize the cookies that are presented to it by the computer, which causes the error messages in the logs.

* **Limitations when using the Minikube none driver**

There are a number of limitations associated with the Minikube none driver that are documented on the [Minikube site](https://minikube.sigs.k8s.io/docs/reference/drivers/none/). You must evaluate the impacts of these limitations for your implementation.

However, the unavailability of the `minikube ssh` command might make it difficult to analyze and resolve problems and issues. For example, switching to the kvm2 driver enables the use of `minikube ssh` and resolves issues with the Docker Registry.
