
## Source of the xmlserver_prometheus.jar file

* The source code that the `xmlserver_prometheus.jar` file is based on resides in the <https://github.ibm.com/wh-spm-performance/xmlserver_collector_exporter> repo.
* Whenever a PR is integrated in that repo a new version of the `.jar` file is built by Travis/Maven and put into: <https://eu.artifactory.swg-devops.com/artifactory/wh-spmdevops-maven-virtual/xmlserver-statistics/xmlserver_collector_exporter/0.0.1-SNAPSHOT/> along with a `-sources.jar` file containing the source code.
* It is planned that the aforementioned repo will be integrated into this `spm-kubernetes` repo, but until then the `xmlserver_prometheus.jar` jar file must be updated "manually". For instance:
  * Navigate to <https://eu.artifactory.swg-devops.com/artifactory/wh-spmdevops-maven-virtual/xmlserver-statistics/xmlserver_collector_exporter/0.0.1-SNAPSHOT/> via a browser to identify the latest .jar file versions.
  * Set appropriate environment variables and values:
```
export ARTIFACTORY_USER=<Your-Artifactory-ID>
export ARTIFACTORY_TOKEN=<Your-Artifactory-Token>
export XMLSERVER_PROMETHEUS_JAR=<Lastest-jar-file-basename-in-Artifactory>

curl -u$ARTIFACTORY_USER:$ARTIFACTORY_TOKEN "https://eu.artifactory.swg-devops.com/artifactory/wh-spmdevops-maven-virtual/xmlserver-statistics/xmlserver_collector_exporter/0.0.1-SNAPSHOT/$XMLSERVER_PROMETHEUS_JAR.jar" -o xmlserver_prometheus.jar
curl -u$ARTIFACTORY_USER:$ARTIFACTORY_TOKEN "https://eu.artifactory.swg-devops.com/artifactory/wh-spmdevops-maven-virtual/xmlserver-statistics/xmlserver_collector_exporter/0.0.1-SNAPSHOT/$XMLSERVER_PROMETHEUS_JAR-sources.jar" -o xmlserver_prometheus-sources.jar
```

* The latest jars from Artifactory are based on:
  * `xmlserver_collector_exporter-0.0.1-20220301.145059-10.jar`
  * `xmlserver_collector_exporter-0.0.1-20220301.145059-10-sources.jar`

