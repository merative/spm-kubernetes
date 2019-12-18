# Base third-party software

## IBM Installation Manager

Download and install [1.8.9.6 Installation Manager](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%7ERational&product=ibm/Rational/IBM+Installation+Manager&release=1.8.9.6&platform=All&function=fixId&fixids=1.8.9.6-IBMIM-*-X86_64*,1.8.9.6-IBMIM-WIN64*&includeRequisites=1&includeSupersedes=0&downloadMethod=http).

## IBM WebSphere Liberty licensing

If you are an existing WebSphere customer, you are entitled to access a WebSphere Liberty license. If you are not an existing WebSphere customer, you can download a 60-day trial of Liberty. For more information, see [IBM WebSphere Liberty: Pricing](https://www.ibm.com/cloud/websphere-liberty/pricing).

## IBM WebSphere Liberty

WebSphere Liberty 19.0.0.6 is the only application server that supports SPM on Kubernetes and is therefore required. Download and install WebSphere Liberty 19.0.0.6.

* Browse to [Passport Advantage](https://www.ibm.com/software/passportadvantage/index.html), search for and download one of the following packages:

1. **IBM WebSphere Application Server Liberty Network Deployment**
1. **IBM WebSphere Application Server Liberty Base**

If you are unsure of what installer to use, contact your IBM Account Executive.

Also, download and install the following packages:

* [19.0.0.6 Fix Pack](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FWebSphere&product=ibm/WebSphere/WebSphere+Liberty&release=All&platform=All&function=fixId&fixids=19.0.0.6-WS-LIBERTY-*-FP&includeRequisites=1&includeSupersedes=0&downloadMethod=http)
* [8.0.5.41 IBM Java SDK](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FWebSphere&product=ibm/WebSphere/WebSphere+Liberty&release=All&platform=All&function=fixId&fixids=8.0.5.41-JavaSE-SDK-*x64*-repo&includeRequisites=1&includeSupersedes=0&downloadMethod=http)

Install WebSphere Liberty as described in [Installing Liberty](https://www.ibm.com/support/knowledgecenter/SSEQTP_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_inst_top.html).

When installed, create an environment variable `WLP_HOME` that points to the Liberty installation directory. For example:

    ```shell
    WLP_HOME=/opt/IBM/WebSphere/Liberty
    ```

## IBM MQ Resource Adapter

MQ is required for Liberty JMS support, therefore you must install the MQ Resource Adapter.

Browse to:
[Fix Central](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FWebSphere&product=ibm/WebSphere/WebSphere+MQ&release=All&platform=All&function=fixId&fixids=9.1.3.0-IBM-MQ-Java-InstallRA&includeRequisites=1&includeSupersedes=0&downloadMethod=http)
to download the 9.1.3.0-IBM-MQ-Java-InstallRA.jar file.

You are prompted to log in, if an error occurs refresh the Fix Central link. Then, go to the download page, review the license and if you agree with its terms, select 'I agree'.
When the download completes, copy `9.1.3.0-IBM-MQ-Java-InstallRA.jar` to `$SPM_HOME/dockerfiles/Liberty/content`.

## Java

Java version 8 is required. See
[IBM SDK Java Technology Edition Version 8.0](https://www.ibm.com/support/pages/ibm-sdk-java-technology-edition-version-80-websphere-application-server-using-installation-manager)
for download and installation information.

Base the installation folder for Java the Liberty installation folder; for example: `$WLP_HOME/java`

When installed, create the following environment variable:

`JAVA_HOME=$WLP_HOME/java/8.0`

Add `$JAVA_HOME/bin` to the `PATH` environment variable.

## Database

A supported relational database is required, either IBM Db2 version 11.1 or Oracle Database 12cR2. You need either a Passport Advantage, or an Oracle account to download the relevant database software.

* Download Db2 from [Passport Advantage](https://www.ibm.com/software/passportadvantage/index.html).
  * See the [Db2 IBM Knowledge Center](https://www.ibm.com/support/knowledgecenter/en/SSEPGG_11.1.0/com.ibm.db2.luw.qb.server.doc/doc/c0060076.html) for detailed installation information.
* Download Oracle Database from [Oracle Software Delivery Cloud](https://edelivery.oracle.com/osdc/faces/SoftwareDelivery).
  * See the [Oracle Database Help Center](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/index.html) for detailed installation information.

## Apache Ant

Ant 1.9.9 is required and can be downloaded from [Apache.org](https://archive.apache.org/dist/ant/binaries/):

* Download the Ant 1.9.9 .zip file; for example:

  `wget https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.9-bin.zip`
* Extract the Ant .zip file to your environment; for example:

  `unzip -x apache-ant-1.9.9-bin.zip`
* Create the following environment variables:
  * `ANT_HOME` - that points to the installation directory
  * `ANT_OPTS=-Xmx1400m -Dcmp.maxmemory=1400m`
* Add `$ANT_HOME/bin` to the `PATH` environment variable

* Test Ant by running:

  `ant -version`
