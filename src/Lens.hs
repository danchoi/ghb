{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

{- | Test using Control.Lens's aeson traversal -}
module Main where
import Control.Lens
import Data.Aeson
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Aeson.Lens
import Data.Maybe
import Data.Data.Lens
import Control.Applicative


-- for testing

getValue :: FilePath -> IO Value
getValue fp =  BL.readFile fp >>= return . fromJust . decode



login = ix "user" . ix "login"
body = ix "body"

loginBody  = login `alongside` body

proc1 v = v ^.. _Array . traverse . _Object . body
-- proc2 v = v ^.. _Array . traverse . _Object . body

test = getValue "json/issues.json" >>= return . proc1 

item x = (x ^. ix "url" ._String , x ^. ix "body" ._String)

main = do 
  x <- BL.getContents 
  let v :: Value = fromJust $ decode x 
  -- print v
  -- print $ v ^? nth 0 . key "state"
  print $ v ^? _Array . traverse . _Object . ix "comments" 
  print $ v ^.. _Array . traverse . _Object . ix "user" . ix "login" . _String
  -- print $ v ^.. _Array . traverse . _Object . body
  -- print $ v ^.. _Array . traverse . _Object . loginBody -- does not work
  -- does not work:
  -- print $ v ^.. _Array . traverse . _Object . ((ix "user" . ix "login" . _String) `alongside` (ix "url" . _String))
  -- traverseOf each print $ v ^.. _Array . traverse . _Object 
  let xs = v ^.. _Array . traverse . _Object 
  traverseOf each (\x -> print (x ^. ix "url" ._String, 1)) xs
  print $ traverseOf each (\x -> (x ^. ix "url" ._String , x ^? ix "body" ._String))  xs

  let ys =  v ^.. _Array . traverse . _Object . ix "url" ._String
  print ys

  -- THIS WORKS
  putStrLn "map item xs"
  print $ map item xs

  putStrLn " test "



