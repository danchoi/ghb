{-# LANGUAGE OverloadedStrings, DeriveGeneric, RecordWildCards #-}

module Ghb.Types
where 
import Data.Aeson
import Data.Text (Text)
import Data.Maybe
import Control.Applicative
import Control.Monad (MonadPlus, mzero)
import qualified Data.Text.Lazy.Encoding as TE
import Data.Time.Clock
import qualified Data.Vector as V
import Text.Printf

data IssueState = Open | Closed deriving (Show)

data Issue = Issue {
    issueNumber :: Int
  , issueRepo :: Maybe String
  , issueTitle :: String
  , issueNumComments :: Int
  , issueState :: IssueState
  , issueUrl :: String
  , issueBody :: String
  , issueCreated :: String
  , issueUpdated :: String
  , issueUsername :: String
  , issueAssignee :: Maybe String
  , issueLabels :: [String]
  } deriving (Show)

data Comment = Comment {
    commentId :: Int
  , commentHtmlUrl :: String
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
          <*> ((v .: "repository" >>= (.: "name")) <|> pure Nothing)
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
  
printfIssue :: Issue -> IO ()
printfIssue (Issue {..}) = do 
    printf "%5d %-20.20s %-50.50s %s %s\n" 
      issueNumber 
      (fromMaybe "-" issueRepo) issueTitle issueUsername 
      (fromMaybe "-" issueAssignee)

instance FromJSON Comment where 
    parseJSON (Object v) = Comment 
        <$> v .: "id" 
        <*> v .: "html_url" 
        <*> v .: "body" 
        <*> v .: "created_at" 
        <*> v .: "updated_at" 
        <*> (v .: "user" >>= (.: "login"))



