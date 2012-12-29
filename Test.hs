module Main where
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as B8
import Text.JSON.Pretty

import Network.Curl

main = do
    token <- readFile "token.txt"
    let headers = [CurlHttpHeaders ["Authorization: token "++token]]
    (code, rBody) <- curlGetString "https://api.github.com/repos/MackeyRMS/mackey/issues/208/comments" headers
    putStrLn rBody
    -- putStrLn $ show $ pp_string rBody



