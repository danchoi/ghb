{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

{- | Try joining data to a JSON -}
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
import Control.Monad
import qualified Data.HashMap.Strict as M

{- inserts "newVal":"hello" to each object -}

main = do
    r <- BL.getContents
    let xs :: Value = fromJust . decode $ r
    -- copy user value to another key
    let xs' = map (\x -> M.insert "newVal" (fromJust . M.lookup "user" $ x) x) (xs ^.. _Array . traverse . _Object)
    -- how to insert Null:
    -- let xs' = map (\x -> M.insert "newVal" Null x) (xs ^.. _Array . traverse . _Object)
    BL.putStrLn $ encode xs'

