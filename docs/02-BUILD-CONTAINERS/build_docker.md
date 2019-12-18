# Setting up the Docker context

Build Docker images by using the following components:

* The artifacts that you downloaded by following the steps that are described in [GitHub repo](../01-PREREQ/git.md).
* The `release.zip` and `StaticContent.zip` files that you built in [Building The Cúram Social Program Management application](../01-PREREQ/spm-build.md).

## Building Cúram Social Program Management (SPM) resources

Part of the Docker images that you build rely on the `release.zip` and `StaticContent.zip` files that you built in [Building the IBM Cúram Social Program Management application](../01-PREREQ/spm-build.md).

If you built `release.zip` and `StaticContent.zip` on a separate computer, you must transfer the files to the computer you're currently working on.
For simplicity, it is assumed that these files are copied to `/tmp/`.

## Getting the external artifacts

Set up the environment by getting the external artifacts needed to build the images.

For the following steps, use the `$SPM_HOME` folder that you created in [GitHub repo](../01-PREREQ/git.md).

1. Create a batch-stage folder to contain the contents of `release.zip`.

  ```shell
  mkdir $SPM_HOME/dockerfiles/Liberty/content/batch-stage
  ```

1. Extract `release.zip` into the batch-stage folder as follows:

  ```shell
  unzip -qd $SPM_HOME/dockerfiles/Liberty/content/batch-stage /tmp/release.zip
  chmod +x $SPM_HOME/dockerfiles/Liberty/content/batch-stage/*.sh
  ```

  Where `/tmp/release.zip` is the absolute path, where the `release.zip` is saved.

1. Create the following folders:

  ```shell
  mkdir $SPM_HOME/dockerfiles/Liberty/content/ear-stage
  mkdir $SPM_HOME/dockerfiles/Liberty/content/res-stage
  ```

  `ear-stage` contains the EAR files, `res-stage` contains the batch and XML files.

1. Move the `ear` directory out of `batch-stage` into its own directory called `ear-stage` within the DockerFiles folder:

  ```shell
  mv $SPM_HOME/dockerfiles/Liberty/content/batch-stage/ear $SPM_HOME/dockerfiles/Liberty/content/ear-stage/
  ```

## Configuring a WebSphere Liberty server

Modify `Bootstrap.properties` and `AppServer.properties` in `$SPM_HOME/dockerfiles/Liberty/content` depending on your configuration.
The property files contain the username and encrypted password that is used to access the database and the application server.

Change the username and password in the property files and then copy the files to the target folder.

Run the following shell script:

```shell
cp -vf $SPM_HOME/dockerfiles/Liberty/content/*.properties $SPM_HOME/dockerfiles/Liberty/content/batch-stage/project/properties/
```

## Liberty server configuration options

Depending on where you are setting up the Docker context, you should take one of the following steps:

* if you are using a single machine with both SPM and Minikube installed, see "Retrieve configuration files from a single machine"
* if you are using separate machines for SPM and Minikube installation, see "Retrieve configuration files from a separate machine"

### Retrieve configuration files from a single machine

Run the following commands on the computer where WebSphere Liberty is installed, with `$WLP_HOME` pointing to that installation.
This environment is already in place when you're running all the steps in the same computer. In this case, run the following commands:

```
cd $SPM_HOME/dockerfiles/Liberty/content/batch-stage
. ./SetEnvironment.sh
ant -f $CURAMSDEJ/bin/build.xml configure -Dwlp.shared.resource.dir=$SPM_HOME/dockerfiles/Liberty/content/res-stage/resources \
  -Dserver.setup.location=$SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer \
  -Dcrypto.ext.dir=$SPM_HOME/dockerfiles/Liberty/content/res-stage/ -Dwlp.environment.variable.set=true -Dkeep.profile=true
```

### Retrieve configuration files from a separate machine

If you plan to build docker containers on a different computer from the one where `release.zip` is created,
run the steps directly on that computer. You will copy the `res-stage` folder at the end of the operation.
In this case, run the following commands:

