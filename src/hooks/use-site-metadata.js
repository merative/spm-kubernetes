import { useStaticQuery, graphql } from "gatsby";

export const useSiteMetadata = () => {
  const { site } = useStaticQuery(
    graphql`
      query SiteMetaData {
        site {
          siteMetadata {
            title
            description
            repository {
              baseUrl
              subDirectory
              branch
            }
          }
        }
      }
    `
  );
  return site.siteMetadata;
};
