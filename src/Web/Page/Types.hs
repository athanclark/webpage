{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}

module Web.Page.Types where

import Data.Default
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
  deriving Show

instance (Monoid m, Monoid a) => Default (WebPage m a) where
  def = WebPage mempty mempty mempty mempty mempty mempty mempty mempty
