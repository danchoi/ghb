module Main where
import Data.Aeson
import GHCore
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Maybe (fromJust)
import qualified Data.Map as M

main = do
  raw <- readFile "json/issues.json"
  let json = B.pack raw
  let r = decode json :: Maybe ([M.Map String Value])
  mapM_ (putStrLn . show . M.toList) $ fromJust r


