module Ghb.CoreTest where
import Ghb.Types
import Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Maybe (fromJust, fromMaybe)
import System.Environment

testIssue = do 
    [f] <- getArgs
    raw <- fmap B.pack $ readFile f
    let r = eitherDecode raw :: Either String [Issue]
    case r of 
      Left err -> putStrLn err
      Right xs -> mapM_ printfIssue xs



