# Batch processing

Batch processes are not relevant in this deployment. However, they are included to prove the way that they are deployed and run.

The Kubernetes object that is being created by using the code in this repository is a Cron job, which is scheduled to run every 15 minutes.
So initially no pod is listed, but a pod is started after 15 minutes and is visible when you run the `kubectl get pods` command.

The pod runs the standard command `build runbatch` that is described in [Running the Batch Launcher](https://www.ibm.com/support/knowledgecenter/SS8S5A_7.0.8/com.ibm.curam.content.doc/Operations/c_COPSGUIDE_Processes2RunningBatchLauncher1.html).

At the end of the execution, the pod stops but is not destroyed and a new pod is created after another 15 minutes. Access the log by running the `kubectl logs pod/podname` command.

You can delete the pod by running the `kubectl delete pod/podname` command.
