{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
module Api.UserApi
    ( UserApi
    , SortBy(..)
    ) where

import Servant

import ContentTypes (HTML, JSON)
import Model.User (User)


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
