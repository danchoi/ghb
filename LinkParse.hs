module Main where
import Text.ParserCombinators.Parsec
import Control.Applicative

linkExample = " <https://api.github.com/users/danchoi/followers?page=2>; rel=\"next\", <https://api.github.com/users/danchoi/followers?page=4>; rel=\"last\""

parseLink :: String -> Either ParseError [Link]
parseLink input = parse links "(unknown)" input

data Link = Link {
      linkHref :: String
    , linkRel :: String
    } deriving (Read, Show)

link :: CharParser st Link
link = do
    spaces
    char '<'
    href <- manyTill anyChar (char '>')
    string "; rel=\""
    rel <- manyTill anyChar (char '"')
    return $ Link href rel

links :: CharParser st [Link]
links = sepBy link (char ',')

main = putStrLn $ show $ parseLink linkExample
