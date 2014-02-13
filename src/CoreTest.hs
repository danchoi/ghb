module CoreTest where
import Data.Aeson
import GHCore
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Maybe (fromJust, fromMaybe)

testUser = do
  raw <- readFile "json/user.json"
  let json = B.pack raw
  let r = decode json :: Maybe User
  putStrLn . show $ fromJust r

testIssue = do 
    raw <- fmap B.pack $ readFile "vmailissues.json"
    let r = decode raw :: Maybe [Issue]
    mapM_ print $ fromMaybe [] r



