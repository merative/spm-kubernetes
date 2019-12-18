# Building the IBM Cúram Social Program Management application

_**Note:**_ Before proceeding with the following, ensure that the steps defines in [Create SPM Database](create_spm_db.md) are completed. This action should only be a one off set-up.

Building Social Program Management (SPM) for deployment to Kubernetes is similar to on-premises SPM builds with some differences.
Notably, because the application server for the cloud environment is IBM WebSphere Liberty some target names are changed or are not supported.

Take the following steps to build SPM:  

## Source the SPM environment variables

Enter the directory where SPM is installed and source the SetEnvironment script; for example, in a shell script:

```shell
cd /opt/IBM/Curam/Development
. SetEnvironment.sh
```

## Set up AppServer.properties and verify the configuration

Before you build SPM, add an `AppServer.properties` file to `$SERVER_DIR/project/properties`.  `AppServer.properties` must specify `as.vendor=WLP`; for example:

```properties
# Property to indicate that WebSphere Liberty is installed
as.vendor=WLP

# The username and password for the administrator role
security.username=websphere
# Encrypt the plain-text password using 'build encrypt -Dpassword=<password>'
# Below is the encryption for the default password ("websphere")
security.password=XOVRjjVTebM8gV953LGMLQ==

# The name of the server on which the application will be hosted
curam.server.name=CuramServer
server.name=CuramServer

# The Curam client HTTP port
curam.client.httpport=10101

# The Curam web service port
curam.webservices.httpport=10102

# Required for Building CuramBIRTViewer.ear
curam.server.port=2809
```

To confirm your configuration, run the following shell script:

```shell
cd $SERVER_DIR
./build.sh configtest
```

## Set up static content

The static content server feature allows static content to be hosted on a separate web server.
This feature allows the web server that hosts the static content to be tuned for the static content and reduces the load on the main SPM application servers.
The option enables the relocation of static content to a separate server to allow for performance optimizations.

To enable static content, create a file called `curam-config.xml` in the following location `$CLIENT_DIR/components/custom/`.

Add the following to `curam-config.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<APP_CONFIG>
  <STATIC_CONTENT_SERVER>
    <URL>/CuramStatic/</URL>
  </STATIC_CONTENT_SERVER>
</APP_CONFIG>
```

## Build the SPM server

To build the SPM server, run the following shell script:

```shell
./build.sh clean server
```

## Build the database

To build the database, run the following shell script:

```shell
./build.sh database prepare.application.data
```

## Build the SPM client

To build the client, run the following shell script:

```shell
cd $CLIENT_DIR
./build.sh clean client
```

## Build `StaticContent.zip`

To build `StaticContent.zip`, run the following shell script:

```shell
cd $CLIENT_DIR
./build.sh zip-static-content
```

The `StaticContent.zip` file that is created is in the `$CLIENT_DIR/build` folder and is needed for the steps in
[Building Docker images](../02-BUILD-CONTAINERS/build_docker.md).

### Build the Cúram EAR files for WebSphere Liberty

Modify the `requireServer` setting in the `$SERVER_DIR/project/config/deployment_packaging.xml` file. This command works on multiple platforms:

```shell
sed -i  's/name="Curam" requireServer="true"/name="Curam" requireServer="false"/g' $SERVER_DIR/project/config/deployment_packaging.xml
```

To build the application EAR files for WebSphere Liberty, run the following shell script:

```shell
cd $SERVER_DIR
./build.sh libertyEAR -Dcuram.ejbserver.app.name=CuramServerCode
./build.sh libertyEAR -Dserver.only=true -Dear.name=CuramServerCode -DSERVER_MODEL_NAME=CuramServerCode -Dcuram.ejbserver.app.name=CuramServerCode
```

## Package a release.zip file

To package the build into a `release.zip` file, run the following shell script:

```shell
./build.sh release -Dcreate.zip=true
```

The .zip file that is created is in the `$SERVER_DIR/release` folder and is needed for the steps in
[Setting up the Docker environment](../02-BUILD-CONTAINERS/build_docker.md).
