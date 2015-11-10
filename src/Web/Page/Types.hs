{-# LANGUAGE
    OverloadedStrings
  , ExtendedDefaultRules
  #-}

module Web.Page.Types where

import Data.Default
import Data.Monoid

-- | Generic layout for a web page. We keep the data type purely parametric to
-- allow for record-syntax overloading / reassignment, like this:
-- .
--
-- >  page :: WebPage (Html ()) T.Text
-- @ page' = page \{pageTitle = "foo!"\}@
--
data WebPage markup attr = WebPage
  { pageTitle           :: attr -- ^ Page title
  , favicon             :: markup -- ^ Favicon tags
  , metaVars            :: markup -- ^ @\<meta\>@ tags
  , initScripts         :: markup -- ^ JavaScript to include at the top of the page
  , beforeStylesScripts :: markup -- ^ JavaScript to include before @\<style\>@ tags
  , styles              :: markup -- ^ Styles
  , afterStylesScripts  :: markup -- ^ JavaScript to include after @\<style\>@ tags - ie: <http://modernizr.com Modernizr>
  , bodyScripts         :: markup -- ^ JavaScript to include at the base of @\<body\>@
  } deriving (Show, Eq, Ord)


instance ( Monoid m
         , Monoid a
         ) => Monoid (WebPage m a) where
  mempty = WebPage mempty mempty mempty mempty mempty mempty mempty mempty
  mappend (WebPage t1 f1 m1 is1 bs1 s1 as1 b1) (WebPage t2 f2 m2 is2 bs2 s2 as2 b2) =
    WebPage (t1 `mappend` t2)
            (f1 `mappend` f2)
            (m1 `mappend` m2)
            (is1 `mappend` is2)
            (bs1 `mappend` bs2)
            (s1 `mappend` s2)
            (as1 `mappend` as2)
            (b1 `mappend` b2)


instance ( Monoid m
         , Monoid a
         ) => Default (WebPage m a) where
  def = mempty
