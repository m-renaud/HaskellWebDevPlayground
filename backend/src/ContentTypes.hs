{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-|
Module: ContentTypes
Description: The content types available to APIs

All model data exposed through an API with a given content type must have the
associated instance in scope within Lib.hs. The corresponding instances are:

    ContentType     Instance
    --------------------------
    Servant.HTML    Lucid.ToHtml
    Servart.JSON    Data.Aeson.ToJSON (usually done with deriveJSON TH)

To add a new content type:
  1. Declare an empty data type
  2. Implement the Servant.Accept, Lucid.ToHtml, and Servant.MimeRender
     typeclasses
-}
module ContentTypes
    ( Servant.HTML.Lucid.HTML
    , Servant.JSON
    ) where

import qualified Servant.HTML.Lucid
import qualified Servant
