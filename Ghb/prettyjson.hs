module Main where
import Text.JSON.Pretty
import Text.JSON.String

main = do
    putStrLn "hello"
    s <- readFile "test.json"
    let res = either show (show . pp_value) $ runGetJSON readJSTopType s
    putStrLn $ res

