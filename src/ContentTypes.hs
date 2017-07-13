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
    HTML            Lucid.ToHtml
    Servart.JSON    Data.Aeson.ToJSON (usually done with deriveJSON TH)

To add a new content type:
  1. Declare an empty data type
  2. Implement the Servant.Accept, Lucid.ToHtml, and Servant.MimeRender
     typeclasses
-}
module ContentTypes
    ( HTML
    , Servant.JSON
    ) where

import Lucid (Html, ToHtml(..), toHtml, renderBS)
import Network.HTTP.Media ((//), (/:))
import Servant (Accept(..), MimeRender(..))
import qualified Servant


data HTML

instance Accept HTML where
    contentType _ = "text" // "html" /: ("charset", "utf-8")

instance ToHtml a => MimeRender HTML a where
    mimeRender _ = renderBS . toHtml

instance MimeRender HTML (Html a) where
    mimeRender _ = renderBS
