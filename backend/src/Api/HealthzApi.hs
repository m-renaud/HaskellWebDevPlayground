{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
module Api.HealthzApi
    ( HealthzApi
    ) where

import Servant

import ContentTypes (HTML, JSON)


-- | API for viewing the health of the server.
type HealthzApi
     = "healthz"
       :> Get '[JSON, HTML] String