```
mkdir /tmp/res-stage
cd /opt/IBM/Curam/Development
. ./SetEnvironment.sh
ant -f $CURAMSDEJ/bin/build.xml configure -Dwlp.shared.resource.dir=/tmp/res-stage/resources \
  -Dserver.setup.location=/tmp/res-stage/defaultServer \
  -Dcrypto.ext.dir=/tmp/res-stage/ -Dwlp.environment.variable.set=true -Dkeep.profile=true
```

Copy the resulting `res-stage` folder into `$SPM_HOME/dockerfiles/Liberty/content` on the target computer where you ran all the previous steps.

## Copy Liberty configuration files

When the `res-stage` folder is populated, copy the local xml config files into the newly generated `adc_conf` folder. Run the following shell script:

```shell
cp -vf $SPM_HOME/dockerfiles/Liberty/content/configOverride/*.xml $SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer/adc_conf/
```

Apply the following change to the files.

* On file `$SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer/adc_conf/server_applications.xml` substitute the string `jndiName="curamejb/ApplicationName" value="Curam"` with `jndiName="curamejb/ApplicationName" value="CuramServerCode"`

* On a Linux or OSX computer, these changes can be applied by running by using the following shell script:

```shell
cd $SPM_HOME/dockerfiles/Liberty
sed -i.bak 's|jndiName="curamejb/ApplicationName" value="Curam"|jndiName="curamejb/ApplicationName" value="CuramServerCode"|' $SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer/adc_conf/server_applications.xml
```

## Copy Static Content artifacts

Copy the static content .zip file for Docker image creation. Run the following shell script:

```shell
mkdir $SPM_HOME/dockerfiles/HTTPServer/staticcontent/
cp -vf /tmp/StaticContent.zip $SPM_HOME/dockerfiles/HTTPServer/staticcontent/
```

## Installing external artifacts

In addition to `release.zip` and `StaticContent.zip`, download and install the following artifacts.

### Install Ant

Download the Apache Ant version 1.9.9 .zip file from [apache.org](https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.9-bin.zip).

Place the .zip file into the `$SPM_HOME/dockerfiles/Liberty/content` folder by running the following shell script:

```shell
cd $SPM_HOME/dockerfiles/Liberty/content
wget https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.9-bin.zip
```

### Install javax.mail.jar and activation.jar files

JavaMail is an external dependency for SPM and is represented by the JAR files `activation.jar` and `javax.mail.jar`. Copy these files in the folder `$SPM_HOME/dockerfiles/Liberty/content/dependencies`.

You can copy the files manually, or you can use the `gradle.build` file that is located in the `$SPM_HOME/dockerfiles/Liberty/content` folder.

Gradle is an open source build-automation system that builds upon the concepts of Apache Ant and Apache Maven.
The installation steps for Gradle are in [Gradle installation](https://gradle.org/install/).
Gradle is not mandatory, but it makes the deployment process faster.

When Gradle is installed, run the following shell script to download JavaMail and activation.jar and automatically create the dependencies subfolder:

```shell
cd $SPM_HOME/dockerfiles/Liberty/content
gradle getJavaMail
```

When the `gradle` command completes, verify its success. Run the following shell script to confirm that the `activation.jar` and `javax.mail.jar` files are available:

```shell
ls $SPM_HOME/dockerfiles/Liberty/content/dependencies
```

To confirm that the javax.mail.jar and activation.jar files are available.

### Download IBM MQ Adapter

The MQ Resource Adapter can be downloaded from [Fix Central](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FWebSphere&product=ibm/WebSphere/WebSphere+MQ&release=All&platform=All&function=fixId&fixids=9.1.3.0-IBM-MQ-Java-InstallRA&includeRequisites=1&includeSupersedes=0&downloadMethod=http&login=true&login=true).
The file must be placed in `$SPM_HOME/dockerfiles/Liberty/content`
