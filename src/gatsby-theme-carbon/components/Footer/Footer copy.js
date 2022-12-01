import React from 'react';
import PropTypes from 'prop-types';
import { useStaticQuery, graphql } from 'gatsby';
import { Row, Grid, Column } from 'gatsby-theme-carbon/src/components/Grid';
import {
  footer,
  grid,
  nav,
  listItem,
  logo,
  content,
} from 'gatsby-theme-carbon/src/components/Footer/Footer.module.scss';

const Footer = ({ Content, links, Logo }) => {
// const Footer = ({ Content, links }) => {
  const { firstCol, secondCol } = links;
  const { site } = useStaticQuery(graphql`
    query SHADOW_BUILD_TIME_QUERY {
      site {
        buildTime(formatString: "DD MMMM YYYY")
      }
    }
  `);
  return (
    <footer className={footer}>
      <Grid className={grid}>
        <Row>
          <Column colLg={2} colMd={2}>
            <ul className={nav}>
              {firstCol &&
                firstCol.map((link, i) => (
                  <li key={i} className={listItem}>
                    <a href={link.href} aria-label={link.linkText}>
                      {link.linkText}
                    </a>
                  </li>
                ))}
            </ul>
          </Column>
          <Column colLg={2} colMd={2}>
            <ul className={nav}>
              {secondCol &&
                secondCol.map((link, i) => (
                  <li key={i} className={listItem}>
                    <a href={link.href} aria-label={link.linkText}>
                      {link.linkText}
                    </a>
                  </li>
                ))}
            </ul>
          </Column>
          <Column
            className={content}
            colLg={4}
            colMd={4}
            colSm={3}
            offsetLg={2}>
            <Content buildTime={site.buildTime} />
          </Column>
        </Row>
        <Row>
          <Column colLg={3}>
            <Logo />
          </Column>
        </Row>
      </Grid>
    </footer>
  );
};

const IBMLogo = () => (
  <svg
    className={logo}
    width="81"
    height="32"
    xmlns="http://www.w3.org/2000/svg">
    // xmlns="https://www.merative.com/content/dam/merative/images/logos/full%20color.svg">
    <g fillRule="evenodd">
      <path d="m948.81848,815.99902c0,-8.33337 -0.01098,-16.16675 0.00238,-24.00006c0.02667,-15.62744 8.29053,-28.31158 22.25665,-34.18768c13.99116,-5.88672 29.34003,-2.74127 40.45234,8.31091c0.69232,0.6886 1.26477,1.49774 2.15448,2.56391c6.07214,-6.71399 12.95581,-11.30854 21.65954,-13.01233c21.36121,-4.18152 41.75147,10.98651 43.53845,32.59295c0.13709,1.65711 0.1222,3.32947 0.12293,4.99476c0.00806,17.64965 0.00488,35.29937 0.00488,53.26641c-5.17688,0 -10.10058,0 -15.85681,0c0,-1.61493 0.00061,-3.35852 0,-5.10211c-0.00586,-16.99994 0.1333,-34.00159 -0.07129,-50.99908c-0.12707,-10.54639 -8.04089,-18.98145 -18.41907,-20.29657c-9.43835,-1.19605 -18.96643,4.96655 -21.92535,14.41345c-0.67938,2.16913 -0.8446,4.57062 -0.85413,6.86676c-0.06872,16.66644 -0.03698,33.33319 -0.03698,49.99988c0,1.62573 0.00006,3.25146 0.00006,5.15417c-5.37195,0 -10.28955,0 -15.62397,0c-0.07708,-1.58471 -0.22106,-3.18597 -0.22265,-4.78735c-0.01654,-16.66669 0.00458,-33.33331 -0.01508,-50c-0.01452,-12.30756 -8.95721,-21.73731 -20.59015,-21.76526c-11.67364,-0.02808 -20.77673,9.26678 -20.84576,21.53174c-0.0929,16.49951 -0.02344,32.99988 -0.02356,49.49988c0,1.79248 0.00012,3.58496 0.00012,5.58813c-5.47509,0 -10.39343,0 -15.70703,0c0,-10.16772 0,-20.15008 0,-30.63251z" />
    </g>
  </svg>
);


const DefaultContent = ({ buildTime }) => (
  <>
    <p>
      Last updated: {buildTime}
    </p>
  </>
);

Footer.defaultProps = {
  links: {
    firstCol: [ ],
    secondCol: [ ],
  },
  Content: DefaultContent,
  Logo: IBMLogo,
};

Footer.propTypes = {
  /**
   * Specify the first and second columns of your links
   */
  links: PropTypes.exact({
    firstCol: PropTypes.arrayOf(
      PropTypes.shape({
        href: PropTypes.string,
        linkText: PropTypes.string,
      })
    ),
    secondCol: PropTypes.arrayOf(
      PropTypes.shape({
        href: PropTypes.string,
        linkText: PropTypes.string,
      })
    ),
  }),

  /**
   * Specify the first and second columns of your links
   */
  Content: PropTypes.elementType,

  /**
   * Provide a logo to be rendered in the bottom left corner
   */
  Logo: PropTypes.elementType,
};

export default Footer;
