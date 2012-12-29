module Main where
import Data.Aeson
import GHCore
import qualified Data.ByteString.Lazy.Char8 as B

main = do
  raw <- readFile "json/user.json"
  let json = B.pack raw
  let r = decode json :: Maybe User
  putStrLn . show $ r


