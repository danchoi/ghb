{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Ghb.Core
where 
import Data.Aeson
import Data.Text (Text)
import Control.Applicative
import Control.Monad (MonadPlus, mzero)
import qualified Data.Text.Lazy.Encoding as TE
import Data.Time.Clock
import qualified Data.Vector as V

data IssueState = Open | Closed deriving (Show)

data Issue = Issue {
    issueNumber :: Int
  , issueTitle :: String
  , issueNumComments :: Int
  , issueState :: IssueState
  , issueUrl :: String
  , issueBody :: String
  , issueCreated :: String
  , issueUpdated :: String
  , issueUsername :: Text
  , issueAssignee :: Maybe Text
  , issueLabels :: [Text]
  } deriving (Show)

data Comment = Comment {
    commentId :: Int
  , commentUrl :: String
  , commentIssueUrl :: String
  , commentBody :: String
  , commentCreated :: String -- change to date
  , commentUpdated :: String
  , commentUser :: Text
  } deriving (Show)

instance FromJSON IssueState where
    parseJSON (String "open") = pure Open
    parseJSON (String "closed") = pure Closed

instance FromJSON Issue where
    parseJSON (Object v) =
        Issue 
          <$> v .: "number" 
          <*> v .: "title" 
          <*> v .: "comments" 
          <*> v .: "state" 
          <*> v .: "url" 
          <*> v .: "body" 
          <*> v .: "created_at" 
          <*> v .: "updated_at" 
          <*> (v .: "user" >>= (.: "login")) 
          <*> ((v .: "assignee" >>= (.: "login"))  <|> pure Nothing )
          <*> (v .: "labels" >>= mapM (.: "name"))
  

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



