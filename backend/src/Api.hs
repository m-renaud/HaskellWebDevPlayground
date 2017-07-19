{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}

module Api
    ( Api
    , api) where

import Servant

import Api.HealthzApi (HealthzApi)
import Api.UserApi (UserApi)

type Api
    = UserApi
    :<|> HealthzApi

api :: Proxy Api
api = Proxy
