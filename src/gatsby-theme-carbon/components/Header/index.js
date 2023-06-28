import React from "react";
import Header from "gatsby-theme-carbon/src/components/Header";

const CustomHeader = (props) => (
  <Header {...props}>
    Merative&nbsp;<span>SPM on Kubernetes</span>
  </Header>
);

export default CustomHeader;
