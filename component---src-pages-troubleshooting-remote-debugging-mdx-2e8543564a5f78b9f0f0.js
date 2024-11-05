"use strict";(self.webpackChunkspm_kubernetes=self.webpackChunkspm_kubernetes||[]).push([[6437],{4973:function(e,t,n){n.r(t),n.d(t,{_frontmatter:function(){return p},default:function(){return f}});var r=n(45),a=(n(6540),n(5680)),o=n(4330);const i=["components"],p={},g=e=>function(t){return console.warn("Component "+e+" was not imported, exported, or provided by MDXProvider as global scope"),(0,a.yg)("div",t)},s=g("InlineNotification"),l=g("Tabs"),d=g("Tab"),u=g("Row"),b=g("Column"),m=g("Caption"),c={_frontmatter:p},y=o.A;function f(e){let{components:t}=e,n=(0,r.A)(e,i);return(0,a.yg)(y,Object.assign({},c,n,{components:t,mdxType:"MDXLayout"}),(0,a.yg)("h2",null,"Remote debugging"),(0,a.yg)("p",null,"It might be necessary to use a remote debugger to step through code execution on the cluster, where log analysis does not provide sufficient information to resolve an issue.\nThe following is an outline of the steps required to connect eclipse’s remote debugger to the Merative Social Program Management (SPM) code running on the cluster."),(0,a.yg)("ul",null,(0,a.yg)("li",{parentName:"ul"},"Edit the Cúram producer deployment spec to pass debug arguments to the WebSphere® Liberty server."),(0,a.yg)("li",{parentName:"ul"},"Forward the debugging port from the port running the Cúram producer pod."),(0,a.yg)("li",{parentName:"ul"},"Create the remote debug configuration in eclipse."),(0,a.yg)("li",{parentName:"ul"},"Connect the remote debugger to the listener.")),(0,a.yg)("p",null,"These steps are explained in more detail below."),(0,a.yg)("h3",null,"Edit the Cúram producer deployment"),(0,a.yg)("p",null,"Edit the deployment spec for the Cúram producer deployment."),(0,a.yg)("p",null,(0,a.yg)("inlineCode",{parentName:"p"},"kubectl edit deployment release-apps-curam-producer")),(0,a.yg)("p",null,"Add the following lines under ",(0,a.yg)("inlineCode",{parentName:"p"},".spec.template.spec.containers"),":"),(0,a.yg)(s,{mdxType:"InlineNotification"},(0,a.yg)("p",null,(0,a.yg)("strong",{parentName:"p"},"Note:")," Under ",(0,a.yg)("inlineCode",{parentName:"p"},".spec.template.spec.containers")," we can define multiple containers. The top level indented hyphen character preceding args\nsignifies the start of ",(0,a.yg)("em",{parentName:"p"},"a")," container definition, remove the ",(0,a.yg)("inlineCode",{parentName:"p"},"-")," at the same indentation level before env section or they will be treated\nas two separate container definitions, with one being invalid.")),(0,a.yg)(l,{mdxType:"Tabs"},(0,a.yg)(d,{label:"Correct Example",mdxType:"Tab"},(0,a.yg)(u,{mdxType:"Row"},(0,a.yg)(b,{mdxType:"Column"},(0,a.yg)("pre",null,(0,a.yg)("code",{parentName:"pre"},"containers:\n- args:\n  - /opt/ibm/wlp/bin/server\n  - debug\n  - defaultServer\n  env:\n  ...\n  ...\n"))))),(0,a.yg)(d,{label:"Incorrect Example",mdxType:"Tab"},(0,a.yg)(u,{mdxType:"Row"},(0,a.yg)(b,{mdxType:"Column"},(0,a.yg)("pre",null,(0,a.yg)("code",{parentName:"pre"},"containers:\n- args:\n  - /opt/ibm/wlp/bin/server\n  - debug\n  - defaultServer\n- env:\n  ...\n  ...\n")))))),(0,a.yg)("p",null,"Upon saving your deployment setting changes the Cúram producer deployment will terminate its pod and start a new one with the debug configuration."),(0,a.yg)(s,{kind:"info",mdxType:"InlineNotification"},(0,a.yg)("p",null,(0,a.yg)("strong",{parentName:"p"},"Note:")," The liveness, readiness, or startup probes could interfere with debugging and may need to be disabled.\nThe probes are designed and configured for a typical environment and the delays involved in debugging sessions may be incompatible, causing unexpected restarts and failures.")),(0,a.yg)("h3",null,"Forward the debugging port"),(0,a.yg)("p",null,"Once the restarted pod has completed initialization and started the Libery server ",(0,a.yg)("inlineCode",{parentName:"p"},"kubectl logs")," command will indicate that the Liberty server is waiting on the debug port:"),(0,a.yg)("pre",null,(0,a.yg)("code",{parentName:"pre"},"Listening for transport dt_socket at address: 7777\n")),(0,a.yg)("p",null,"At this point forward the WebSphere® Liberty server’s debug port to make it available to the remote debugger. 7777 is the default debug port for WebSphere® Liberty."),(0,a.yg)("p",null,(0,a.yg)("inlineCode",{parentName:"p"},"kubectl port-forward release-apps-curam-producer-XXXX 7777:7777")),(0,a.yg)("h3",null,"Create the remote debug configuration"),(0,a.yg)("p",null,"From the Eclipse debug view, create a Java Remote Application. Attach an appropriate source code project, and attach the Java Remote Application to the port you forwarded in ",(0,a.yg)("a",{parentName:"p",href:"#forward-the-debugging-port"},"Forward the debugging port"),".\nThe ",(0,a.yg)("inlineCode",{parentName:"p"},"Host")," field in the debug configuration will be ",(0,a.yg)("inlineCode",{parentName:"p"},"localhost")," even if you are using a remote cluster because the port forwarding\nrelies on the local loopback device."),(0,a.yg)("span",{className:"gatsby-resp-image-wrapper",style:{position:"relative",display:"block",marginLeft:"auto",marginRight:"auto",maxWidth:"1152px"}},"\n      ",(0,a.yg)("span",{parentName:"span",className:"gatsby-resp-image-background-image",style:{paddingBottom:"77.43055555555556%",position:"relative",bottom:"0",left:"0",backgroundImage:"url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAPCAIAAABr+ngCAAAACXBIWXMAABYlAAAWJQFJUiTwAAABkElEQVQoz5XQ4Y6cIBQFYN7/ffoM86fbpB1HOyiigyByQVAZrTtTbZRs02Z3dtsvhGi4J5CDKMYRTtI0ywiJ45gQYoxp27brunbX9/31D9775x/Pp/LbU3pE22+/DVpru871vbv6YZrGZVnWdV2W5eff7vf7uq4F0C/kO4pSfoiqLJeFaElRH2OaZEwIwVjFWKUaBa9pcK0zoBG9yMNTHGN6nebej1+POMlKKaUQgnO+Tb4idlwIZAzkJC1o7v0w+IFdyktJlVJmB2/hnIc8AmPOacoYm+fZOUdpmSTJ+XxmjOkHbGtKbjCtkQSVEdI0zbqu4zjmeU4IKctymzIaNLyxXu5Hum0ppZzz2+02TRPeSSmNMdba/oGu67Zna8XOSURpEcKhqtCWlBIe0FpLKZGoq1N8whgLIay1AGBe6Hdt4VrKY3RK4tg5NwyDUkr/m/3mBtKMhLanafq/cD8M3vt5nkPbjWxAwYdLKdjCWsPvDsOz4TGtddjN/oFYxWspQyacvRs2GpqCm0+fu0NifwHnmTgenpthNQAAAABJRU5ErkJggg==')",backgroundSize:"cover",display:"block"}}),"\n  ",(0,a.yg)("picture",{parentName:"span"},"\n          ",(0,a.yg)("source",{parentName:"picture",srcSet:["/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/0eda2/remote_debugger.webp 288w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/460e2/remote_debugger.webp 576w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/e0ca3/remote_debugger.webp 1152w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/d02be/remote_debugger.webp 1728w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/ff5d0/remote_debugger.webp 1768w"],sizes:"(max-width: 1152px) 100vw, 1152px",type:"image/webp"}),"\n          ",(0,a.yg)("source",{parentName:"picture",srcSet:["/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/7fc1e/remote_debugger.png 288w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/a5df1/remote_debugger.png 576w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/3cbba/remote_debugger.png 1152w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/0b124/remote_debugger.png 1728w","/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/78453/remote_debugger.png 1768w"],sizes:"(max-width: 1152px) 100vw, 1152px",type:"image/png"}),"\n          ",(0,a.yg)("img",{parentName:"picture",className:"gatsby-resp-image-image",src:"/spm-kubernetes/static/8f4f9be162543665743b3f2eb1624c5f/3cbba/remote_debugger.png",alt:"Figure 1: Example Debugger Config",title:"Figure 1: Example Debugger Config",loading:"lazy",decoding:"async",style:{width:"100%",height:"100%",margin:"0",verticalAlign:"middle",position:"absolute",top:"0",left:"0"}}),"\n        "),"\n    "),(0,a.yg)(m,{mdxType:"Caption"},(0,a.yg)("p",null,(0,a.yg)("em",{parentName:"p"},"Figure 1:")," Example debugger config")),(0,a.yg)("h3",null,"Connect the remote debugger to the listener"),(0,a.yg)("p",null,"Launch the debugger and debug as usual."))}f.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-troubleshooting-remote-debugging-mdx-2e8543564a5f78b9f0f0.js.map