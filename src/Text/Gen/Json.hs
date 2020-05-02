{-# LANGUAGE OverloadedStrings #-}

module Text.Gen.Json(
    
)where

import Text.Gen

genJsonString :: Text -> Gen ()
genJsonString str = genPair "\"" "\"" $ genRaw str

genJsonBoolean :: Bool -> Gen ()
genJsonBoolean True = genRaw "true"
genJsonBoolean False = genRaw "false"

genJsonArray :: [Gen ()] -> Gen ()
genJsonArray genlst = do
    genPair "[" "]" $ do
        mapM genlst 

