{-# LANGUAGE OverloadedStrings #-}

module Web.Page.Hastache where

import Web.Page.Types

import Text.Hastache
import Text.Hastache.Context
import qualified Data.Text as T
import qualified Data.Text.Lazy as LT

import Data.Monoid

-- | We choose to not interpolate the @WebPage@ data type as a JSON Hastache
-- template value because I don't want the portions of @WebPage@ visible by
-- @content@.
template :: WebPage LT.Text T.Text
         -> LT.Text
         -> LT.Text
template page content = mconcat
  [ "<!DOCTYPE html>"
  , "<html>"
  , "<head>"
  , initScripts page
  , "<title>" <> (LT.fromStrict $ pageTitle page) <> "</title>"
  , metaVars page
  , favicon page
  , beforeStylesScripts page
  , styles page
  , afterStylesScripts page
  , "</head>"
  , "<body>"
  , content
  , bodyScripts page
  , "</body>"
  , "</html>"
  ]
