{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Api
    ( Api
    , UserApi
    , SortBy(..)
    , api) where

import Network.HTTP.Media ((//), (/:))
import Servant

import ContentTypes (HTML, JSON)
import Model.User (User)

type Api
    = UserApi
    :<|> HealthzApi


-- | API for accessing user information.
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


instance FromHttpApiData SortBy where
    parseQueryParam "id" = Right Id
    parseQueryParam "firstname" = Right FirstName
    parseQueryParam "lastname" = Right LastName
    parseQueryParam _ = Left "Invalid sortby parameter"


-- | API for viewing the health of the server.
type HealthzApi
     = "healthz"
       :> Get '[JSON, HTML] String




api :: Proxy Api
api = Proxy
