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


main = do 
  x <- BL.getContents 
  let v :: Value = fromJust $ decode x 
  -- print v
  print $ v ^? nth 0 . key "state"
  putStrLn "OK"


