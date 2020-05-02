{-# LANGUAGE OverloadedStrings #-}

module Text.Gen.Json(
    
)where

import Text.Gen

genJsonString :: Text -> Gen ()
genJsonString str = genPair "\"" "\"" $ genRaw str

genJsonBoolean :: Bool -> Gen ()
genJsonBoolean True = genRaw "true"
genJsonBoolean False = genRaw "false"

genSeq :: [Gen ()] -> Text -> Gen ()
genSeq (x:xs) splt= do
    x
    genRaw splt
    genSeq xs
genSeq [] = return ()

genJsonArray :: [Gen ()] -> Gen ()
genJsonArray genlst = do
    genPair "[" "]" $ do
        genSeq genlst ","

