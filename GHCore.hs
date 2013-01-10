{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module GHCore
where 
import GHC.Generics
import Data.Aeson
import Data.Text (Text)
import Control.Applicative
import Control.Monad (MonadPlus, mzero)
import qualified Data.Text.Lazy.Encoding as TE
import Data.Time.Clock
import qualified Data.Vector as V


data User = User {
    userId :: Int
  , userLogin :: String
  , userGravatarId :: String
  , userAvatarUrl :: String
  , userUrl :: String
  , userReposUrl :: String
  , userGistsUrl :: String
  , userFollowersUrl :: String
  , userFollowingUrl :: String
  , userSubscriptionsUrl :: String
  , userOrganizationsUrl :: String
  , userStarredUrl :: String
  , userEventsUrl :: String
  , userReceivedEventsUrl :: String
  } deriving (Show)

data IssueState = Open | Closed deriving (Show)

data PullRequest = PullRequest {
    pullRequestPatchUrl :: Maybe String
  , pullRequestDiffUrl :: Maybe String
  , pullRequestHtmlUrl :: Maybe String
  } deriving (Show)

data Issue = Issue {
    issueId :: Int
  , issueNumber :: Int
  , issueNumComments :: Int
  , issueState :: IssueState
  , issueUrl :: String
  , issueCommentsUrl :: String
  , issueTitle :: String
  , issueBody :: String
  , issueMilestone :: Maybe Int
  , issueCreated :: String
  , issueUpdated :: String
  , issuePullRequest :: PullRequest
  , issueUser :: User
  , issueAssignee :: Maybe User
  , issueLabels :: [Label]
  } deriving (Show)

data Label = Label {
    labelColor :: String
  , labelName :: String
  , labelUrl :: String
  } deriving (Show)

data Comment = Comment {
    commentId :: Int
  , commentUrl :: String
  , commentIssueUrl :: String
  , commentBody :: String
  , commentCreated :: String -- change to date
  , commentUpdated :: String
  , commentUser :: User
  } deriving (Show)


-- FromJSON instances

instance FromJSON User where
    parseJSON (Object v) = 
        User <$> 
             v .: "id" <*> 
             v .: "login" <*> 
             v .: "gravatar_id" <*> 
             v .: "avatar_url" <*> 
             v .: "url" <*> 
             v .: "repos_url" <*> 
             v .: "gists_url" <*> 
             v .: "followers_url" <*>
             v .: "following_url" <*> 
             v .: "subscriptions_url" <*> 
             v .: "organizations_url" <*> 
             v .: "starred_url" <*>
             v .: "events_url" <*> 
             v .: "received_events_url" 

instance FromJSON PullRequest where
    parseJSON (Object v) =
        PullRequest <$>
            v .: "patch_url" <*>
            v .: "diff_url" <*>
            v .: "html_url" 

instance FromJSON IssueState where
    parseJSON (String "open") = pure Open
    parseJSON (String "closed") = pure Closed

instance FromJSON Issue where
    parseJSON (Object v) =
        Issue <$>
            v .: "id" <*>
            v .: "number" <*>
            v .: "comments" <*>
            v .: "state" <*>
            v .: "url" <*>
            v .: "comments_url" <*>
            v .: "title" <*>
            v .: "body" <*>
            v .: "milestone" <*>
            v .: "created_at" <*>
            v .: "updated_at" <*>
            v .: "pull_request" <*>
            v .: "user" <*>
            v .: "assignee" <*>
            v .: "labels"

instance FromJSON Label where
    parseJSON (Object v) = 
        Label <$>
            v .: "color" <*>
            v .: "name" <*>
            v .: "url" 

instance FromJSON Comment where 
    parseJSON (Object v) = 
        Comment <$>
            v .: "id" <*>
            v .: "url" <*>
            v .: "issue_url" <*>
            v .: "body" <*>
            v .: "created_at" <*>
            v .: "updated_at" <*>
            v .: "user" 



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


