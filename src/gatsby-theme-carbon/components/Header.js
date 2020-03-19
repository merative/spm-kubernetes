import React from 'react';
import Header from 'gatsby-theme-carbon/src/components/Header';

require('./languages/prism-powershell')


const CustomHeader = props => (
  <Header {...props}>
    IBM Cúram SPM on Kubernetes Runbook
  </Header>
);

export default CustomHeader;
