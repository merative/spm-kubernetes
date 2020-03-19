import React from 'react';
import ResourceLinks from 'gatsby-theme-carbon/src/components/LeftNav/ResourceLinks';

const links = [
  {
    title: 'Github',
    href: 'https://github.com/IBM/spm-kubernetes',
  },
  {
    title: 'Knowledge Center',
    href: 'https://www.ibm.com/support/knowledgecenter/SS8S5A_7.0.10/com.ibm.curam.nav.doc/spm_7010_welcome.html',
  }
];

// shouldOpenNewTabs: true if outbound links should open in a new tab
const CustomResources = () => <ResourceLinks shouldOpenNewTabs links={links} />;

export default CustomResources;
