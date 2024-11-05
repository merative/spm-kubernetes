"use strict";(self.webpackChunkspm_kubernetes=self.webpackChunkspm_kubernetes||[]).push([[9189],{8575:function(e,n,t){t.r(n),t.d(n,{_frontmatter:function(){return s},default:function(){return l}});var a=t(45),r=(t(6540),t(5680)),i=t(4330);const o=["components"],s={},p=e=>function(n){return console.warn("Component "+e+" was not imported, exported, or provided by MDXProvider as global scope"),(0,r.yg)("div",n)},c=p("InlineNotification"),g=p("Caption"),d={_frontmatter:s},u=i.A;function l(e){let{components:n}=e,t=(0,a.A)(e,o);return(0,r.yg)(u,Object.assign({},d,t,{components:n,mdxType:"MDXLayout"}),(0,r.yg)("p",null,"Merative Social Program Management (SPM) is not a PaaS nor a SaaS offering on Cloud. SPM is a platform for Social Programs that customers configure and customize according to their own requirements.\nThen build, deploy, run and operate on environments according to their own Software Development Life Cycle (SDLC) requirements."),(0,r.yg)("p",null,"SPM can either be deployed on traditional hosting architectures (i.e. virtual machines or bare metal) or on Kubernetes. This runbook only refers to the cloud native hosting on Kubernetes."),(0,r.yg)("p",null,"SPM can be deployed on two Kubernetes distributions:"),(0,r.yg)("ol",null,(0,r.yg)("li",{parentName:"ol"},(0,r.yg)("p",{parentName:"li"},(0,r.yg)("strong",{parentName:"p"},"Azure Kubernetes Services (AKS)"),": only available on Microsoft Azure."),(0,r.yg)(c,{kind:"warning",mdxType:"InlineNotification"},(0,r.yg)("p",{parentName:"li"},(0,r.yg)("strong",{parentName:"p"},"Note:")," Azure Kubernetes Services (AKS) is exclusively available for Development and Test purposes ",(0,r.yg)("strong",{parentName:"p"},"only"),"."))),(0,r.yg)("li",{parentName:"ol"},(0,r.yg)("p",{parentName:"li"},(0,r.yg)("strong",{parentName:"p"},"Red Hat OpenShift"),": on any environment supported by Red Hat (e.g. on-premises, private cloud or public cloud)."))),(0,r.yg)("p",null,"The Figure 1 shows the essential nature of the SPM architecture on Kubernetes."),(0,r.yg)("p",null,"It conveys the governing ideas and major building blocks of the architecture.\nThe ",(0,r.yg)("strong",{parentName:"p"},"“Development & DevOps”"),", ",(0,r.yg)("strong",{parentName:"p"},"“Security”")," and ",(0,r.yg)("strong",{parentName:"p"},"“Governance”")," components and processes described in the architecture diagram are just for reference and will likely be different, depending on your Deployment Architecture."),(0,r.yg)("p",null,"SPM does not require nor impose these components in the architecture."),(0,r.yg)(c,{mdxType:"InlineNotification"},(0,r.yg)("p",null,(0,r.yg)("strong",{parentName:"p"},"Note:")," This runbook does not provide any content or guidance on the ",(0,r.yg)("inlineCode",{parentName:"p"},"Development and DevOps"),", ",(0,r.yg)("inlineCode",{parentName:"p"},"Governance")," or ",(0,r.yg)("inlineCode",{parentName:"p"},"Security"),".")),(0,r.yg)("span",{className:"gatsby-resp-image-wrapper",style:{position:"relative",display:"block",marginLeft:"auto",marginRight:"auto",maxWidth:"1152px"}},"\n      ",(0,r.yg)("span",{parentName:"span",className:"gatsby-resp-image-background-image",style:{paddingBottom:"91.31944444444444%",position:"relative",bottom:"0",left:"0",backgroundImage:"url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAASCAIAAADUsmlHAAAACXBIWXMAABYlAAAWJQFJUiTwAAADAUlEQVQ4y3WTS28cRRRG+8fyA5CyZcuKHUIIKVJEWLBBIMQj4aEgklgTsKx47LHHM54Z97trurqq6/3u6kYzDt75LGpxVUf3Sve7yfQo4zRNhPTZ+bsyz5rdildbjiHLbjjnPL0mcJ887h5kK7n/+olb/+v+/sY8f6IuXplnH+t66778SMz/elw+woWo5zNU59XqMjt7TdoaLt4x0u9mf7ZFmoQQ1BHv/TiO8ciDLIRETFIhmxYWTUsYI8oghO8q0IB9IoQAABRFgRCy1voj8ohSyjk3BG+MUUoZow8fnB2GYRqjszYxxjDGQNPAtjVaxSFoqQAAdVVh1A3BO2spIVVVNnWtpAwh3I/mvU+s0Yi5q5QuM3K3d3kXDy8aSzwWaCxQzGAo8FiRqThUIpeOELJLc2NM4qxuqV/nXVZ12xwCJDvmYa8apPZYAqwywLZ5u8nbqqXpXiJqAACXF9dSykNnKsO61qvGVdgta2/8+M/GhBBOtwoQH6xc5jRtaN452GtMNejak9ulD+Egcz1cZ2S+7TclfjOvMOG/zFJjzO+n2bbE0xRfnpNFYX57j8tWMOmNFev80jmXOKMhD6DjjOueyg5TKmyHGBMOE0aFJsI1ACLMygqUrWTK3WyKn39dxhATo7VxEXHXMkbVgLnfY9VyhrguWl5CDntZtjwHrJceMmmdb0B3drrzzidaqUMYdHeRv5imKQzBaXdV/MFUfb5MF7c7CKrrzd3Z1dY6cpG/cN7GGIfBHsbWSsVpooylRRZi9MMgpMzKgjKKe4IQppRgREjPCaVZlhpt4/j/nqVS5fqWwk5BTLuOlhXDWEHEeyKkqOsK455w2Pa5FKpjFSYwxvGDrLzvvniKv/2OPX3Of/gJffWMvp2hzz7vX5+IITBKnI7v6x9f3n5qtP1+8cmqmR2P9V42Bt2s8S5dnczyxRXJcgrh6s3bertVHyJt82q32s210uts3uzL8UHWh/hbaUxalfV+b5xTWlOlmJBa6/uDY5QzIqSURjnBxUO2/wPlSuZ4F2UWPwAAAABJRU5ErkJggg==')",backgroundSize:"cover",display:"block"}}),"\n  ",(0,r.yg)("picture",{parentName:"span"},"\n          ",(0,r.yg)("source",{parentName:"picture",srcSet:["/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/0eda2/architecture-overview.webp 288w","/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/460e2/architecture-overview.webp 576w","/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/e0ca3/architecture-overview.webp 1152w","/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/9a814/architecture-overview.webp 1518w"],sizes:"(max-width: 1152px) 100vw, 1152px",type:"image/webp"}),"\n          ",(0,r.yg)("source",{parentName:"picture",srcSet:["/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/7fc1e/architecture-overview.png 288w","/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/a5df1/architecture-overview.png 576w","/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/3cbba/architecture-overview.png 1152w","/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/36102/architecture-overview.png 1518w"],sizes:"(max-width: 1152px) 100vw, 1152px",type:"image/png"}),"\n          ",(0,r.yg)("img",{parentName:"picture",className:"gatsby-resp-image-image",src:"/spm-kubernetes/static/0dd461ed66e780cf772ac2b5cbd2d865/3cbba/architecture-overview.png",alt:"architecture overview",title:"architecture overview",loading:"lazy",decoding:"async",style:{width:"100%",height:"100%",margin:"0",verticalAlign:"middle",position:"absolute",top:"0",left:"0"}}),"\n        "),"\n    "),(0,r.yg)(g,{mdxType:"Caption"},(0,r.yg)("p",null,(0,r.yg)("em",{parentName:"p"},"Figure 1:")," SPM on Kubernetes")),(0,r.yg)("p",null,"The Figure 2 shows how SPM is built as a containerized application by using WebSphere® Application Server Liberty, packaged as Docker®\ncontainers, orchestrated by Helm, and running on Red Hat OpenShift or Kubernetes Service."),(0,r.yg)("span",{className:"gatsby-resp-image-wrapper",style:{position:"relative",display:"block",marginLeft:"auto",marginRight:"auto",maxWidth:"381px"}},"\n      ",(0,r.yg)("span",{parentName:"span",className:"gatsby-resp-image-background-image",style:{paddingBottom:"152.43055555555557%",position:"relative",bottom:"0",left:"0",backgroundImage:"url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAACXBIWXMAAAsTAAALEwEAmpwYAAAEfElEQVRIx4VWaXPaSBDl//+GfNst29lcTuKyU87G2HGMHXvBYE4jYQkM6D5AoBu9rW4hwjreZKpeTc9IenTP6+6hNJvN8KvhxxmmTgrVzaE4CaZ2DGWzTmF66eb9km3bbKxWK2RZtsEqy2gXYytCe5ygN03QnSYQDeDBBu7VFboT2kvRHoeIkxWADCXHcZgwY4IfczHIIyLrq4QUR+dN7OyXUR+4EPUM9wo9jxCnq9zDgrDwsLCXyyUW3hyyumBviKyvJLhqKzirSmjKHhPSfncSrT3cIiwGkbquC9txYFsmpOmMQ+1OYnSnMQQ9w8AA7pWciPZ70xBJ4SGdYavVQqfTgSiK0HUd9CO+H/ALyzCFpPqQtQCy5kMibNYB25ob8flRgKX8Y5+98jyPQ7UsC4vlEmHgQ3FiiCYg2zkkC3gwwV6STegr8Q8PnwuZUonDti0MpjOc1YYo3wxwciPivD7Cxd0Y110dX29lXt/JHpI0+y9hmqYsBo0kSWCaFnRNY8LDry3sH1/j1WEFB+Vbxsm1gP3PN4yaYCPny1AiT54O8tC2c1EG0zn6BjAwwaELRo6+Bs5JskmYjcrj8RiCIGA4HPI8Go34DIMgF8XzEz78of4UIc+yHkBzok3KlUhVRVFQqVRQrVbZJuVJnCgMYM4TTl5RSyGohASCluZrLeU8FNUI6WpNWIRMxMUZ0p5l2RyyOJ6hIS3QkOa4kxeMhuSh/jBjMZrDBTpUes+pXNQxh+p5MHQNQ22Jo/M29j6c4eXBOY4rXbw7vsbuhzO8Pqrg1eEF7qQ5cr7s57ThDuP7LMzMdfCgLNBTgb664hIssL3ujLdKT1VV1Go1NBoNNJtNyLLMIROhv1zAcJaQ9BiysYa+BSPmZ9SRVoUoJAARnp6eolwuwzAMVjmKojyFlinupwEEJUB/mkNQwnyeBvxsaIQ/CClkSmTyiOw4jlll153BdWwMdZ97HoUoaBnPPSVBf23/FPJzZxiGIRzHZVGER4eT+qLxiD/e/o2PJ1Qpdfz57oTnTT98Svi09BzXha6pkNQFesoK7ccAt6LLadMa+bgdzNjuKSk6v+uHecguFgsPE2MBQY3xoCeQjBUe9HRtp2yLagxJ20ps+liSJC45qhL6ARIlDKNN6ZGSIytlVYdGgqGZ8Jpm2Uig2FulRwREROkymUyYkDD3PL4CKCX2v9Tx8uAbPpbrODht4N3nf/DXISX1JXben6EmOljfSM+LQlVCpWcaOsSxi9pghm+NMa57Jq7aGipNBef1R1yS3VLQkBccyU+X1PZFRXnozWd8B7cnCSvNLWzdyrZBKXSvxIji9PlrdPsqVd0EdTng2+6mZ3AzpbnaN/G9o/Jc7Vtoj5YIoieET0mLC1/SAux/qeH14QXefLrihvD2+Dvef6nizdEl3ny6xFVrgigFSqZp8oeUe5SL20iSlP89TK0Q7WmWd2g9R1/Pu3axpq698COUipr93TCXgOU/D9MHZmua0osXL7C3t4ednZ3/xd7uLvZ2d7D7C+TPd/EvBLXC5RW5MR0AAAAASUVORK5CYII=')",backgroundSize:"cover",display:"block"}}),"\n  ",(0,r.yg)("picture",{parentName:"span"},"\n          ",(0,r.yg)("source",{parentName:"picture",srcSet:["/spm-kubernetes/static/2255d49fb1f3d63731113eeeaa0d618b/0eda2/spm_on_kubernetes.webp 288w","/spm-kubernetes/static/2255d49fb1f3d63731113eeeaa0d618b/ae2a5/spm_on_kubernetes.webp 381w"],sizes:"(max-width: 381px) 100vw, 381px",type:"image/webp"}),"\n          ",(0,r.yg)("source",{parentName:"picture",srcSet:["/spm-kubernetes/static/2255d49fb1f3d63731113eeeaa0d618b/7fc1e/spm_on_kubernetes.png 288w","/spm-kubernetes/static/2255d49fb1f3d63731113eeeaa0d618b/b6c51/spm_on_kubernetes.png 381w"],sizes:"(max-width: 381px) 100vw, 381px",type:"image/png"}),"\n          ",(0,r.yg)("img",{parentName:"picture",className:"gatsby-resp-image-image",src:"/spm-kubernetes/static/2255d49fb1f3d63731113eeeaa0d618b/b6c51/spm_on_kubernetes.png",alt:"spm on kubernetes",title:"spm on kubernetes",loading:"lazy",decoding:"async",style:{width:"100%",height:"100%",margin:"0",verticalAlign:"middle",position:"absolute",top:"0",left:"0"}}),"\n        "),"\n    "),(0,r.yg)(g,{mdxType:"Caption"},(0,r.yg)("p",null,(0,r.yg)("em",{parentName:"p"},"Figure 2:")," SPM packaging for Kubernetes")),(0,r.yg)(c,{mdxType:"InlineNotification"},(0,r.yg)("p",null,(0,r.yg)("strong",{parentName:"p"},"Note:")," Database support remains on virtual machines (VMs) as part of the initial offering.")),(0,r.yg)(c,{mdxType:"InlineNotification"},(0,r.yg)("p",null,(0,r.yg)("strong",{parentName:"p"},"Note:")," IBM MQ running on Kubernetes is only supported on OpenShift. When deploying SPM on a Kubernetes Services (AKS), IBM MQ must be hosted on virtual machines or bare metal. More information about SPM and IBM MQ can be found ",(0,r.yg)("a",{parentName:"p",href:"/spm-kubernetes/supporting-infrastructure/mq/mq-overview"},"here"),".")),(0,r.yg)("p",null,"To support containerized architectures, a number of architectural changes were made. The changes are documented as follows and apply only to SPM running on\nKubernetes."),(0,r.yg)("ul",null,(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("strong",{parentName:"li"},"Message Architecture"),"\nWhen Merative Social Program Management is containerized, IBM MQ Long Term Support (LTS) is used as the message engine to process internal application\nJMS-based deferred processing."),(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("strong",{parentName:"li"},"Transaction Isolation"),"\nClient HTTP initiated transactions and JMS initiated transactions run on different WebSphere Application Server Liberty instances, integrated through\nan external message engine (for example, IBM MQ)."),(0,r.yg)("li",{parentName:"ul"},(0,r.yg)("strong",{parentName:"li"},"Elasticity"),"\nElasticity in Kubernetes Service is the ability to scale up or down pods and nodes to adjust to the load to meet the end user demand.")),(0,r.yg)("p",null,"For more information about SPM Kubernetes architecture changes, see ",(0,r.yg)("strong",{parentName:"p"},"Kubernetes architecture")," in the ",(0,r.yg)("em",{parentName:"p"},"Social Program Management SPM on Kubernetes Guide"),"."),(0,r.yg)(c,{mdxType:"InlineNotification"},(0,r.yg)("p",null,"The Social Program Management PDF documentation is available to download from ",(0,r.yg)("a",{parentName:"p",href:"https://curam-spm-devops.github.io/wh-support-docs/spm/pdf-documentation/"},"Merative Support Docs"),".")))}l.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-architecture-arch-overview-architecture-overview-mdx-ec692a6c76cad408167a.js.map