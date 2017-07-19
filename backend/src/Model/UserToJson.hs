{-# LANGUAGE TemplateHaskell #-}
module Model.UserToJson where

import Model.User (User(..))

import Data.Aeson.TH

$(deriveJSON defaultOptions ''User)
