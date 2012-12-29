{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module GHCore
where 
import GHC.Generics
import Data.Aeson
import Data.Text (Text)
import Control.Applicative
import Control.Monad (MonadPlus, mzero)
import qualified Data.Text.Lazy.Encoding as TE

data User = User {
    login :: String
  , followersUrl :: String
  , starredUrl :: String
  } deriving (Show)

instance FromJSON User where
  parseJSON (Object v) = 
    User <$> v .: "login" <*> 
         v .: "followers_url" <*>
         v .: "starred_url"
    



{-


  {"type": "User",
           "followers_url": "https://api.github.com/users/danchoi/followers",
           "login": "danchoi",
           "starred_url": "https://api.github.com/users/danchoi/starred{/owner}{/repo}",
           "gists_url": "https://api.github.com/users/danchoi/gists{/gist_id}",
           "following_url": "https://api.github.com/users/danchoi/following",
           "organizations_url": "https://api.github.com/users/danchoi/orgs",
           "repos_url": "https://api.github.com/users/danchoi/repos",
           "events_url": "https://api.github.com/users/danchoi/events{/privacy}",
           "url": "https://api.github.com/users/danchoi",
           "subscriptions_url": "https://api.github.com/users/danchoi/subscriptions",
           "received_events_url": "https://api.github.com/users/danchoi/received_events",
           "id": 12854, "gravatar_id": "004e78a7e0aaf9f1eb0009668cd84b1a",
           "avatar_url": "https://secure.gravatar.com/avatar/004e78a7e0aaf9f1eb0009668cd84b1a?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"}

-}


