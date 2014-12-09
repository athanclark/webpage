{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE BangPatterns #-}

module Lucid.Scaffold where


import Lucid
import Lucid.Base

import qualified Data.Text as T

import Data.Monoid

data WebPage m where
  WebPage :: Monad m =>
             T.Text -- ^ Page title
          -> T.Text -- ^ Favicon url
          -> (HtmlT m ())
          -> (HtmlT m ()) -- ^ JavaScript to include at the top of the page
          -> (HtmlT m ()) -- ^ JavaScript to include before @/<style/>@ tags
          -> (HtmlT m ()) -- ^ Styles
          -> (HtmlT m ()) -- ^ JavaScript to include after @/<style/>@ tags - see <http://modernizr.com Modernizr>
          -> (HtmlT m ()) -- ^ JavaScript to include at the base of @/<body/>@
          -> WebPage m

pageTitle :: Monad m => WebPage m -> T.Text
pageTitle !(WebPage !x _ _ _ _ _ _ _) = x

favicon :: Monad m => WebPage m -> T.Text
favicon !(WebPage _ !x _ _ _ _ _ _) = x

metaVars :: Monad m => WebPage m -> HtmlT m ()
metaVars !(WebPage _ _ !x _ _ _ _ _) = x

initScripts :: Monad m => WebPage m -> HtmlT m ()
initScripts !(WebPage _ _ _ !x _ _ _ _) = x

beforeStylesScripts :: Monad m => WebPage m -> HtmlT m ()
beforeStylesScripts !(WebPage _ _ _ _ !x _ _ _) = x

styles :: Monad m => WebPage m -> HtmlT m ()
styles !(WebPage _ _ _ _ _ !x _ _) = x

afterStylesScripts :: Monad m => WebPage m -> HtmlT m ()
afterStylesScripts !(WebPage _ _ _ _ _ _ !x _) = x

bodyScripts :: Monad m => WebPage m -> HtmlT m ()
bodyScripts !(WebPage _ _ _ _ _ _ _ !x) = x

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
