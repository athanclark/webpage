{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE BangPatterns #-}

module Web.Page.Lucid
    ( module Web.Page.Types
    , template ) where

import Web.Page.Types

import Lucid
import Lucid.Base

import qualified Data.Text as T

import Data.Monoid

-- | Generic page template implemented in Lucid.
template :: Monad m =>
            WebPage (HtmlT m ()) T.Text -- ^ Page information
         -> HtmlT m () -- ^ Content to insert in @\<body\>@
         -> HtmlT m () 
template page content = doctypehtml_ $ mconcat $
  [ head_ [] $ mconcat $
      [ initScripts page
      , title_ $ toHtmlRaw $ pageTitle page
      , metaVars page
      , favicon page
      , beforeStylesScripts page
      , styles page
      , afterStylesScripts page
      ]
  , body_ [] $ mconcat $
      [ content
      , bodyScripts page
      ]
  ]
