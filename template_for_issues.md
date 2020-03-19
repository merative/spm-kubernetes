# Issue Template

---
name: Issue Template

---

**Please follow this template for creating issues**
This is a basic template to follow if issues arise.

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1.  
2.  
3.  

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Please complete the following information:**
    * OS: []
    * Docker Version: []
    * Minikube Version: []
    * Ant Version: []
    * Java Version: []
    * Liberty  Version: []
    * Cúram SPM Version: []

**Additional context**
Add any other context about the problem here.

**Log Collection**
From the host

```shell
docker cp <containerId>:/file/path/within/container /host/path/target
```

If you wish the navigate the docker to find log files you can do so with.

```shell
docker exec -it [container-id] bash
```
