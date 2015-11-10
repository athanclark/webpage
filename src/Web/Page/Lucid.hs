{-# LANGUAGE
    OverloadedStrings
  , ExtendedDefaultRules
  , BangPatterns
  #-}

module Web.Page.Lucid
  ( module X
  , template
  ) where

import Web.Page.Types as X

import Lucid

import qualified Data.Text as T


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
