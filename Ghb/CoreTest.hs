module Ghb.CoreTest where
import Ghb.Core
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Maybe (fromJust, fromMaybe)
import System.Environment

testUser = do
  raw <- readFile "json/user.json"
  let json = B.pack raw
  let r = decode json :: Maybe User
  putStrLn . show $ fromJust r

testIssue = do 
    [f] <- getArgs
    raw <- fmap B.pack $ readFile f
    B.putStrLn raw
    let r = decode raw :: Maybe [Issue]
    mapM_ print $ fromMaybe [] r



