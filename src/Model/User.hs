module Model.User
    ( User(..)
    ) where

data User = User
    { userId :: Int
    , userFirstName :: String
    , userLastName :: String
    } deriving (Eq, Show)
