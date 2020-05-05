{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Gen
--import Text.Gen.Json
import Text.Gen.C
import Data.Text
import System.IO

{--
main :: IO ()
main = do
    putStrLn $ unpack $ runGen "    " $ do
        block "{\n" "}\n" $ do
            line $ raw "asd;"
            line $ do
                raw "func"
                pair "(" ");" $ Text.Gen.split "," [raw "a",raw "b"]
            line $ raw "asd"
            line $ do
                raw "if"
                pair "(" ")" $ raw "a == b"
                block "{\n" "}\n" $ do
                    line $ raw "asd;"
                    line $ raw "adsasd;"
--}

{--
main :: IO ()
main = do
    putStrLn $ unpack $ runGen "    " $ do
        object $ do
            lineComma $ value "name" $ string "john"
            lineComma $ value "age" $ number 3
            lineComma $ value "ids" $ array $ string `fmap` ["asd","ads"]
            line $ value "info" $ object $ do
                lineComma $ value "asd" $ string "asd"
                lineComma $ value "bl" $ bool False
                line $ value "asdsa" $ string "asd"
--}

main :: IO ()
main = do
    putStrLn $ unpack $ runGen "    " $ do
        include' "stdio.h"
        define "PI" "3.1415926" 
        newline
        enum "Index" $ raw `fmap` ["first","second","third","forth","fifth"] 
        newline 
        struct "Fuck" $ do
           statement $ var int "a"
           statement $ var char "c"
        newline
        function char "nmsl" [var char "asd",var int "abc"]
        cblock $ do
            statement $ do
                raw "asd"
                binaryOp "=" $ do
                    raw "asd"
                    binaryOp "+" $ raw "abc"
            statement $ raw "return asd"
        newline
        function int "main" [var int "argc",var char "argv[]"]
        cblock $ do
            statement $ call "nmsl" [char' 'a',number 123]
            statement $ call "printf" [call "nmsl" [char' 'b',number 222]]
            statement $ raw "return 0"


