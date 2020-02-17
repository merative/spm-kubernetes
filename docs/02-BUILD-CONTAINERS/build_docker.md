# Setting up the Docker context

To build the required Docker images, the context for building them must be established as described in the [Docker build](https://docs.docker.com/engine/reference/commandline/build/) command description.

The following components provide this context:

* The artifacts that you downloaded by following the steps that are described in [GitHub repo](../01-PREREQ/git.md).
* The `release.zip` and `StaticContent.zip` files that you built in [Building The Cúram Social Program Management application](../01-PREREQ/spm-build.md).

## Building IBM Cúram Social Program Management (SPM) resources

Some of the Docker images that you build rely on the `release.zip` and `StaticContent.zip` files that you built in [Building the IBM Cúram Social Program Management application](../01-PREREQ/spm-build.md).

If you built `release.zip` and `StaticContent.zip` on a different computer to the one where Minikube will be deployed, you must transfer the files to the computer you're currently working on.
For simplicity, it is assumed that these files are copied to `/tmp/`.

## Preparing the SPM environment

Prepare the SPM Docker environment by using the `release.zip` file.

For the following steps, use the `$SPM_HOME` folder that you created in [GitHub repo](../01-PREREQ/git.md).

1. Create a `batch-stage` folder to contain the contents of `release.zip`, run the following command:

  ```shell
  mkdir $SPM_HOME/dockerfiles/Liberty/content/batch-stage
  ```

1. Extract `release.zip` into the `batch-stage` folder, run the following commands:

  ```shell
  unzip -qd $SPM_HOME/dockerfiles/Liberty/content/batch-stage /tmp/release.zip
  chmod +x $SPM_HOME/dockerfiles/Liberty/content/batch-stage/*.sh
  ```

  Where `/tmp/release.zip` is the absolute path where the `release.zip` is saved.

1. Create the following folders:

  ```shell
  mkdir $SPM_HOME/dockerfiles/Liberty/content/ear-stage
  mkdir $SPM_HOME/dockerfiles/Liberty/content/res-stage
  ```

  The `ear-stage` folder contains the EAR files. The `res-stage` folder contains the batch and XML files.

1. Move the `ear` directory out of `batch-stage` into its own directory called `ear-stage` within the `DockerFiles` folder:

  ```shell
  mv $SPM_HOME/dockerfiles/Liberty/content/batch-stage/ear $SPM_HOME/dockerfiles/Liberty/content/ear-stage/
  ```

## Modifying SPM properties

`Bootstrap.properties` `AppServer.properties` are required to configure Liberty.  
However the relevant properties in `Bootstrap.properties` that you modify in the on-premise implementation of SPM are no longer relevant because Kubernetes configmaps provide the necessary values for the database configuration.  

The only properties that you must modify in `AppServer.properties` are `security.username` and `security.password`.  These properties contain the
WebSphere Liberty administrator credentials. If the password is changed the value must be the encrypted  by running the following commands:

```shell
cd $SERVER_DIR ; ./build.sh encrypt -Dpassword=<The password to be encrypted>
```

Copy the property files using the following command:

```shell
cp -vf $SPM_HOME/dockerfiles/Liberty/content/*.properties $SPM_HOME/dockerfiles/Liberty/content/batch-stage/project/properties/
```

## Liberty server configuration options

Depending on whether you deployed Minikube on the same computer where `release.zip` was built, or on a different computer, select one of the following options:

1. If you built `release.zip` on the **same computer** as the Minikube deployment, follow the steps in "building the WebSphere Liberty configuration locally".
2. If you built `release.zip` on a **different computer** to the Minikube deployment, follow the steps in "Building the WebSphere Liberty configuration remotely".

### Building the WebSphere Liberty configuration locally

Run the following commands on the computer where WebSphere Liberty is installed, with `$WLP_HOME` pointing to that installation.
This environment is already in place when you're running all the steps in the same computer. In this case, run the following commands:

```shell
cd $SPM_HOME/dockerfiles/Liberty/content/batch-stage
. ./SetEnvironment.sh
ant -f $CURAMSDEJ/bin/build.xml configure -Dwlp.shared.resource.dir=$SPM_HOME/dockerfiles/Liberty/content/res-stage/resources \
  -Dserver.setup.location=$SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer \
  -Dcrypto.ext.dir=$SPM_HOME/dockerfiles/Liberty/content/res-stage/ -Dwlp.environment.variable.set=true -Dkeep.profile=true
```

### Building the WebSphere Liberty configuration remotely

If you plan to build docker containers on a different computer from the one where `release.zip` is created,
run the steps directly on that computer. You will copy the `res-stage` folder at the end of the operation.
In this case, run the following commands:

```shell
mkdir /tmp/res-stage
cd /opt/IBM/Curam/Development
. ./SetEnvironment.sh
ant -f $CURAMSDEJ/bin/build.xml configure -Dwlp.shared.resource.dir=/tmp/res-stage/resources \
  -Dserver.setup.location=/tmp/res-stage/defaultServer \
  -Dcrypto.ext.dir=/tmp/res-stage/ -Dwlp.environment.variable.set=true -Dkeep.profile=true
```

Copy the resulting `res-stage` folder into `$SPM_HOME/dockerfiles/Liberty/content` on the target computer.

## Copying Liberty configuration files

When the `res-stage` folder is populated, copy the local XML config files into the newly generated `adc_conf` folder. Run the following command:

```shell
cp -vf $SPM_HOME/dockerfiles/Liberty/content/configOverride/*.xml $SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer/adc_conf/
```

Change the `$SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer/adc_conf/server_applications.xml` file to reflect the correct jndiName attribute values by running the following commands:

```shell
cd $SPM_HOME/dockerfiles/Liberty
sed -i.bak 's|jndiName="curamejb/ApplicationName" value="Curam"|jndiName="curamejb/ApplicationName" value="CuramServerCode"|' $SPM_HOME/dockerfiles/Liberty/content/res-stage/defaultServer/adc_conf/server_applications.xml
```

## Copying static content artifacts

Copy the static content `.zip` file for Docker image creation. Run the following commands:

```shell
mkdir $SPM_HOME/dockerfiles/HTTPServer/staticcontent/
cp -vf /tmp/StaticContent.zip $SPM_HOME/dockerfiles/HTTPServer/staticcontent/
```

## Installing external artifacts

In addition to `release.zip` and `StaticContent.zip`, download and install the following artifacts.

### Add the Ant zip file to the Docker environment

Copy `apache-ant-1.9.9-bin.zip` to `$SPM_HOME/dockerfiles/Liberty/content`. If Ant is not already available on the computer, run the following commands:

```shell
cd $SPM_HOME/dockerfiles/Liberty/content
wget https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.9-bin.zip
```

### Installing javax.mail.jar and activation.jar files

JavaMail is an external dependency for SPM and is represented by the JAR files `activation.jar` and `javax.mail.jar`. Copy these files in the folder `$SPM_HOME/dockerfiles/Liberty/content/dependencies`.

Use the `gradle.build` file that is located in the `$SPM_HOME/dockerfiles/Liberty/content` folder to build these files.

Gradle is an open source build-automation system that builds upon the concepts of Apache Ant and Apache Maven.
The installation steps for Gradle are in [Gradle installation](https://gradle.org/install/).
Gradle is not mandatory, but it makes the deployment process faster.

When Gradle is installed, run the following commands to download `JavaMail` and `activation.jar` and automatically create the dependencies subfolder:

```shell
cd $SPM_HOME/dockerfiles/Liberty/content
gradle getJavaMail
```

When the `gradle` command completes, verify its success. Confirm the availability of the JAR files, by running the following command:

`ls $SPM_HOME/dockerfiles/Liberty/content/dependencies`

### Downloading IBM MQ Resource Adapter

MQ is required for Liberty JMS support, therefore you must install the MQ Resource Adapter.

Take the following steps to download `9.1.3.0-IBM-MQ-Java-InstallRA.jar`:

1. Browse to [Fix Central](https://www-945.ibm.com/support/fixcentral/swg/downloadFixes?parent=ibm%2FWebSphere&product=ibm/WebSphere/WebSphere+MQ&release=All&platform=All&function=fixId&fixids=9.1.3.0-IBM-MQ-Java-InstallRA&includeRequisites=1&includeSupersedes=0&downloadMethod=http&login=true&login=true).
2. You are prompted to log in. If an error occurs refresh the Fix Central link.
3. Download `9.1.3.0-IBM-MQ-Java-InstallRA.jar`.
4. When the download completes, copy `9.1.3.0-IBM-MQ-Java-InstallRA.jar` to `$SPM_HOME/dockerfiles/Liberty/content`.
