module Lib
    ( startApp
    ) where


import Data.List
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

import Api
import Api.UserApi (SortBy(..))
import Model.User
import Model.UserToHtml
import Model.UserToJson


-- HANDLERS


getUsers :: [User] -> Maybe SortBy -> Handler [User]
getUsers users maybeSortBy =
    let
        sortUsers :: SortBy -> [User]
        sortUsers sortBy =
            case sortBy of
                Id ->
                    users
                FirstName ->
                    Data.List.sortOn userFirstName users
                LastName ->
                    Data.List.sortOn userLastName users
    in
        return (maybe users sortUsers maybeSortBy)



getUserById :: [User] -> Integer -> Handler User
getUserById users id =
    return (users !! fromIntegral (id - 1))


getAllUsers :: [User] -> Handler [User]
getAllUsers =
    return

usersDb :: [User]
usersDb =
    [ User 1 "Matt" "Renaud"
    , User 2 "Tom" "Law"
    , User 3 "Evan" "Jones"
    ]


getHealthz :: Handler String
getHealthz =
    return "OK"


-- APP


usersApiHandlers =
    getUsers usersDb :<|>
    getUserById usersDb :<|>
    getAllUsers usersDb


healthzHandlers =
    getHealthz


server :: Server Api
server =
    usersApiHandlers :<|>
    healthzHandlers


startApp :: IO ()
startApp =
    run 8081 app


app :: Application
app =
    serve api server
