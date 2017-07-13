{-# LANGUAGE DataKinds #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Api
    ( UserApi
    , SortBy(..)
    , api) where

import Data.Aeson
import Data.Aeson.TH
import Data.ByteString (ByteString)
import Lucid (Html, ToHtml, toHtml, renderBS)
import Network.HTTP.Media ((//), (/:))
import Servant

import Model.User (User)

data HTML

instance Accept HTML where
    contentType _ = "text" // "html" /: ("charset", "utf-8")

instance ToHtml a => MimeRender HTML a where
    mimeRender _ = renderBS . toHtml

instance MimeRender HTML (Html a) where
    mimeRender _ = renderBS


type UserApi
    = "user"
      :> QueryParam "sortby" SortBy
      :> Get '[JSON, HTML] [User]

    :<|>

      "user"
      :> Capture "userId" Integer
      :> Get '[JSON, HTML] User

    :<|>

      "user"
      :> "listall"
      :> Get '[JSON, HTML] [User]


data SortBy
    = Id
    | FirstName
    | LastName
    deriving (Eq, Show)

$(deriveJSON defaultOptions ''SortBy)


instance FromHttpApiData SortBy where
    parseQueryParam "id" = Right Id
    parseQueryParam "firstname" = Right FirstName
    parseQueryParam "lastname" = Right LastName
    parseQueryParam _ = Left "Invalid sortby parameter"



api :: Proxy UserApi
api = Proxy
