"use strict";(self.webpackChunkspm_kubernetes=self.webpackChunkspm_kubernetes||[]).push([[7348],{8689:function(e,n,t){var r;t.d(n,{we:function(){return S}});var o=t(6540),u=t(6635),s=(t(961),t(4743));const l={...r||(r=t.t(o,2))},c=l.useInsertionEffect||(e=>e());function f(e){const n=o.useRef((()=>{0}));return c((()=>{n.current=e})),o.useCallback((function(){for(var e=arguments.length,t=new Array(e),r=0;r<e;r++)t[r]=arguments[r];return null==n.current?void 0:n.current(...t)}),[])}const i="ArrowUp",a="ArrowDown",d="ArrowLeft",m="ArrowRight";var v="undefined"!=typeof document?o.useLayoutEffect:o.useEffect;const g=[d,m],R=[i,a];let p=!1,C=0;const w=()=>"floating-ui-"+Math.random().toString(36).slice(2,6)+C++;const h=l.useId||function(){const[e,n]=o.useState((()=>p?w():void 0));return v((()=>{null==e&&n(w())}),[]),o.useEffect((()=>{p=!0}),[]),e};function k(){const e=new Map;return{emit(n,t){var r;null==(r=e.get(n))||r.forEach((e=>e(t)))},on(n,t){e.set(n,[...e.get(n)||[],t])},off(n,t){var r;e.set(n,(null==(r=e.get(n))?void 0:r.filter((e=>e!==t)))||[])}}}const x=o.createContext(null),M=o.createContext(null),b=()=>{var e;return(null==(e=o.useContext(x))?void 0:e.id)||null},E=()=>o.useContext(M);function S(e){void 0===e&&(e={});const{nodeId:n}=e,t=function(e){const{open:n=!1,onOpenChange:t,elements:r}=e,u=h(),s=o.useRef({}),[l]=o.useState((()=>k())),c=null!=b(),[i,a]=o.useState(r.reference),d=f(((e,n,r)=>{s.current.openEvent=e?n:void 0,l.emit("openchange",{open:e,event:n,reason:r,nested:c}),null==t||t(e,n,r)})),m=o.useMemo((()=>({setPositionReference:a})),[]),v=o.useMemo((()=>({reference:i||r.reference||null,floating:r.floating||null,domReference:r.reference})),[i,r.reference,r.floating]);return o.useMemo((()=>({dataRef:s,open:n,onOpenChange:d,elements:v,events:l,floatingId:u,refs:m})),[n,d,v,l,u,m])}({...e,elements:{reference:null,floating:null,...e.elements}}),r=e.rootContext||t,l=r.elements,[c,i]=o.useState(null),[a,d]=o.useState(null),m=(null==l?void 0:l.domReference)||c,g=o.useRef(null),R=E();v((()=>{m&&(g.current=m)}),[m]);const p=(0,s.we)({...e,elements:{...l,...a&&{reference:a}}}),C=o.useCallback((e=>{const n=(0,u.vq)(e)?{getBoundingClientRect:()=>e.getBoundingClientRect(),contextElement:e}:e;d(n),p.refs.setReference(n)}),[p.refs]),w=o.useCallback((e=>{((0,u.vq)(e)||null===e)&&(g.current=e,i(e)),((0,u.vq)(p.refs.reference.current)||null===p.refs.reference.current||null!==e&&!(0,u.vq)(e))&&p.refs.setReference(e)}),[p.refs]),x=o.useMemo((()=>({...p.refs,setReference:w,setPositionReference:C,domReference:g})),[p.refs,w,C]),M=o.useMemo((()=>({...p.elements,domReference:m})),[p.elements,m]),S=o.useMemo((()=>({...p,...r,refs:x,elements:M,nodeId:n})),[p,x,M,n,r]);return v((()=>{r.dataRef.current.floatingContext=S;const e=null==R?void 0:R.nodesRef.current.find((e=>e.id===n));e&&(e.context=S)})),o.useMemo((()=>({...p,context:S,refs:x,elements:M})),[p,x,M,S])}}}]);
//# sourceMappingURL=5c0b189e-48d3a405eb9db9ae9013.js.map