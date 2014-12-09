{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE BangPatterns #-}

module Lucid.Scaffold where


import Lucid
import Lucid.Base

import qualified Data.Text as T

import Data.Monoid

data WebPage m = WebPage {           pageTitle :: T.Text -- ^ Page title
                         ,             favicon :: T.Text -- ^ Favicon url
                         ,            metaVars :: (HtmlT m ())
                         ,         initScripts :: (HtmlT m ()) -- ^ JavaScript to include at the top of the page
                         , beforeStylesScripts :: (HtmlT m ()) -- ^ JavaScript to include before @/<style/>@ tags
                         ,              styles :: (HtmlT m ()) -- ^ Styles
                         ,  afterStylesScripts :: (HtmlT m ()) -- ^ JavaScript to include after @/<style/>@ tags - see <http://modernizr.com Modernizr>
                         ,         bodyScripts :: (HtmlT m ()) -- ^ JavaScript to include at the base of @/<body/>@
                         }


instance Monad m => Monoid (WebPage m) where
  mempty = WebPage "" "" mempty mempty mempty mempty mempty mempty
  mappend x _ = x -- Some people just want to watch the world burn.


template :: Monad m => WebPage m -> HtmlT m () -> HtmlT m ()
template page content = doctypehtml_ $ mconcat $
  [ head_ [] $ mconcat $
      [ initScripts page
      , title_ $ toHtmlRaw $ pageTitle page
      , metaVars page
      , link_ [ rel_ "icon"
              , href_ $ favicon page
              ]
      , beforeStylesScripts page
      , styles page
      , afterStylesScripts page
      ]
  , body_ [] $ mconcat $
      [ content
      , bodyScripts page
      ]
  ]

