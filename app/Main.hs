{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text

main :: IO ()
main = do
    args <- getArgs
    print args
    
