{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE BangPatterns #-}

module Web.Page.Types where


import Data.Monoid

-- | Generic layout for a web page. We keep the data type purely parametric to 
-- allow for record-syntax overloading / reassignment, like this:
-- .
-- > page :: WebPage (Html ()) T.Text
-- >
-- > page' = page {pageTitle = "foo!"}
data WebPage markup attr = WebPage {           pageTitle :: attr -- ^ Page title
                                   ,             favicon :: attr -- ^ Favicon url
                                   ,            metaVars :: markup -- ^ @\<meta\>@ tags
                                   ,         initScripts :: markup -- ^ JavaScript to include at the top of the page
                                   , beforeStylesScripts :: markup -- ^ JavaScript to include before @\<style\>@ tags
                                   ,              styles :: markup -- ^ Styles
                                   ,  afterStylesScripts :: markup -- ^ JavaScript to include after @\<style\>@ tags - ie: <http://modernizr.com Modernizr>
                                   ,         bodyScripts :: markup -- ^ JavaScript to include at the base of @\<body\>@
                                   }

instance (Monoid m, Monoid a) => Monoid (WebPage m a) where
  mempty = WebPage mempty mempty mempty mempty mempty mempty mempty mempty
  mappend x _ = x -- Some people just want to watch the world burn.
