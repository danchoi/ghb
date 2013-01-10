module Main where
import Data.Aeson
import GHCore
import Data.Maybe (fromJust)
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as B8

import Network.Curl

main = do
    token <- readFile "token.txt"
    let headers = [CurlHttpHeaders ["Authorization: token "++token]]
    (CurlOK, rBody) <- curlGetString "https://api.github.com/repos/MackeyRMS/mackey/issues/208/comments" headers
    putStrLn rBody
    let json = B8.pack rBody
    let r = decode json :: Maybe [Comment]
    putStrLn . show $ fromJust r
