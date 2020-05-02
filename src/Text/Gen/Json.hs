{-# LANGUAGE OverloadedStrings #-}

module Text.Gen.Json(
    genJsonString,
    genJsonBoolean,
    genJsonArray
)where

import Text.Gen
import Data.Text

genJsonString :: Text -> Gen ()
genJsonString str = genPair "\"" "\"" $ genRaw str

genJsonBoolean :: Bool -> Gen ()
genJsonBoolean True = genRaw "true"
genJsonBoolean False = genRaw "false"

genSeq :: [Gen ()] -> Text -> Gen ()
genSeq (x:[]) _ = x
genSeq (x:xs) splt = do
    x
    genRaw splt
    genSeq xs splt
genSeq [] _ = return ()

genJsonArray :: [Gen ()] -> Gen ()
genJsonArray genlst = do
    genPair "[" "]" $ do
        genSeq genlst ","

