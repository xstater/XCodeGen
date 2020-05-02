{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Gen
import Text.Gen.Json
import Data.Text

main :: IO ()
main = do
    putStrLn $ unpack $ runGen "aa" $ do
        genLine "nmsl"
    putStrLn $ unpack $ runGen "    " $ do
        genPair "(\n" ")\n" $ do
            genLine "nmsl"
            genIndent
            genPair "(" ")\n" $ do
                genRaw "a,b,c"
            genLine "cnmb"
    putStrLn $ unpack $ runGen "    " $ do
        genJsonArray $ genJsonString `fmap` ["gg","iji"]
