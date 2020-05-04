{-# LANGUAGE OverloadedStrings #-}

module Text.Gen.Json(
    string,
    bool,
    number,
    Text.Gen.Json.null,
    array,
    object,
    value,
    lineComma
)where

import Text.Gen
import Data.Text hiding (split)

string :: Text -> Gen ()
string txt = pair "\"" "\"" $ raw txt

bool :: Bool -> Gen ()
bool True = raw "true"
bool False = raw "false"

number :: (Show n,Num n) => n -> Gen ()
number num = raw $ pack $ show num

null :: Gen ()
null = raw "null"

array :: [Gen ()] -> Gen ()
array xs = pair "[" "]" $ split "," xs

object :: Gen () -> Gen ()
object acts = do
    block "{\n" "}" acts 
    

value :: Text -> Gen () -> Gen ()
value name acts = do
    string name
    raw ":"
    acts

lineComma :: Gen () -> Gen ()
lineComma act = do
    indent
    act
    raw ","
    newline

