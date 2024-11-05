"use strict";(self.webpackChunkspm_kubernetes=self.webpackChunkspm_kubernetes||[]).push([[5594],{5698:function(e,a,t){t.r(a),t.d(a,{_frontmatter:function(){return o},default:function(){return d}});var n=t(45),i=(t(6540),t(5680)),r=t(4330);const l=["components"],o={},s=(p="InlineNotification",function(e){return console.warn("Component "+p+" was not imported, exported, or provided by MDXProvider as global scope"),(0,i.yg)("div",e)});var p;const m={_frontmatter:o},y=r.A;function d(e){let{components:a}=e,t=(0,n.A)(e,l);return(0,i.yg)(y,Object.assign({},m,t,{components:a,mdxType:"MDXLayout"}),(0,i.yg)("p",null,"All values defined in the Helm Chart ",(0,i.yg)("inlineCode",{parentName:"p"},"values.yaml")," file or in your custom override file become part of the Helm release definition."),(0,i.yg)("p",null,"As of Helm v3, the release definition is stored as a Kubernetes Secret resource by default, as opposed to a ConfigMap.\nThis provides additional security to any credentials defined as values in the release, in comparison to release definitions being stored as ConfigMaps in Helm v2."),(0,i.yg)(s,{mdxType:"InlineNotification"},(0,i.yg)("p",null,"You may find additional information about Secrets and how to define them in Kubernetes in the official documentation:"),(0,i.yg)("ul",null,(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("a",{parentName:"li",href:"https://kubernetes.io/docs/concepts/configuration/secret/"},"Kubernetes Secrets")),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("a",{parentName:"li",href:"https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/"},"Encrypting Secret Data at Rest")))),(0,i.yg)("p",null,"By default, the ",(0,i.yg)("inlineCode",{parentName:"p"},"spm")," chart will generate all of the secrets it needs. However, you may want to manage them outside of a Helm release, and point to existing secrets.\nThe following is a list of the Secrets which may be provided externally, and the data they must provide."),(0,i.yg)("p",null,"The descriptions refer to 2 variants of encryption/encoding: SPM and XOR."),(0,i.yg)("ul",null,(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("a",{parentName:"li",href:"https://ibm.biz/EncryptingSPMPasswords"},"SPM encryption")," refers to the values obtained from the ",(0,i.yg)("inlineCode",{parentName:"li"},"build.sh encrypt -Dpassword=<password>")," command."),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("a",{parentName:"li",href:"https://www.ibm.com/docs/en/was-liberty/base?topic=applications-securityutility-command"},"XOR encoding")," refers to the values obtained from the ",(0,i.yg)("inlineCode",{parentName:"li"},"$WLP_HOME/bin/securityUtility encode <password>")," command.")),(0,i.yg)("h2",null,"SPM Secrets"),(0,i.yg)("p",null,"The secrets are structured the following way - the top-level key is the property, which must be set in the override values file, and nested in it are the keys that must be defined for the secret along with their description.\nIf the following top-level keys are not provided, the secrets will be generated by the Helm Chart, prefixed with the Helm release name."),(0,i.yg)("ul",null,(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"global.imagePullSecret.secretName")," (type: kubernetes.io/dockerconfigjson)"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"global.hubPullSecret.secretName")," (type: kubernetes.io/dockerconfigjson)"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"global.database.credsSecretName")," (type: Opaque)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"SPM_DB_USR"),": Database username for datastore connections"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"SPM_DB_PSW"),": SPM encrypted password for the datastore connections (used by Batch processes)"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"XOR_DB_PSW"),": XOR encoded password for the datastore connections (used by WebSphere Liberty)"))),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"global.mq.queueManager.secret.name")," (type: Opaque)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"adminPasswordKey"),": Password for the ",(0,i.yg)("inlineCode",{parentName:"li"},"admin")," user in the ",(0,i.yg)("a",{parentName:"li",href:"https://hub.docker.com/r/ibmcom/mq"},"IBM MQ Docker image")),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"appPasswordKey"),": Password for the ",(0,i.yg)("inlineCode",{parentName:"li"},"app")," user in the ",(0,i.yg)("a",{parentName:"li",href:"https://hub.docker.com/r/ibmcom/mq"},"IBM MQ Docker image")),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"appUsername"),": Username for MQ connections"))),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"global.mq.tlsSecretName")," (type: variable - see options)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},"When IBM MQ is hosted on VMs outside the cluster (type: Opaque):",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"key_{{ $qmgrName }}.arm"),": A certificate file for each of the Queue Managers (one for every application)"))),(0,i.yg)("li",{parentName:"ul"},"When IBM MQ is hosted in containers inside the cluster (type: kubernetes.io/tls)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"tls.key"),": (optional) A private key file to configure in IBM MQ Containers"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"tls.crt"),": (optional) A certificate file to configure in IBM MQ Containers"))))),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("img",{parentName:"li",src:"https://img.shields.io/badge/-SPM_8.0.0.0-green",alt:"SPM 8.0.0.0"}),(0,i.yg)("inlineCode",{parentName:"li"},"apps.jwtConfig.secretName")," (type: kubernetes.io/tls)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"tls.key"),": A private key file for signing JSON Web Tokens"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"tls.crt"),": A certificate file for signing JSON Web Tokens"))),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"apps.ltpaKeys.secretName")," (type: Opaque)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"ltpa.keys"),": Contents of the ",(0,i.yg)("inlineCode",{parentName:"li"},"ltpa.keys")," file generated using ",(0,i.yg)("inlineCode",{parentName:"li"},"securityUtility createLTPAKeys --password=<password> --file=ltpa.keys")),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"passwordKey"),": XOR encoded password for the ",(0,i.yg)("inlineCode",{parentName:"li"},"ltpa.keys")," file"))),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"apps.systemUser.credsSecretName")," (type: Opaque)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"SYSTEM_USER"),": The user under which JMS messages are executed (default: SYSTEM)"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"SYSTEM_PASSWORD"),": XOR encoded password for ",(0,i.yg)("inlineCode",{parentName:"li"},"SYSTEM_USER")))),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"apps.wlpAdmin.secretName")," (type: Opaque)",(0,i.yg)("ul",{parentName:"li"},(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"KeystorePassword"),": Password for the default WebSphere Liberty keystore"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"XORKeystorePassword"),": XOR encoded password for the default WebSphere Liberty keystore"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"WebSphereUsername"),": Username of the administrative user for accessing the ",(0,i.yg)("a",{parentName:"li",href:"https://www.ibm.com/docs/en/was-liberty/base?topic=liberty-administering-using-admin-center"},"Liberty Admin Center"),", when enabled"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"WebSpherePassword"),": Password of the Liberty administrative user"),(0,i.yg)("li",{parentName:"ul"},(0,i.yg)("inlineCode",{parentName:"li"},"XORWebSpherePassword"),": XOR encoded password of the Liberty administrative user")))))}d.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-deployment-secrets-mdx-f9724beb566f4e5011c6.js.map