module Main where
import Data.Aeson
import GHCore
import Data.Maybe (fromJust)
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as B8

import Network.Curl

getResp :: String -> IO String
getResp url = do
    token <- readFile "token.txt"
    let headers = [CurlHttpHeaders ["Authorization: token "++token]]
    (CurlOK, rBody) <- curlGetString url headers
    return rBody


comments = do
    rBody <- getResp "https://api.github.com/repos/MackeyRMS/mackey/issues/208/comments"
    putStrLn rBody
    let json = B8.pack rBody
    let r = decode json :: Maybe [Comment]
    let xs = fromJust r
    mapM_ (putStrLn.commentBody) xs

followers = do
    rsp <- getResp "https://api.github.com/users/danchoi/followers"
    let users = fromJust ( (decode $ B8.pack rsp) :: Maybe [User] )
    mapM_ (putStrLn . show . userLogin) users

main = followers
