{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
module Model.UserToHtml where

import Lucid

import Model.User (User(..))

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
