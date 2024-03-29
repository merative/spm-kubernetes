import React from 'react';
import ResourceLinks from 'gatsby-theme-carbon/src/components/LeftNav/ResourceLinks';

const links = [
  {
    title: 'SPM Documentation',
    href: 'https://curam-spm-devops.github.io/wh-support-docs/spm/pdf-documentation/',
  },
  {
    title: 'GitHub',
    href: 'https://github.com/merative/spm-kubernetes',
  },
  {
    title: 'Change Log',
    href: 'https://github.com/merative/spm-kubernetes/blob/main/CHANGELOG.md',
  }
];

// shouldOpenNewTabs: true if outbound links should open in a new tab
const CustomResources = () => <ResourceLinks shouldOpenNewTabs links={links} />;

export default CustomResources;
