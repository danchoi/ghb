module Main where
import Ghb.Types
import Ghb.CoreTest
import Options.Applicative
import Data.Aeson (decode)
import Data.Maybe (fromMaybe)
import qualified Data.ByteString.Lazy.Char8 as B

data RunMode = ParseIssues 
             | ParseComments 
               deriving (Show)

parseOpts :: Parser RunMode
parseOpts = (flag' ParseIssues (long "issues" <> short 'i' <> help "parse issues"))
        <|> (flag' ParseComments (long "comments" <> short 'c' <> help "parse comments"))


parseIssues :: B.ByteString -> [Issue]
parseIssues s = fromMaybe [] $ decode s 

parseComments :: B.ByteString -> [Comment]
parseComments s = fromMaybe [] $ decode s 

main = do
    s <- B.getContents
    mode <- execParser opts
    case mode of
      ParseIssues -> mapM_ print $ parseIssues s
      ParseComments -> mapM_ print $ parseComments s
    
  where opts = info (helper <*> parseOpts)
                    (fullDesc
                    <> progDesc "github tools"
                    <> header "ghc - some github tools")

