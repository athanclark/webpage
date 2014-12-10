{-# LANGUAGE OverloadedStrings #-}

module Web.Page.Blaze
    ( module Web.Page.Types
    , template ) where

import Web.Page.Types

import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

template :: H.ToValue a =>
            WebPage H.Html a
         -> H.Html
         -> H.Html
template page content = content
