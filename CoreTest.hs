module Main where
import Data.Aeson
import GHCore
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Maybe (fromJust)

testUser = do
  raw <- readFile "json/user.json"
  let json = B.pack raw
  let r = decode json :: Maybe User
  putStrLn . show $ fromJust r

testIssue = do 
    raw <- fmap B.pack $ readFile "json/issues.json"
    let r = decode raw :: Maybe [Issue]
    putStrLn . show $ r


main = testIssue
