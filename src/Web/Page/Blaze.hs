{-# LANGUAGE
    OverloadedStrings
  #-}

module Web.Page.Blaze
  ( module X
  , template
  ) where

import Web.Page.Types as X

import qualified Text.Blaze.Html5 as H

import qualified Data.Text as T

-- | You should really be using Lucid...
template :: WebPage H.Html T.Text
         -> H.Html
         -> H.Html
template page content = do
  H.docTypeHtml $ do
    (H.head $ do
      initScripts page
      (H.title $ H.toHtml $ pageTitle page)
      metaVars page
      favicon page
      beforeStylesScripts page
      styles page
      afterStylesScripts page)
    H.body $ do
      content
      bodyScripts page
