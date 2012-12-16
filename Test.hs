module Main where

import Network.Curl

main = do
    putStrLn "test"
    token <- readFile "token.txt"
    putStrLn $ "token: " ++ token
    let headers = [CurlHttpHeaders ["Authorization: token "++token]]
    (code, rBody) <- curlGetString "https://api.github.com/repos/MackeyRMS/mackey/issues/208/comments" headers
    putStrLn (show code)
    putStrLn rBody



