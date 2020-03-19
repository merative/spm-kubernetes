import React from 'react';
import Footer from 'gatsby-theme-carbon/src/components/Footer';

const Content = ({ buildTime }) => (
  <>
    <p>
      Last update: {buildTime}
    </p>
  </>
);

const links = {
  firstCol: [
    { }
  ],
  secondCol: [
    { }
  ]
};

const CustomFooter = () => <Footer links={links} Content={Content} />;

export default CustomFooter;
