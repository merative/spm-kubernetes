"use strict";(self.webpackChunkspm_kubernetes=self.webpackChunkspm_kubernetes||[]).push([[5618],{8353:function(e,n,t){t.r(n),t.d(n,{_frontmatter:function(){return i},default:function(){return m}});var o=t(45),r=(t(6540),t(5680)),s=t(4330);const a=["components"],i={},u=(l="InlineNotification",function(e){return console.warn("Component "+l+" was not imported, exported, or provided by MDXProvider as global scope"),(0,r.yg)("div",e)});var l;const p={_frontmatter:i},c=s.A;function m(e){let{components:n}=e,t=(0,o.A)(e,a);return(0,r.yg)(c,Object.assign({},p,t,{components:n,mdxType:"MDXLayout"}),(0,r.yg)("p",null,"In Cloud environments, all the components of the platform must be up-to-date because of the often short maintenance cycles."),(0,r.yg)("h2",null,"Kubernetes"),(0,r.yg)("p",null,"The Kubernetes project gets minor releases approximately every three months, and it maintains only the three most recent minor releases."),(0,r.yg)(u,{mdxType:"InlineNotification"},(0,r.yg)("p",null,"Find out more about the Kubernetes project release cycle in ",(0,r.yg)("a",{parentName:"p",href:"https://kubernetes.io/docs/setup/release/version-skew-policy/"},"Kubernetes version and version skew support"),"."),(0,r.yg)("p",null,"Find out more about the Azure Kubernetes Service release and support cycle in ",(0,r.yg)("a",{parentName:"p",href:"https://learn.microsoft.com/en-us/azure/aks/supported-kubernetes-versions?tabs=azure-cli"},"Azure Kubernetes Services Docs"),".")),(0,r.yg)("p",null,"Managed Kubernetes services like AKS have a hands-off upgrade process, whereby the upgrade is performed with the click of a button.\nBefore upgrading, review all the release notes between the source and target versions because Kubernetes features can change over time."),(0,r.yg)(u,{kind:"warning",mdxType:"InlineNotification"},(0,r.yg)("p",null,(0,r.yg)("strong",{parentName:"p"},"Warning:")," Kubernetes upgrades cannot be rolled back. Always make sure to do the upgrade on a development cluster before proceeding to higher environments.")),(0,r.yg)("p",null,"Alongside the upgrade of the Kubernetes service, ensure you upgrade any pipelines and developer tools with a compatible version of ",(0,r.yg)("inlineCode",{parentName:"p"},"kubectl"),". The command-line tool must be within one minor version (older or newer) of the Kubernetes service."),(0,r.yg)("h2",null,"Helm"),(0,r.yg)("p",null,"Starting with Helm v3, there is no server-side component, so the process of upgrading the command-line tool is a case of replacing the binary.\nAs with any software, make sure to review the Helm ",(0,r.yg)("a",{parentName:"p",href:"https://github.com/helm/helm/releases"},"Release Notes")," before upgrading."),(0,r.yg)("h2",null,"Middleware components"),(0,r.yg)("p",null,"Because of the immutable nature of containers, when the application middleware (for example, IBM® WebSphere® Liberty) needs to be updated, new application images must be built upon a new base image.\nThe new images should then be promoted throughout the software development lifecycle using the methods outlined in ",(0,r.yg)("a",{parentName:"p",href:"/spm-kubernetes/operations/updating_curam"},"Updating SPM Deployment"),"."))}m.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-operations-updating-tools-mdx-add98c928c3dac4d38e3.js.map