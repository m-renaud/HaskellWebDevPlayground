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
import Network.HTTP.Media ((//), (/:))
import Lucid
import Servant

import Model (User(..))

data HTML

instance Accept HTML where
    contentType _ = "text" // "html" /: ("charset", "utf-8")

instance ToHtml a => MimeRender HTML a where
    mimeRender _ = renderBS . toHtml

instance MimeRender HTML (Html a) where
    mimeRender _ = renderBS


instance ToHtml User where
    toHtml user =
        tr_ $ do
            td_ (toHtml . show $ userId user)
            td_ (toHtml $ userFirstName user)
            td_ (toHtml $ userLastName user)
    toHtmlRaw = toHtml


instance ToHtml [User] where
    toHtml users =
        table_ $ do
            tr_ $ do
                th_ "id"
                th_ "first name"
                th_ "last name"
            foldMap toHtml users
    toHtmlRaw = toHtml


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
