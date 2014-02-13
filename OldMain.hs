{-# LANGUAGE OverloadedStrings, StandaloneDeriving, ScopedTypeVariables #-}
module Main where

import Control.Monad.IO.Class (liftIO)
import Control.Monad (liftM)
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

reqUrl = fromJust . parseURL $ "https://api.github.com/authorizations"
accUrl = fromJust . parseURL $ "https://github.com/login/oauth/access_token"
-- serviceUrl = fromJust . parseURL $ "http://api.oauth.com/1.1/statuses/user_timeline.json?screen_name=danchoi"

oauthApp :: IO Application 
oauthApp = do
    (key:secret:callback:_) <- liftM lines $ readFile "oauth.cfg" 
    return $ Application { consKey = key, consSec = secret, callback = URL "" }

main = do
    putStrLn "hello"
    oauth <- oauthApp
    putStrLn $ "Using oauth config " ++ (show oauth)
    reqToken :: Token <- runOAuthM (fromApplication oauth) $ do
        s1 <- signRq2 HMACSHA1 Nothing reqUrl 
        liftIO $ putStrLn $ "s1: " ++ (show s1)
        oauthRequest CurlClient s1
        token <- getToken
        liftIO $ putStrLn $ "token: " ++ (show token)
        return token
    putStrLn $ "Received reqToken: " ++ (show reqToken)
    putStrLn $ "Token oauth params: " ++ (show $ oauthParams reqToken)

