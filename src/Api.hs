{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}

module Api
    ( UserApi
    , SortBy(..)
    , api) where

import Data.Aeson.TH
import Network.HTTP.Media ((//), (/:))
import Servant

import ContentTypes (HTML, JSON)
import Model.User (User)

type UserApi
    = "user"
      :> QueryParam "sortby" SortBy
      :> Get '[JSON, HTML] [User]
      -- ^ /user[?sortby=(id|firstname|lastname)]

    :<|>

      "user"
      :> Capture "userId" Integer
      :> Get '[JSON, HTML] User
      -- ^ /user/<Integer>

    :<|>

      "user"
      :> "listall"
      :> Get '[JSON, HTML] [User]
      -- ^ /user/listall
      -- Equivalent to /user


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
