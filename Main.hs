{-# LANGUAGE OverloadedStrings, StandaloneDeriving, ScopedTypeVariables #-}
module Main where

import Network.OAuth.Consumer 
import Network.OAuth.Http.Request 
import Network.OAuth.Http.Response
import Network.OAuth.Http.CurlHttpClient
import Network.OAuth.Http.PercentEncoding 
import Data.Maybe (fromJust)
import Control.Monad.Error (runErrorT)
import qualified Data.ByteString.Char8 as B

deriving instance Show Application
deriving instance Show Token
deriving instance Read Application
deriving instance Read OAuthCallback

reqUrl = fromJust . parseURL $ "https://api.twitter.com/oauth/request_token"
accUrl = fromJust . parseURL $ "https://api.twitter.com/oauth/access_token"
serviceUrl = fromJust . parseURL $ "http://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=danchoi"


main = do
    putStrLn "hello"
