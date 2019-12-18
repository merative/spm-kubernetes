# GitHub repo

This runbook and its associated artifacts are provisioned through GitHub.

Download the [spm-containerization](https://github.com/IBM/spm-containerization)
repository on your development system. Take the following steps:

## Install Git

Git is the distributed version control system on which GitHub is built. Usually Git is already included on development systems, but if it is missing, you can get it from [Getting Started - Installing Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

## Obtain the code

The [spm-containerization](https://github.com/IBM/spm-containerization) repository is stored in an Enterprise instance of GitHub that requires extra security measures.
You cannot clone a repository by using a username and password. Instead, you must configure an ssh key pair to be able to download the repo.
The download procedure is detailed in [Connecting to GitHub with SSH](https://help.github.com/en/enterprise/2.16/user/authenticating-to-github/connecting-to-github-with-ssh).

When the ssh keys are configured, clone the repository locally by using the following command:

```shell
git clone git@github.com/IBM/spm-containerization.git
```

The Git clone command creates a folder that is named `spm-containerization` in your current path. This folder is referred to `$SPM_HOME` for the remainder of this runbook. The `$SPM_HOME` folder contains three subfolders:

* *docs:* Contains the source files for this runbook, do not modify the source files.
* *dockerfiles:* Contains the docker files and other artifacts that are used to generate the containers. For more information, see [Setting up the Docker context](../02-BUILD-CONTAINERS/build_docker.md).
* *helm-charts:* Contains the charts that are used to deploy the containers on Kubernetes. For more information, see [Preparing Helm Charts](../03-DEPLOYMENT/hc_preparation.md).

You must create a local branch if you want to make local modifications to any of these files,
so you can continue to pull the latest code from the master branch without accidentally overriding any local change.
However, IBM does not currently support any external contributions to this repo, such as pull requests and forks.
