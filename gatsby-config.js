const siteTitle = 'IBM Curam SPM on Kubernetes Runbook'

var activeEnv = 'local'

if (process.env.TRAVIS_BRANCH == 'next-release') {
  if (process.env.TRAVIS_REPO_SLUG == 'wh-curamspm-devops/spm-kubernetes') {
    activeEnv = 'development'
  }
}

if (process.env.TRAVIS_BRANCH == 'master') {
  if (process.env.TRAVIS_REPO_SLUG == 'wh-curamspm-devops/spm-kubernetes') {
    activeEnv = 'staging'
  }
  if (process.env.TRAVIS_REPO_SLUG == 'IBM/spm-kubernetes') {
    activeEnv = 'production'
  }
}

console.log(`Using environment config: '${activeEnv}'`)
require("dotenv").config({
  path: `.env.${activeEnv}`,
})

module.exports = {
  siteMetadata: {
    title: siteTitle,
    description: 'IBM Curam Social Program Management on Kubernetes Runbook',
    keywords: 'ibm,curam,containers',
  },
  pathPrefix: process.env.SITE_PREFIX,
  plugins: [
    {
      resolve: 'gatsby-plugin-manifest',
      options: {
        name: siteTitle,
        short_name: siteTitle,
        start_url: process.env.SITE_PREFIX,
        background_color: '#ffffff',
        theme_color: '#0062ff',
        display: 'browser',
      },
    },
    {
      resolve: 'gatsby-theme-carbon',
      options: {
        isSearchEnabled: true,
        withWebp: true,
        imageQuality: 75,
      },
    },
  ],
};
